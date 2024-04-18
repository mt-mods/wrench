
-- Register wrench support for bones

local S = wrench.translator

if bones.redo then
	local function can_pickup_bones(pos, player)
		local meta = minetest.get_meta(pos)
		if meta:get_string("infotext") == "" then
			return false
		end
		if meta:get_int("time") >= bones.share_time then
			return true
		end
		local name = player:get_player_name()
		local owner = meta:get_string("owner")
		if owner == "" or owner == name or minetest.check_player_privs(name, "protection_bypass") then
			return true
		end
		return false, S("Cannot pickup node. Owned by @1.", owner)
	end
	wrench.register_node("bones:bones", {
		lists = {"main"},
		metas = {
			owner = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			time = wrench.META_TYPE_INT,
		},
		timer = true,
		can_pickup = can_pickup_bones,
	})
else
	wrench.register_node("bones:bones", {
		lists = {"main"},
		metas = {
			owner = wrench.META_TYPE_STRING,
			_owner = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			time = wrench.META_TYPE_INT,
		},
		owned = true,
	})
end
