local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Main = require(script.Parent.Main)
local Bar = require(script.Parent.Bar)
local ContentsContainer = require(script.Parent.ContentsContainer)
local TabSelection = require(script.Parent.TabSelection)

local App = Roact.Component:extend("App")

function App:render()
    local children = {}

    if self.props["isStory"]then
        children["Bar"] = Roact.createElement(Bar)
        children["ContentsContainer"] = Roact.createElement(ContentsContainer)
        children["TabSelection"] = Roact.createElement(TabSelection)
    else
        children["Main"] = Roact.createElement(Main)
    end
    
    return Roact.createElement(RoactRodux.StoreProvider, {
        store = self.props.store,
    }, children)
end

return App