local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)
local Otter = require(script.Parent.Parent.Parent.Immediate.Otter)
local RoactRodux = require(script.Parent.Parent.Parent.Immediate.RoactRodux)

local Constants = require(script.Parent.Parent.Constants)

local Icon = Roact.Component:extend("Icon")

function Icon:init()
    self.isRotating = false

    self.rotation, self.updateRotation = Roact.createBinding(0)
    self.spinMotor = Otter.createSingleMotor(0)
    self.spinMotor:onStep(self.updateRotation)

    self.transparency, self.updateTransparency = Roact.createBinding(0)
    self.transparencyMotor = Otter.createSingleMotor(0)
    self.transparencyMotor:onStep(self.updateTransparency)

    function self.rotate()
        self.spinMotor:setGoal(Otter.spring(self.rotation:getValue() + 360, Constants.SPRING_CONFIG_2))
        wait(1.75)
    end
end

function Icon:render()
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0.049, 0, 0.078, 0),
        Position = UDim2.new(0.397, 0, 0.63, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
    }, {
        UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint"),
        Icon1 = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            Image = "rbxassetid://6154459898",
            ImageTransparency = self.transparency,
        }),
        Icon2 = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1,
            Image = "rbxassetid://6145261527",
            Rotation = self.rotation,
            ImageTransparency = self.transparency,
        }),
    })
end

function Icon:didMount()
    self.isRotating = true

    coroutine.wrap(function()
        while self.isRotating == true do
            self.rotate()
        end
    end)()
end

function Icon:didUpdate()
    if self.props.finished == true then
        self.transparencyMotor:setGoal(Otter.spring(1, Constants.SPRING_CONFIG_1))
    end
end

function Icon:willUnmount()
    self.isRotating = false
    self.spinMotor:destroy()
    self.transparencyMotor:destroy()
    self.transparencyMotor = nil
end

local function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Icon)