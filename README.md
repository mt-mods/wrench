![](https://github.com/mt-mods/wrench/workflows/luacheck/badge.svg)
[![License](https://img.shields.io/badge/license-LGPLv2.0%2B-purple.svg)](https://www.gnu.org/licenses/old-licenses/lgpl-2.0.en.html)

<!--
[![ContentDB](https://content.minetest.net/packages/mt-mods/wrench/shields/downloads/)](https://content.minetest.net/packages/mt-mods/wrench/)
-->

# Wrench

<img src="textures/technic_wrench.png"/>

The wrench tool allows you to left-click on nodes with inventories to pick them up.

This mod is a fork from wrench/ in https://github.com/mt-mods/technic

# Supported Mods and Nodes

* https://github.com/minetest/minetest_game
  - bones:bones
  - default:chest
  - default:chest_locked
  - default:furnace
  - default:sign_wall_wood
  - default:sign_wall_steel
  - vessels:shelf
* https://github.com/minetest-mods/3d_armor
  - 3d_armor_stand:armor_stand
  - 3d_armor_stand:locked_armor_stand
* https://github.com/mt-mods/basic_signs
  - basic_signs:sign_wall_glass
  - basic_signs:sign_wall_locked
  - basic_signs:sign_wall_obsidian_glass
  - basic_signs:sign_wall_plastic
  - basic_signs:sign_wall_steel_\*
* https://notabug.org/TenPlus1/bees
  - bees:hive_wild
* https://github.com/Lokrates/Biofuel
  - biofuel:refinery
* https://github.com/HybridDog/connected_chests
* https://github.com/minetest-mods/digilines
  - digilines:chest
  - digilines:lcd
  - digilines:lightsensor
  - digilines:rtc
* https://github.com/mt-mods/digistuff
  - digistuff:advtouchscreen
  - digistuff:button_\*
  - digistuff:camera
  - digistuff:card_reader
  - digistuff:controller_programmed
  - digistuff:detector
  - digistuff:eeprom
  - digistuff:gpu
  - digistuff:ioexpander_\*
  - digistuff:light_\*
  - digistuff:movestone
  - digistuff:nic
  - digistuff:noteblock
  - digistuff:panel
  - digistuff:piezo
  - digistuff:piston\*
  - digistuff:ram
  - digistuff:timer
  - digistuff:touchscreen
  - digistuff:wall_knob_configured
* https://github.com/minetest-mods/digtron
  - digtron:battery_holder
  - digtron:inventory
  - digtron:fuelstore
  - digtron:combined_storage
* https://github.com/minetest-mods/drawers
  - drawers:wood
  - drawers:acacia_wood
  - drawers:aspen_wood
  - drawers:junglewood
  - drawers:pine_wood
* https://github.com/minetest-mods/mesecons
  - mesecons_commandblock:commandblock_\*
  - mesecons_detector:node_detector_\*
  - mesecons_detector:object_detector_\*
  - mesecons_luacontroller:luacontroller\*
  - mesecons_microcontroller:microcontroller\*
* https://notabug.org/tenplus1/mobs_redo
  - mobs:spawner
* https://github.com/minetest-mods/more_chests
  - more_chests:cobble
  - more_chests:dropbox
  - more_chests:fridge
  - more_chests:big_fridge
  - more_chests:shared
  - more_chests:secret
  - more_chests:toolbox_\*
* https://github.com/mt-mods/pipeworks
  - pipeworks:autocrafter
  - pipeworks:deployer_\*
  - pipeworks:dispenser_\*
  - pipeworks:nodebreaker_\*
  - pipeworks:\*filter
  - pipeworks:lua_tube\*
  - pipeworks:mese_sand_tube_\*
  - pipeworks:mese_tube_\*
  - pipeworks:teleport_tube_\*
* https://notabug.org/tenplus1/protector
  - protector:chest
  - protector:protect
  - protector:protect2
* https://github.com/mt-mods/signs_lib
* https://github.com/mt-mods/technic
  - technic:cnc\*
  - technic:coal_alloy_furnace\*
  - technic:\*chest\*
  - technic:injector
  - technic:tool_workshop
  - technic:\*_alloy_furnace\*
  - technic:\*_battery_box\*
  - technic:\*_centrifuge\*
  - technic:\*_compressor\*
  - technic:\*_electric_furnace\*
  - technic:\*_extractor\*
  - technic:\*_freezer\*
  - technic:\*_grinder\*
* https://github.com/minetest-mods/xdecor
  - realchess:chessboard
  - xdecor:cabinet
  - xdecor:cabinet_half
  - xdecor:empty_shelf
  - xdecor:multishelf
  - xdecor:cauldron_\*
  - xdecor:enchantment_table
  - xdecor:itemframe
  - xdecor:mailbox

# Settings in `minetest.conf`
```ini
# Allows the wrench to be crafted if either the 'technic' or 'default' mod is installed.
wrench.enable_crafting = true
```

# Contributors (originally technic modpack)

* kpoppel
* Nekogloop
* Nore/Ekdohibs
* ShadowNinja
* VanessaE
* BuckarooBanzay
* OgelGames
* int-ua
* S-S-X
* H-V-Smacker
* groxxda
* SwissalpS
* And many others...

# License (originally technic modpack)

Unless otherwise stated, all components of this modpack are licensed under the
LGPL, V2 or later.  See also the individual mod folders for their
secondary/alternate licenses, if any.
