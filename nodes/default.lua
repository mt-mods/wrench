
-- Register nodes from default / minetest_game

local has_pipeworks = minetest.get_modpath("pipeworks")
local splitstacks = has_pipeworks and wrench.META_TYPE_INT
local formspec = has_pipeworks and wrench.META_TYPE_STRING

wrench.register_node("default:chest", {
	lists = {"main"},
	metas = {
		splitstacks = splitstacks,
		formspec = formspec,
	}
})

wrench.register_node("default:chest_locked", {
	lists = {"main"},
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		splitstacks = splitstacks,
		formspec = formspec,
	},
	owned = true,
})

wrench.register_node("default:furnace", {
	lists = {"fuel", "src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		fuel_totaltime = wrench.META_TYPE_FLOAT,
		fuel_time = wrench.META_TYPE_FLOAT,
		src_totaltime = wrench.META_TYPE_FLOAT,
		src_time = wrench.META_TYPE_FLOAT,
		splitstacks = splitstacks,
		formspec = formspec,
	},
})

wrench.register_node("default:furnace_active", {
	lists = {"fuel", "src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		fuel_totaltime = wrench.META_TYPE_FLOAT,
		fuel_time = wrench.META_TYPE_FLOAT,
		src_totaltime = wrench.META_TYPE_FLOAT,
		src_time = wrench.META_TYPE_FLOAT,
		splitstacks = splitstacks,
		formspec = formspec,
	},
})

wrench.register_node("default:sign_wall_wood", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING
	},
})

wrench.register_node("default:sign_wall_steel", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING
	},
})
