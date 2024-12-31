
-- Register wrench support for the digibuilder mod

wrench.register_node("digibuilder:digibuilder", {
	lists = { "main" },
	metas = {
		channel = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
	},
})

