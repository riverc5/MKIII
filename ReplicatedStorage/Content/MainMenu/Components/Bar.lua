local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local Tabs = require(script.Parent.Tabs)
local Profile = require(script.Parent.Profile)
local Dropdown = require(script.Parent.InfoDropdown)

local Bar = Roact.Component:extend("Bar")

function Bar:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1.001, 0, 0.09, 0),
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.044, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
    }, {
         UIGradient = Roact.createElement("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(183, 193, 245)),
                ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)),
                
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0.5, 0.1),
                NumberSequenceKeypoint.new(1, 0),
            }),
        }),
        Dropdown = Roact.createElement(Dropdown),
        Tabs = Roact.createElement(Tabs),
        Profile = Roact.createElement(Profile),
    })
end

return Bar