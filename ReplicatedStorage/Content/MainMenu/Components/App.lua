local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Main = require(script.Parent.Main)
local Bar = require(script.Parent.Bar)
local ContentsContainer = require(script.Parent.ContentsContainer)

local App = Roact.Component:extend("App")

function App:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.props.store,
    }, {
        --Main = Roact.createElement(Main),
        Bar = Roact.createElement(Bar),
        ContentsContainer = Roact.createElement(ContentsContainer),
    })
end

return App