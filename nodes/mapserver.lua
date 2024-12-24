
-- Register wrench support for mapserver mod

wrench.register_node("mapserver:border", {
	lists = {},
	metas = {
		color = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
		index = wrench.META_TYPE_INT,
		infotext = wrench.META_TYPE_IGNORE,
		name = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
	owned = true,
	after_place = function(pos, player)
		local node_def = core.registered_nodes["mapserver:border"]
		node_def.on_receive_fields(pos, nil, {}, player)
	end,
})


wrench.register_node("mapserver:label", {
	lists = {},
	metas = {
		color = wrench.META_TYPE_STRING,
		direction = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
		size = wrench.META_TYPE_STRING,
		text = wrench.META_TYPE_STRING,
	},
	owned = true,
	after_place = function(pos, player)
		local node_def = core.registered_nodes["mapserver:label"]
		node_def.on_receive_fields(pos, nil, {}, player)
	end,
})


wrench.register_node("mapserver:train", {
	lists = {},
	metas = {
		color = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
		index = wrench.META_TYPE_INT,
		infotext = wrench.META_TYPE_IGNORE,
		line = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
		station = wrench.META_TYPE_STRING,
	},
	owned = true,
	after_place = function(pos, player)
		local node_def = core.registered_nodes["mapserver:train"]
		node_def.on_receive_fields(pos, nil, {}, player)
	end,
})


for _, colour in ipairs({ "blue", "green", "orange", "red", "purple" }) do
	local node_name = "mapserver:poi_" .. colour
	wrench.register_node(node_name, {
		lists = {},
		metas = {
			addr = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_IGNORE,
			icon = wrench.META_TYPE_STRING,
			image = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			name = wrench.META_TYPE_STRING,
			owner = wrench.META_TYPE_STRING,
			url = wrench.META_TYPE_STRING,
		},
		owned = true,
		after_place = function(pos, player)
			local node_def = core.registered_nodes[node_name]
			node_def.on_receive_fields(pos, nil, {}, player)
		end,
	})
end

