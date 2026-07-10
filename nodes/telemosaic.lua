
local S = wrench.translator

local function get_dest_string(meta)
	local dest = meta:get_string("telemosaic:dest")
	if dest:find(":") then
		-- Old version
		local list = string.split(pos, ':')
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
	},
	description = description,
}

for _,state in ipairs({"", "_disabled", "_err"}) do
	wrench.register_node("telemosaic:beacon"..state, def) 
	wrench.register_node("telemosaic:beacon"..state.."_protected", def) 
end
