local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local Rodux = require(ReplicatedStorage.Modules.Rodux)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local SwitchTab = require(script.Parent.Actions.SwitchTab)
local SwitchTabContents = require(script.Parent.Actions.SwitchTabContents)

local App = require(script.Parent.Components.App)
local Reducer = require(script.Parent.Reducers.MainMenuReducer)

local PLAYER = Players.LocalPlayer
local PLAYERGUI = PLAYER:WaitForChild("PlayerGui")

local MainMenu = {}
MainMenu.__index = MainMenu

function MainMenu.new(...)
    local self = {}
    setmetatable(self, MainMenu)

    self.Store = Rodux.Store.new(Reducer)

    self.Root = Roact.createElement("ScreenGui", {
        ResetOnSpawn = false,
        DisplayOrder = 99999,
    }, {
        App = Roact.createElement(App, {
            store = newMainMenu.Store,
        })
    })
    return self
end

function MainMenu:Mount()
    Roact.mount(self.Root, PLAYERGUI)
end

function MainMenu:SwitchTab(name)
    self.Store:dispatch(SwitchTab(name))
    self.Store:dispatch(SwitchTabContents(name))
end

return MainMenu