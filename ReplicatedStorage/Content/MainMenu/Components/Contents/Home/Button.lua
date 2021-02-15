local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Button = Roact.Component:extend("Button")

function Button:render()
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0,0.168, 0),
    }, {
        UIPadding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0.05, 0),
            PaddingRight = UDim.new(0.05, 0),
            PaddingTop = UDim.new(0.05, 0),
            PaddingBottom = UDim.new(0.05, 0),
        }),
        Selection = Roact.createElement("Frame", {
            BackgroundTransparency = 0.1,
            Size = UDim2.new(0.024, 0, 0.114, 0),
            Position = UDim2.new(-0.09, 0,0.5, 0),
        }, {
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(0.5, 0),
            }),
            UIGradient = Roact.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 0.32),
                }),
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(173, 172, 174)),
                }),
            }),
        }),
        Button = Roact.createElement("TextButton", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Font = Enum.Font.SourceSansSemibold,
            TextScaled = true,
            Text = self.props.Text,
            TextColor3 = Color3.fromRGB(251, 251, 251),
            TextTransparency = 0.2,
            TextXAlignment = Enum.TextXAlignment.Left,
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(221, 219, 222)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.8, 0.38),
                    NumberSequenceKeypoint.new(1, 1),
                })
            })
        })
    })
end

return Button