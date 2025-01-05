# Wrench [wrench]

![](https://github.com/mt-mods/wrench/workflows/luacheck/badge.svg)
[![License](https://img.shields.io/badge/license-LGPLv2.0%2B-purple.svg)](https://www.gnu.org/licenses/old-licenses/lgpl-2.0.en.html)
[![ContentDB](https://content.minetest.net/packages/mt-mods/wrench/shields/downloads/)](https://content.minetest.net/packages/mt-mods/wrench/)

The wrench tool allows you to pick up nodes with inventories or other metadata, such as chests, signs, drawers, machines, etc, and transport them intact to another location.

![](screenshot.png?raw=true)

This mod was originally part of [`technic_plus`](https://github.com/mt-mods/technic), but was split out to be a standalone mod. It's now much more powerful, supporting many more mods, and is also safer to use.

## Usage

To pick up nodes, simply punch them with the wrench (left-click). The picked-up node can then be placed as normal.

## Settings

- `wrench.enable_crafting` - Adds a craft recipe for the wrench if either 'technic' or 'default' is installed. Default enabled.
- `wrench.tool_uses` - The number of times the wrench can be used before breaking. Set to 0 for infinite uses. Default 50.
- `wrench.compress_data` - Enables compression of item metadata when picking up nodes. Significantly decreases the size of item metadata. Default enabled.

## Supported Mods

To make maintaining support easier, wrench only supports specific versions of mods and their nodes, as listed below. Other versions will likely be compatible, but support is only guaranteed for the versions listed.

- `3d_armor_stand` - https://github.com/minetest-mods/3d_armor
- `basic_signs` - https://github.com/mt-mods/basic_signs
- `beacon` - https://github.com/OgelGames/beacon
- `bees` - https://notabug.org/TenPlus1/bees
- `biofuel` - https://github.com/Lokrates/Biofuel
- `bones` - https://github.com/minetest/minetest_game OR https://github.com/OgelGames/bones
- `christmas` - https://github.com/mt-mods/christmas
- `connected_chests` - https://github.com/HybridDog/connected_chests
- `currency` - https://github.com/mt-mods/currency
- `default` - https://github.com/minetest/minetest_game
- `digibuilder` - https://github.com/BuckarooBanzay/digibuilder
- `digilines` - https://github.com/minetest-mods/digilines
- `digiscreen` - https://cheapiesystems.com/git/digiscreen
- `digistuff` - https://github.com/mt-mods/digistuff
- `digtron` - https://github.com/minetest-mods/digtron
- `drawers` - https://github.com/minetest-mods/drawers
- `easyvend` - https://github.com/minetest-mirrors/easyvend
- `ehlphabet` - https://github.com/mt-mods/ehlphabet
- `fancy_vend` - https://github.com/mt-mods/fancy_vend
- `jumpdrive` - https://github.com/mt-mods/jumpdrive
- `locator` - https://github.com/pandorabox-io/locator
- `mapserver` - https://github.com/minetest-mapserver/mapserver_mod
- `mesecons_commandblock` - https://github.com/minetest-mods/mesecons
- `mesecons_detector` - https://github.com/minetest-mods/mesecons
- `mesecons_luacontroller` - https://github.com/minetest-mods/mesecons
- `mesecons_microcontroller` - https://github.com/minetest-mods/mesecons
- `missions` - https://github.com/mt-mods/missions
- `mobs` - https://notabug.org/tenplus1/mobs_redo
- `more_chests` - https://github.com/minetest-mods/more_chests
- `moreblocks` - https://github.com/minetest-mods/moreblocks
- `pipeworks` - https://github.com/mt-mods/pipeworks
- `powerbanks` - https://github.com/OgelGames/powerbanks
- `protector` - https://notabug.org/tenplus1/protector
- `signs_lib` - https://github.com/mt-mods/signs_lib
- `smartshop` - https://github.com/pandorabox-io/smartshop
- `soundblock` - https://github.com/mt-mods/soundblock
- `spacecannon` - https://github.com/mt-mods/spacecannon
- `technic` - https://github.com/mt-mods/technic
- `technic_chests` - https://github.com/mt-mods/technic
- `technic_cnc` - https://github.com/mt-mods/technic
- `vacuum` - https://github.com/mt-mods/vacuum
- `vessels` - https://github.com/minetest/minetest_game
- `wine` - https://codeberg.org/tenplus1/wine
- `xdecor` - https://github.com/minetest-mods/xdecor

## API

An API is provided to add support for more nodes. See [API.md](API.md) for details.

## License

Textures - [CC BY-SA 4.0](LICENSE-MEDIA)

Everything else - [LGPL, V2 or later.](LICENSE)
