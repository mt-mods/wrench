
-- Register wrench support for biofuel refinery

wrench.register_node("biofuel:refinery", {
	lists = {"src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		progress = wrench.META_TYPE_INT,
	},
	timer = true,
})

wrench.register_node("biofuel:refinery_active", {
	lists = {"src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		progress = wrench.META_TYPE_INT,
	},
	timer = true,
})
