local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Rodux = require(ReplicatedStorage.Modules.Rodux)

local Tabs = require(script.Parent.Tabs)
local Dropdown = require(script.Parent.Dropdown)

local MainMenuReducer = Rodux.combineReducers({
    Tabs = Tabs,
    Dropdown = Dropdown,
})

return MainMenuReducer