
-- Register wrench support for vessels

wrench.register_node("vessels:shelf", {
	lists = { "vessels" },
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
})
