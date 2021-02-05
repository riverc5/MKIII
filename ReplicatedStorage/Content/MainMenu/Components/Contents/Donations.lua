local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Donations = Roact.Component:extend("Donations")

function Donations:render()
    return Roact.createFragment({})
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Donations)