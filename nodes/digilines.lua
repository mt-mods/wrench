
-- Register wrench support for digilines

local desc_channel = function(pos, meta, node, player)
	local desc = minetest.registered_nodes[node.name].description
	return string.format("%s with channel \"%s\"", desc, meta:get_string("channel"))
end

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
	description = desc_channel,
})

wrench.register_node("digilines:rtc", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
	description = desc_channel,
})

wrench.register_node("digilines:lcd", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
	description = desc_channel,
})
