local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Store = Roact.Component:extend("Store")

function Store:render()
    return Roact.createFragment({
        Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
        })
    })
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Store)