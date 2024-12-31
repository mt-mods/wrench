
-- Register wrench support for the soundblock mod

wrench.register_node("soundblock:block", {
	lists = {},
	metas = {
		gain = wrench.META_TYPE_INT,
		hear_distance = wrench.META_TYPE_INT,
		interval_max = wrench.META_TYPE_INT,
		interval_min = wrench.META_TYPE_INT,
		randomize_position = wrench.META_TYPE_INT,
		selected_sound_key = wrench.META_TYPE_STRING,
		state = wrench.META_TYPE_STRING,
	},
	timer = true,
})

