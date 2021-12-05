
-- Register wrench support for bees

wrench.register_node("bees:hive_wild", {
	timer = true,
	lists = {"combs", "queen"},
	metas = {
		agressive = wrench.META_TYPE_INT,
	},
})
