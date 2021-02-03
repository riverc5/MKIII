local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local Types = require(script.Parent.Parent.Types)

local AddItemToDropdown = Rodux.makeActionCreator("AddItemToDropdown", function(tab: Types.Tab)
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