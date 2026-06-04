
-- Register wrench support for drawers mod nodes

local INT, STRING = wrench.META_TYPE_INT, wrench.META_TYPE_STRING

local function slot_description(meta, id)
	local count = meta:get_int("count"..id)
	if count == 0 then
		return ""
	end
	local item = ItemStack(meta:get_string("name"..id)):get_short_description()
	if count >= 1000 then
		count = string.format("%.1fk", count / 1000)
	end
	return "\n"..count.." "..item
end

-- Assemble definitions for 1x1, 1x2 and 1x4 drawers
for _, drawer_type in ipairs({1, 2, 4}) do

	local function description(pos, meta, node)
		local desc = wrench.description_with_items(pos, meta, node)
		if drawer_type == 1 then
			return desc..slot_description(meta, "")
		end
		for i=1, drawer_type do
			desc = desc..slot_description(meta, i)
		end
		return desc
	end

	local def = {
		lists = {"upgrades"},
		metas = {
			formspec = wrench.META_TYPE_IGNORE,
		},
		description = description,
		after_place = drawers.spawn_visuals
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
