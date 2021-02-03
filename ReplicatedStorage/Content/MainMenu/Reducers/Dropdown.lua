local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)
local Cryo = require(ReplicatedStorage.Modules.Cryo)

local AddItemToDropdown = require(script.Parent.Parent.Actions.AddItemToDropdown)

local TabContents = Rodux.createReducer(nil, {
    [AddItemToDropdown.name] = function(state, action)
        return Cryo.Dictionary.join(state, action)
    end,
})

return TabContents