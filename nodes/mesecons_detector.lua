
-- Register wrench support for mesecons_detector

for _, state in pairs({"on", "off"}) do
	wrench.register_node("mesecons_detector:node_detector_"..state, {
		drop = state == "on",
		metas = {
			formspec = wrench.META_TYPE_IGNORE,
			distance = wrench.META_TYPE_STRING,
			digiline_channel = wrench.META_TYPE_STRING,
			scanname = wrench.META_TYPE_STRING,
		},
	})
	wrench.register_node("mesecons_detector:object_detector_"..state, {
		drop = state == "on",
		metas = {
			formspec = wrench.META_TYPE_IGNORE,
			digiline_channel = wrench.META_TYPE_STRING,
			scanname = wrench.META_TYPE_STRING,
		},
	})
end
