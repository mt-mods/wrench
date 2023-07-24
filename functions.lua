
local S = wrench.translator

local SERIALIZATION_VERSION = 1

local errors = {
	owned = function(owner) return S("Cannot pickup node. Owned by @1.", owner) end,
	full_inv = S("Not enough room in inventory to pickup node."),
	bad_item = function(item) return S("Cannot pickup node containing @1.", item) end,
	nested = S("Cannot pickup node. Nesting inventories is not allowed."),
	metadata = S("Cannot pickup node. Node contains too much metadata."),
	no_list = S("Cannot pickup node. Node has no inventory."),
	missing = function(node, missing_lists, missing_metas)
		return S("Cannot pickup @1, unknown value(s) in lists: @2 metas: @3",
			node.name,
			table.concat(missing_lists, ","),
			table.concat(missing_metas, ", ")
		)
	end
}

local function get_stored_metadata(itemstack)
	local meta = itemstack:get_meta()
	local data = meta:get("data") or meta:get("")
	data = minetest.deserialize(data)
	if not data or not data.version or not data.name then
		return
	end
	return data
end

local function other_keys_than(list, keys)
	local list2 = table.copy(list)
	for _, k in ipairs(keys) do
		list2[k] = nil
	end
	local other_keys = {}
	for k, _ in pairs(list2) do
		other_keys[#other_keys+1] = k
	end
	return other_keys
end

local function get_description(def, pos, meta, node, player)
	local t = type(def.description)
	if t == "string" then
		return def.description
	elseif t == "function" then
		local desc = def.description(pos, meta, node, player)
		if desc then
			return desc
		end
	end
	if def.lists then
		return wrench.description_with_items(pos, meta, node, player)
	elseif def.metas and def.metas.text then
		return wrench.description_with_text(pos, meta, node, player)
	elseif def.metas and def.metas.channel and
		#other_keys_than(def.metas, {"channel", "formspec", "infotext", "owner"}) == 0 then
		return wrench.description_with_channel(pos, meta, node, player)
	else
		return wrench.description_with_configuration(pos, meta, node, player)
	end
end

function wrench.description_with_items(pos, meta, node, player)
	return S("@1 with items", minetest.registered_nodes[node.name].description)
end

function wrench.description_with_channel(pos, meta, node, player)
	local desc = minetest.registered_nodes[node.name].description
	return S("@1 with channel \"@2\"", desc, meta:get_string("channel"))
end

function wrench.description_with_configuration(pos, meta, node, player)
	return S("@1 with configuration", minetest.registered_nodes[node.name].description)
end

function wrench.description_with_text(pos, meta, node, player)
	local text = meta:get_string("text")
	if #text > 32 then
		text = text:sub(1, 24).."..."
	end
	return S("@1 with text \"@2\"", minetest.registered_nodes[node.name].description, text)
end

local function check_dev_lists(def, inventory)
	local array_find = function(list, val)
		for i, _ in ipairs(list) do
			if list[i] == val then return i end
		end
	end
	local get_keys = function(list)
		local keys = {}
		for k, _ in pairs(list) do
			keys[#keys+1] = k
		end
		return keys
	end
	local def_lists = def.lists or {}
	local lists = get_keys(inventory:get_lists())
	local missing_lists = {}
	for _, v in ipairs(lists) do
		if not array_find(def_lists, v)
			and not (def.lists_ignore and array_find(def.lists_ignore, v)) then
			table.insert(missing_lists, v)
		end
	end
	return missing_lists
end

local function check_dev_metas(def, meta)
	local def_metas = def.metas or {}
	local metatable = meta:to_table()
	local missing_metas = {}
	for k in pairs(metatable.fields) do
		if not def_metas[k] then
			table.insert(missing_metas, k)
		end
	end
	return missing_metas
end

function wrench.pickup_node(pos, player)
	local node = minetest.get_node(pos)
	local def = wrench.registered_nodes[node.name]
	if not def then
		return
	end
	local meta = minetest.get_meta(pos)
	if def.owned and not minetest.check_player_privs(player, "protection_bypass") then
		local owner = meta:get_string("owner")
		if owner ~= "" and owner ~= player:get_player_name() then
			return false, errors.owned(owner)
		end
	end
	local data = {
		name = def.drop or node.name,
		version = SERIALIZATION_VERSION,
		lists = {},
		metas = {},
	}
	local inv = meta:get_inventory()
	local missing_lists = check_dev_lists(def, inv)
	local missing_metas = check_dev_metas(def, meta)
	if #missing_metas > 0 or #missing_lists > 0 then
		return false, errors.missing(node, missing_lists, missing_metas)
	end
	for _, listname in pairs(def.lists or {}) do
		local list = inv:get_list(listname)
		if not list then
			return false, errors.no_list
		end
		for i, stack in pairs(list) do
			if wrench.blacklisted_items[stack:get_name()] then
				local desc = stack:get_definition().description
				return false, errors.bad_item(desc)
			end
			local sdata = get_stored_metadata(stack)
			if sdata and sdata.lists and next(sdata.lists) ~= nil then
				return false, errors.nested
			end
			list[i] = stack:to_string()
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
	local drop_node = node
	if def.drop then
		drop_node = table.copy(node)
		drop_node.name = def.drop
	end
	local stack = ItemStack(drop_node.name)
	local item_meta = stack:get_meta()
	item_meta:set_string("data", minetest.serialize(data))
	item_meta:set_string("description", get_description(def, pos, meta, drop_node, player))
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
	if wrench.has_digilines and node_def.digiline or node_def.digilines then
		digilines.update_autoconnect(pos)
	end
	return true
end

function wrench.restore_node(pos, player, stack, pointed)
	if not stack then
		return
	end
	local data = get_stored_metadata(stack)
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
	if wrench.has_digilines and node_def.digiline or node_def.digilines then
		digilines.update_autoconnect(pos)
	end
	return true
end
