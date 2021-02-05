local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Home = Roact.Component:extend("Home")

function Home:render()
    return Roact.createFragment({})
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Home)