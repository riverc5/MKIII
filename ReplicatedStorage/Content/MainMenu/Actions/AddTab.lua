local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local AddTab = Rodux.makeActionCreator("AddTab", function(tab)
    return tab
end)

return AddTab