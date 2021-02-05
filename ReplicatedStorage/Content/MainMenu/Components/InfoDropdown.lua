local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)
local Otter = require(ReplicatedStorage.Modules.Otter)
local Constants = require(script.Parent.Parent.Constants)

local InfoDropdown = Roact.Component:extend("InfoDropdown")

local ProfileItem = require(script.Parent.ProfileItem)

function InfoDropdown:init()
    -- TODO: Find and set sizes for closedSize and openSize and figure out
    -- AnchorPoints and Positions
    self.isOpen = true
    self.closedSize = UDim2.new()
    self.openSize = UDim2.new(0.839, 0, 0.978, 1)

    self.xScale, self.updateXScale = Roact.createBinding(self.closedSize.X.Scale)
    self.xScaleMotor = Otter.createSingleMotor(self.closedSize.X.Scale)
    self.xScaleMotor:onStep(self.updateXScale)

    self.yScale, self.updateYScale = Roact.createBinding(self.closedSize.Y.Scale)
    self.yScaleMotor = Otter.createSingleMotor(self.closedSize.Y.Scale)
    self.yScaleMotor:onStep(self.updateYScale)

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
        Size = UDim2.new(0.143, 0, 2.668, 0),
        Position = UDim2.new(0.839, 0, 0.978, 1),
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
    }, children)
end

function InfoDropdown:willUpdate()
    if self.props.state == true then
        self.xScaleMotor:setGoal(Otter.spring(self.openSize, Constants.DROPDOWN_SPRING_CONFIG))
        self.yScaleMotor:setGoal(Otter.spring(self.openSize, Constants.DROPDOWN_SPRING_CONFIG))
    else
        self.xScaleMotor:setGoal(Otter.spring(self.closedSize, Constants.DROPDOWN_SPRING_CONFIG))
        self.yScaleMotor:setGoal(Otter.spring(self.closedSize, Constants.DROPDOWN_SPRING_CONFIG))
    end
end

function InfoDropdown:willUnmount()
    self.xScaleMotor:destroy()
    self.yScaleMotor:destroy()
    self.xScaleMotor = nil
    self.yScaleMotor = nil
end

local function mapStateToProps(state, props)
    return state.Dropdown
end

return RoactRodux.connect(mapStateToProps)(InfoDropdown)