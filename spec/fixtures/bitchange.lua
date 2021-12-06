
-- Cleaned up copy/paste from https://github.com/SmallJoker/bitchange/blob/master/shop.lua @ 733ce6f4
-- Added forced registration to save setting modpaths and modname, wrench API should work
--  without knowing anything about mod that is calling API to register nodes.

minetest.register_node(":bitchange:shop", {
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Exchange shop (owned by "..meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Exchange shop (constructing)")
		meta:set_string("formspec", "test formspec")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("stock", 5*4) -- needed stock for exchanges
		inv:set_size("custm", 5*4) -- stock of the customers exchanges
		inv:set_size("custm_ej", 4) -- ejected items if shop has no inventory room
		inv:set_size("cust_ow", 2*2) -- owner wants
		inv:set_size("cust_og", 2*2) -- owner gives
		inv:set_size("cust_ej", 4) -- ejected items if player has no inventory room
	end,
})
