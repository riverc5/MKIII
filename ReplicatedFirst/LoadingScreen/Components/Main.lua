local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)
local RoactRodux = require(script.Parent.Parent.Parent.Immediate.RoactRodux)
local Otter = require(script.Parent.Parent.Parent.Immediate.Otter)

local Icon = require(script.Parent.Parent.Components.Icon)
local Label = require(script.Parent.Parent.Components.Label)
local LoadingBar = require(script.Parent.Parent.Components.LoadingBar)
local Constants = require(script.Parent.Parent.Constants)

local Main = Roact.Component:extend("Main")

function Main:init()
    self.transparency, self.updateTransparency = Roact.createBinding(0)
    self.transparencyMotor = Otter.createSingleMotor(0)
    self.transparencyMotor:onStep(self.updateTransparency)
end

function Main:render()
    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(1, 0, 1, 72),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(9, 9, 9),
        BackgroundTransparency = self.transparency,
    }, {
        Icon = Roact.createElement(Icon),
        Label = Roact.createElement(Label),
        LoadingBar = Roact.createElement(LoadingBar),
    })
end

function Main:didUpdate()
    if self.props.finished == true then
        self.transparencyMotor:setGoal(Otter.spring(1, Constants.SPRING_CONFIG_1))
    end
end

function Main:willUnmount()
    self.transparencyMotor:destroy()
    self.transparencyMotor = nil
end

local function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Main)