require("mineunit")

-- Some Mineunit modules, should be good enough for wrench
mineunit("core")
mineunit("protection")
mineunit("player")
mineunit("server")

-- Just for default:stone, could use any node instead of `default` but real placement requires supporting node
fixture("default")

-- Load wrench mod
sourcefile("init")

-- Load bitchange mod fixture for tests, depends on wrench
fixture("bitchange")

describe("Wrench", function()

	-- Create world with 5 x 1 x 1 stone layer in case node placement requires support node below location.
	world.set_default_node("air")
	world.layout({
		{{{x=0,y=0,z=0},{x=4,y=0,z=0}}, "default:stone"},
	})

	-- Execute on mods loaded callbacks to finish loading mods.
	mineunit:mods_loaded()

	local Sam = Player("Sam")
	local SX = Player("SX")

	function wrench_test_setup_and_teardown()
		-- Basic setup and teardown for tests, setup/teardown can be stacked within describe block
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
	end

	describe("bitchange:shop", function()

		wrench_test_setup_and_teardown()
		setup(function()
			-- Place bitchange:shop and insert some item stacks into inventories
			world.place_node({x=0,y=1,z=0}, "bitchange:shop", Sam)
			minetest.get_meta({x=0,y=1,z=0}):get_inventory():set_stack("stock", 2, "default:stone 42")
			minetest.get_meta({x=0,y=1,z=0}):get_inventory():set_stack("cust_ow", 3, "default:sand 1")
		end)

		it("can register node for wrench", function()
			-- Modified copy/paste code from https://github.com/SmallJoker/bitchange/blob/master/shop.lua @ 733ce6f4
			-- Checking `wrench.plus` instead of `wrench` and changed `wrench:register_node` to `wrench.register_node`
			if minetest.get_modpath("wrench") and wrench.plus then
				local STRING = wrench.META_TYPE_STRING
				wrench.register_node("bitchange:shop", {
					lists = {"stock", "custm", "custm_ej", "cust_ow", "cust_og", "cust_ej"},
					metas = {
						owner = STRING,
						infotext = STRING,
						title = STRING,
					},
					owned = true
				})
			end
		end)

		it("can be picked up", function()
			-- Sam uses wrench holding sneak targeting node at pos from directly above it
			Sam:do_use_from_above({x=0,y=1,z=0}, {sneak=true})

			-- Check that bitchange:shop node is gone from world
			assert.nodename("air", {x=0,y=1,z=0})

			-- Check that Sam got correct item, next test does extended validation for stack
			assert.has_item(Sam, "main", 2, "bitchange:shop 1")

			-- Verify tool wear, value should change on successful operation
			assert.lt(0, Sam:get_inventory():get_stack("main", 1):get_wear())
		end)

		it("correctly placed after picked up", function()
			-- SX gets and places shop itemstack picked up by Sam
			SX:get_inventory():set_stack("main", 1, Sam:get_inventory():get_stack("main", 2))
			SX:do_place_from_above({x=2,y=1,z=0})

			-- Check that correct node was placed
			assert.nodename("bitchange:shop", {x=2,y=1,z=0})

			-- Get metadata for validation
			local meta = minetest.get_meta({x=2,y=1,z=0})

			-- Validate metadata fields of placed node
			local expected_fields = {
				owner = "Sam",
				infotext = "Exchange shop (owned by Sam)",
				formspec = "test formspec",
			}
			assert.same(expected_fields, meta:to_table().fields)

			-- Validate inventory of placed node
			local inv = meta:get_inventory()
			assert.equals(5*4, inv:get_size("stock"))
			assert.equals(5*4, inv:get_size("custm"))
			assert.equals(4, inv:get_size("custm_ej"))
			assert.equals(2*2, inv:get_size("cust_ow"))
			assert.equals(2*2, inv:get_size("cust_og"))
			assert.equals(4, inv:get_size("cust_ej"))

			-- Check that inventory contains expected items and other slots are empty
			assert.same(ItemStack(), inv:get_stack("stock", 1))
			assert.same(ItemStack("default:stone 42"), inv:get_stack("stock", 2))
			assert.same(ItemStack(), inv:get_stack("cust_ow", 2))
			assert.same(ItemStack("default:sand 1"), inv:get_stack("cust_ow", 3))
		end)

	end)

	describe("default:cobble", function()

		wrench_test_setup_and_teardown()
		setup(function()
			world.place_node({x=1,y=1,z=0}, "default:cobble", Sam)
		end)

		it("cannot be picked up", function()
			-- Sam uses wrench holding sneak targeting node at pos from directly above it
			Sam:do_use_from_above({x=1,y=1,z=0}, {sneak=true})

			-- Check that default:cobble is still in world
			assert.nodename("default:cobble", {x=1,y=1,z=0})

			-- Check that Sam did not receive new item, second inventory slot is empty
			assert.has_item(Sam, "main", 2, ItemStack())
		end)

	end)

	describe("no-op tool use", function()

		wrench_test_setup_and_teardown()

		local function test_noop_use(description, controls)
			it(description, function()
				-- Sam uses wrench holding sneak targeting nothing
				Sam:set_pos({x=9999,y=9999,z=9999})
				Sam:do_use(controls)
				-- Check that Sam still have wrench and did not receive new item
				assert.has_item(Sam, "main", 1, "wrench:wrench 1")
				assert.has_item(Sam, "main", 2, ItemStack())
				-- Verify tool wear, no operation should not affect tool
				assert.equals(0, Sam:get_inventory():get_stack("main", 1):get_wear())
			end)
		end

		test_noop_use("works pointing nothing (sneak)", {sneak=true})
		test_noop_use("works pointing nothing (aux1)", {aux1=true})
		test_noop_use("works pointing nothing (no modifers)")

	end)

end)
