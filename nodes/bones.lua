
-- Register wrench support for bones

if bones.redo then
	wrench.register_node("bones:bones", {
		lists = {"main"},
		metas = {
			owner = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_STRING,
			time = wrench.META_TYPE_INT,
		},
		owned = true,
		timer = true,
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
