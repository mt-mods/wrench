
local S = wrench.translator

local get_keys = function(list)
	local keys = {}
	for k, _ in pairs(list) do
		keys[#keys+1] = k
	end
	return keys
end

local spairs = function(tbl, order_func)
	local ptrs = {}
	for p in pairs(tbl) do ptrs[#ptrs +1] = p end
	table.sort(ptrs, order_func and function(a, b) return order_func(a, b) end)
	local i = 0
	return function()
		i = i +1
		if ptrs[i] then return ptrs[i], tbl[ptrs[i]] end
	end
end

local strip_esc = function(text)
	text = minetest.strip_colors(text)
	-- strip translation foo
	local ESCAPE_CHAR = string.char(0x1b)
	text = string.gsub(text, ESCAPE_CHAR .. "%(T@[^%)]+%)", "")
	return string.gsub(text, ESCAPE_CHAR .. "[ET]", "")
end

-- use wrench with sneak to show node propperies (useful to add new nodes)

local orig_wrench_pickup_node = wrench.pickup_node
wrench.pickup_node = function(pos, player)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	if not player:get_player_control().sneak then
		local inventory = meta:get_inventory()
	        local lists = get_keys(inventory:get_lists())
		local metatable = meta:to_table()
		local metas = get_keys(metatable.fields)
		local rc, message = orig_wrench_pickup_node(pos, player)
		if rc == nil then
			if #lists == 0 and #metas == 0 then
				return false, S("can't pickup node: @1, no inventory and no meta.fields", node.name)
			else
				return false, S("can't pickup unsupported node: @1", node.name)
			end
		end
		return rc, message
	end
	local def = minetest.registered_nodes[node.name]
	print("wrench.register_node(\"" .. node.name .. "\", {");
	-- timer
	local timer = minetest.get_node_timer(pos)
	if timer:get_timeout() ~= 0 then
		print("\ttimer = true,")
	end
	-- drop
	if def.drop then
		if type(def.drop) ~= "string" then
			print("\t-- has drop " .. type(def.drop) .. "!")
		elseif def.drop == node.name or def.drop == node.name .. " 1" then
			print("\t-- drop = \"" .. def.drop .. "\",")
		else
			print("\tdrop = true, -- " .. def.drop)
		end
	end
	if def.after_place_node then
		print("\t-- has after_place " .. type(def.after_place_node))
	end
	if def.after_dig_node then
		print("\t-- has after_dig " .. type(def.after_dig_node))
	end
	if def.can_dig then
		print("\t-- has can_dig " .. type(def.can_dig) .. " " ..
			((type(def.can_dig) == "function") and
			(def.can_dig(pos, player) and ', returns true' or ', returns false') or ""
			)
		)
	end
	-- owner
	local owner = meta:get_string("owner")
	if owner and owner ~= "" then
		print("\towned = true, -- '" .. owner ..  "' FIXME:?")
	end
	-- lists
	local inventory = meta:get_inventory()
--	print(dump(inventory))
	local lists = get_keys(inventory:get_lists())
	if #lists > 0 then
		print("\tlists = {\"" .. table.concat(lists, "\", \"") .. "\"},")
	end
	-- metas
	local metatable = meta:to_table()
	local metas = get_keys(metatable.fields)
--	print(dump(metatable))
	if #metas > 0 then
		print("\tmetas = {")
		for k, v in pairs(metatable.fields) do
			local t = "--[[FIXME:!]]--"
			if meta:get_int(k) .. "" == v .. "" then
				t = "wrench.META_TYPE_INT"
			elseif meta:get_float(k) .. "" == v .. "" then
				t = "wrench.META_TYPE_FLOAT"
			elseif meta:get_string(k) == v then
				t = "wrench.META_TYPE_STRING"
			end
			local x = (k ~= "infotext" and k ~= "formspec") and
				(" -- " .. v) or ""
			print("\t\t" .. k .. " = " .. t .. "," .. x)
		end
		print("\t},")
	end
	print("})")
end

-- list supported modnames and nodes (useful to update README.md)

minetest.register_on_mods_loaded(function()
	print("wrench registered_nodes:")
	local last_mod = "?"
	for name, def in spairs(wrench.registered_nodes, function(a,b)
--		return minetest.registered_nodes[a].mod_origin < minetest.registered_nodes[b].mod_origin or a < b
		return a < b
	end) do
		if not def.drop then
			local node = minetest.registered_nodes[name]
			local mod = node.mod_origin
			if last_mod ~= mod then
				last_mod = mod
				print("* "..mod)
			end
			local desc = strip_esc(node.description or "")
			print(string.format("  - %-40s %q", name, desc))
		end
	end
end)
