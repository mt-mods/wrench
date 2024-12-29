
-- Register wrench support for the easyvend mod

for _, name in ipairs({
		"easyvend:vendor", "easyvend:vendor_on",
		"easyvend:depositor", "easyvend:depositor_on",
	}) do
	wrench.register_node(name, {
		lists = { "gold", "item" },
		metas = {
			configmode = wrench.META_TYPE_INT,
			cost = wrench.META_TYPE_INT,
			earnings = wrench.META_TYPE_INT,
			formspec = wrench.META_TYPE_IGNORE,
			infotext = wrench.META_TYPE_IGNORE,
			itemname = wrench.META_TYPE_STRING,
			joke_id = wrench.META_TYPE_INT,
			joketimer = wrench.META_TYPE_INT,
			message = wrench.META_TYPE_IGNORE,
			number = wrench.META_TYPE_INT,
			owner = wrench.META_TYPE_STRING,
			status = wrench.META_TYPE_IGNORE,
			stock = wrench.META_TYPE_INT,
			wear = wrench.META_TYPE_INT,
		},
	})
end
