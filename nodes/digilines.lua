
-- Register wrench support for digilines

wrench.register_node("digilines:chest", {
	lists = {"main"},
	metas = {
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digilines:lightsensor", {
	metas = {
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digilines:rtc", {
	metas = {
		channel = wrench.META_TYPE_STRING,
	},
})

local update_lcd = minetest.registered_nodes["digilines:lcd"].after_place_node

wrench.register_node("digilines:lcd", {
	metas = {
		text = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
	after_place = function(pos)
		local param2 = minetest.get_node(pos).param2
		if param2 == 0 or param2 == 1 then
			minetest.swap_node(pos, {name = "digilines:lcd", param2 = 3})
		end
		update_lcd(pos)
	end,
})
