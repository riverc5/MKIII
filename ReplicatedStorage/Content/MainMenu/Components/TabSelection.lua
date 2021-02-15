local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)
local Otter = require(ReplicatedStorage.Modules.Otter)

local Constants = require(script.Parent.Parent.Constants)

local TabSelection = Roact.Component:extend("TabSelection")

function TabSelection:init()
    self.firstTime = true

    self.positionX, self.updatePositionX = Roact.createBinding(0)
    self.positionXMotor = Otter.createSingleMotor(self.positionX:getValue())
    self.positionXMotor:onStep(self.updatePositionX)

    self.positionY, self.updatePositionY = Roact.createBinding(0)
    self.positionYMotor = Otter.createSingleMotor(self.positionY:getValue())
    self.positionYMotor:onStep(self.updatePositionY)

    self.position = Roact.joinBindings({self.positionX, self.positionY}):map(function(positions)
        print("mapping")
        return UDim2.fromOffset(positions[1], positions[2])
    end)
end

function TabSelection:render()
    return Roact.createElement("Frame", {
        Position = self.position,
        Size = UDim2.new(0.116, 0, 0.008, 0),
        BackgroundColor3 = Color3.fromRGB(203, 82, 65),
        ZIndex = 2
    }, {
        UICorner = Roact.createElement("UICorner", {
            CornerRadius = UDim.new(0.5, 0),
        }),
        UIGradient = Roact.createElement("UIGradient", {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(186, 185, 187)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 185, 187)),
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.13),
                NumberSequenceKeypoint.new(0.5, 0),
                NumberSequenceKeypoint.new(1, 0.13),
            }),
        }),
    })
end

function TabSelection:willUpdate(nextProps)
    self.tab = nextProps.TabRefs[nextProps.ActiveTab]

    if not self.tab then
        return
    else
        self.tab = self.tab:getValue()
    end

    if self.firstTime == true then
        self.firstTime = false
        print(nextProps)
        self.updatePositionX(self.tab.AbsolutePosition.X - self.tab.AbsoluteSize.X * 2.12)
        self.updatePositionY(self.tab.AbsolutePosition.Y + self.tab.AbsoluteSize.Y / 1.2)
    else
        self.positionXMotor:setGoal(Otter.spring(self.tab.AbsolutePosition.X - self.tab.AbsoluteSize.X * 2.12, Constants.DROPDOWN_SPRING_CONFIG_2))
        self.positionYMotor:setGoal(Otter.spring(self.tab.AbsolutePosition.Y + self.tab.AbsoluteSize.Y / 1.2, Constants.DROPDOWN_SPRING_CONFIG_2))
    end
end

function TabSelection:willUnmount()
    self.positionXMotor:destroy()
    self.positionXMotor = nil
    self.positionYMotor:destroy()
    self.positionYMotor = nil
end

local function mapStateToProps(state)
    return state.Tabs
end

return RoactRodux.connect(mapStateToProps)(TabSelection)