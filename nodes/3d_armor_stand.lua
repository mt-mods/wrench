
-- Register wrench support for armor stands

local S = wrench.translator

local def = minetest.registered_nodes["3d_armor_stand:armor_stand"]

local add_entity_and_node = def and def.after_place_node
local update_entity = def and def.on_metadata_inventory_put

local lists = {
	"armor_head",
	"armor_torso",
	"armor_legs",
	"armor_feet",
}

local function after_place(pos, player)
	add_entity_and_node(pos, player)
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
