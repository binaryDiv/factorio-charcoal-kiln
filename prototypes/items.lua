local utils = require("prototypes.utils")
local item_sounds = require("__base__.prototypes.item_sounds")

-- Create charcoal kiln item (similar to stone furnace)
local charcoal_kiln = {
    type = "item",
    name = "charcoal-kiln",
    icon = utils.path("graphics/icons/charcoal-kiln.png"),

    -- Sort Charcoal kiln before Stone furnace ("a[stone-furnace]")
    subgroup = "smelting-machine",
    order = "a[charcoal-kiln]",

    place_result = "charcoal-kiln",
    stack_size = 50,
    inventory_move_sound = item_sounds.brick_inventory_move,
    pick_sound = item_sounds.brick_inventory_pickup,
    drop_sound = item_sounds.brick_inventory_move,
}

data:extend {
    charcoal_kiln,
}
