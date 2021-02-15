local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local Rodux = require(ReplicatedStorage.Modules.Rodux)

local App = require(script.Parent.Parent.App)
local InitialState = require(script.Parent.Parent.Parent.InitialState)
local AddTab = require(script.Parent.Parent.Parent.Actions.AddTab)
local AddItemToDropdown = require(script.Parent.Parent.Parent.Actions.AddItemToDropdown)
local Reducer = require(script.Parent.Parent.Parent.Reducers.MainMenuReducer)

return function(target)
    local store = Rodux.Store.new(Reducer, InitialState, {
        --Rodux.loggerMiddleware,
    })

    local root = Roact.createElement(App, {
        store = store,
        isStory = true,
    })

    local handle = Roact.mount(root, target, "MainMenu")

    store:dispatch(AddTab({
        Name = "Home",
        Text = "HOME",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "Rules",
        Text = "RULES",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "Store",
        Text = "STORE",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "Donations",
        Text = "DONATE",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "Credits",
        Text = "CREDITS",
        Icon = "rbxassetid://6119732925",
    }))

    store:dispatch(AddItemToDropdown({
        Name = "Workpoints",
        Text = "25/25",
        Image = "rbxassetid://6301062966",
    }))
    store:dispatch(AddItemToDropdown({
        Name = "Playtime",
        Text = "1d, 0h, 0m",
        Image = "rbxassetid://6301062839",
    }))
    store:dispatch(AddItemToDropdown({
        Name = "Credits",
        Text = "100,000",
        Image = "rbxassetid://6301062902",
    }))

    return function()
        Roact.unmount(handle)
    end
end