
-- Register wrench support for mesecons

-- TODO: update neighboring mesecons:wire or nodes (via after_dig_node?)

local function register_node_on_off(name, def)
	wrench.register_node(name .. "_off", def)
	def.drop = true
	wrench.register_node(name .. "_on", def)
end

-- Commandblock

register_node_on_off("mesecons_commandblock:commandblock", {
	-- ignore after_place function: sets owner
	owner = true,
	metas = {
		infotext = wrench.META_TYPE_STRING,
		commands = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
})

-- Detectors

register_node_on_off("mesecons_detector:node_detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		distance = wrench.META_TYPE_STRING,
		digiline_channel = wrench.META_TYPE_STRING,
		scanname = wrench.META_TYPE_STRING,
	},
})

register_node_on_off("mesecons_detector:object_detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		digiline_channel = wrench.META_TYPE_STRING,
		scanname = wrench.META_TYPE_STRING,
	},
})

-- Controllers

local luacontroller_defs = {
	drop = true,
	metas = {
		code = wrench.META_TYPE_STRING,
		lc_memory = wrench.META_TYPE_STRING,
		luac_id = wrench.META_TYPE_INT,
		formspec = wrench.META_TYPE_STRING,
		real_portstates = wrench.META_TYPE_INT,
	},
}

for a = 0, 1 do
for b = 0, 1 do
for c = 0, 1 do
for d = 0, 1 do
	local state = d .. c .. b .. a
	wrench.register_node("mesecons_luacontroller:luacontroller" .. state, luacontroller_defs)

	wrench.register_node("mesecons_microcontroller:microcontroller" .. state, {
		drop = "mesecons_microcontroller:microcontroller0000",
		metas = {
			infotext = wrench.META_TYPE_STRING,
			code = wrench.META_TYPE_STRING,
			afterid = wrench.META_TYPE_INT,
			eeprom = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			real_portstates = wrench.META_TYPE_INT,
		},
	})
end
end
end
end

wrench.register_node("mesecons_luacontroller:luacontroller_burnt", luacontroller_defs)
