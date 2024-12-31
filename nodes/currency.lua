
-- Register wrench support for the currency mod

wrench.register_node("currency:barter", {
	lists = { "pl1", "pl2" },
	metas = {
		clean = wrench.META_TYPE_INT,
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_IGNORE,
		pl1 = wrench.META_TYPE_STRING,
		pl2 = wrench.META_TYPE_STRING,
		pl1step = wrench.META_TYPE_INT,
		pl2step = wrench.META_TYPE_INT,
		timer = wrench.META_TYPE_INT,
	},
	timer = true,
	after_place = function(pos, player, stack, pointed)
		barter.chest.update_formspec(core.get_meta(pos))
	end,
})

wrench.register_node("currency:safe", {
	lists = { "main" },
	metas = {
		infotext = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
	owned = true,
})

-- Unkown what happens if a shop is wrenched while a user is using it.
for _, name in ipairs({ "currency:shop", "currency:shop_empty" }) do
	wrench.register_node(name, {
		lists = { "customers_gave", "owner_gives", "owner_wants", "stock" },
		metas = {
			infotext = wrench.META_TYPE_STRING,
			owner = wrench.META_TYPE_STRING,
		},
		owned = true,
	})
end

