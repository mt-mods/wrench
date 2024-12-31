
-- Register wrench support for the powerbanks mod

for i = 1, 3 do
	wrench.register_node("powerbanks:powerbank_mk" .. i .. "_node", {
		lists = { "main" },
		metas = {
			charge = wrench.META_TYPE_INT,
			formspec = wrench.META_TYPE_IGNORE,
			infotext = wrench.META_TYPE_IGNORE,
			owner = wrench.META_TYPE_STRING,
		},
		timer = true,
		after_place = function(pos)
			local timer = core.get_node_timer(pos)
			if not timer:is_started() then
				-- Just to re-create infotext and formspec.
				timer:start(0)
			end
		end,
	})
end

