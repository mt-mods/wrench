
-- Register wrench support for signs_lib (overrides default signs)

local S = wrench.translator

local function get_sign_description(pos, meta, node)
	local desc = minetest.registered_nodes[node.name].description
	local text = meta:get_string("text")
	if #text > 32 then
		text = text:sub(1, 24).."..."
	end
	return S("@1 with text \"@2\"", desc, text)
end

local function remove_glow(pos, meta)
	meta:set_string("glow", "")
end

-- Wood signs

local wood_signs = {
	"default:sign_wall_wood",
	"default:sign_wood_hanging",
	"default:sign_wood_onpole",
	"default:sign_wood_onpole_horiz",
	"default:sign_wood_yard",
}

for _, n in pairs(wood_signs) do
	wrench.register_node(n, {
		metas = {
			text = wrench.META_TYPE_STRING,
			glow = wrench.META_TYPE_STRING,
			widefont = wrench.META_TYPE_INT,
			unifont = wrench.META_TYPE_INT,
		},
		before_remove = remove_glow,
		after_place = function(pos, player, stack, pointed)
			signs_lib.after_place_node(pos, player, stack, pointed)
			signs_lib.update_sign(pos)
		end,
		description = get_sign_description,
		drop = "default:sign_wall_wood",
	})
end

-- Steel signs (locked)

local steel_signs = {
	"default:sign_wall_steel",
	"default:sign_steel_hanging",
	"default:sign_steel_onpole",
	"default:sign_steel_onpole_horiz",
	"default:sign_steel_yard",
}

for _, n in pairs(steel_signs) do
	wrench.register_node(n, {
		metas = {
			text = wrench.META_TYPE_STRING,
			glow = wrench.META_TYPE_STRING,
			widefont = wrench.META_TYPE_INT,
			unifont = wrench.META_TYPE_INT,
			owner = wrench.META_TYPE_STRING,
		},
		before_remove = remove_glow,
		after_place = function(pos, player, stack, pointed)
			signs_lib.after_place_node(pos, player, stack, pointed, true)
			signs_lib.update_sign(pos)
		end,
		description = get_sign_description,
		drop = "default:sign_wall_steel",
		owned = true,
	})
end
