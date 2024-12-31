
-- Register wrench support for locator mod

wrench.register_node("locator:radar", {
	lists = {},
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		range = wrench.META_TYPE_INT,
	},
	after_place = function(pos, player)
		local node_def = core.registered_nodes["locator:radar"]
		node_def.on_receive_fields(pos, nil, {}, player)
	end,
})

for i = 1, 3 do
	local node_name = "locator:beacon_" .. i
	wrench.register_node(node_name, {
		lists = {},
		metas = {
			active = wrench.META_TYPE_INT,
			formspec = wrench.META_TYPE_IGNORE,
			infotext = wrench.META_TYPE_IGNORE,
			name = wrench.META_TYPE_STRING,
			owner = wrench.META_TYPE_STRING,
			range = wrench.META_TYPE_IGNORE,
		},
		after_pickup = function(pos)
			locator.remove_beacon(pos)
		end,
		after_place = function(pos, player)
			local node_def = core.registered_nodes[node_name]
			node_def.on_receive_fields(pos, nil, {}, player)
		end,
	})
end
