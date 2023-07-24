
local S = wrench.translator

local tool_uses = tonumber(minetest.settings:get("wrench.tool_uses")) or 50

minetest.register_tool("wrench:wrench", {
	description = S("Wrench"),
	inventory_image = "technic_wrench.png",
	on_use = function(stack, player, pointed)
		if not player or not pointed then
			return
		end
		local name = player:get_player_name()
		local pos = pointed.under
		if not pos or minetest.is_protected(pos, name) then
			return
		end
		local picked_up, err_msg = wrench.pickup_node(pos, player)
		if not picked_up then
			if err_msg then
				minetest.chat_send_player(name, err_msg)
			end
			return
		end
		if tool_uses > 0 then
			stack:add_wear(65535 / tool_uses)
		end
		return stack
	end,
})

if minetest.settings:get_bool("wrench.enable_crafting", true) then
	if minetest.get_modpath("technic") then
		minetest.register_craft({
			output = "wrench:wrench",
			recipe = {
				{"technic:stainless_steel_ingot", "", "technic:stainless_steel_ingot"},
				{"", "technic:stainless_steel_ingot", ""},
				{"", "technic:stainless_steel_ingot", ""}
			}
		})
	elseif minetest.get_modpath("default") then
		minetest.register_craft({
			output = "wrench:wrench",
			recipe = {
				{"default:steel_ingot", "", "default:steel_ingot"},
				{"", "default:steel_ingot", ""},
				{"", "default:steel_ingot", ""}
			}
		})
	end
end
