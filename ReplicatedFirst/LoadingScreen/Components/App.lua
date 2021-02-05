local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)
local RoactRodux = require(script.Parent.Parent.Parent.Immediate.RoactRodux)

local Main = require(script.Parent.Parent.Components.Main)

local App = Roact.Component:extend("App")

function App:render()
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.props.store,
    }, {
       Main = Roact.createElement(Main)
    })
end

return App