local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local SetDropdownEnabled = Rodux.makeActionCreator("SetDropdownEnabled", function(enabled)
    return {
        enabled = enabled
    }
end)

return SetDropdownEnabled