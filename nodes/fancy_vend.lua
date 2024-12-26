
-- Register wrench support for the fancy_vend mod

for _, vendor in ipairs({
		"fancy_vend:player_vendor",
		"fancy_vend:player_depo",
		"fancy_vend:admin_vendor",
		"fancy_vend:admin_depo",
	}) do
	wrench.register_node(vendor, {
		lists = { "given_item", "main", "wanted_item" },
		metas = {
			alerted = wrench.META_TYPE_STRING,
			configured = wrench.META_TYPE_STRING,
			infotext = wrench.META_TYPE_IGNORE,
			item = wrench.META_TYPE_STRING,
			log = wrench.META_TYPE_STRING,
			message = wrench.META_TYPE_STRING,
			owner = wrench.META_TYPE_STRING,
			settings = wrench.META_TYPE_STRING,
		},
		after_pickup = function(pos, node, meta_table, player)
			local above_node_pos = table.copy(pos)
			above_node_pos.y = above_node_pos.y + 1
			core.remove_node(above_node_pos)
			fancy_vend.remove_item(above_node_pos)
		end,
		after_place = function(pos)
			-- This happens during vendor's on_place function is being run!
			-- So we need to hack around that race condition.
			-- At this time wrench has already set the meta, so we can stash
			-- it from the node with fancy_vend function
			local settings = fancy_vend.get_vendor_settings(pos)
			core.after(0, function(p, s)
				-- Use fancy_vend's own function to apply the stashed settings
				fancy_vend.set_vendor_settings(p, s)
				fancy_vend.refresh_vendor(p)
			end, pos, settings)
		end,
	})
end

