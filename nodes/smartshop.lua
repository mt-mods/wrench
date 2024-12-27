
-- Register wrench support for the smartshop mod

wrench.register_node("smartshop:shop", {
	lists = {
		"give1", "give2", "give3", "give4",
		"main",
		"pay1", "pay2", "pay3", "pay4",
	},
	metas = {
		alerted = wrench.META_TYPE_INT,
		type = wrench.META_TYPE_INT,
		ghost = wrench.META_TYPE_INT,
		creative = wrench.META_TYPE_INT,
		state = wrench.META_TYPE_INT,
		infotext = wrench.META_TYPE_IGNORE,
		owner = wrench.META_TYPE_STRING,
	},
	after_pickup = function(pos)
		-- Remove entities
		smartshop.update(pos, "clear")
		-- Give smartshop a chance to keep track of statistics
		smartshop.update_info(pos)
	end,
	after_place = function(pos)
		-- Update infotext
		smartshop.update_info(pos)
		-- Create entities
		smartshop.update(pos)
	end,
})

