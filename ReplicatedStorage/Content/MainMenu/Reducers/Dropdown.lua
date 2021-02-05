local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)
local Cryo = require(ReplicatedStorage.Modules.Cryo)

local InitialState = require(script.Parent.Parent.InitialState)
local AddItemToDropdown = require(script.Parent.Parent.Actions.AddItemToDropdown)
local GetDictionarySize = require(script.Parent.Parent.Helpers.GetDictionarySize)

local TabContents = Rodux.createReducer(InitialState, {
    [AddItemToDropdown.name] = function(state, action)
        return Cryo.Dictionary.join(state, {
            items = Cryo.Dictionary.join(state.items, {
                [tostring(GetDictionarySize(state.items) + 1)] = action,
            })
        })
    end,
})

return TabContents