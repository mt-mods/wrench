
-- Register wrench support for mesecons_commandblock

local states = { "off", "on" }
for _, state in ipairs(states) do
	wrench.register_node("mesecons_commandblock:commandblock_"..state, {
		-- ignore after_place function: sets owner
		owned = true,
		drop = state == "on",
		metas = {
			infotext = wrench.META_TYPE_STRING,
			commands = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_STRING,
			owner = wrench.META_TYPE_STRING,
		},
	})
end
