
-- Register wrench support for mesecons_luacontroller

local S = wrench.translator

local luacontroller_def = {
	drop = true,
	metas = {
		code = wrench.META_TYPE_STRING,
		lc_memory = wrench.META_TYPE_STRING,
		luac_id = wrench.META_TYPE_INT,
		formspec = wrench.META_TYPE_STRING,
		real_portstates = wrench.META_TYPE_INT,
		ignore_offevents = wrench.META_TYPE_STRING,
	},
	description = function(pos, meta, node, player)
		local desc = minetest.registered_nodes["mesecons_luacontroller:luacontroller0000"].description
		return S("@1 with code", desc)
	end,
}

for a = 0, 1 do
for b = 0, 1 do
for c = 0, 1 do
for d = 0, 1 do
	local state = d..c..b..a
	wrench.register_node("mesecons_luacontroller:luacontroller"..state, luacontroller_def)
end
end
end
end

luacontroller_def.drop = nil
wrench.register_node("mesecons_luacontroller:luacontroller_burnt", luacontroller_def)
