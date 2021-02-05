local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local AddItemToDropdown = Rodux.makeActionCreator("AddItemToDropdown", function(dropdown)
    return dropdown
end)

return AddItemToDropdown