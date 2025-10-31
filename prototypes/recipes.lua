local charcoal_kiln_lib = require("__charcoal-kiln__.lib")

-- Add recipe for the charcoal kiln itself, as well as the recipe category and item subgroup
data:extend {
    -- Recipe for crafting the charcoal kiln
    {
        type = "recipe",
        name = "charcoal-kiln",
        enabled = false,
        ingredients = {
            { type = "item", name = "stone", amount = 5 },
        },
        results = {
            { type = "item", name = "charcoal-kiln", amount = 1 },
        },
    },

    -- Recipe category for making charcoal
    {
        type = "recipe-category",
        name = "charcoal-kiln",
    },

    -- Subgroup for charcoal recipes
    {
        type = "item-subgroup",
        name = "charcoal",
        group = "intermediate-products",
        -- Sort right after the "raw-resources" subgroup which has order "b"
        order = "b-b[charcoal]",
    },
}

-- Generate recipe for charcoal from wood.
-- This also adds the new recipes to the effects of the charcoal kiln technology.
if data.raw.item["wood"] ~= nil then
    charcoal_kiln_lib.add_charcoal_recipe {
        order = "a-a[wood]",
        from_item = "wood",
        from_icon = "__base__/graphics/icons/wood.png",
    }
end

-- If enabled, generate additional recipes for wooden items (if they exist) as an early way of recycling.
if charcoal_kiln_lib.settings.enable_additional_recipes then
    if data.raw.item["wooden-chest"] ~= nil then
        charcoal_kiln_lib.add_charcoal_recipe {
            order = "b-a[wooden-chest]",
            from_item = "wooden-chest",
            from_icon = "__base__/graphics/icons/wooden-chest.png",
        }
    end

    if data.raw.item["small-electric-pole"] ~= nil then
        charcoal_kiln_lib.add_charcoal_recipe {
            order = "c-a[small-electric-pole]",
            from_item = "small-electric-pole",
            from_icon = "__base__/graphics/icons/small-electric-pole.png",
            from_amount = 2,
            to_amount = 1,
        }
    end
end
