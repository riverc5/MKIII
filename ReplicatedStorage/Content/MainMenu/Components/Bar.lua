local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local Bar = Roact.Component:extend("Bar")

function Bar:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1.001, 0, 0.09, 0),
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.044, 0),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
    })
end

return Bar