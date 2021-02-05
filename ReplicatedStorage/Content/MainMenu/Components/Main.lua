local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)

local Bar = require(script.Parent.Bar)
local ContentsContainer = require(script.Parent.ContentsContainer)

local Main = Roact.Component:extend("Main")

function Main:render()
    return Roact.createElement("ScreenGui", {
        DisplayOrder = 50,
    }, {
        Bar = Roact.createElement(Bar),
        ContentsContainer = Roact.createElement(ContentsContainer),
    })
end

return Main