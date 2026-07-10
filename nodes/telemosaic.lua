
local S = wrench.translator

local function get_dest_string(meta)
	local dest = meta:get("telemosaic:dest")
	if dest and dest:find(":") then
		-- Old version
		local list = string.split(dest, ':')
		local p = {
			x = tonumber(list[1]),
			y = tonumber(list[2]),
			z = tonumber(list[3])
		}
		if p.x and p.y and p.z then
			return core.pos_to_string(p)
		end
	else
		return dest
	end
end

local function save_old_pos(pos)
	core.get_meta(pos):set_string("old_pos", core.pos_to_string(pos))
end

local function after_place(pos)
	local meta = core.get_meta(pos)
	local old_pos = meta:get("old_pos")
	local dest = get_dest_string(meta)
	if not old_pos or not dest then
		return
	end
	local other_meta = core.get_meta(core.string_to_pos(dest))
	local other_dest = get_dest_string(other_meta)
	if other_dest and old_pos == other_dest then
		-- Update the connected telemosaic
		other_meta:set_string("telemosaic:dest", core.pos_to_string(pos))
	end
	meta:set_string("old_pos", "")
end

local function description(pos, meta, node, player)
	local suffix = node.name:match("_protected$") and "_protected" or ""
	local name = core.registered_nodes["telemosaic:beacon_off"..suffix].description
	local dest = get_dest_string(meta) or ""
	return S("@1 with destination @2", name, dest)
end

local def = {
	metas = {
		["telemosaic:dest"] = wrench.META_TYPE_STRING,
		channel = core.get_modpath("digilines") and wrench.META_TYPE_STRING or nil,
		old_pos = wrench.META_TYPE_STRING,  -- Temporary value used to update connected beacons
	},
	description = description,
	after_place = after_place,
	can_pickup = save_old_pos,
}

for _,state in ipairs({"", "_disabled", "_err"}) do
	wrench.register_node("telemosaic:beacon"..state, def)
	wrench.register_node("telemosaic:beacon"..state.."_protected", def)
end
