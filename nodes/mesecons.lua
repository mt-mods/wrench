
-- Register wrench support for mesecons

local S = wrench.translator

local function register_node_on_off(name, def)
	wrench.register_node(name.."_off", def)
	def.drop = true
	wrench.register_node(name.."_on", def)
end

local desc_conf = function(pos, meta, node, player)
        local desc = minetest.registered_nodes[node.name].description
        return S("@1 with configuration", desc)
end

-- Commandblock

register_node_on_off("mesecons_commandblock:commandblock", {
	-- ignore after_place function: sets owner
	owned = true,
	metas = {
		infotext = wrench.META_TYPE_STRING,
		commands = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
	description = desc_conf,
})

-- Detectors

register_node_on_off("mesecons_detector:node_detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		distance = wrench.META_TYPE_STRING,
		digiline_channel = wrench.META_TYPE_STRING,
		scanname = wrench.META_TYPE_STRING,
	},
	description = desc_conf,
})

register_node_on_off("mesecons_detector:object_detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		digiline_channel = wrench.META_TYPE_STRING,
		scanname = wrench.META_TYPE_STRING,
	},
	description = desc_conf,
})

-- Controllers

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

local microcontroller_def = {
	drop = true,
	metas = {
		infotext = wrench.META_TYPE_STRING,
		code = wrench.META_TYPE_STRING,
		afterid = wrench.META_TYPE_INT,
		eeprom = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		real_portstates = wrench.META_TYPE_INT,
	},
	description = function(pos, meta, node, player)
		return meta:get_string("infotext")
	end,
}

for a = 0, 1 do
for b = 0, 1 do
for c = 0, 1 do
for d = 0, 1 do
	local state = d..c..b..a
	wrench.register_node("mesecons_luacontroller:luacontroller"..state, luacontroller_def)
	wrench.register_node("mesecons_microcontroller:microcontroller"..state, microcontroller_def)
end
end
end
end

luacontroller_def.drop = nil
wrench.register_node("mesecons_luacontroller:luacontroller_burnt", luacontroller_def)
