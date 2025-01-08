
-- Register wrench support for the jumpdrive mod

wrench.register_node("jumpdrive:engine", {
	lists = {"main", "upgrade"},
	metas = {
		x = wrench.META_TYPE_INT,
		y = wrench.META_TYPE_INT,
		z = wrench.META_TYPE_INT,
		radius = wrench.META_TYPE_INT,
		powerstorage = wrench.META_TYPE_INT,
		max_powerstorage = wrench.META_TYPE_INT,
		power_requirement = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE, -- legacy field
		HV_EU_input = wrench.META_TYPE_IGNORE,
		HV_EU_demand = wrench.META_TYPE_IGNORE,
		simulation_expiry = wrench.META_TYPE_INT,
	},
	after_place = function(pos)
		jumpdrive.update_formspec(core.get_meta(pos), pos)
	end,
})

wrench.register_node("jumpdrive:fleet_controller", {
	lists = {"main"},
	metas = {
		x = wrench.META_TYPE_INT,
		y = wrench.META_TYPE_INT,
		z = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		active = wrench.META_TYPE_INT,
		jump_index = wrench.META_TYPE_INT,
		jump_list = wrench.META_TYPE_STRING
	}
})

