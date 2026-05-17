
-- Register wrench support for mooncontroller

for a = 0, 1 do
for b = 0, 1 do
for c = 0, 1 do
for d = 0, 1 do
	local state = d..c..b..a
	wrench.register_node("mooncontroller:mooncontroller"..state, {
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
	})
end
end
end
end
