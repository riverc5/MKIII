local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)

local SwitchTab = require(script.Parent.Parent.Actions.SwitchTab)
local AddTabRef = require(script.Parent.Parent.Actions.AddTabRef)

local Tab = Roact.Component:extend("Tab")

function Tab:init()
    self.ref = Roact.createRef()
end

function Tab:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(0.172, 0, 1, 0),
        BackgroundTransparency = 1,
        [Roact.Ref] = self.ref,
    }, {
        Icon = Roact.createElement("ImageLabel", {
            Image = self.props.Icon,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.223, 0, 0.5, 0),
            Size = UDim2.new(0.248, 0, 0.646, 0),
            BackgroundTransparency = 1,
        }, {
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint", {
                AspectType = Enum.AspectType.ScaleWithParentSize,
            })
        }),
        Label = Roact.createElement("TextButton", {
            Font = Enum.Font.SciFi,
            TextScaled = true,
            Text = self.props.Text,
            Position = UDim2.new(0.699, 0, 0.49, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(0.585, 0, 0.4, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1, 1, 1),
            [Roact.Event.Activated] = function()
                self.props.setActiveTab(self.props.Name)
            end,
        }),
    })
end

function Tab:didMount()
    self.props.addRef(self.ref, self.props.Name)
end

local function mapDispatchToProps(dispatch)
    return {
        setActiveTab = function(name)
            dispatch(SwitchTab(name))
        end,
        addRef = function(ref, name)
            dispatch(AddTabRef({
                Name = name,
                Ref = ref,
            }))
        end
    }
end

return RoactRodux.connect(nil, mapDispatchToProps)(Tab)