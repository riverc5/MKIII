local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Modules.Roact)
local Rodux = require(ReplicatedStorage.Modules.Rodux)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local App = require(script.Parent.Parent.App)
local InitialState = require(script.Parent.Parent.Parent.InitialState)
local AddTab = require(script.Parent.Parent.Parent.Actions.AddTab)
local SwitchTab = require(script.Parent.Parent.Parent.Actions.SwitchTab)
local AddItemToDropdown = require(script.Parent.Parent.Parent.Actions.AddItemToDropdown)
local Reducer = require(script.Parent.Parent.Parent.Reducers.MainMenuReducer)

-- math.huge is supplied to avoid producing any output errors
local PLAYERGUI = Players.LocalPlayer:WaitForChild("PlayerGui", math.huge)

local MainMenu = {}

function MainMenu.new(...)
    local self = {}
    setmetatable(self, MainMenu)
    local args = {...}
    local tabs = args[1]
    local profileItems = args[2]

    self.store = Rodux.Store.new(Reducer, InitialState, {
        Rodux.thunkMiddleware,
    })
    
    self.root = Roact.createElement(App, {
        store = self.store,
    })

    self.handle = Roact.mount(self.root, PLAYERGUI, "MainMenu")

    for _, tab in pairs(tabs) do
        self.store:dispatch(AddTab(tab))
    end

    for _, item in pairs(profileItems) do
        self.store:dispatch(AddItemToDropdown(item))
    end

    return self
end

return MainMenu