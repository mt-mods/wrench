
-- Register wrench support for more_chests

local basic_chests = {
	"more_chests:cobble",
	"more_chests:dropbox",
	"more_chests:fridge",
	"more_chests:big_fridge",
	"more_chests:secret",
	"more_chests:toolbox_acacia",
	"more_chests:toolbox_aspen",
	"more_chests:toolbox_jungle",
	"more_chests:toolbox_pine",
	"more_chests:toolbox_steel",
	"more_chests:toolbox_wood",
}

for _, chest in pairs(basic_chests) do
	wrench.register_node(chest, {
		lists = {"main"},
		metas = {
			owner = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_IGNORE,
		},
		owned = true,
	})
end

-- Shared Chest

wrench.register_node("more_chests:shared", {
	lists = {"main"},
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		shared = wrench.META_TYPE_STRING,
	},
	owned = true,
})
