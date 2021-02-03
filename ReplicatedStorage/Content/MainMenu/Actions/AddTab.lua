local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local AddItemToDropdown = Rodux.makeActionCreator("AddItemToDropdown", function(tab)
    return {
        Tabs = {
            {
                Name = tab.Name,
                Icon = tab.Icon,
            },
        },
    }
end)

return AddItemToDropdown