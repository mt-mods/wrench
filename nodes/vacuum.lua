
-- Register wrench support for the vacuum mod

wrench.register_node("vacuum:airpump", {
	lists = { "main" },
	metas = {
		enabled = wrench.META_TYPE_INT,
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
	},
})

