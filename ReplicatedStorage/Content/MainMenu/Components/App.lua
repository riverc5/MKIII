local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local ContentsContainer = require(script.Parent.ContentsContainer)
local Bar = require(script.Parent.Bar)
local Tabs = require(script.Parent.Tabs)
local TabSelection = require(script.Parent.TabSelection)
local Profile = require(script.Parent.Profile)
local Dropdown = require(script.Parent.InfoDropdown)

local App = Roact.Component:extend("App")

function App:render()
    return Roact.createElement("ScreenGui", {
        DisplayOrder = 999,
    }, {
        Bar = Roact.createElement(Bar, nil, {
            Dropdown = Roact.createElement(Dropdown),
            Tabs = Roact.createElement(Tabs),
            Profile = Roact.createElement(Profile),
            TabSelection = Roact.createElement(TabSelection),
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
        }),
        ContentsContainer = Roact.createElement(ContentsContainer),
    })
end

return App