local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FastCast = require(ReplicatedStorage.Modules.FastCast)
local PartCache = require(ReplicatedStorage.Modules.PartCache)
local BulletProvider = require(ReplicatedStorage.Modules.BulletProvider)
local Animations = require(ReplicatedStorage.Modules.Animations)

local GetMouseDirection = require(script.Parent.Helpers.GetMouseDirection)
local CreateMotor = require(script.Parent.Helpers.CreateMotor)
local GetPlayerFromPart = require(script.Parent.Helpers.GetPlayerFromPart)

local ProjectileWeapon = {}
ProjectileWeapon.__index = ProjectileWeapon

function ProjectileWeapon.new(config)
    local NewProjectileWeapon = {}
    setmetatable(NewProjectileWeapon, ProjectileWeapon)
    
    NewProjectileWeapon.Accumulated = 0
    NewProjectileWeapon.TimesFired = 0
    
    local bullet = {
        Color = config.TracerColor,
        Lifetime = config.TracerLifetime,
    }

    NewProjectileWeapon.PartCacheInstance = PartCache.new(BulletProvider:Construct(bullet), 10)

    NewProjectileWeapon.Caster = FastCast.new()
    NewProjectileWeapon.CastBehavior = FastCast.newBehavior()
    NewProjectileWeapon.CastBehavior.RaycastParams = RaycastParams.new()
    NewProjectileWeapon.CastBehavior.RaycastParams.IgnoreWater = true
    NewProjectileWeapon.CastBehavior.RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    NewProjectileWeapon.CastBehavior.RaycastParams.FilterDescendantsInstances = config.RaycastBlacklist -- TODO: + character stuff
    NewProjectileWeapon.CastBehavior.MaxDistance = config.MaxDistance
    NewProjectileWeapon.CastBehavior.CosmeticBulletProvider = NewProjectileWeapon.PartCacheInstance

    NewProjectileWeapon.Speed = config.Speed
    NewProjectileWeapon.Sounds = config.Sounds
    NewProjectileWeapon.Humanoid = config.Humanoid
    NewProjectileWeapon.Animator = config.Animator
    NewProjectileWeapon.Animations = config.Animations
    NewProjectileWeapon.GripPart = config.GripPart
    NewProjectileWeapon.GripBodyPart = config.GripBodyPart
    NewProjectileWeapon.ProcessingRemote = config.ProcessingRemote
    NewProjectileWeapon.GripCFrame = config.GripCFrame
    NewProjectileWeapon.OriginPart = config.OriginPart
end

function ProjectileWeapon:Init()
    -- roact stuff here
    self.Animations = Animations:Setup(self.Animator, self.Animations)

    self.Caster.RayHit:Connect(function(caster, result, velocity, cosmeticBullet)
        local part = result.Instance
        local normal = result.Normal
        local position = result.Position
        local maybeHumanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        local maybePlayer = GetPlayerFromPart(part)
        if maybeHumanoid and maybePlayer and maybeHumanoid.Health > 0 and self.Humanoid.Health > 0 then
            self.ProcessingRemote:FireServer("Hit", maybePlayer, maybeHumanoid)
        end

        -- Hit particle effects go here based on hit normal. Use attachments.
    end)
end

function ProjectileWeapon:Equip()
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

function ProjectileWeapon:Unequip()
    for _, animation in pairs(self.Animations) do
        animation:Stop()
    end

    self.Sounds.Unequip:Play()
    self.ProcessingRemote:FireServer("Unequip")
end

function ProjectileWeapon:Fire()
    -- TODO: SPREAD AND OTHER FACTORS
    self.Caster:Fire(
        self.OriginPart.Position,
        GetMouseDirection(),
        self.Speed,
        self.CastBehavior
    )
    -- We send this remote when the user initially triggers to fire so we can replicate
    -- the muzzle flash and tracer rounds to other clients by setting a replicated attribute
    -- that contains JSON data of the shot for other clients to pick up on.
    self.ProcessingRemote:FireServer("Fire")
end

function ProjectileWeapon:Reload()
    self.ProcessingRemote:FireServer("Reload")
    -- do store updating here for ammo amount
end

return ProjectileWeapon