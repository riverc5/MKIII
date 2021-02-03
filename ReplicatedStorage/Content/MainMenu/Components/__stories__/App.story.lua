local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local Rodux = require(ReplicatedStorage.Modules.Rodux)

local App = require(script.Parent.Parent.App)
local AddTab = require(script.Parent.Parent.Parent.Actions.AddTab)
local SwitchTab = require(script.Parent.Parent.Parent.Actions.SwitchTab)
local AddItemToDropdown = require(script.Parent.Parent.Parent.Actions.AddItemToDropdown)
local Reducer = require(script.Parent.Parent.Parent.Reducers.MainMenuReducer)

return function(target)
    local store = Rodux.Store.new(Reducer)
    
    local root = Roact.createElement(RoactRodux.StoreProvider, {
        store = store,
    }, {
        App = Roact.createElement(App),
    })
    
    local handle = Roact.mount(root, target)
    
    store:setState({
        
    })
    
    store:dispatch(AddTab({
        Name = "HOME",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "RULES",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "STORE",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "DONATE",
        Icon = "rbxassetid://6119732925",
    }))
    store:dispatch(AddTab({
        Name = "CREDITS",
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