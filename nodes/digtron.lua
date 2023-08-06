
-- Register wrench support for digtron

wrench.register_node("digtron:battery_holder", {
	lists = {"batteries"},
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
	},
})

wrench.register_node("digtron:inventory", {
	lists = {"main"},
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
	},
})

wrench.register_node("digtron:fuelstore", {
	lists = {"fuel"},
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
	},
})

wrench.register_node("digtron:combined_storage", {
	lists = {"main", "fuel"},
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
	},
})

-- Blacklist loaded crates to prevent nesting of inventories

wrench.blacklist_item("digtron:loaded_crate")
wrench.blacklist_item("digtron:loaded_locked_crate")
