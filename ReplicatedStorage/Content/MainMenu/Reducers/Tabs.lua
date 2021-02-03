local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)
local Cryo = require(ReplicatedStorage.Modules.Cryo)

local SwitchTab = require(script.Parent.Parent.Actions.SwitchTab)
local AddTab = require(script.Parent.Parent.Actions.AddTab)

local Tabs = Rodux.createReducer(nil, {
    [SwitchTab.name] = function(state, action)
        return Cryo.Dictionary.join(state, action)
    end,
    [AddTab.name] = function(state, action)
        action.Tabs[1].Index = tostring(#state.Tabs + 1)
        return Cryo.Dictionary.join(state, action)
    end,
})

return Tabs