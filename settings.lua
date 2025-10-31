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
}
