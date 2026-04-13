
-- Register wrench support for drawers mod nodes

local INT, STRING = wrench.META_TYPE_INT, wrench.META_TYPE_STRING

local function compact_description_for_drawer(meta, id)
	local item_name = meta:get_string("name" .. id)
	local item_desc = ItemStack(item_name):get_short_description() or item_name
	local count = meta:get_int("count" .. id)
	if 1000 <= count then
		count = math.round(count * .001) .. "k"
	end
	return count .. " " .. item_desc
end

local function description(pos, meta, node, player)
	local node_def = core.registered_nodes[node.name]
	local drawers = node_def.groups.drawer

	if 1 == drawers then
		return compact_description_for_drawer(meta, "")
	end

	local id = 1
	local descriptions = {}
	repeat
		table.insert(descriptions, compact_description_for_drawer(meta, id))
		id = id + 1
	until id > drawers

  if 2 == drawers then
		return table.concat(descriptions, "\n")
	end

	return descriptions[1] .. "   " .. descriptions[2] .. "\n"
		.. descriptions[3] .. "   " .. descriptions[4]
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
