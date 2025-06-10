-- Helper function to generate charcoal recipes, e.g. "charcoal from wooden chest".
-- Generates a layered icon consisting of the coal icon and an offset icon of the ingredient (must be set if it's not
-- a base item).
local function generate_charcoal_recipe(order, from_item, from_amount, to_amount, from_icon)
    if not from_icon then
        from_icon = "__base__/graphics/icons/" .. from_item .. ".png"
    end

    return {
        type = "recipe",
        name = "charcoal-from-" .. from_item,
        category = "charcoal",
        subgroup = "charcoal",
        order = "a[charcoal]-" .. order .. "[" .. from_item .. "]",
        icons = {
            { icon = "__base__/graphics/icons/coal.png", shift = { 4, 4 } },
            { icon = from_icon, scale = 0.33, shift = { -6, -6 } },
        },
        enabled = false,
        energy_required = 3.2,
        ingredients = {
            { type = "item", name = from_item, amount = from_amount },
        },
        results = {
            { type = "item", name = "coal", amount = to_amount },
        },
        auto_recycle = false,
    }
end

-- Add new recipe prototypes
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
        name = "charcoal",
    },

    -- Subgroup for charcoal recipes
    {
        type = "item-subgroup",
        name = "charcoal",
        group = "intermediate-products",
        -- Sort right after the "raw-resources" subgroup which has order "b"
        order = "b-b[charcoal]",
    },

    -- Recipes to make charcoal from wood and other wooden items
    generate_charcoal_recipe("a", "wood", 1, 1),
    generate_charcoal_recipe("b", "wooden-chest", 1, 1),
    generate_charcoal_recipe("c", "small-electric-pole", 2, 1),
}
