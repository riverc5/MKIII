local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local ContentsContainer = Roact.Component:extend("ContentsContainer")

function ContentsContainer:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0.909, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.545, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    })
end

return ContentsContainer