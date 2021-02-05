local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Store = Roact.Component:extend("Store")

function Store:render()
    return Roact.createFragment({})
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Store)