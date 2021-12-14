
-- Register wrench support for digilines

wrench.register_node("digilines:chest", {
	lists = {"main"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digilines:lightsensor", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digilines:rtc", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digilines:lcd", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})
