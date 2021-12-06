require("mineunit")

-- Some Mineunit modules, should be good enough for wrench
mineunit("core")
mineunit("protection")
mineunit("player")
mineunit("server")

-- Just for default:stone, could use any node instead of `default` but real placement requires supporting node
fixture("default")

-- Load drawers mod for tests, wrench drawers support depends on drawers mod
fixture("drawers")

-- Load wrench mod
sourcefile("init")

describe("Drawers", function()

	-- Execute on mods loaded callbacks to finish loading mods.
	mineunit:mods_loaded()

	local Sam = Player("Sam")
	local SX = Player("SX")

	-- Create world with 5 x 1 x 1 stone layer in case node placement requires support node below location.
	world.set_default_node("air")
	world.layout({
		{{{x=0,y=0,z=0},{x=4,y=0,z=0}}, "default:stone"},
	})
	world.place_node({x=0,y=1,z=0}, "drawers:wood2", Sam)

	local expected_drawer_fields = minetest.get_meta({x=0,y=1,z=0}):to_table().fields

	setup(function()
		-- reset and join players, Sam gets new wrench:wrench
		Sam:do_reset()
		SX:do_reset()
		mineunit:execute_on_joinplayer(Sam)
		mineunit:execute_on_joinplayer(SX)
		Sam:get_inventory():set_stack("main", 1, ItemStack("wrench:wrench"))
	end)

	teardown(function()
		-- after test set it done players will leave
		mineunit:execute_on_leaveplayer(SX)
		mineunit:execute_on_leaveplayer(Sam)
	end)

	it("registered drawer", function()
		-- Checks for drawers:wood because that one is always available and does not have dependencies
		assert.not_nil(wrench.registered_nodes["drawers:wood1"], "Drawer drawers:wood1 not registered for wrench")
		assert.not_nil(wrench.registered_nodes["drawers:wood2"], "Drawer drawers:wood2 not registered for wrench")
		assert.not_nil(wrench.registered_nodes["drawers:wood4"], "Drawer drawers:wood4 not registered for wrench")
	end)

	it("can be picked up", function()
		-- Sam uses wrench holding sneak targeting node at pos from directly above it
		Sam:do_use_from_above({x=0,y=1,z=0}, {sneak=true})

		-- Check that drawers:wood2 node is gone from world
		assert.nodename("air", {x=0,y=1,z=0})

		-- Check that Sam got correct item, next test does extended validation for stack
		assert.has_item(Sam, "main", 2, "drawers:wood2 1")

		-- Verify tool wear, value should change on successful operation
		assert.lt(0, Sam:get_inventory():get_stack("main", 1):get_wear())
	end)

	it("correctly placed after picked up", function()
		-- SX gets and places drawer picked up by Sam
		SX:get_inventory():set_stack("main", 1, Sam:get_inventory():get_stack("main", 2))
		SX:do_place_from_above({x=2,y=1,z=0})

		-- Check that correct node was placed
		assert.nodename("drawers:wood2", {x=2,y=1,z=0})

		-- Get metadata for validation
		local meta_fields = minetest.get_meta({x=2,y=1,z=0}):to_table().fields

		-- Validate metadata fields of placed node
		assert.same(expected_drawer_fields, meta_fields)
	end)

end)
