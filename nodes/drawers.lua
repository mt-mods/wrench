
-- Register wrench support for drawers mod nodes

local S = wrench.translator
local INT, STRING = wrench.META_TYPE_INT, wrench.META_TYPE_STRING

local function description(pos, meta, node, player)
	local item_name = meta:get_string("name")
	-- Ignore cabinets with multiple drawers and empty ones.
	if "" == item_name then
		return wrench.description_with_items(pos, meta, node, player)
	end

	local node_def = core.registered_nodes[node.name]
	local node_desc = node_def.description or node.name
	local item_desc = core.registered_items[item_name].description or item_name
	return S("@1 with @2", node_desc, item_desc)
end

-- Assemble definitions for drawer type 1, 2 and 4
for _, drawer_type in ipairs({1, 2, 4}) do

	local def = {
		lists = {"upgrades"},
		metas = {
			formspec = wrench.META_TYPE_IGNORE,
		},
		after_place = drawers.spawn_visuals,
		description = description,
	}

	for i=1, drawer_type do

		local suffix = ""
		if drawer_type ~= 1 then
			-- Index as suffix
			suffix = i
		end

		def.metas["name"..suffix] = STRING
		def.metas["count"..suffix] = INT
		def.metas["max_count"..suffix] = INT
		def.metas["base_stack_max"..suffix] = INT
		def.metas["entity_infotext"..suffix] = STRING
		def.metas["stack_max_factor"..suffix] = INT
	end

	wrench.register_node("drawers:wood"..drawer_type, def)
	wrench.register_node("drawers:acacia_wood"..drawer_type, def)
	wrench.register_node("drawers:aspen_wood"..drawer_type, def)
	wrench.register_node("drawers:junglewood"..drawer_type, def)
	wrench.register_node("drawers:pine_wood"..drawer_type, def)
end
