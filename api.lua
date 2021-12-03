
function wrench.register_node(name, def)
	assert(type(name) == "string", "wrench.register_node invalid type for name")
	assert(type(def) == "table", "wrench.register_node invalid type for def")
	local node_def = minetest.registered_nodes[name]
	if node_def then
		local old_after_place = node_def.after_place_node
		minetest.override_item(name, {
			after_place_node = function(...)
				if not wrench.restore_node(...) and old_after_place then
					return old_after_place(...)
				end
			end
		})
		def = table.copy(def)
		if def.drop == true and type(node_def.drop) == "string" then
			def.drop = node_def.drop
		elseif def.drop and type(def.drop) ~= "string" then
			minetest.log("warning", "Ignoring invalid type for drop in definition for "..name)
			def.drop = nil
		end
		if def.drop and not wrench.registered_nodes[def.drop] then
			if def.drop ~= name then
				minetest.log("warning", "Ignoring unsupported node for drop in definition for "..name)
			end
			def.drop = nil
		end
		wrench.registered_nodes[name] = def
	else
		minetest.log("warning", "Attempt to register unknown node for wrench: "..name)
	end
end

function wrench.blacklist_item(name)
	assert(type(name) == "string", "wrench:blacklist_item invalid type for name")
	local node_def = minetest.registered_items[name]
	if node_def then
		wrench.blacklisted_items[name] = true
	else
		minetest.log("warning", "Attempt to blacklist unknown item for wrench: "..name)
	end
end