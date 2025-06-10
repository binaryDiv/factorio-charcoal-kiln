local utils = require("prototypes.utils")

-- Base the Charcoal kiln off the Stone furnace
local charcoal_kiln = table.deepcopy(data.raw.furnace["stone-furnace"])

-- Customize entity
charcoal_kiln.name = "charcoal-kiln"
charcoal_kiln.icon = utils.path("graphics/icons/charcoal-kiln.png")
charcoal_kiln.minable.result = "charcoal-kiln"
charcoal_kiln.corpse = "charcoal-kiln-remnants"
charcoal_kiln.fast_replaceable_group = nil
charcoal_kiln.next_upgrade = nil

-- Use special recipe category
charcoal_kiln.crafting_categories = { "charcoal-kiln" }

-- Reduce energy usage (stone furnace: 90kW)
charcoal_kiln.energy_usage = "60kW"

-- Override graphics
charcoal_kiln.graphics_set.animation.layers[1].filename = utils.path(
    "graphics/entities/charcoal-kiln.png"
)
charcoal_kiln.graphics_set.working_visualisations[1].animation.layers[2].filename = utils.path(
    "graphics/entities/charcoal-kiln-light.png"
)

-- Create remnants based off the stone furnace
local charcoal_kiln_remnants = table.deepcopy(data.raw.corpse["stone-furnace-remnants"])
charcoal_kiln_remnants.name = "charcoal-kiln-remnants"
charcoal_kiln_remnants.icon = utils.path("graphics/icons/charcoal-kiln.png")
charcoal_kiln_remnants.animation[1].filename = utils.path("graphics/entities/charcoal-kiln-remnants.png")

-- Add new prototypes
data:extend {
    charcoal_kiln,
    charcoal_kiln_remnants,
}
