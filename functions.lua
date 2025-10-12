
local S = wrench.translator

local SERIALIZATION_VERSION = 1

local compress_data = minetest.settings:get_bool("wrench.compress_data", true)

local errors = {
	owned = function(owner) return S("Cannot pickup node. Owned by @1.", owner) end,
	bad_item = function(item) return S("Cannot pickup node containing @1.", item) end,
	full_inv = S("Not enough room in inventory to pickup node."),
	nested = S("Cannot pickup node. Nesting inventories is not allowed."),
	metadata = S("Cannot pickup node. Node contains too much metadata."),
	missing_inv = S("Cannot pickup node. Node is missing inventory."),
	unknown = S("Cannot pickup node. Node contains unknown metadata."),
}

function wrench.description_with_items(pos, meta, node, player)
	local desc = minetest.registered_nodes[node.name].description or node.name
	return S("@1 with items", desc)
end

function wrench.description_with_text(pos, meta, node, player)
	local text = meta:get_string("text")
	if #text > 32 then
		text = text:sub(1, 24).."..."
	end
	local desc = minetest.registered_nodes[node.name].description or node.name
	return S("@1 with text \"@2\"", desc, text)
end

function wrench.description_with_channel(pos, meta, node, player)
	local desc = minetest.registered_nodes[node.name].description or node.name
	return S("@1 with channel \"@2\"", desc, meta:get_string("channel"))
end

function wrench.description_with_configuration(pos, meta, node, player)
	local desc = minetest.registered_nodes[node.name].description or node.name
	return S("@1 with configuration", desc)
end

local function get_description(def, pos, meta, node, player)
	if type(def.description) == "string" then
		return def.description
	elseif type(def.description) == "function" then
		local desc = def.description(pos, meta, node, player)
		if desc then
			return desc
		end
	end
	if def.lists then
		return wrench.description_with_items(pos, meta, node, player)
	elseif def.metas and def.metas.text then
		return wrench.description_with_text(pos, meta, node, player)
	elseif def.metas and def.metas.channel then
		return wrench.description_with_channel(pos, meta, node, player)
	else
		return wrench.description_with_configuration(pos, meta, node, player)
	end
end

local function save_data(stack, data, desc)
	local meta = stack:get_meta()
	data = minetest.serialize(data)
	if compress_data then
		data = minetest.encode_base64(minetest.compress(data, "deflate"))
		meta:set_string("compressed", "true")
	end
	meta:set_string("data", data)
	meta:set_string("description", desc)
	return stack
end

local function get_data(stack)
	local meta = stack:get_meta()
	local data = meta:get("data") or meta:get("")
	if not data then
		return nil
	end
	if meta:get("compressed") == "true" then
		data = minetest.decompress(minetest.decode_base64(data), "deflate")
	end
	data = minetest.deserialize(data)
	if not data or not data.version or not data.name then
		return nil
	end
	return data
end

local function safe_to_pickup(def, meta, inv)
	local def_metas = def.metas or {}
	local metatable = meta:to_table()
	for k in pairs(metatable.fields) do
		if not def_metas[k] then
			return false
		end
	end
	local all_lists = {}
	for _,list in pairs(def.lists or {}) do
		table.insert(all_lists, list)
	end
	for _,list in pairs(def.lists_ignore or {}) do
		table.insert(all_lists, list)
	end
	local lists = inv:get_lists()
	for k in ipairs(lists) do
		if table.indexof(all_lists, k) == -1 then
			return false
		end
	end
	return true
end

function wrench.pickup_node(pos, player)
	local node = minetest.get_node(pos)
	local def = wrench.registered_nodes[node.name]
	if not def then
		return
	end
	local pickup_override = false
	if def.can_pickup then
		local can_pickup, err_msg = def.can_pickup(pos, player)
		if can_pickup == false then
			return false, err_msg
		elseif can_pickup == true then
			pickup_override = true
		end
	end
	local meta = minetest.get_meta(pos)
	if not pickup_override then
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) then
			return
		end
		if def.owned and not minetest.check_player_privs(player, "protection_bypass") then
			local owner = meta:get_string("owner")
			if owner ~= "" and owner ~= player:get_player_name() then
				return false, errors.owned(owner)
			end
		end
	end
	local inv = meta:get_inventory()
	if not safe_to_pickup(def, meta, inv) then
		return false, errors.unknown
	end
	local data = {
		name = def.drop or node.name,
		version = SERIALIZATION_VERSION,
		lists = {},
		metas = {},
	}
	for _, listname in pairs(def.lists or {}) do
		local list = inv:get_list(listname)
		if not list then
			return false, errors.missing_inv
		end
		for i, stack in ipairs(list) do
			if stack:is_empty() then
				list[i] = ""
			else
				if wrench.blacklisted_items[stack:get_name()] then
					local desc = stack:get_description()
					return false, errors.bad_item(desc)
				end
				local sdata = get_data(stack, true)
				if sdata and sdata.lists and next(sdata.lists) ~= nil then
					return false, errors.nested
				end
				list[i] = stack:to_string()
			end
		end
		data.lists[listname] = list
	end
	for name, meta_type in pairs(def.metas or {}) do
		if meta_type == wrench.META_TYPE_FLOAT then
			data.metas[name] = meta:get_float(name)
		elseif meta_type == wrench.META_TYPE_STRING then
			data.metas[name] = meta:get_string(name)
		elseif meta_type == wrench.META_TYPE_INT then
			data.metas[name] = meta:get_int(name)
		end
	end
	if def.timer then
		local timer = minetest.get_node_timer(pos)
		data.timer = {
			timeout = timer:get_timeout(),
			elapsed = timer:get_elapsed()
		}
	end
	local drop_node = table.copy(node)
	if def.drop then
		drop_node.name = def.drop
	end
	local stack = ItemStack(drop_node.name)
	save_data(stack, data, get_description(def, pos, meta, drop_node, player))
	if #stack:to_string() > 65000 then
		return false, errors.metadata
	end
	local player_inv = player:get_inventory()
	if not player_inv:room_for_item("main", stack) then
		return false, errors.full_inv
	end
	player_inv:add_item("main", stack)
	if def.before_pickup then
		def.before_pickup(pos, meta, node, player)
	end
	local meta_table = meta:to_table()
	minetest.remove_node(pos)
	if def.after_pickup then
		def.after_pickup(pos, node, meta_table, player)
	end
	local node_def = minetest.registered_nodes[node.name]
	if wrench.has_pipeworks and node_def.tube then
		pipeworks.after_dig(pos)
	end
	if wrench.has_mesecons and node_def.mesecons then
		mesecon.on_dignode(pos, node)
	end
	if wrench.has_digilines and (node_def.digiline or node_def.digilines) then
		digilines.update_autoconnect(pos)
	end
	return true
end

function wrench.restore_node(pos, player, stack, pointed)
	if not stack then
		return
	end
	local data = get_data(stack)
	if not data then
		return
	end
	local def = wrench.registered_nodes[data.name]
	if not def then
		return
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	for listname, list in pairs(data.lists) do
		inv:set_list(listname, list)
	end
	for name, value in pairs(data.metas) do
		local meta_type = def.metas and def.metas[name]
		if meta_type == wrench.META_TYPE_INT then
			meta:set_int(name, value)
		elseif meta_type == wrench.META_TYPE_FLOAT then
			meta:set_float(name, value)
		elseif meta_type == wrench.META_TYPE_STRING then
			meta:set_string(name, value)
		end
	end
	if data.timer then
		local timer = minetest.get_node_timer(pos)
		if data.timer.timeout == 0 then
			timer:stop()
		else
			timer:set(data.timer.timeout, data.timer.elapsed)
		end
	end
	if def.after_place then
		def.after_place(pos, player, stack, pointed)
	end
	local node_def = minetest.registered_nodes[data.name]
	if wrench.has_pipeworks and node_def.tube then
		pipeworks.after_place(pos)
	end
	if wrench.has_mesecons and node_def.mesecons then
		mesecon.on_placenode(pos, minetest.get_node(pos))
	end
	if wrench.has_digilines and (node_def.digiline or node_def.digilines) then
		digilines.update_autoconnect(pos)
	end
	return true
end
