unused_args = false
allow_defined_top = true

globals = {
	"minetest",
}

read_globals = {
	string = {fields = {"split"}},
	table = {fields = {"copy"}},

	-- Minetest
	"ItemStack",

	-- Mods
	"digilines",
	"drawers",
	"intllib",
	"mesecon",
	"pipeworks",
	"xdecor",
}
