
-- Register wrench support for xdecor

xdecor:register_repairable("wrench:wrench")

local nodes = {
	"xdecor:cabinet",
	"xdecor:cabinet_half",
	"xdecor:empty_shelf",
	"xdecor:multishelf",
}

for _, nodename in pairs(nodes) do
	wrench.register_node(nodename, {
		lists = {"main"},
	})
end

-- cauldron

nodes = {
	"xdecor:cauldron_empty",
	"xdecor:cauldron_idle",
	"xdecor:cauldron_boiling",
	"xdecor:cauldron_soup",
}

local function translated(player, text)
	local player_name = player:get_player_name()
	local lang_code =  minetest.get_player_information(player_name).lang_code
	return minetest.get_translated_string(lang_code, text)
end

for _, nodename in pairs(nodes) do
	wrench.register_node(nodename, {
		metas = {
			infotext = wrench.META_TYPE_STRING,
		},
		description = function(pos, meta, node, player)
			local str = translated(player, minetest.registered_nodes[node.name].infotext)
			local i = string.find(str, "-")
			return (i and i > 0) and string.sub(str, 1, i - 1) or str
		end,

	})
end

-- enchantment_table

wrench.register_node("xdecor:enchantment_table", {
	lists = { "tool", "mese" },
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
})

-- itemframe

wrench.register_node("xdecor:itemframe", {
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		item = wrench.META_TYPE_STRING,
	},
	owned = true,
	after_place = function(pos, player, stack)
                -- force item update
		local timer = minetest.get_node_timer(pos)
		timer:start(0)
	end,
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes[node.name].description
		local item = meta:get_string("item")
		if item and item ~= "" then
			local d = ItemStack(item):get_short_description()
			return string.format("%s with \"%s\"", desc, d or item)
		else
			return desc
		end
	end,
})

-- mailbox

local mailbox_metas = {
	owner = wrench.META_TYPE_STRING,
	infotext = wrench.META_TYPE_STRING,
	formspec = wrench.META_TYPE_STRING,
}

for i = 1, 7 do
    mailbox_metas["giver" .. i] = wrench.META_TYPE_STRING
    mailbox_metas["stack" .. i] = wrench.META_TYPE_STRING
end

wrench.register_node("xdecor:mailbox", {
	lists = {"mailbox", "drop"},
	metas = mailbox_metas,
	owned = true,
})

-- workbench

wrench.register_node("xdecor:workbench", {
	lists = { "tool", "input", "hammer", "forms", "storage" },
	metas = {
		infotext = wrench.META_TYPE_STRING,
	},
	owned = true,
	after_place = function(pos, player, stack)
		local timer = minetest.get_node_timer(pos)
		timer:start(3.0)
	end,
})
