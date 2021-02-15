local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local NewsCard = require(script.NewsCard)
local Button = require(script.Button)

local Home = Roact.Component:extend("Home")

function Home:render()
    return Roact.createFragment({
        Buttons = Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(0.197, 0, 0.492, 0),
            Position = UDim2.new(0.155, 0, 0.498, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
        }, {
            UIListLayout = Roact.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.Name,
                Padding = UDim.new(0.02, 0),
            }),
            Play = Roact.createElement(Button, {
                Text = "PLAY",
            }),
            InviteFriends = Roact.createElement(Button, {
                Text = "INVITE FRIENDS",
            }),
        }),
        Title = Roact.createElement("TextLabel", {
            BackgroundTransparency = 1,
            Text = "CITY - 17",
            Font = Enum.Font.Jura,
            RichText = true,
            TextScaled = true,
            Size = UDim2.new(0.786, 0, 0.221, 0),
            Position = UDim2.new(0.057, 0, 0.031, 0),
            TextTransparency = 0.1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1, 1, 1)
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(222, 221, 224)),
                    ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(0.25, 0.1),
                    NumberSequenceKeypoint.new(0.5, 0.325),
                    NumberSequenceKeypoint.new(0.75, 0.1),
                    NumberSequenceKeypoint.new(1, 0),
                }),
                Rotation = 90,
            })
        }),
        News = Roact.createElement(NewsCard, {
            Title = "MKIII is Live!",
            Description = "See latest updates & what's new",
            Image = "rbxassetid://6357981147",
        })
    })
end

function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Home)