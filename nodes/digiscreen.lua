
-- Register wrench support for digiscreen

wrench.register_node("digiscreen:digiscreen", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		data = wrench.META_TYPE_STRING,
	},
	after_place = function(pos, player, stack, pointed)
		local meta = minetest.get_meta(pos)
		local node = minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		local data = minetest.deserialize(meta:get_string("data"))
		if data then
			-- Force screen update
			def.digiline.effector.action(pos, node, meta:get_string("channel"), data)
		end
	end,
})
