# API
## Node registration
Schematic:
```lua
wrench.register_node(node.name, {
        lists = list,
        -- inventory list

        lists_ignore = lists_ignore,
        -- ignored and not saved inventory list

        metas = table,
        -- Table for node metadata:
            -- name: Meta name
            -- type: Data type:
                -- `wrench.META_TYPE_IGNORE` ignored and not saved
                -- `wrench.META_TYPE_FLOAT` for float
                -- `wrench.META_TYPE_STRING` for string
                -- `wrench.META_TYPE_INT` for integer

        description = nil,
        -- Default behaver:
            -- when `lists` is not `nil`
                -- `minetest.registered_nodes[node.name].description` + " with items"
            -- when `lists` is `nil` and only `metas.channel` is defined
                -- `minetest.registered_nodes[node.name].description` + " with cannel '<CHANNEL>'"
            -- when `lists` is `nil`
                -- `minetest.registered_nodes[node.name].description` + " with configuration"
        description = `wrench.description_with_items`,
        -- Description of the node + " with items"
        description = `wrench.description_with_configuration`,
        -- Description of the node + " with configuration"
        description = `wrench.description_with_channel`,
        -- Description of the node + " with channel " + channel
        description = `wrench.description_with_text`,
        -- Description of the node + " with text " + text
        description = function(pos, meta, node, player),
        -- Function returns description

        drop = nil,
        -- Default dropped item is the node itself
        drop = true,
        -- Use `minetest.registered_nodes[node.name].drop`
        drop = "default:cobble",
        -- Name of dropped item

        owned = nil,
        -- Default: anyone can pickup this node
        owned = true,
        -- Only `metas["owner"]` can pickup this node

        timer = nil,
        -- Default
        timer = true,
        -- Save NodeTimers

        before_pickup = nil,
        -- Default
        before_pickup = function(pos, meta, node, player)
        -- Function called before pickup node

        after_pickup = nil,
        -- default
        after_pickup = function(pos, node, meta_table, player)
        -- Function called after pickup node

        after_place = nil,
        -- Default
        after_place = function(pos, player, itemstack, pointed_thing),
        -- Function called after place node
})
```
Example:
```lua
wrench.register_node("bones:bones", {
        lists = {"main"},
        metas = {
                        owner = wrench.META_TYPE_STRING,
                        infotext = wrench.META_TYPE_STRING,
                        formspec = wrench.META_TYPE_STRING,
                        time = wrench.META_TYPE_INT,
        },
        owned = true,
})
```
