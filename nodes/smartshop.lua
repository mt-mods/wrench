
-- Register wrench support for the smartshop mod

wrench.register_node("smartshop:shop", {
	lists = {
		"give1", "give2", "give3", "give4",
		"main",
		"pay1", "pay2", "pay3", "pay4",
	},
	metas = {
		alerted = wrench.META_TYPE_INT,
		creative = wrench.META_TYPE_INT,
		ghost = wrench.META_TYPE_INT,
		infotext = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
		state = wrench.META_TYPE_IGNORE,
		type = wrench.META_TYPE_INT,
	},
	after_pickup = function(pos)
		-- Remove entities
		if smartshop.update_entities then
			smartshop.update_entities(pos, "clear")
		else
			-- Older version
			smartshop.update(pos, "clear")
		end
		-- Give smartshop a chance to keep track of statistics
		smartshop.update_info(pos)
	end,
	after_place = function(pos)
		-- Update infotext
		smartshop.update_info(pos)
		-- Create entities
		if smartshop.update_entities then
			smartshop.update_entities(pos, "update")
		else
			-- Older version
			smartshop.update(pos, "update")
		end
	end,
})

