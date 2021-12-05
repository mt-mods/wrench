
local get_keys = function(list)
	local keys = {}
	for k, _ in pairs(list) do
		keys[#keys+1] = k
	end
	return keys
end

local orig_wrench_pickup_node = wrench.pickup_node
wrench.pickup_node = function(pos, player)
	if not player:get_player_control().sneak then
		return orig_wrench_pickup_node(pos, player)
	end
	local node = minetest.get_node(pos)
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
			print("\tdrop = \"" .. def.drop .. "\",")
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
			(def.can_dig(pos, player) and ', returns rue' or 'returns false') or ""
			)
                )
	end
	local meta = minetest.get_meta(pos)
	-- owner
	local owner = meta:get_string("owner")
	if owner and owner ~= "" then
		print("\towner = true, -- '" .. owner ..  "' FIXME:?")
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

