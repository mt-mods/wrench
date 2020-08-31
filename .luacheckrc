unused_args = false
allow_defined_top = true
max_line_length = 999

globals = {
    "technic", "minetest",
}

read_globals = {
    string = {fields = {"split", "trim"}},
    table = {fields = {"copy", "getn"}},

    "intllib", "ItemStack", "drawers",
}

files["init.lua"].ignore = { "name", "stack" }
