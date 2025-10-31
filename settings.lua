-- Define startup settings
data:extend {
    -- Enable additional recipes for charcoal from wooden objects (e.g. wooden chests, small electric poles)
    {
        type = "bool-setting",
        name = "charcoal-kiln-enable-additional-recipes",
        order = "a",
        setting_type = "startup",
        default_value = true,
    },

    -- Hide all charcoal recipes from crafting menu
    {
        type = "bool-setting",
        name = "charcoal-kiln-hide-charcoal-recipes",
        order = "b",
        setting_type = "startup",
        default_value = true,
    },
}
