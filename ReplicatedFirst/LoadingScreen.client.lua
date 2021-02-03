local ContentProvider = game:GetService("ContentProvider")
local UserInputService = game:GetService("UserInputService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local Roact = require(ReplicatedFirst.Immediate.Roact)
local Rodux = require(ReplicatedFirst.Immediate.Rodux)
local App = require(ReplicatedFirst.LoadingScreen.Components.App)
local SetBarAlpha = require(ReplicatedFirst.LoadingScreen.Actions.SetBarAlpha)
local Reducer = require(ReplicatedFirst.LoadingScreen.Reducers.Reducer)
local Constants = require(ReplicatedFirst.LoadingScreen.Constants)
-- TODO PROD-1: get this to work without InitialState
local InitialState = require(ReplicatedFirst.LoadingScreen.InitialState)

local PLAYERGUI = Players.LocalPlayer:WaitForChild("PlayerGui")
local INCREMENT = 1 / #Constants.CONTENT

local mainMenuStore = Rodux.Store.new(Reducer, InitialState)

local current = mainMenuStore:getState().loadingBarProgress

local root = Roact.createElement("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
}, {
    App = Roact.createElement(App, {
        store = mainMenuStore,
    }),
})

local handle = Roact.mount(root, PLAYERGUI, "LoadingScreen")

ReplicatedFirst:RemoveDefaultLoadingScreen()
StarterGui:SetCore("TopbarEnabled", false)
UserInputService.ModalEnabled = true
UserInputService.MouseIconEnabled = false

-- Wait for the first snapshot of the game to be sent before we start loading
-- in content. Guarantees all assets are available before we begin preloading.
if not game.IsLoaded then
    game.Loaded:Wait()
end

for _, content in pairs(Constants.CONTENT) do
    ContentProvider:PreloadAsync({content})
    current += INCREMENT
    mainMenuStore:dispatch(SetBarAlpha(current))
    -- TODO PROD-2: Remove this wait on production.
    wait(0.5)
end

Roact.unmount(handle)

StarterGui:SetCore("TopbarEnabled", true)
UserInputService.ModalEnabled = false
UserInputService.MouseIconEnabled = true