
-- Register wrench support for digistuff

local S = wrench.translator

local function desc_stripped(node)
	local desc = minetest.registered_nodes[node.name].description
	desc = string.gsub(desc, " %(you hacker you!%)", "")
	return string.gsub(desc, " %- you hacker you!%)", ")")
end

local function desc_stripped_with_channel(pos, meta, node, player)
	return S("@1 with channel \"@2\"", desc_stripped(node), meta:get_string("channel"))
end

-- Buttons
-- Unconfigured node cannot be picked up (digistuff:button)

local nodes = {
	"digistuff:button_off",
	"digistuff:button_off_pushed",
	"digistuff:button_on_pushed",
}

for _, node in ipairs(nodes) do
	wrench.register_node(node, {
		drop = "digistuff:button_off",
		metas = {
			channel = wrench.META_TYPE_STRING,
			protected = wrench.META_TYPE_INT,
			msg = wrench.META_TYPE_STRING,
			mlight = wrench.META_TYPE_INT,
		},
		description = desc_stripped_with_channel,
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

-- Card Reader

wrench.register_node("digistuff:card_reader", {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		writepending = wrench.META_TYPE_INT,
		writedata = wrench.META_TYPE_STRING,
		writedescription = wrench.META_TYPE_STRING,
	},
})

-- Game Controller
-- Unconfigured node cannot be picked up (digistuff:controller)

wrench.register_node("digistuff:controller_programmed", {
	metas = {
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
	description = desc_stripped_with_channel,
	-- Prevent picking up occupied controllers.
	can_pickup = function(pos)
		return core.registered_nodes["digistuff:controller_programmed"].can_dig(pos)
	end,
})

-- Detector

wrench.register_node("digistuff:detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		radius = wrench.META_TYPE_INT,
	},
})

-- GPU

local gpu_def = {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
	},
}

for i = 0, 7 do
	gpu_def.metas["buffer"..i] = wrench.META_TYPE_STRING
end

wrench.register_node("digistuff:gpu", gpu_def)

-- Memory: EEPROM & SRAM

local mem_def = {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
	},
}

for i = 0, 31 do
	mem_def.metas[string.format("data%02i", i)] = wrench.META_TYPE_STRING
end

wrench.register_node("digistuff:eeprom", mem_def)
wrench.register_node("digistuff:ram", mem_def)

-- I/O Expander
-- Inputs are not saved because they depend adjacent nodes.

for i = 0, 15 do
	wrench.register_node("digistuff:ioexpander_"..i, {
		metas = {
			formspec = wrench.META_TYPE_IGNORE,
			channel = wrench.META_TYPE_STRING,
			aon = wrench.META_TYPE_IGNORE,
			bon = wrench.META_TYPE_IGNORE,
			con = wrench.META_TYPE_IGNORE,
			don = wrench.META_TYPE_IGNORE,
			outstate = wrench.META_TYPE_INT,
		},
		description = i > 0 and desc_stripped_with_channel or nil,
	})
end

-- Light

for i = 0, 14 do
	wrench.register_node("digistuff:light_"..i, {
		metas = {
			formspec = wrench.META_TYPE_IGNORE,
			channel = wrench.META_TYPE_STRING,
		},
		description = function(pos, meta, node, player)
			local channel = meta:get_string("channel")
			return S("@1 (light level @2) with channel \"@3\"", desc_stripped(node), i, channel)
		end,
	})
end

-- Movestone
-- Moving movestones will be stopped when picked up.

wrench.register_node("digistuff:movestone", {
	owned = true,
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
		state = wrench.META_TYPE_IGNORE,
		active = wrench.META_TYPE_IGNORE,
	},
})

-- Nic

wrench.register_node("digistuff:nic", {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
	},
})

-- Noteblock

wrench.register_node("digistuff:noteblock", {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
	},
})

-- Panel

wrench.register_node("digistuff:panel", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		locked = wrench.META_TYPE_INT,
		text = wrench.META_TYPE_STRING,
	},
})

-- Piezo
-- Sounds will be stopped when picked up.

wrench.register_node("digistuff:piezo", {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
	},
})

-- Pistons
-- Extended pistons will be retracted when picked up.

wrench.register_node("digistuff:piston", {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
})

wrench.register_node("digistuff:piston_ext", {
	drop = true,
	before_pickup = function(pos, meta, node, player)
		-- Remove piston head
		local def = minetest.registered_nodes[node.name]
		def.after_dig_node(pos, node)
	end,
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
	description = desc_stripped_with_channel,
})

-- Timer

wrench.register_node("digistuff:timer", {
	timer = true,
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
		loop = wrench.META_TYPE_INT,
	},
})

-- Touchscreens

wrench.register_node("digistuff:touchscreen", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		data = wrench.META_TYPE_STRING,
		init = wrench.META_TYPE_INT,
		locked = wrench.META_TYPE_INT,
		no_prepend = wrench.META_TYPE_INT,
		real_coordinates = wrench.META_TYPE_INT,
		fixed_size = wrench.META_TYPE_INT,
		width = wrench.META_TYPE_STRING,
		height = wrench.META_TYPE_STRING,
	},
})

-- Wall Knob
-- Unconfigured node cannot be picked up (digistuff:wall_knob)

wrench.register_node("digistuff:wall_knob_configured", {
	drop = false,
	metas = {
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		min = wrench.META_TYPE_INT,
		max = wrench.META_TYPE_INT,
		value = wrench.META_TYPE_INT,
		protected = wrench.META_TYPE_INT,
	},
	description = desc_stripped_with_channel,
})

