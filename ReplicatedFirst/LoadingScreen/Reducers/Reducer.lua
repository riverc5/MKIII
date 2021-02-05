local Rodux = require(script.Parent.Parent.Parent.Immediate.Rodux)
local Cryo = require(script.Parent.Parent.Parent.Immediate.Cryo)

local SetBarAlpha = require(script.Parent.Parent.Actions.SetBarAlpha)
local SetFinished = require(script.Parent.Parent.Actions.SetFinished)

local Reducer = Rodux.createReducer(nil, {
    [SetBarAlpha.name] = function(state, action)
        state = state or {}
        
        return Cryo.Dictionary.join(state, {loadingBarProgress = action.alpha})
    end,
    [SetFinished.name] = function(state, action)
        state = state or {}

        return Cryo.Dictionary.join(state, action)
    end,
})

return Reducer