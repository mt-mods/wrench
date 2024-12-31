
-- Register wrench support for the moreblocks mod

wrench.register_node("moreblocks:circular_saw", {
	lists = { "input", "micro" , "output", "recycle" },
	metas = {
		anz = wrench.META_TYPE_INT,
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_STRING,
		max_offered = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
	},
})

