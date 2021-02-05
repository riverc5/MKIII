local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Rules = Roact.Component:extend("Rules")

function Rules:render()
    return Roact.createFragment({})
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Rules)