
-- Register wrench support for digiscreen

local update_screen
for _,lbm in pairs(minetest.registered_lbms) do
	if lbm.name == "digiscreen:respawn" then
		update_screen = lbm.action
	end
end

wrench.register_node("digiscreen:digiscreen", {
	metas = {
		formspec = wrench.META_TYPE_IGNORE,
		channel = wrench.META_TYPE_STRING,
		data = wrench.META_TYPE_STRING,
	},
	after_place = update_screen,
})
