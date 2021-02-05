local Roact = require(script.Parent.Parent.Parent.Immediate.Roact)
local Otter = require(script.Parent.Parent.Parent.Immediate.Otter)
local RoactRodux = require(script.Parent.Parent.Parent.Immediate.RoactRodux)

local Constants = require(script.Parent.Parent.Constants)

local Label = Roact.Component:extend("Label")

function Label:init()
    self.active = true
    self.text, self.updateText = Roact.createBinding("LOADING")

    self.transparency, self.updateTransparency = Roact.createBinding(0)
    self.transparencyMotor = Otter.createSingleMotor(0)
    self.transparencyMotor:onStep(self.updateTransparency)
end

function Label:render()
    return Roact.createElement("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.244, 0, 0.114, 0),
        Position = UDim2.new(0.547, 0, 0.629, 0),
        TextScaled = true,
        BackgroundTransparency = 1,
        Font = Enum.Font.TitilliumWeb,
        Text = self.text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTransparency = self.transparency,
    })
end

function Label:didMount()
    coroutine.wrap(function()
        while self.active == true do
            self.updateText("LOADING.")
            wait(0.25)
            self.updateText("LOADING..")
            wait(0.25)
            self.updateText("LOADING...")
            wait(1.1)
        end
    end)()
end

function Label:didUpdate()
    if self.props.finished == true then
        self.transparencyMotor:setGoal(Otter.spring(1, Constants.SPRING_CONFIG_1))
    end
end

function Label:willUnmount()
    self.active = false
    self.transparencyMotor:destroy()
    self.transparencyMotor = nil
end

local function mapStateToProps(state, props)
    return state
end

return RoactRodux.connect(mapStateToProps)(Label)