local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)
local Cryo = require(ReplicatedStorage.Modules.Cryo)

local GetDictionarySize = require(script.Parent.Parent.Helpers.GetDictionarySize)
local InitialState = require(script.Parent.Parent.InitialState)
local SwitchTab = require(script.Parent.Parent.Actions.SwitchTab)
local AddTab = require(script.Parent.Parent.Actions.AddTab)
local AddTabRef = require(script.Parent.Parent.Actions.AddTabRef)

local Tabs = Rodux.createReducer(InitialState, {
    [SwitchTab.name] = function(state, action)
        return Cryo.Dictionary.join(state, action)
    end,
    [AddTab.name] = function(state, action)
        local size = tostring(GetDictionarySize(state.Tabs) + 1)
        return Cryo.Dictionary.join(state, {
            Tabs = Cryo.Dictionary.join(state.Tabs, {
                [size] = {
                    Name = action.Name,
                    Text = action.Text,
                    Icon = action.Icon,
                    Index = size,
                },
            })
        })
    end,
    [AddTabRef.name] = function(state, action)
        return Cryo.Dictionary.join(state, {
            TabRefs = Cryo.Dictionary.join(state.TabRefs, {
                [action.Name] = action.Ref,
            })
        })
    end
})

return Tabs