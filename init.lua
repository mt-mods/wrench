
local modpath = minetest.get_modpath("wrench")

wrench = {
	translator = minetest.get_translator("wrench"),
	plus = true,
	registered_nodes = {},
	blacklisted_items = {},
	META_TYPE_IGNORE = 0,
	META_TYPE_FLOAT = 1,
	META_TYPE_STRING = 2,
	META_TYPE_INT = 3,
	has_pipeworks = minetest.get_modpath("pipeworks"),
	has_mesecons = minetest.get_modpath("mesecons"),
	has_digilines = minetest.get_modpath("digilines"),
}

dofile(modpath.."/api.lua")
dofile(modpath.."/functions.lua")
dofile(modpath.."/tool.lua")
dofile(modpath.."/crafts.lua")
dofile(modpath.."/legacy.lua")

local mods = {
	"3d_armor_stand",
	"basic_signs",
	"beacon",
	"bees",
	"biofuel",
	"bones",
	"christmas",
	"connected_chests",
	"currency",
	"default",
	"digibuilder",
	"digilines",
	"digiscreen",
	"digistuff",
	"digtron",
	"drawers",
	"easyvend",
	"ehlphabet",
	"fancy_vend",
	"jumpdrive",
	"locator",
	"mapserver",
	"mesecons_commandblock",
	"mesecons_detector",
	"mesecons_luacontroller",
	"mesecons_microcontroller",
	"missions",
	"mobs",
	"more_chests",
	"moreblocks",
	"pipeworks",
	"powerbanks",
	"protector",
	"signs_lib",
	"smartshop",
	"soundblock",
	"spacecannon",
	"technic",
	"technic_chests",
	"technic_cnc",
	"vacuum",
	"vessels",
	"wine",
	"xdecor",
}

for _, mod in pairs(mods) do
	if minetest.get_modpath(mod) then
		dofile(modpath.."/nodes/"..mod..".lua")
	end
end
