local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)
local Cryo = require(ReplicatedStorage.Modules.Cryo)

local InitialState = require(script.Parent.Parent.InitialState)
local GetDictionarySize = require(script.Parent.Parent.Helpers.GetDictionarySize)
local AddItemToDropdown = require(script.Parent.Parent.Actions.AddItemToDropdown)
local SetDropdownEnabled = require(script.Parent.Parent.Actions.SetDropdownEnabled)

local TabContents = Rodux.createReducer(InitialState, {
    [AddItemToDropdown.name] = function(state, action)
        return Cryo.Dictionary.join(state, {
            items = Cryo.Dictionary.join(state.items, {
                [tostring(GetDictionarySize(state.items) + 1)] = action,
            })
        })
    end,
    [SetDropdownEnabled.name] = function(state, action)
        return Cryo.Dictionary.join(state, {
            state = action.enabled,
        })
    end,
})

return TabContents