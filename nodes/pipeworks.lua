
-- Register wrench support for pipeworks

local desc_ghost_items = function(pos, meta, node, player)
	local desc = minetest.registered_nodes[node.name].description
	return string.format("%s with configuration", desc)
end

local desc_infotext = function(pos, meta, node, player)
	return meta:get_string("infotext")
end

-- Autocrafter

wrench.register_node("pipeworks:autocrafter", {
	after_place = pipeworks.after_place,
	lists = {"src", "dst", "recipe", "output"},
	metas = {
		enabled = wrench.META_TYPE_INT,
		channel = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	description = desc_infotext,
	timer = true,
})

local wielder_data = {
	after_place = pipeworks.after_place,
	lists = {"main"},
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	-- drop node in state 'off' like digging
	drop = true,
}

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
	after_place = pipeworks.after_place,
	lists = {"main"},
	metas = {
		slotseq_mode = wrench.META_TYPE_INT,
		slotseq_index = wrench.META_TYPE_INT,
		exmatch_mode = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	description = desc_ghost_items,
}

wrench.register_node("pipeworks:filter", filter_data)
wrench.register_node("pipeworks:mese_filter", filter_data)

filter_data.metas["channel"] = wrench.META_TYPE_STRING
wrench.register_node("pipeworks:digiline_filter", filter_data)

-- Tubes (6d style): 'mese_sand_tube' and 'teleport_tube'

for i = 1, 10 do
	wrench.register_node("pipeworks:mese_sand_tube_"..i, {
		drop = true,
		after_place = pipeworks.after_place,
		metas = {
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			dist = wrench.META_TYPE_INT,
		},
		description = desc_infotext,
	})
	wrench.register_node("pipeworks:teleport_tube_"..i, {
		drop = true,
		after_place = pipeworks.after_place,
		metas = {
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			channel = wrench.META_TYPE_STRING,
			can_receive = wrench.META_TYPE_INT,
		},
		description = desc_infotext,
	})
end

-- Tubes (old style): 'lua_tube' and 'mese_tube'

local lua_tube_data = {
	drop = true,
	after_place = pipeworks.after_place,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		code = wrench.META_TYPE_STRING,
		ignore_offevents = wrench.META_TYPE_STRING,
		lc_memory  = wrench.META_TYPE_STRING,
		luac_id = wrench.META_TYPE_INT,
		real_portstates = wrench.META_TYPE_INT,
	},
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes[node.name].description
		return string.format("%s with program", desc)
	end,
}

local mese_tube_data = {
	drop = true,
	after_place = pipeworks.after_place,
	lists = {},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	description = desc_ghost_items,
}

for i = 1, 6 do
	mese_tube_data.metas["l"..i.."s"] = wrench.META_TYPE_INT
	table.insert(mese_tube_data.lists, "line"..i)
end

wrench.register_node("pipeworks:lua_tube_burnt", lua_tube_data)

for xm = 0, 1 do
for xp = 0, 1 do
for ym = 0, 1 do
for yp = 0, 1 do
for zm = 0, 1 do
for zp = 0, 1 do
	local tname = xm..xp..ym..yp..zm..zp
	wrench.register_node("pipeworks:lua_tube"..tname, lua_tube_data)
	wrench.register_node("pipeworks:mese_tube_"..tname, mese_tube_data)
end
end
end
end
end
end
