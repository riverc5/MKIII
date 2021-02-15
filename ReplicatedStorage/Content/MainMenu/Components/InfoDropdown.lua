local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)
local Otter = require(ReplicatedStorage.Modules.Otter)

local Constants = require(script.Parent.Parent.Constants)

local InfoDropdown = Roact.Component:extend("InfoDropdown")

local ProfileItem = require(script.Parent.ProfileItem)

function InfoDropdown:init()
    self.closedSize = UDim2.new(0.143, 0, 0, 0)
    self.openSize = UDim2.new(0.143, 0, 2.668, 0)

    self.xScale, self.updateXScale = Roact.createBinding(self.closedSize.X.Scale)
    self.xScaleMotor = Otter.createSingleMotor(self.closedSize.X.Scale)
    self.xScaleMotor:onStep(self.updateXScale)

    self.yScale, self.updateYScale = Roact.createBinding(self.closedSize.Y.Scale)
    self.yScaleMotor = Otter.createSingleMotor(self.closedSize.Y.Scale)
    self.yScaleMotor:onStep(self.updateYScale)

    self.transparency, self.updateTransparency = Roact.createBinding(1)
    self.transparencyMotor = Otter.createSingleMotor(1)
    self.transparencyMotor:onStep(self.updateTransparency)

    self.size = Roact.joinBindings({self.xScale, self.yScale}):map(function(sizes)
        return UDim2.fromScale(sizes[1], sizes[2])
    end)
end

function InfoDropdown:render()
    local children = {
        UIGradient = Roact.createElement("UIGradient", {
            Rotation = 90,
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 0.212),
            }),
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(192, 191, 193)),
                ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)),
            })
        }),
        UIListLayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(-0.03, 0),
            VerticalAlignment = Enum.VerticalAlignment.Center,
        })
    }

    for _, item in pairs(self.props.items) do
        local element = Roact.createElement(ProfileItem, item)
        table.insert(children, element)
    end

    return Roact.createElement("Frame", {
        Size = self.size,
        Position = UDim2.new(0.91, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        BackgroundTransparency = self.transparency,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0)
    }, children)
end

function InfoDropdown:willUpdate(nextProps)
    if nextProps.state == true then
        self.transparencyMotor:setGoal(Otter.spring(0.5, Constants.DROPDOWN_SPRING_CONFIG_2))
        self.xScaleMotor:setGoal(Otter.spring(self.openSize.X.Scale, Constants.DROPDOWN_SPRING_CONFIG_2))
        self.yScaleMotor:setGoal(Otter.spring(self.openSize.Y.Scale, Constants.DROPDOWN_SPRING_CONFIG_2))
    else
        self.transparencyMotor:setGoal(Otter.spring(1, Constants.DROPDOWN_SPRING_CONFIG_2))
        self.xScaleMotor:setGoal(Otter.spring(self.closedSize.X.Scale, Constants.DROPDOWN_SPRING_CONFIG_2))
        self.yScaleMotor:setGoal(Otter.spring(self.closedSize.Y.Scale, Constants.DROPDOWN_SPRING_CONFIG_2))
    end
end

function InfoDropdown:willUnmount()
    self.xScaleMotor:destroy()
    self.yScaleMotor:destroy()
    self.xScaleMotor = nil
    self.yScaleMotor = nil
end

local function mapStateToProps(state)
    return state.Dropdown
end

return RoactRodux.connect(mapStateToProps)(InfoDropdown)