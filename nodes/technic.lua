
-- Register wrench support for technic mod machines and other containers

local machine_invlist = {"src", "dst"}
local machine_invlist_upgrades = {"src", "dst", "upgrade1", "upgrade2"}

local function register_machine_node(nodename, tier)
	local lists = tier ~= "LV" and machine_invlist_upgrades or machine_invlist
	local metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = tier ~= "LV" and wrench.META_TYPE_STRING or wrench.META_TYPE_IGNORE,
		splitstacks = tier ~= "LV" and wrench.META_TYPE_INT or nil,
		[tier.."_EU_demand"] = wrench.META_TYPE_INT,
		[tier.."_EU_input"] = wrench.META_TYPE_INT,
		tube_time = tier ~= "LV" and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE,
		src_time = wrench.META_TYPE_INT,
	}
	wrench.register_node(nodename, {
		lists = lists,
		metas = metas,
		lists_ignore = tier ~= "LV" and {"dst_tmp"} or {"dst_tmp", "upgrade1", "upgrade2"}
	})
end

local defaults = {tiers = {"LV", "MV", "HV"}}

local base_machines = {
	electric_furnace = defaults,
	grinder = defaults,
	compressor = defaults,
	alloy_furnace = {tiers = {"LV", "MV"}},
	extractor = {tiers = {"LV", "MV"}},
	centrifuge = {tiers = {"MV"}},
	freezer = {tiers = {"MV"}},
}

for name, data in pairs(base_machines) do
	for _, tier in ipairs(data.tiers) do
		local nodename = "technic:"..tier:lower().."_"..name
		register_machine_node(nodename, tier)
		if minetest.registered_nodes[nodename.."_active"] then
			register_machine_node(nodename.."_active", tier)
		end
	end
end

-- Generators

local function register_generator(nodename, tier)
	wrench.register_node(nodename, {
		lists = {"src"},
		metas = {
			infotext = wrench.META_TYPE_IGNORE,
			formspec = wrench.META_TYPE_IGNORE,
			splitstacks = tier ~= "LV" and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE,
			burn_time = wrench.META_TYPE_INT,
			burn_totaltime = wrench.META_TYPE_INT,
			tube_time = wrench.META_TYPE_IGNORE,
			[tier.."_EU_supply"] = wrench.META_TYPE_IGNORE,
		},
	})
end

for _, tier in ipairs(defaults.tiers) do
	local nodename ="technic:"..tier:lower().."_generator"
	register_generator(nodename, tier)
	register_generator(nodename.."_active", tier)
end

-- Special nodes

wrench.register_node("technic:coal_alloy_furnace", {
	lists = {"fuel", "src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		fuel_totaltime = wrench.META_TYPE_FLOAT,
		fuel_time = wrench.META_TYPE_FLOAT,
		src_totaltime = wrench.META_TYPE_FLOAT,
		src_time = wrench.META_TYPE_FLOAT,
		formspec = wrench.META_TYPE_IGNORE,
	},
})

wrench.register_node("technic:coal_alloy_furnace_active", {
	lists = {"fuel", "src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		fuel_totaltime = wrench.META_TYPE_FLOAT,
		fuel_time = wrench.META_TYPE_FLOAT,
		src_totaltime = wrench.META_TYPE_FLOAT,
		src_time = wrench.META_TYPE_FLOAT,
		formspec = wrench.META_TYPE_IGNORE,
	},
})

wrench.register_node("technic:tool_workshop", {
	lists = {"src", "upgrade1", "upgrade2"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		MV_EU_demand = wrench.META_TYPE_INT,
		MV_EU_input = wrench.META_TYPE_INT,
		tube_time = wrench.META_TYPE_INT,
		formspec = wrench.META_TYPE_IGNORE
	},
})

-- Battery boxes

for _, tier in pairs({"LV", "MV", "HV"}) do
	for i = 0, 8 do
		wrench.register_node("technic:"..tier:lower().."_battery_box"..i, {
			lists = tier ~= "LV" and machine_invlist_upgrades or machine_invlist,
			metas = {
				infotext = wrench.META_TYPE_STRING,
				formspec = wrench.META_TYPE_STRING,
				[tier.."_EU_demand"] = wrench.META_TYPE_INT,
				[tier.."_EU_supply"] = wrench.META_TYPE_INT,
				[tier.."_EU_input"] = wrench.META_TYPE_INT,
				internal_EU_charge = wrench.META_TYPE_INT,
				internal_EU_charge_max = wrench.META_TYPE_INT,
				last_side_shown = wrench.META_TYPE_INT,
				channel = wrench.has_digilines and wrench.META_TYPE_STRING,
				tube_time = tier ~= "LV" and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE,
			},
			lists_ignore = tier ~= "LV" and nil or {"upgrade1", "upgrade2"},
		})
	end
end

-- Other machines

wrench.register_node("technic:injector", {
	lists = {"main"},
	metas = {
		splitstacks = wrench.META_TYPE_INT,
		mode = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	timer = true,
})

if wrench.has_digilines then
	wrench.register_node("technic:power_monitor", {
		metas = {
			channel = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_IGNORE,
			formspec = wrench.META_TYPE_IGNORE,
		},
	})
	wrench.register_node("technic:switching_station", {
		timer = true,
		metas = {
			channel = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_IGNORE,
			formspec = wrench.META_TYPE_IGNORE,
		},
	})
end

-- Supply converter

wrench.register_node("technic:supply_converter", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		enabled = wrench.META_TYPE_INT,
		power = wrench.META_TYPE_INT,
		mesecon_effect = wrench.META_TYPE_INT,
		mesecon_mode = wrench.META_TYPE_INT,
		LV_EU_demand = wrench.META_TYPE_IGNORE,
		LV_EU_input = wrench.META_TYPE_IGNORE,
		LV_EU_supply = wrench.META_TYPE_IGNORE,
		MV_EU_demand = wrench.META_TYPE_IGNORE,
		MV_EU_input = wrench.META_TYPE_IGNORE,
		MV_EU_supply = wrench.META_TYPE_IGNORE,
		HV_EU_demand = wrench.META_TYPE_IGNORE,
		HV_EU_input = wrench.META_TYPE_IGNORE,
		HV_EU_supply = wrench.META_TYPE_IGNORE,
	},
})

-- Forcefield emitter

local states = { "off", "on" }
for _, state in ipairs(states) do
	wrench.register_node("technic:forcefield_emitter_"..state, {
		drop = state == "on",
		metas = {
			enabled = wrench.META_TYPE_INT,
			formspec = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			mesecon_mode = wrench.META_TYPE_INT,
			mesecon_effect = wrench.META_TYPE_INT,
			HV_EU_input = wrench.META_TYPE_INT,
			HV_EU_demand = wrench.META_TYPE_INT,
			range = wrench.META_TYPE_INT,
			shape = wrench.META_TYPE_INT,
			channel = wrench.has_digilines and wrench.META_TYPE_STRING,
		},
	})
end

-- Quarry

wrench.register_node("technic:quarry", {
	owned = true,
	lists = {"cache"},
	metas = {
		enabled = wrench.META_TYPE_INT,
		finished = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
		purge_on = wrench.META_TYPE_INT,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		HV_EU_demand = wrench.META_TYPE_INT,
		max_depth = wrench.META_TYPE_INT,
		dug = wrench.META_TYPE_INT,
		offset_x = wrench.META_TYPE_INT,
		offset_y = wrench.META_TYPE_INT,
		offset_z = wrench.META_TYPE_INT,
		size = wrench.META_TYPE_INT,
		step = wrench.META_TYPE_INT,
		reset_on_move = wrench.META_TYPE_STRING,
		mesecons = wrench.has_mesecons and wrench.META_TYPE_STRING,
		channel = wrench.has_digilines and wrench.META_TYPE_STRING,
		HV_EU_input = wrench.META_TYPE_IGNORE,
	},
})
