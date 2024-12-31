
-- Register wrench support for the missions mod

wrench.register_node("missions:mission", {
	lists = { "main" },
	metas = {
		description = wrench.META_TYPE_STRING,
		hidden = wrench.META_TYPE_INT,
		infotext = wrench.META_TYPE_STRING,
		name = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
		steps = wrench.META_TYPE_STRING,
		successcount = wrench.META_TYPE_INT,
		time = wrench.META_TYPE_INT,
		valid = wrench.META_TYPE_INT,
	},
})

