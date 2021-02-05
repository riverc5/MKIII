local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)
local Cryo = require(ReplicatedStorage.Modules.Cryo)

local InitialState = require(script.Parent.Parent.InitialState)
local SwitchTab = require(script.Parent.Parent.Actions.SwitchTab)
local AddTab = require(script.Parent.Parent.Actions.AddTab)
local GetDictionarySize = require(script.Parent.Parent.Helpers.GetDictionarySize)

local Tabs = Rodux.createReducer(InitialState, {
    [SwitchTab.name] = function(state, action)
        return Cryo.Dictionary.join(state, action)
    end,
    [AddTab.name] = function(state, action)
        action.Index = tostring(GetDictionarySize(state) + 1)

        return Cryo.Dictionary.join(state, {
            [action.Index] = { -- we use Index to make our state 'pretty'
                Name = action.Name,
                Icon = action.Icon,
                Index = action.Index,
            },
        })
    end,
})

return Tabs