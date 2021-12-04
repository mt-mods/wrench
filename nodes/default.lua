
-- Register nodes from default / minetest_game

local has_pipeworks = minetest.get_modpath("pipeworks")
local splitstacks = has_pipeworks and wrench.META_TYPE_INT
local formspec = has_pipeworks and wrench.META_TYPE_STRING

wrench:register_node("default:chest", {
	lists = {"main"},
	metas = {
		splitstacks = splitstacks,
		formspec = formspec,
	}
})

wrench:register_node("default:chest_locked", {
	lists = {"main"},
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		splitstacks = splitstacks,
		formspec = formspec,
	},
	owned = true,
})

wrench:register_node("default:furnace", {
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

wrench:register_node("default:furnace_active", {
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

local function get_sign_description(pos, meta, node)
	local desc = minetest.registered_nodes[node.name].description
	local text = meta:get_string("text")
	if #text > 32 then
		text = text:sub(1, 24).."..."
	end
	return string.format("%s with text \"%s\"", desc, text)
end

wrench:register_node("default:sign_wall_wood", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING
	},
	description = get_sign_description,
})

wrench:register_node("default:sign_wall_steel", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING
	},
	description = get_sign_description,
})
