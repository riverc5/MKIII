local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local SwitchTab = Rodux.makeActionCreator("SwitchTab", function(tabName)
    return {
        activeTab = tabName,
    }
end)

return SwitchTab