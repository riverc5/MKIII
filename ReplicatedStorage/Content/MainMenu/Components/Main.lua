local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local Bar = require(script.Parent.Bar)
local TabSelection = require(script.Parent.TabSelection)
local ContentsContainer = require(script.Parent.ContentsContainer)

local Main = Roact.Component:extend("Main")

function Main:render()
    return Roact.createElement("ScreenGui", {
        DisplayOrder = 50,
        IgnoreGuiInset = true,
    }, {
        Bar = Roact.createElement(Bar),
        ContentsContainer = Roact.createElement(ContentsContainer),
        TabSelection = Roact.createElement(TabSelection),
    })
end

return Main