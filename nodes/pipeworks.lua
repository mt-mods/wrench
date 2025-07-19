
-- Register wrench support for pipeworks

local S = wrench.translator

local desc_infotext = function(pos, meta, node, player)
	return meta:get_string("infotext")
end

-- Autocrafter

wrench.register_node("pipeworks:autocrafter", {
	lists = {"src", "dst", "recipe", "output"},
	metas = {
		enabled = wrench.META_TYPE_INT,
		channel = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		splitstacks = wrench.META_TYPE_INT,
	},
	description = desc_infotext,
	timer = true,
})

local wielder_data = {
	lists = {"main"},
	metas = {
		infotext = wrench.META_TYPE_IGNORE,
		formspec = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
	},
	drop = true,
}

wrench.register_node("pipeworks:deployer_off", wielder_data)
wrench.register_node("pipeworks:deployer_on", wielder_data)

wrench.register_node("pipeworks:dispenser_off", wielder_data)
wrench.register_node("pipeworks:dispenser_on", wielder_data)

table.insert(wielder_data.lists, "pick")
wielder_data.lists_ignore = {"ghost_pick"}
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
	description = wrench.description_with_configuration,
}

wrench.register_node("pipeworks:filter", filter_data)
wrench.register_node("pipeworks:mese_filter", filter_data)

filter_data.metas["channel"] = wrench.META_TYPE_STRING
wrench.register_node("pipeworks:digiline_filter", filter_data)

-- Tubes (6d style): 'mese_sand_tube','teleport_tube', 'digiline_detector_tube'

for i = 1, 10 do
	wrench.register_node("pipeworks:mese_sand_tube_"..i, {
		drop = true,
		metas = {
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_IGNORE,
			dist = wrench.META_TYPE_INT,
			adjlist = wrench.META_TYPE_IGNORE,
			tubedir = wrench.META_TYPE_IGNORE,
		},
		description = desc_infotext,
	})
	wrench.register_node("pipeworks:teleport_tube_"..i, {
		drop = true,
		metas = {
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			channel = wrench.META_TYPE_STRING,
			digiline_channel = wrench.META_TYPE_STRING,
			owner = wrench.META_TYPE_STRING,
			can_receive = wrench.META_TYPE_INT,
			adjlist = wrench.META_TYPE_IGNORE,
			tubedir = wrench.META_TYPE_IGNORE,
		},
		description = desc_infotext,
	})
	if wrench.has_digilines then
		wrench.register_node("pipeworks:digiline_detector_tube_"..i, {
			drop = true,
			metas = {
				formspec = wrench.META_TYPE_IGNORE,
				channel = wrench.META_TYPE_STRING,
				adjlist = wrench.META_TYPE_IGNORE,
				tubedir = wrench.META_TYPE_IGNORE,
			},
			description = wrench.description_with_channel,
		})
	end
end

-- Tubes (old style): 'lua_tube' and 'mese_tube'

local lua_tube_data = {
	drop = true,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		code = wrench.META_TYPE_STRING,
		ignore_offevents = wrench.META_TYPE_STRING,
		lc_memory  = wrench.META_TYPE_STRING,
		luac_id = wrench.META_TYPE_INT,
		real_portstates = wrench.META_TYPE_INT,
		tubedir = wrench.META_TYPE_IGNORE,
	},
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes["pipeworks:lua_tube000000"].description
		return S("@1 with code", desc)
	end,
}

local mese_tube_data = {
	drop = true,
	lists = {},
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_IGNORE,
		adjlist = wrench.META_TYPE_IGNORE,
		tubedir = wrench.META_TYPE_IGNORE,
	},
	description = wrench.description_with_configuration,
}

for i = 1, 6 do
	mese_tube_data.metas["l"..i.."s"] = wrench.META_TYPE_INT
	table.insert(mese_tube_data.lists, "line"..i)
end

local has_lua_tube = core.get_modpath("mesecons_luacontroller") and true

for xm = 0, 1 do
for xp = 0, 1 do
for ym = 0, 1 do
for yp = 0, 1 do
for zm = 0, 1 do
for zp = 0, 1 do
	local tname = xm..xp..ym..yp..zm..zp
	if has_lua_tube then
		wrench.register_node("pipeworks:lua_tube"..tname, lua_tube_data)
	end
	wrench.register_node("pipeworks:mese_tube_"..tname, mese_tube_data)
end
end
end
end
end
end

if has_lua_tube then
	lua_tube_data.drop = nil
	wrench.register_node("pipeworks:lua_tube_burnt", lua_tube_data)
end

