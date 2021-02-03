local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local Types = require(script.Parent.Parent.Types)

local AddItemToDropdown = Rodux.makeActionCreator("AddItemToDropdown", function(dropdown: Types.Dropdown)
    return {
        Dropdown = {
            Items = {
                    {
                        Name = dropdown.Name,
                        Text = dropdown.Text,
                        Image = dropdown.Image,
                    },
            },
        },
    }
end)

return AddItemToDropdown