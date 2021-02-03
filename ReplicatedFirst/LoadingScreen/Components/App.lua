local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)
local RoactRodux = require(script.Parent.Parent.Parent.Immediate.RoactRodux)

local Icon = require(script.Parent.Parent.Components.Icon)
local Label = require(script.Parent.Parent.Components.Label)
local LoadingBar = require(script.Parent.Parent.Components.LoadingBar)

local App = Roact.Component:extend("App")

function App:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.props.store,
    }, {
        Background = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 72),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        }, {
            Icon = Roact.createElement(Icon),
            Label = Roact.createElement(Label),
            LoadingBar = Roact.createElement(LoadingBar),
        })
    })
end

return App