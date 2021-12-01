
-- Register wrench support for bones

wrench.register_node("bones:bones", {
	lists = {"main"},
	metas = {
			owner = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			time = wrench.META_TYPE_INT,
	},
	owned = true,
})
