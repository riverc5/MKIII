local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local Tab = Roact.Component:extend("Tab")

function Tab:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(0.172, 0, 1, 0),
        BackgroundTransparency = 1,
    }, {
        Icon = Roact.createElement("ImageLabel", {
            Image = self.props.Icon,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.223, 0, 0.5, 0),
            Size = UDim2.new(0.248, 0, 0.646, 0),
            BackgroundTransparency = 1,
        }, {
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectType = Enum.AspectType.ScaleWithParentSize,
            })
        }),
        Label = Roact.createElement("TextLabel", {
            Font = Enum.Font.SciFi,
            TextScaled = true,
            Text = self.props.Name,
            Position = UDim2.new(0.699, 0, 0.49, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(0.585, 0, 0.4, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1, 1, 1),
        }),
    })
end

return Tab