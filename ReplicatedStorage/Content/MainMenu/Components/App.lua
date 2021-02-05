local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Main = require(script.Parent.Main)
local Bar = require(script.Parent.Bar)
local ContentsContainer = require(script.Parent.ContentsContainer)

local App = Roact.Component:extend("App")

function App:render()
    local children = {}

    -- This is a fix for when we render stories, because if we render Main directly,
    -- it will render the ScreenGui and Hoarcekat will refuse to work.
    if self.props.isStory then
        children["Bar"] = Roact.createElement(Bar)
        children["ContentsContainer"] = Roact.createElement(ContentsContainer)
    else
        children["Main"] = Roact.createElement(ContentsContainer)
    end

    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.props.store,
    }, children)
end

return App