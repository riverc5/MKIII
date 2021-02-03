--[[
    This is the component that goes under the dropdown list. Pass 'Image' and 'Text' in props.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local ProfileItem = Roact.Component:extend("ProfileItem")

function ProfileItem:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(0.995, 0, 0.283, 0),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
    }, {
        Icon = Roact.createElement("ImageLabel", {
            Image = self.props.Image,
            BackgroundTransparency = 1,
            Size = UDim2.new(0.147, 0, 0.657, 0),
            Position = UDim2.new(0.18, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
        }, {
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = 0.986,
            })
        }),
        Label = Roact.createElement("TextLabel", {
            RichText = true,
            TextScaled = true,
            Text = "<b>"..self.props.Text.."</b>",
            Size = UDim2.new(0.607, 0, 0.657, 0),
            Position = UDim2.new(0.32, 0, 0.171, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.TitilliumWeb,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(252, 252, 252)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 185, 187)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 0.075, 0.075),
                }),
                Rotation = 90,
            })
        }),
    }
    )
end

return ProfileItem