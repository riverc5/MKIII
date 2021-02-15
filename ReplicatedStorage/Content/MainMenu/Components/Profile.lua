local Players = game:GetService("Players")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Modules.Roact)
local RoactRodux = require(ReplicatedStorage.Modules.RoactRodux)
local Otter = require(ReplicatedStorage.Modules.Otter)

local Constants = require(script.Parent.Parent.Constants)

local SetDropdownEnabled = require(script.Parent.Parent.Actions.SetDropdownEnabled)

local PLAYER = Players.LocalPlayer

local Profile = Roact.Component:extend("Profile")

function Profile:init()
    self.dropdownEnabled = false
    self.rotation, self.updateRotation = Roact.createBinding(90)
    self.rotationMotor = Otter.createSingleMotor(90)
    self.rotationMotor:onStep(self.updateRotation)
end

function Profile:render()
    return Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.new(0.17, 0, 1, 0),
        Position = UDim2.new(0.914, 0, 0.5, 0),
        BackgroundTransparency = 1,
    }, {
        Dropdown = Roact.createElement("ImageButton", {
            BackgroundTransparency = 1,
            Image = "rbxasset://textures/AnimationEditor/button_control_play.png",
            Rotation = self.rotation,
            Size = UDim2.new(0.117, 0, 0.467, 0),
            Position = UDim2.new(0.78, 0, 0.244, 0),
            [Roact.Event.Activated] = function()
                self.dropdownEnabled = not self.dropdownEnabled
                self.rotationMotor:setGoal(Otter.spring(self.dropdownEnabled and -90 or 90, Constants.DROPDOWN_SPRING_CONFIG_2))
                self.props.onClick(self.dropdownEnabled)
            end,
        }),
        Thumbnail = Roact.createElement("ImageLabel", {
            Image = Players:GetUserThumbnailAsync(PLAYER.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size60x60),
            Size = UDim2.new(0.2, 0, 0.812, 0),
            Position = UDim2.new(0.059, 0, 0.121, 0),
            BackgroundTransparency = 1,
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(186, 185, 187)),
                    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(186, 185, 187)),
                }),
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.2, 0.06),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(0.8, 0.06),
                    NumberSequenceKeypoint.new(1, 1),
                })
            }),
            UICorner = Roact.createElement("UICorner", {
                CornerRadius = UDim.new(1, 0),
            }),
            UIAspectRatioConstraint = Roact.createElement("UIAspectRatioConstraint"),
        }),
        Label = Roact.createElement("TextLabel", {
            Font = Enum.Font.SciFi,
            Text = "PROFILE",
            TextScaled = true,
            Size = UDim2.new(0.522, 0, 0.489, 0),
            Position = UDim2.new(0.266, 0, 0.25, 0),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
        }, {
            UIGradient = Roact.createElement("UIGradient", {
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.145),
                    NumberSequenceKeypoint.new(0.5, 0),
                    NumberSequenceKeypoint.new(1, 0.145),
                })
            })
        }),
    })
end

function Profile:willUnmount()
    self.rotationMotor:destroy()
    self.rotationMotor = nil
end

local function mapStateToProps(state)
    return state.Dropdown
end

local function mapDispatchToProps(dispatch)
    return {
        onClick = function(enabled)
            dispatch(SetDropdownEnabled(enabled))
        end
    }
end

return RoactRodux.connect(mapStateToProps, mapDispatchToProps)(Profile)