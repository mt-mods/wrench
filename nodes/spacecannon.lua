
-- Register wrench support for the spacecannon mod

for colour, ballistic in pairs({
		blue = true,
		green = false,
		purple = true,
		red = false,
		yellow = false,
	}) do
	wrench.register_node("spacecannon:cannon_" .. colour, {
		lists = ballistic and { "src" } or {},
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

