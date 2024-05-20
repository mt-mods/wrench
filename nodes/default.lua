
-- Register nodes from default / minetest_game

local splitstacks = wrench.has_pipeworks and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE
local formspec = wrench.has_pipeworks and wrench.META_TYPE_STRING or wrench.META_TYPE_IGNORE

wrench.register_node("default:chest", {
	lists = {"main"},
	metas = {
		splitstacks = splitstacks,
		formspec = formspec,
		infotext = wrench.META_TYPE_IGNORE,
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

for _,name in pairs({"default:furnace", "default:furnace_active"}) do
	wrench.register_node(name, {
		lists = {"fuel", "src", "dst"},
		metas = {
			infotext = wrench.META_TYPE_STRING,
			fuel_totaltime = wrench.META_TYPE_FLOAT,
			fuel_time = wrench.META_TYPE_FLOAT,
			src_totaltime = wrench.META_TYPE_FLOAT,
			src_time = wrench.META_TYPE_FLOAT,
			timer_elapsed = wrench.META_TYPE_INT,
			splitstacks = splitstacks,
			formspec = formspec,
		},
		timer = true,
	})
end

wrench.register_node("default:sign_wall_wood", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
})

wrench.register_node("default:sign_wall_steel", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
})

local function bookshelf_desc(pos, meta)
	return meta:get_string("infotext")
end

wrench.register_node("default:bookshelf", {
	lists = {"books"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
	description = bookshelf_desc,
})
