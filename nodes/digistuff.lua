
-- Register wrench support for digistuff

local S = wrench.translator

function desc_stripped(node)
	local desc = minetest.registered_nodes[node.name].description
	desc = string.gsub(desc, " %(you hacker you!%)", "")
	return string.gsub(desc, " %- you hacker you!%)", ")")
end

function desc_stripped_with_channel(pos, meta, node, player)
	return S("@1 with channel \"@2\"", desc_stripped(node), meta:get_string("channel"))
end

--[[
	NOTE: it makes no sense to pickup unconfigured nodes with 'wrench' like:
	- "digistuff:button"
	- "digistuff:controller"
	- "digistuff:wall_knob"
--]]

-- Buttons

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

-- Controller

wrench.register_node("digistuff:controller_programmed", {
	drop = false,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
	description = desc_stripped_with_channel,
})

-- Detector

wrench.register_node("digistuff:detector", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_INT,
		radius = wrench.META_TYPE_INT,
	},
})

-- GPU

local gpu_def = {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
}
for i = 0, 7 do
	gpu_def.metas["buffer"..i] = wrench.META_TYPE_STRING
end
wrench.register_node("digistuff:gpu", gpu_def)

-- Memory: eeprom & ram

local mem_def = {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
}
for i = 0, 31 do
	mem_def.metas[string.format("data%02i", i)] = wrench.META_TYPE_STRING
end
wrench.register_node("digistuff:eeprom", mem_def)
wrench.register_node("digistuff:ram", mem_def)

-- I/O Expander

-- The input state depends on the neighbor. That's why we don't save this.
local save_i_state = false
local save_o_state = true
local i_state_type = save_i_state == true and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE
local o_state_type = save_o_state == true and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE
for i = 0, 15 do
	wrench.register_node("digistuff:ioexpander_"..i, {
		drop = save_o_state == false and "ioexpander_0",
		metas = {
			formspec = wrench.META_TYPE_STRING,
			channel = wrench.META_TYPE_STRING,
			aon = i_state_type,
			bon = i_state_type,
			con = i_state_type,
			don = i_state_type,
			outstate = o_state_type,
		},
		description = i == 0 or desc_stripped_with_channel,
	})
end

-- Light

for i = 0, 14 do
	wrench.register_node("digistuff:light_"..i, {
		metas = {
			formspec = wrench.META_TYPE_STRING,
			channel = wrench.META_TYPE_STRING,
		},
		description = function(pos, meta, node, player)
			local state = i == 0 and "off" or S("light level @1", i)
			return S("@1 (@2) with channel \"@3\"", desc_stripped(node), state, meta:get_string("channel"))
		end,
	})
end

-- Movestone

-- TODO: Save (and restore) state and activity when pickup a moving movestone?
local movestone_save_state = false
wrench.register_node("digistuff:movestone", {
	owned = true,
	timer = movestone_save_state,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
		state = movestone_save_state and wrench.META_TYPE_STRING or wrench.META_TYPE_IGNORE,
		active = movestone_save_state and wrench.META_TYPE_INT or wrench.META_TYPE_IGNORE,
	},
})

-- Nic

wrench.register_node("digistuff:nic", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
	},
})

-- Noteblock

wrench.register_node("digistuff:noteblock", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
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

-- .. with channel sniffing to restore "fastrepeat" or "slowrepeat"
local node_def = minetest.registered_nodes["digistuff:piezo"]
local orig_action = node_def.digiline.effector.action
node_def.digiline.effector.action = function(pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	if (meta:get_string("channel") == channel) then
		meta:set_string("last_msg", msg)
	end
	return orig_action(pos, node, channel, msg)
end
wrench.register_node("digistuff:piezo", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		last_msg = wrench.META_TYPE_STRING,
	},
	after_place = function(pos, player, stack, pointed)
		local meta = minetest.get_meta(pos)
		local last_msg = meta:get_string("last_msg")
		if last_msg == "fastrepeat" or last_msg == "slowrepeat" then
			local node = minetest.get_node(pos)
			local def = minetest.registered_nodes[node.name]
			def.digiline.effector.action(pos, node, meta:get_string("channel"), last_msg)
		end
	end,
})

-- Piston

-- TODO: restore extended piston?
local piston_extended_restore = true
wrench.register_node("digistuff:piston", {
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
})
wrench.register_node("digistuff:piston_ext", {
	drop = not piston_extended_restore,
	before_remove = function(pos, meta, node, player)
		-- remove "digistuff:piston_pusher"
		local def = minetest.registered_nodes[node.name]
		def.after_dig_node(pos, node)
	end,
	after_place = piston_extended_restore and function(pos, player, stack, pointed)
		local channel = minetest.get_meta(pos):get_string("channel")
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = "digistuff:piston", param2 = node.param2})
		node = minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		def.digiline.effector.action(pos, node, channel, { action = "extend" })
	end,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		owner = wrench.META_TYPE_STRING,
	},
	description = desc_stripped_with_channel,
})

-- Timer

wrench.register_node("digistuff:timer", {
	timer = true,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		loop = wrench.META_TYPE_INT,
	},
})

-- Touchscreens

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
		data = wrench.META_TYPE_STRING,
		init = wrench.META_TYPE_INT,
	},
})

-- Wall Knob

wrench.register_node("digistuff:wall_knob_configured", {
	drop = false,
	metas = {
		formspec = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		channel = wrench.META_TYPE_STRING,
		min = wrench.META_TYPE_INT,
		max = wrench.META_TYPE_INT,
		value = wrench.META_TYPE_INT,
		protected = wrench.META_TYPE_INT,
	},
	description = desc_stripped_with_channel,
})
