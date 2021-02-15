local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local Home = require(script.Parent.Contents.Home)
local Rules = require(script.Parent.Contents.Rules)
local Store = require(script.Parent.Contents.Store)
local Donations = require(script.Parent.Contents.Donations)
local Credits = require(script.Parent.Contents.Credits)

local ContentsContainer = Roact.Component:extend("ContentsContainer")

function ContentsContainer:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 0.909, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.545, 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
    }, {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.Name,

        }),
        A_Home = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, Roact.createElement(Home)),
        B_Rules = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, Roact.createElement(Rules)),
        C_Store = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, Roact.createElement(Store)),
        D_Donations = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, Roact.createElement(Donations)),
        E_Credits = Roact.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
        }, Roact.createElement(Credits)),
    })
end

return ContentsContainer