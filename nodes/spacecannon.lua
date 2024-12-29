
-- Register wrench support for the spacecannon mod

for _, def in ipairs(spacecannon.cannon_defs) do
	wrench.register_node("spacecannon:cannon_" .. def.color, {
		lists = def.is_th and {} or { "src" },
		metas = {
			channel = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_IGNORE,
			HV_EU_demand = wrench.META_TYPE_INT,
			HV_EU_input = wrench.META_TYPE_INT,
			infotext = wrench.META_TYPE_IGNORE,
			owner = wrench.META_TYPE_STRING,
			powerstorage = wrench.META_TYPE_INT,
		},
	})
end

