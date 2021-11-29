
-- Register wrench support for pipeworks

wrench.register_node("pipeworks:autocrafter", {
	lists = { "src", "dst", "recipe", "output" },
	metas = {
		enabled = wrench.META_TYPE_INT,
		channel = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
        description = function(pos, meta, node, player)
		return meta:get_string("infotext")
	end,
	after_place = function(pos, player, stack)
		local meta = minetest.get_meta(pos)
		if meta and meta:get_int("enabled") == 1 then
			local timer = minetest.get_node_timer(pos)
			timer:start(1) -- craft_time = 1
		end
	end,
})

local wielder_data = {
	lists = { "main" },
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
}

-- TODO: convert *_on to *_off nodes before pickpup?
wrench.register_node("pipeworks:deployer_off", wielder_data)
wrench.register_node("pipeworks:deployer_on", wielder_data)

wrench.register_node("pipeworks:dispenser_off", wielder_data)
wrench.register_node("pipeworks:dispenser_on", wielder_data)
