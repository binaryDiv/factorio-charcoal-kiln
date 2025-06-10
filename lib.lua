-- Shared library to work with the Charcoal Kiln mod, e.g. to generate custom charcoal recipes.
--
-- Example code for adding optional support for Charcoal Kiln to your own mod. Assuming your mod adds a "wooden-example"
-- item that is made from wood, you can auto-generate a charcoal recipe for it like so:
--
-- if mods["charcoal-kiln"] then
--     local charcoal_kiln_lib = require("__charcoal-kiln__.lib")
--
--     charcoal_kiln_lib.add_charcoal_recipe {
--         order = "d[wooden-example]",
--         from_item = "wooden-example",
--         from_icon = "__some-example-mod__/graphics/icons/wooden-example.png",
--         from_amount = 1,  -- Optional, this is the default value.
--         to_amount = 4,    -- Should be chosen depending on how much wood the original recipe used.
--     }
-- end

local charcoal_kiln_lib = {}

-- Generate a prototype for a new charcoal recipe from a given input item, e.g. "Charcoal from wooden chest".
-- The icon will be automatically generated from the parameter "from_icon" and "from_icon_size" (optional).
-- Alternatively, you can specify a custom icon with the parameter "icon_override" (string or an IconData array).
--
-- Arguments:
--   from_item: The item used as the ingredient for making charcoal (required)
--   from_icon: Icon of the ingredient, used to auto-generate the recipe icon (required unless `icon_override` is set)
--              Can be a simple filename or a full IconData specification. See `generate_charcoal_recipe_icon_spec()`.
--   from_icon_size: Size of the `from_icon`. Only needed for icons with sizes other than 64 pixels.
--   icon_override: Can be used to set a custom recipe icon, overriding the auto-generated recipe icon.
--                  Either a simple filename as a string or `array[IconData]` (see `RecipePrototype.icons`).
--   order: Recipe order string. Defaults to "z[$FROM_ITEM]".
--          The mod uses "a-a[wood]", "b-a[wooden-chest]", "c-a[small-electric-pole]" for the base game wood items.
--   from_amount: Amount of the recipe ingredient. Defaults to 1.
--   to_amount: Amount of coal to craft in the recipe. Defaults to 1.
--   crafting_time: Recipe crafting time, i.e. `energy_required`. Defaults to 3.2 seconds (like most furnace recipes).
--   enabled: Whether the recipe should be enabled right from the start. Defaults to false.
function charcoal_kiln_lib.generate_charcoal_recipe_prototype(params)
    local from_item = params.from_item

    local recipe = {
        type = "recipe",
        name = "charcoal-from-" .. from_item,
        localised_name = charcoal_kiln_lib.generate_charcoal_recipe_localised_name(from_item),
        category = "charcoal-kiln",
        subgroup = "charcoal",
        order = params.order or ("z[" .. from_item .. "]"),
        enabled = params.enabled or false,
        energy_required = params.crafting_time or 3.2,
        ingredients = {
            { type = "item", name = from_item, amount = params.from_amount or 1 },
        },
        results = {
            { type = "item", name = "coal", amount = params.to_amount or 1 },
        },
        auto_recycle = false,
    }

    -- Allow setting a custom icon via "icon_override", both as a string or full icon specification table
    if params.icon_override and type(params.icon_override) == "string" then
        recipe.icon = params.icon_override
    elseif params.icon_override then
        recipe.icons = params.icon_override
    else
        recipe.icons = charcoal_kiln_lib.generate_charcoal_recipe_icon_spec(params.from_icon, params.from_icon_size)
    end

    return recipe
end

-- Generate an icon specification for a charcoal recipe with a given icon. The generated icon is a composition of the
-- base game coal icon and the given icon. The icon can be given either as a simple filename or as an IconData table
-- (see https://lua-api.factorio.com/latest/types/IconData.html).
-- For icons with a size other than 64 pixels, the icon size must be specified as the second parameter (unless the icon
-- is already given as an IconData table).
function charcoal_kiln_lib.generate_charcoal_recipe_icon_spec(from_icon, from_icon_size)
    -- Default icon size: 64 pixel
    from_icon_size = from_icon_size or 64

    if type(from_icon) == "string" then
        from_icon = {
            icon = from_icon,
            icon_size = from_icon_size,
            scale = (64 / from_icon_size) / 3,
            shift = { -6, -6 },
        }
    end

    return {
        {
            icon = "__base__/graphics/icons/coal.png",
            shift = { 4, 4 },
        },
        from_icon,
    }
end

-- Generate a LocalisedString for automatic localisation of a charcoal recipe's name based on the item names.
function charcoal_kiln_lib.generate_charcoal_recipe_localised_name(from_item)
    -- Localised name of the "from" item with fallbacks: Placeable items (e.g. wooden chest) often don't have localised
    -- item names, but use the localised name of the entity they place. This is a simplified approach that might not
    -- always work (in which case the mod author should just set a proper localised recipe name), but it's good enough.
    -- Also, fallback to the internal name (e.g. "wooden-chest") rather than failing translation completely.
    local localised_item_name = {
        "?",
        { "item-name." .. from_item },
        { "entity-name." .. from_item },
        from_item,
    }

    return {
        "?",
        -- Always prefer the explicit recipe name if it is localised
        { "recipe-name.charcoal-from-" .. from_item },
        -- Otherwise, use templated string with the localised item name for automatic localisation
        { "recipe-name.template_charcoal-from", localised_item_name },
        -- Fallback for unsupported languages: Just use "[Coal] from [X]" (which is better than just "Unknown key ...")
        { "", { "item-name.coal" }, " from ", localised_item_name },
    }
end

-- Add a recipe to be unlocked with the charcoal kiln technology.
-- Note that the "charcoal-kiln" technology must already exist, otherwise the call will likely fail.
-- To make sure that the technology has already been created, either add this mod as an (optional) dependency to your
-- mod or call the function in data-updates or data-final-fixes.
function charcoal_kiln_lib.unlock_recipe_with_charcoal_kiln_technology(recipe_name)
    local tech = data.raw.technology["charcoal-kiln"]
    table.insert(tech.effects, { type = "unlock-recipe", recipe = recipe_name })
end

-- Generate and add a new charcoal recipe to the game.
--
-- This function is a shorthand for calling `generate_charcoal_recipe()`, adding the prototype to `data`, and calling
-- `unlock_recipe_with_charcoal_kiln_technology()` to add the recipe to the charcoal kiln technology.
--
-- In most cases, this is the only function you need to call, everything else happens automatically.
function charcoal_kiln_lib.add_charcoal_recipe(params)
    -- Generate a charcoal recipe prototype and add it to data
    local new_recipe = charcoal_kiln_lib.generate_charcoal_recipe_prototype(params)
    data:extend { new_recipe }

    -- Add the new recipe to the charcoal kiln technology
    charcoal_kiln_lib.unlock_recipe_with_charcoal_kiln_technology(new_recipe.name)

    -- Return recipe prototype (just in case you need it)
    return new_recipe
end

return charcoal_kiln_lib
