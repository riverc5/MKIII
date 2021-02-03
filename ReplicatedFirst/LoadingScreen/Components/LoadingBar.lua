local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)
local RoactRodux = require(script.Parent.Parent.Parent.Immediate.RoactRodux)
local Otter = require(script.Parent.Parent.Parent.Immediate.Otter)

local Constants = require(script.Parent.Parent.Constants)

local LoadingBar = Roact.Component:extend("LoadingBar")

function LoadingBar:init()
    self.barAlpha, self.updateBarAlpha = Roact.createBinding(self.props.loadingBarProgress)
    self.barAlphaMotor = Otter.createSingleMotor(self.props.loadingBarProgress)
    self.barAlphaMotor:onStep(self.updateBarAlpha)

    self.barAlpha = self.barAlpha:map(function(value)
        return UDim2.fromScale(value, 1)
    end)
end

function LoadingBar:render()
    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Size = UDim2.new(0.374, 0, 0.006, 0),
        Position = UDim2.new(0.5, 0, 0.712, 0),
    }, {
        Bar = Roact.createElement("Frame", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(0, 0.5),
            Size = self.barAlpha,
            Position = UDim2.new(0, 0, 0.5, 0),
        }),
        Shadow = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        }),
    })
end

function LoadingBar:didUpdate()
    self.barAlphaMotor:setGoal(Otter.spring(self.props.loadingBarProgress, Constants.SPRING_CONFIG_1))
end

function LoadingBar:willUnmount()
    self.barAlphaMotor:destroy()
end

local function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(LoadingBar)