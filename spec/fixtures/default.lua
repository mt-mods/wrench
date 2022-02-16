
local function register_node(name, groups, additional_definition)
	local definition = {
		description = name.." description",
		tiles = { "default_"..name },
		groups = groups,
	}
	for k,v in pairs(additional_definition or {}) do definition[k] = v end
	minetest.register_node(":default:"..name, definition)
end

-- Register some basic nodes
register_node("stone", {cracky = 3, stone = 1}, {is_ground_content = true, drop = "default:cobble"})
register_node("cobble", {cracky=3, stone = 2})
