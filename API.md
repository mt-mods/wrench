# Wrench API

## Functions

#### `wrench.register_node(name, def)`

Registers a node so it can be picked up using the wrench.

**Arguments**
- `name` - The name of the node to be registered.
- `def` - The wrench definition for the node. (see specification below)

#### `wrench.unregister_node(name)`

Unregisters a node so it cannot be picked up using the wrench.

**Arguments**
- `name` - The name of the node to be unregistered.

#### `wrench.blacklist_item(name)`

Blacklists an item so any nodes containing the item cannot be picked up.

**Arguments**
- `name` - The name of the item to be blacklisted.

## Wrench Definition

Used by `wrench.register_node`.

```lua
{
	lists = {},
	-- Names of inventory lists to be saved.
	-- Must be a list of strings.

	lists_ignore = {},
	-- Names of inventory lists to be ignored and not saved.
	-- Must be a list of strings.
	
	metas = {},
	-- Metadata keys and values to be saved.
	-- Must contain all possible keys, even if the values are not to be saved.
	-- Must be a table of key-values, with the values being one of:
	-- * wrench.META_TYPE_IGNORE - Ignored and not saved.
	-- * wrench.META_TYPE_FLOAT - Float value.
	-- * wrench.META_TYPE_STRING - String value
	-- * wrench.META_TYPE_INT - Integer value.

	description = "",
	description = function(pos, meta, node, player),
	-- The description used for the picked up node.
	-- Must be either a string or a function that returns a string.
	-- Default behavior:
	-- * If `lists` is not `nil`: node description + " with items"
	-- * If `metas.text` is defined: node description` + " with text "<TEXT>""
	-- * If `metas.channel` is defined: node description` + " with channel "<CHANNEL>""
	-- * Otherwise: node description + " with configuration"

	drop = true,
	drop = "",
	-- The node that is returned when a node is picked up.
	-- Must be either `true` or a string.
	-- When value is true, the drop defined in the node definition is used.
	-- Default is the original node.

	owned = true,
	-- If true, only the owner of the node can pickup the node.

	timer = true,
	-- If true, the node timer is saved, and restarted upon placement.
	
	can_pickup = function(pos, player)
	-- Function called before a node is picked up.
	-- Return true to skip owner and protection checks.
	-- Return false to disallow pickup. Can also return an optional error message.

	before_pickup = function(pos, meta, node, player)
	-- Function called before a node is picked up, but after metadata has been stored.

	after_pickup = function(pos, node, meta_table, player)
	-- Function called after a node is picked up.
	-- Arguments are identical to `after_dig_node`.

	after_place = function(pos, player, itemstack, pointed_thing),
	-- Function called after a picked up node is placed down.
	-- Arguments are identical to `after_place_node`.
}

```

## Examples

#### Owned chest
```lua
wrench.register_node("default:chest_locked", {
	lists = {"main"},
	metas = {
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_STRING,
		formspec = wrench.META_TYPE_IGNORE,
	},
	owned = true,
})
```

#### Machine with timer
```lua
wrench.register_node("biofuel:refinery", {
	lists = {"src", "dst"},
	metas = {
		infotext = wrench.META_TYPE_STRING,
		progress = wrench.META_TYPE_INT,
	},
	timer = true,
})
```

#### Sign with text
```lua
wrench.register_node("basic_signs:sign_wall_locked", {
	metas = {
		text = wrench.META_TYPE_STRING,
		glow = wrench.META_TYPE_STRING,
		widefont = wrench.META_TYPE_INT,
		unifont = wrench.META_TYPE_INT,
		owner = wrench.META_TYPE_STRING,
		infotext = wrench.META_TYPE_IGNORE,
	},
	before_pickup = function(pos, meta, node, player)
		meta:set_string("glow", "")
	end
	after_place = function(pos, player, stack, pointed)
		signs_lib.after_place_node(pos, player, stack, pointed, true)
		signs_lib.update_sign(pos)
	end,
	drop = true,
	owned = true,
})
```