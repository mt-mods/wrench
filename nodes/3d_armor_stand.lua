
-- Register wrench support for armor stands

local S = wrench.translator

local def = minetest.registered_nodes["3d_armor_stand:armor_stand"]

local add_entity_and_node = def and def.after_place_node
local update_entity = def and def.on_metadata_inventory_take

-- detect which version is being used
-- commit 8f775a64f0a29afbcc63cbcd78938c17609ed187 merged all lists into one
local has_single_inventory = false
for _, lbm in ipairs(core.registered_lbms) do
	if "3d_armor_stand:update_inventories" == lbm.name then
		has_single_inventory = true
		break
	end
end

local legacy_lists = {
	"armor_head",
	"armor_torso",
	"armor_legs",
	"armor_feet",
}

local lists = has_single_inventory and { "main" } or legacy_lists

local function after_place(pos, player)
	add_entity_and_node(pos, player)
	local meta = core.get_meta(pos)
	local inv = meta:get_inventory()
	if has_single_inventory then
		-- Server is running newer version with single inv-list.
		-- Items may need to be moved from separate lists and old lists removed.
		local temp_list
		for i, list_name in ipairs(legacy_lists) do
			temp_list = inv:get_list(list_name)
			-- If first legacy list doesn't exist,
			-- assume this stand was already updated before it was picked up.
			if not temp_list then break end

			-- Move to main list.
			inv:set_stack("main", i, temp_list[1])
			-- Remove legacy list.
			inv:set_size(list_name, 0)
		end
	else
		-- Server is running older version. As convenience for testers
		-- we support some backward compatability.
		local main_list = inv:get_list("main")
		if main_list then
			-- A wrenched stand from a newer version has been placed.
			for i, stack in ipairs(main_list) do
				inv:set_stack(legacy_lists[i], 1, stack)
			end
			inv:set_size("main", 0)
		end
	end
	update_entity(pos)
end

local function description(pos, meta, node)
	local desc = minetest.registered_nodes[node.name].description
	return S("@1 with armor", desc)
end

wrench.register_node("3d_armor_stand:armor_stand", {
	lists = lists,
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
	after_place = after_place,
	description = description,
})

wrench.register_node("3d_armor_stand:locked_armor_stand", {
	lists = lists,
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
	owned = true,
	after_place = after_place,
	description = description,
})

wrench.register_node("3d_armor_stand:shared_armor_stand", {
	lists = lists,
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
	after_place = after_place,
	description = description,
})

