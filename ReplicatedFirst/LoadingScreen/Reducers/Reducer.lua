local Rodux = require(script.Parent.Parent.Parent.Immediate.Rodux)
local Cryo = require(script.Parent.Parent.Parent.Immediate.Cryo)

local SetBarAlpha = require(script.Parent.Parent.Actions.SetBarAlpha)

-- TODO PROD-1: Remove InitialState
local InitialState = require(script.Parent.Parent.InitialState)

local Reducer = Rodux.createReducer(InitialState, {
    [SetBarAlpha.name] = function(state, action)
        return Cryo.Dictionary.join(state, {loadingBarProgress = action.alpha})
    end
})

return Reducer