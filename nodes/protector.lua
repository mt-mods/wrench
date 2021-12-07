
-- Register wrench support for protector

wrench.register_node("protector:chest", {
	lists = {"main"},
	metas = {
		name = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("protector:protect", {
	owned = true,
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		members = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("protector:protect2", {
	owned = true,
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		members = wrench.META_TYPE_STRING,
	},
})
