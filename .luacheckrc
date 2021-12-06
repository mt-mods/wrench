unused_args = false
allow_defined_top = true

-- Exclude regression tests / unit tests
exclude_files = {
	"**/spec/**",
}

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
	"mesecon",
	"pipeworks",
	"xdecor",
}
