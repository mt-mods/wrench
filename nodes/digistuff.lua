
-- Register wrench support for digistuff

-- Buttons

--[[ makes no sense
wrench.register_node("digistuff:button", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		protected = wrench.META_TYPE_INT,
		msg = wrench.META_TYPE_STRING,
		mlight = wrench.META_TYPE_INT,
	},
})
--]]

local nodes = {
	"digistuff:button_off",
	"digistuff:button_off_pushed",
	"digistuff:button_on_pushed",
}
for _, node in ipairs(nodes) do
	wrench.register_node(node, {
		drop = "digistuff:button_off",
		metas = {
			formspec = wrench.META_TYPE_STRING,
			channel = wrench.META_TYPE_STRING,
			protected = wrench.META_TYPE_INT,
			msg = wrench.META_TYPE_STRING,
			mlight = wrench.META_TYPE_INT,
		},
	})
end

-- Camera

wrench.register_node("digistuff:camera", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		radius = wrench.META_TYPE_INT,
		distance = wrench.META_TYPE_INT,
	},
})

-- Cardreader

wrench.register_node("digistuff:card_reader", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		writepending = wrench.META_TYPE_INT,
		writedata = wrench.META_TYPE_STRING,
		writedescription = wrench.META_TYPE_STRING,
	},
})

--[[ TODO
wrench.register_node("digistuff:controller_programmed", {
	drop = "digistuff:controller",
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})
]]--

-- Detector

wrench.register_node("digistuff:detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_INT,
		radius = wrench.META_TYPE_INT,
	},
})

--[[ TODO ...
wrench.register_node("digistuff:eeprom", {
	-- has after_place function
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		--? data[0..31] = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:ram", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		--? data[0..31] = wrench.META_TYPE_STRING,

	},
})

wrench.register_node("digistuff:gpu", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		--? buffer[0..7] = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:ioexpander_0", {
	-- drop = "digistuff:ioexpander_0",
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		don = wrench.META_TYPE_INT,
		con = wrench.META_TYPE_INT,
		bon = wrench.META_TYPE_INT,
		aon = wrench.META_TYPE_INT,
		outstate = wrench.META_TYPE_INT,
	},
})

wrench.register_node("digistuff:movestone", {
	owned = true,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
		state = wrench.META_TYPE_STRING,
		active = wrench.META_TYPE_INT,
	},
})

wrench.register_node("digistuff:noteblock", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:panel", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		locked = wrench.META_TYPE_INT,
		text = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:piezo", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:piston", {
	--owned = true,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:piston_ext", {
	drop = true,
	--owned = true,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:timer", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})
--]]

-- Touchscreens

--[[ very complex ...
wrench.register_node("digistuff:advtouchscreen", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		init = wrench.META_TYPE_INT,
	},
})

wrench.register_node("digistuff:touchscreen", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		init = wrench.META_TYPE_INT,
	},
})
--]]

--[[ TODO
wrench.register_node("digistuff:wall_knob", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		min = wrench.META_TYPE_INT,
		max = wrench.META_TYPE_INT,
		value = wrench.META_TYPE_INT,
		protected = wrench.META_TYPE_INT,
	},
})

wrench.register_node("digistuff:wall_knob_configured", {
	drop = true,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		min = wrench.META_TYPE_INT,
		max = wrench.META_TYPE_INT,
		value = wrench.META_TYPE_INT,
		protected = wrench.META_TYPE_INT,
	},
})
--]]
