
-- Register wrench support for signs_lib (overrides default signs)

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
			infotext = wrench.META_TYPE_IGNORE,
		},
		before_pickup = remove_glow,
		after_place = function(pos, player, stack, pointed)
			signs_lib.after_place_node(pos, player, stack, pointed)
			signs_lib.update_sign(pos)
		end,
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
			infotext = wrench.META_TYPE_IGNORE,
		},
		before_pickup = remove_glow,
		after_place = function(pos, player, stack, pointed)
			signs_lib.after_place_node(pos, player, stack, pointed, true)
			signs_lib.update_sign(pos)
		end,
		drop = "default:sign_wall_steel",
		owned = true,
	})
end
