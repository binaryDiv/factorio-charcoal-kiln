local utils = require("prototypes.utils")

-- Define technology to unlock charcoal kilns
local charcoal_kiln_tech = {
    type = "technology",
    name = "charcoal-kiln",
    icon = utils.path("graphics/technologies/charcoal-kiln.png"),
    icon_size = 256,
    effects = {
        { type = "unlock-recipe", recipe = "charcoal-kiln" },
        -- Charcoal recipes are added in prototypes.recipes
    },
    unit = {
        count = 30,
        time = 15,
        ingredients = {
            { "automation-science-pack", 1 },
        },
    },
    prerequisites = {
        "automation-science-pack",
    },
}

data:extend {
    charcoal_kiln_tech,
}
