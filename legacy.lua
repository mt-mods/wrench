
-- Compatibility for old function signature

local register_node = wrench.register_node

function wrench.register_node(self, ...)
	if self == wrench then
		register_node(...)
	else
		register_node(self, ...)
	end
end

-- Register aliases for old wrench:picked_up_* nodes

local all_nodes = {
	default = {
		"default:chest",
		"default:chest_locked",
		"default:furnace",
		"default:furnace_active"
	},
	drawers = {
		"drawers:acacia_wood1",
		"drawers:acacia_wood2",
		"drawers:acacia_wood4",
		"drawers:aspen_wood1",
		"drawers:aspen_wood2",
		"drawers:aspen_wood4",
		"drawers:junglewood1",
		"drawers:junglewood2",
		"drawers:junglewood4",
		"drawers:pine_wood1",
		"drawers:pine_wood2",
		"drawers:pine_wood4",
		"drawers:wood1",
		"drawers:wood2",
		"drawers:wood4"
	},
	technic_chests = {
		"technic:copper_chest",
		"technic:copper_locked_chest",
		"technic:gold_chest",
		"technic:gold_chest_black",
		"technic:gold_chest_blue",
		"technic:gold_chest_brown",
		"technic:gold_chest_cyan",
		"technic:gold_chest_dark_green",
		"technic:gold_chest_dark_grey",
		"technic:gold_chest_green",
		"technic:gold_chest_grey",
		"technic:gold_chest_magenta",
		"technic:gold_chest_orange",
		"technic:gold_chest_pink",
		"technic:gold_chest_red",
		"technic:gold_chest_violet",
		"technic:gold_chest_white",
		"technic:gold_chest_yellow",
		"technic:gold_locked_chest",
		"technic:gold_locked_chest_black",
		"technic:gold_locked_chest_blue",
		"technic:gold_locked_chest_brown",
		"technic:gold_locked_chest_cyan",
		"technic:gold_locked_chest_dark_green",
		"technic:gold_locked_chest_dark_grey",
		"technic:gold_locked_chest_green",
		"technic:gold_locked_chest_grey",
		"technic:gold_locked_chest_magenta",
		"technic:gold_locked_chest_orange",
		"technic:gold_locked_chest_pink",
		"technic:gold_locked_chest_red",
		"technic:gold_locked_chest_violet",
		"technic:gold_locked_chest_white",
		"technic:gold_locked_chest_yellow",
		"technic:iron_chest",
		"technic:iron_locked_chest",
		"technic:mithril_chest",
		"technic:mithril_locked_chest",
		"technic:silver_chest",
		"technic:silver_locked_chest"
	},
	technic = {
		"technic:cnc",
		"technic:cnc_active",
		"technic:coal_alloy_furnace",
		"technic:coal_alloy_furnace_active",
		"technic:hv_battery_box0",
		"technic:hv_battery_box1",
		"technic:hv_battery_box2",
		"technic:hv_battery_box3",
		"technic:hv_battery_box4",
		"technic:hv_battery_box5",
		"technic:hv_battery_box6",
		"technic:hv_battery_box7",
		"technic:hv_battery_box8",
		"technic:lv_battery_box0",
		"technic:lv_battery_box1",
		"technic:lv_battery_box2",
		"technic:lv_battery_box3",
		"technic:lv_battery_box4",
		"technic:lv_battery_box5",
		"technic:lv_battery_box6",
		"technic:lv_battery_box7",
		"technic:lv_battery_box8",
		"technic:lv_electric_furnace",
		"technic:lv_electric_furnace_active",
		"technic:mv_alloy_furnace",
		"technic:mv_alloy_furnace_active",
		"technic:mv_battery_box0",
		"technic:mv_battery_box1",
		"technic:mv_battery_box2",
		"technic:mv_battery_box3",
		"technic:mv_battery_box4",
		"technic:mv_battery_box5",
		"technic:mv_battery_box6",
		"technic:mv_battery_box7",
		"technic:mv_battery_box8",
		"technic:mv_centrifuge",
		"technic:mv_centrifuge_active",
		"technic:mv_compressor",
		"technic:mv_compressor_active",
		"technic:mv_electric_furnace",
		"technic:mv_electric_furnace_active",
		"technic:mv_extractor",
		"technic:mv_extractor_active",
		"technic:mv_grinder",
		"technic:mv_grinder_active",
		"technic:tool_workshop"
	}
}

for mod, nodes in pairs(all_nodes) do
	if minetest.get_modpath(mod) then
		for _, n in pairs(nodes) do
			minetest.register_alias("wrench:picked_up_"..n:gsub(":", "_"), n)
		end
	end
end
