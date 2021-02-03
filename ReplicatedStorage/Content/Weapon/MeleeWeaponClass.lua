local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local Animations = require(ReplicatedStorage.Modules.Animations)

local CreateMotor = require(script.Parent.Helpers.CreateMotor)
local Tween = require(script.Parent.Helpers.Tween)

local QUAD_INOUT_QUICK = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local QUAD_INOUT_SWIFT = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local MeleeWeapon = {}
MeleeWeapon.__index = MeleeWeapon

function MeleeWeapon.new(config)
    local NewMeleeWeapon = {}
    setmetatable(NewMeleeWeapon, MeleeWeapon)

    -- Properties like Damage and Range do not need to be sent nor set here because
    -- the server deals with these.
    NewMeleeWeapon.Sounds = config.Sounds
    NewMeleeWeapon.Humanoid = config.Humanoid
    NewMeleeWeapon.GripPart = config.GripPart
    NewMeleeWeapon.GripBodyPart = config.GripBodyPart
    NewMeleeWeapon.ProcessingRemote = config.ProcessingRemote
    NewMeleeWeapon.GripCFrame = config.GripCFrame
    NewMeleeWeapon.Animator = config.Animator
    NewMeleeWeapon.Animations = config.Animations
end

function MeleeWeapon:Init()
    -- do roact & store stuff here
    self.Animations = Animations:Setup(self.Animator, self.Animations)
end

function MeleeWeapon:Equip()
    -- First, we create the motor on the client. Immediately, we tell the server to
    -- create its motor that replicates to everyone. Once the server is done it gives
    -- the information back to the client when it's ready, and then the client deletes
    -- the temporary motor it created. Seamless transition.
    self.TempGripMotor = CreateMotor(self.GripBodyPart, self.GripPart, self.GripCFrame)
    
    coroutine.wrap(function()
        self.ProcessingRemote:FireServer("Equip")
        self.ProcessingRemote.OnClientEvent:Connect(function(motor)
            self.TempGripMotor:Destroy()
            self.GripMotor = motor
        end)
    end)()

    -- We play the idle animation and then the equip directly after so that we don't
    -- have to spend extra resources waiting for the equip animation to finish.
    self.Animations.Idle:Play()
    self.Animations.Equip:Play()

    if table.find(self.Sounds, "Idle") then
        self.Sounds.Idle:Play()
    end
end

function MeleeWeapon:Unequip()
    for _, animation in pairs(self.Animations) do
        animation:Stop()
    end

    self.Sounds.Unequip:Play()
    self.ProcessingRemote:FireServer("Unequip")
end

function MeleeWeapon:Attack()
    self.Animations.Attack:Play()
    self.ProcessingRemote:FireServer("Attack")
    coroutine.wrap(function()
        self.Animations.Attack:GetMarkerReachedSignal("Attack"):Connect(function()
            self.Sounds.Attack:Play()
            Tween(Lighting.BlurFX, {Size = 8}, QUAD_INOUT_SWIFT)
            wait(0.3)
            Tween(Lighting.BlurFX, {Size = 0}, QUAD_INOUT_QUICK)
        end)
    end)()
end

function MeleeWeapon:Block()
    self.ProcessingRemote:FireServer("Block")
    self.Animations.Block:Play()
    Tween(self.Humanoid, {WalkSpeed = 7, JumpPower = 0}, QUAD_INOUT_QUICK)
end

function MeleeWeapon:Unblock()
    self.ProcessingRemote:FireServer("Unblock")
    self.Animations.Block:Stop(0.25)
end

return MeleeWeapon