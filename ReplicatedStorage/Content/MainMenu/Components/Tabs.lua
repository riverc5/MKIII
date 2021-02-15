local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local Tab = require(script.Parent.Tab)

local Tabs = Roact.Component:extend("Tabs")

function Tabs:render()
    local children = {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.Name,
        })
    }

    for _, tab in pairs(self.props.Tabs) do
        local element = Roact.createElement(Tab, {
            Icon = tab.Icon,
            Text = tab.Text,
            Name = tab.Name,
        })
        
        children[tab.Index] = element
    end

    return Roact.createElement("Frame", {
        Size = UDim2.new(0.699, 0, 1.096, 0),
        Position = UDim2.new(0.5, 0, 0.471, 0),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
    }, children)
end

local function mapStateToProps(state)
    return state.Tabs
end

return RoactRodux.connect(mapStateToProps)(Tabs)