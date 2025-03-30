local utils = {}

-- Shorthand function to get a path relative to the mod directory
function utils.path(path)
    return "__charcoal-kiln__/" .. path
end

return utils
