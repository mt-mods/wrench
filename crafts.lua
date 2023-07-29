
local has_technic = minetest.get_modpath("technic")
local has_default = minetest.get_modpath("default")
local has_dye = minetest.get_modpath("dye")
local has_wool = minetest.get_modpath("wool")

local colors = {
	white      = "#ffffff",
	grey       = "#888888",
	dark_grey  = "#444444",
	black      = "#111111",
	violet     = "#8000ff",
	blue       = "#0000ff",
	cyan       = "#00ffff",
	dark_green = "#005900",
	green      = "#00ff00",
	yellow     = "#ffff00",
	brown      = "#592c00",
	orange     = "#ff7f00",
	red        = "#ff0000",
	magenta    = "#ff00ff",
	pink       = "#ff7f9f",
}

-- Colored grip recipes by overriding item image using metadata
-- Only works for 5.8.0+ clients, but it's purely aesthetic anyway :)
for name, color in pairs(colors) do
	local item = ItemStack("wrench:wrench")
	item:get_meta():set_string("inventory_image", "wrench_tool.png^(wrench_grip.png^[multiply:"..color..")")
	if has_technic and has_dye then
		minetest.register_craft({
			output = item:to_string(),
			recipe = {
				{"wrench:wrench", "technic:rubber", "dye:"..name},
			}
		})
	elseif has_wool then
		minetest.register_craft({
			output = item:to_string(),
			recipe = {
				{"wrench:wrench", "wool:"..name},
			}
		})
	end
end

-- This is needed to preserve wear when coloring the wrench
minetest.register_on_craft(function(crafted_item, player, old_craft_grid)
	if crafted_item:get_name() ~= "wrench:wrench" then
		return
	end
	for _,stack in ipairs(old_craft_grid) do
		if stack:get_name() == "wrench:wrench" then
			crafted_item:set_wear(stack:get_wear())
			return crafted_item
		end
	end
end)

-- Actual crafting recipe
if minetest.settings:get_bool("wrench.enable_crafting", true) then
	if has_technic then
		minetest.register_craft({
			output = "wrench:wrench",
			recipe = {
				{"", "technic:stainless_steel_ingot", ""},
				{"", "technic:stainless_steel_ingot", "technic:stainless_steel_ingot"},
				{"technic:stainless_steel_ingot", "", ""}
			}
		})
	elseif has_default then
		minetest.register_craft({
			output = "wrench:wrench",
			recipe = {
				{"", "default:steel_ingot", ""},
				{"", "default:steel_ingot", "default:steel_ingot"},
				{"default:steel_ingot", "", ""},
			}
		})
	end
end
