
-- Register wrench support for pipeworks

wrench.register_node("pipeworks:autocrafter", {
	lists = {"src", "dst", "recipe", "output"},
	metas = {
		enabled = wrench.META_TYPE_INT,
		channel = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	description = function(pos, meta, node, player)
		return meta:get_string("infotext")
	end,
	timer = true,
})

local wielder_data = {
	lists = {"main"},
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
}

-- TODO: convert *_on to *_off nodes before pickpup?

wrench.register_node("pipeworks:deployer_off", wielder_data)
wrench.register_node("pipeworks:deployer_on", wielder_data)

wrench.register_node("pipeworks:dispenser_off", wielder_data)
wrench.register_node("pipeworks:dispenser_on", wielder_data)

table.insert(wielder_data.lists, "pick")
table.insert(wielder_data.lists, "ghost_pick")
wrench.register_node("pipeworks:nodebreaker_off", wielder_data)
wrench.register_node("pipeworks:nodebreaker_on", wielder_data)

-- Filters

local filter_data = {
	lists = {"main"},
	metas = {
		slotseq_mode = wrench.META_TYPE_INT,
		slotseq_index = wrench.META_TYPE_INT,
		exmatch_mode = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes[node.name].description
		return string.format("%s with configuration", desc)
	end,
}

wrench.register_node("pipeworks:filter", filter_data)
wrench.register_node("pipeworks:mese_filter", filter_data)

filter_data.metas["channel"] = wrench.META_TYPE_STRING
wrench.register_node("pipeworks:digiline_filter", filter_data)

-- TODO: Tubes

--[[
local nodes = {
	"pipeworks:teleport_tube",
	"pipeworks:mese_tube_000010",
	"pipeworks:lua_tube_000000",
	"pipeworks:mese_sand_tube_2",
}
]]--
