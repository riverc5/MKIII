local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Credits = Roact.Component:extend("Credits")

function Credits:render()
    return Roact.createFragment({})
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Credits)