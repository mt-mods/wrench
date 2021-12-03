
local modpath = minetest.get_modpath("wrench")

wrench = {
	registered_nodes = {},
	blacklisted_items = {},
	META_TYPE_FLOAT = 1,
	META_TYPE_STRING = 2,
	META_TYPE_INT = 3,
}

dofile(modpath.."/legacy.lua")
dofile(modpath.."/functions.lua")
dofile(modpath.."/tool.lua")
dofile(modpath.."/api.lua")

local mods = {
	"3d_armor_stand",
	"bees",
	"biofuel",
	"bones",
	"connected_chests",
	"default",
	"digilines",
	"digtron",
	"drawers",
	"mesecons",
	"more_chests",
	"pipeworks",
	"technic",
	"technic_chests",
	"technic_cnc",
	"vessels",
	"xdecor",
}

for _, modname in pairs(mods) do
	if minetest.get_modpath(modname) then
		dofile(modpath.."/nodes/"..modname..".lua")
	end
end

if minetest.settings:get_bool("wrench.enable_debug", false) then
	dofile(modpath.."/debug.lua")
end
