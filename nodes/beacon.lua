
-- Register wrench support for the beacon mod

for id in pairs(beacon.colors) do
	wrench.register_node("beacon:" .. id, {
		lists = { "beacon_upgrades" },
		metas = {
			active = wrench.META_TYPE_STRING,
			beam_dir = wrench.META_TYPE_STRING,
			channel = wrench.META_TYPE_STRING,
			effect = wrench.META_TYPE_STRING,
			formspec = wrench.META_TYPE_IGNORE,
			owner = wrench.META_TYPE_STRING,
			range = wrench.META_TYPE_INT,
		},
		timer = true,
		after_place = function(pos, player)
			beacon.update_formspec(pos)
			if core.get_meta(pos):get_string("active") == "true" then
				beacon.activate(pos, player:get_player_name())
			end
		end,
	})
end

