
-- Register wrench support for the wine mod

wrench.register_node("wine:wine_barrel", {
	lists = { "dst", "src", "src_b" },
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_IGNORE,
		status = wrench.META_TYPE_FLOAT,
		water = wrench.META_TYPE_INT,
	},
	timer = true,
	after_place = function(pos)
		local timer = core.get_node_timer(pos)
		if not timer:started() then
			timer:start(0)
		end
	end,
})

