local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local AddItemToDropdown = Rodux.makeActionCreator("AddItemToDropdown", function(dropdown)
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