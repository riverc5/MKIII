local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local TabSelection = Roact.Component:extend("TabSelection")

function TabSelection:render()
    return Roact.createElement("Frame", {
        Position = UDim2.new(0.207, 0, 0.967, 0), -- TODO: self.props.Position,
        Size = UDim2.new(0.107, 0, 0.067, 0),
        BackgroundColor3 = Color3.fromRGB(203, 82, 65),
        AnchorPoint = Vector2.new(0.5, 0.5),
    }, {
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0.5, 0),
        }),
        UIGradient = Roact.createElement("UIGradient", {
            Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(186, 185, 187)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 185, 187))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.13), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.13)}),
        }),
    })
end

local function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(TabSelection)