
-- Register wrench support for the christmas mod

for _, colour in ipairs(christmas.present_colours) do
	wrench.register_node("christmas:present_" .. colour.name, {
	})
end

