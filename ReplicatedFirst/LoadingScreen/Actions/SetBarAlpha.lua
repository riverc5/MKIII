local Rodux = require(script.Parent.Parent.Parent.Immediate.Rodux)

local SetBarAlpha = Rodux.makeActionCreator("SetBarAlpha", function(alpha)
    return {
        alpha = alpha,
    }
end)

return SetBarAlpha