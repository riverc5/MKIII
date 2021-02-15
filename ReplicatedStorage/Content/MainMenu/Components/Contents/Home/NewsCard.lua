local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local NewsCard = Roact.Component:extend("NewsCard")

function NewsCard:render()
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.306, 0, 0.279, 0),
        Position = UDim2.new(0.634, 0, 0.645, 0),
    }, {
        Bar = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 0.326, 0),
            Position = UDim2.new(0, 0, 0.674, 0),
            BackgroundTransparency = 0.7,
            BackgroundColor3 = Color3.new(0, 0, 0),
            BorderSizePixel = 0,
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Rotation = 90,
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(81, 82, 83)),
                    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.5, 0.4),
                    NumberSequenceKeypoint.new(1, 0),
                })
            }),
            Label = Roact.createElement("TextLabel", {
                TextScaled = true,
                RichText = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.824, 0, 0.455, 0),
                Position = UDim2.new(0.028, 0, 0.08, 0),
                Font = Enum.Font.SourceSansSemibold,
                Text = self.props.Title,
                TextColor3 = Color3.fromRGB(231, 231, 231),
            }, {
                UIGradient = Roact.createElement("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 213, 216)),
                    }),
                    Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 0.25),
                        NumberSequenceKeypoint.new(0.5, 0),
                        NumberSequenceKeypoint.new(1, 0.25),
                    })
                }),
            }),
            Description = Roact.createElement("TextLabel", {
                TextScaled = true,
                RichText = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.824, 0, 0.318, 0),
                Position = UDim2.new(0.028, 0, 0.535, 0),
                Font = Enum.Font.SourceSansLight,
                Text = self.props.Description,
                TextColor3 = Color3.fromRGB(231, 231, 231),
            }),
        }),
        BackgroundImage = Roact.createElement("ImageLabel", {
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Image = self.props.Image,
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(164, 163, 165)),
                    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(1, 0),
                }),
                Rotation = 90,
            }),
        }),
    })
end

return NewsCard