# Factorio Mod: Charcoal Kiln

Factorio mod that adds a charcoal kiln, which is a special type of furnace that makes coal from wood and wooden objects.

**Mod portal:** https://mods.factorio.com/mod/charcoal-kiln

You can install the mod using the in-game mod manager, or by downloading it from the mod portal page linked above to your game's `mods` directory.


## Mod description

This mod adds a **Charcoal kiln**, which is a special type of furnace that makes coal from wood.

Optionally (enabled by default), additional recipes will be added to make charcoal from other wooden objects, like wooden chests and small electric poles. This gives you a simple way to recycle some of the early-game items.

I know there is a lot of similar mods already, but most of them either add an additional intermediate item or change the behaviour of wood in regular furnaces. This mod simply adds a new crafting machine to directly turn wood to coal.

## Mod compatibility

There are no known mod incompatibilities so far. It probably doesn't make sense to combine the mod with another charcoal mod, though.

The mod currently only adds charcoal recipes for the base game items `wood`, `wooden-chest` and `small-electric-pole` (if they exist). Wood items added by other mods will be ignored.

If you want to add custom charcoal recipes for items from your own mod, this mod comes with a simple-to-use shared library that provides functions for that. See [the example](https://github.com/binaryDiv/factorio-charcoal-kiln/blob/main/lib.lua#L6-L20) within the library code, and don't forget to add this mod as an optional dependency.

## Support

Feel free to report bugs and mod incompatibilities or to request new features either on the [Discussion page](https://mods.factorio.com/mod/charcoal-kiln/discussion) or in the [GitHub issues](https://github.com/binaryDiv/factorio-charcoal-kiln).
