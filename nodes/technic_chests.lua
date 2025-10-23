
-- Register wrench support for technic_chests

local splitstacks = wrench.has_pipeworks and wrench.META_TYPE_INT

local chests_meta = {
	iron = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		sort_mode = wrench.META_TYPE_INT,
		splitstacks = splitstacks,
	},
	copper = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		sort_mode = wrench.META_TYPE_INT,
		autosort = wrench.META_TYPE_INT,
		splitstacks = splitstacks,
	},
	silver = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		sort_mode = wrench.META_TYPE_INT,
		autosort = wrench.META_TYPE_INT,
		splitstacks = splitstacks,
	},
	gold = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		sort_mode = wrench.META_TYPE_INT,
		autosort = wrench.META_TYPE_INT,
		splitstacks = splitstacks,
		color = wrench.META_TYPE_INT,
	},
	mithril = {
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		sort_mode = wrench.META_TYPE_INT,
		autosort = wrench.META_TYPE_INT,
		channel = wrench.META_TYPE_STRING,
		send_put = wrench.META_TYPE_INT,
		send_take = wrench.META_TYPE_INT,
		send_inject = wrench.META_TYPE_INT,
		send_pull = wrench.META_TYPE_INT,
		send_overflow = wrench.META_TYPE_INT,
		splitstacks = splitstacks,
	},
}

local function with_owner_field(metas)
	local result = table.copy(metas)
	result.owner = wrench.META_TYPE_STRING
	return result
end

local function description(pos, meta, node, player)
	local infotext = meta:get_string('infotext')
	-- Default label starts with an escape char for translated text.
	if 27 == infotext:sub(1, 1):byte() then
		return wrench.description_with_items(pos, meta, node, player)
	end
	return core.formspec_escape(infotext)
end

local function register_chests(material, color)
	local lists_ignore = (material ~= "iron" and material ~= "copper") and {"quickmove"} or nil
	wrench.register_node("technic:"..material.."_chest"..color, {
		lists = {"main"},
		lists_ignore = lists_ignore,
		metas = chests_meta[material],
		description = description,
	})
	wrench.register_node("technic:"..material.."_protected_chest"..color, {
		lists = {"main"},
		lists_ignore = lists_ignore,
		metas = chests_meta[material],
		description = description,
	})
	wrench.register_node("technic:"..material.."_locked_chest"..color, {
		lists = {"main"},
		lists_ignore = lists_ignore,
		metas = with_owner_field(chests_meta[material]),
		description = description,
		owned = true,
	})
end

for material in pairs(chests_meta) do
	register_chests(material, "")
end

-- Register extra nodes with color marking for gold chest

local chest_mark_colors = {
	"_black",
	"_blue",
	"_brown",
	"_cyan",
	"_dark_green",
	"_dark_grey",
	"_green",
	"_grey",
	"_magenta",
	"_orange",
	"_pink",
	"_red",
	"_violet",
	"_white",
	"_yellow",
}

for i = 1, 15 do
	register_chests("gold", chest_mark_colors[i])
end
