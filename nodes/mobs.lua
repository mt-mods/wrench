
-- Register wrench support for mobs_redo

wrench.register_node("mobs:spawner", {
	metas = {
		command = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
	description = function(pos, meta, node, player)
		return meta:get_string("infotext")
	end,
})
