
-- Register wrench support for xdecor

local S = wrench.translator

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
		metas = {
			infotext = wrench.META_TYPE_IGNORE,
			formspec = wrench.META_TYPE_IGNORE,
		},
	})
end

-- Cauldron

nodes = {
	"xdecor:cauldron_empty",
	"xdecor:cauldron_idle",
	"xdecor:cauldron_boiling",
	"xdecor:cauldron_soup",
}

for _, nodename in pairs(nodes) do
	wrench.register_node(nodename, {
		metas = {
			infotext = wrench.META_TYPE_STRING,
		},
		description = function(pos, meta, node, player)
			local desc = minetest.registered_nodes[node.name].description
			return desc ~= "" and desc or minetest.registered_nodes[node.name].infotext
		end,
	})
end

-- Chessboard

wrench.register_node("realchess:chessboard", {
	lists = {"board"},
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,

		playerBlack = wrench.META_TYPE_STRING,
		playerWhite = wrench.META_TYPE_STRING,
		lastMove = wrench.META_TYPE_STRING,

		blackAttacked = wrench.META_TYPE_STRING,
		whiteAttacked = wrench.META_TYPE_STRING,

		lastMoveTime = wrench.META_TYPE_INT,
		castlingBlackL = wrench.META_TYPE_INT,
		castlingBlackR = wrench.META_TYPE_INT,
		castlingWhiteL = wrench.META_TYPE_INT,
		castlingWhiteR = wrench.META_TYPE_INT,

		moves = wrench.META_TYPE_STRING,
		eaten = wrench.META_TYPE_STRING,
		mode = wrench.META_TYPE_STRING,
	},
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes[node.name].description
		return S("@1 with game \"@2\" vs. \"@3\"", desc, meta:get_string("playerWhite"), meta:get_string("playerBlack"))
	end
})

-- Enchantment Table

wrench.register_node("xdecor:enchantment_table", {
	lists = {"tool", "mese"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
	},
})

-- Hive

wrench.register_node("xdecor:hive", {
	timer = true,
	lists = {"honey"},
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
	},
})

-- Item Frame

wrench.register_node("xdecor:itemframe", {
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		item = wrench.META_TYPE_STRING,
	},
	owned = true,
	after_place = function(pos, player, stack)
		-- Force item update
		local timer = minetest.get_node_timer(pos)
		timer:start(0)
	end,
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes[node.name].description
		local item = meta:get_string("item")
		if item and item ~= "" then
			local d = ItemStack(item):get_short_description()
			return S("@1 with item \"@2\"", desc, d or item)
		else
			return desc
		end
	end,
})

-- Mailbox

local mailbox_metas = {
	owner = wrench.META_TYPE_STRING,
	infotext = wrench.META_TYPE_STRING,
	formspec = wrench.META_TYPE_STRING,
}

for i = 1, 7 do
	mailbox_metas["giver"..i] = wrench.META_TYPE_STRING
	mailbox_metas["stack"..i] = wrench.META_TYPE_STRING
end

wrench.register_node("xdecor:mailbox", {
	lists = {"mailbox", "drop"},
	metas = mailbox_metas,
	owned = true,
})

-- Workbench

wrench.register_node("xdecor:workbench", {
	lists = {"tool", "input", "hammer", "forms", "storage"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
	owned = true,
	timer = true,
})
