--[[
    This module serves as a entry-point to the core of the netowrking of
    weapons. This module handles user input and sanity checks.
]]

local Players = game:GetService("Players")
local ContextActionService = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")

local ProjectileWeapon = require(script.Parent.ProjectileWeaponClass)
local MeleeWeapon = require(script.Parent.MeleeWeaponClass)

local Player = Players.LocalPlayer

local Weapon = {}

function Weapon:InitializeProjectile(config)
    local weapon = ProjectileWeapon.new(config)

    local equipDebounce = false

    function Fire(actionName, inputState, inputObject)
        if weapon.IsReloading == true then
            return
        end
        if weapon.Automatic == true then
            if inputState == Enum.UserInputState.Begin then
                weapon.FireConnection = RunService.Heartbeat:Connect(function(dt)
                    weapon.Accumulated += dt
                    local fireTimes = math.floor(weapon.Accumulated / (weapon.RPM / 60))

                    if weapon.TimesFired == 0 then
                        weapon:Fire()
                        weapon.TimesFired += 1
                    else
                        if fireTimes >= 1 then
                            for i = 1, fireTimes do
                                weapon:Fire()
                                weapon.timesFired += 1
                            end
                        end
                    end
                end)
            elseif inputState == Enum.UserInputState.End then
                weapon.FireConnection:Disconnect()
            end
        elseif weapon.Automatic == false then
            if inputState == Enum.UserInputState.Begin then
                weapon:Fire()
            end
        end
    end

    function Reload()
        weapon.IsReloading = true

        weapon:Reload()

        weapon.Accumulated = 0
        weapon.TimesFired = 0
        weapon.IsReloading = false
    end

    function Scope()
        -- UserInputService.MouseDeltaSensitivity
        -- FOV
        -- UI
        -- ColorCorrection
        -- Laser
    end

    function Equip()
        if equipDebounce == true then
            return
        end

        weapon:Equip()

        ContextActionService:BindAction("Fire", Fire, false, Enum.UserInputType.MouseButton1)
        ContextActionService:BindAction("Reload", Reload, false, Enum.KeyCode.R)
        ContextActionService:BindAction("Scope", Scope, false, Enum.KeyCode.Z)

        coroutine.wrap(function()
            wait(config.EquipCooldown)
            equipDebounce = false
        end)()
    end

    function Unequip()
        if equipDebounce == true then
            return
        end

        weapon:Unequip()
        ContextActionService:UnbindAction("Fire")

        coroutine.wrap(function()
            wait(config.EquipCooldown)
            equipDebounce = false
        end)()
    end

    config.Tool.Equipped:Connect(Equip)
end

function Weapon:InitializeMelee(config)
    local weapon = MeleeWeapon.new(config)

    local equipDebounce = false
    local attackDebounce = false

    function Block(actionName, inputState, inputObject)
        if weapon.Attacking == true then
            return
        end

        if inputState == Enum.UserInputState.Begin then
            weapon.Blocking = true
            weapon:Block()
        elseif inputState == Enum.UserInputState.End then
            weapon:Unblock()
            weapon.Blocking = false
        end
    end

    function Attack(actionName, inputState, inputObject)
        if inputState ~= Enum.UserInputState.Begin then
            return
        end
        if attackDebounce == true or equipDebounce == true or weapon.Blocking == true then
            return
        end

        weapon.Attacking = true
        weapon:Attack()

        coroutine.wrap(function()
            wait(config.AttackCooldown)
            attackDebounce = false
            weapon.Attacking = false
        end)()
    end

    function Equip()
        if equipDebounce == true then
            return
        end

        weapon:Equip()
        ContextActionService:BindAction("Attack", Attack, false, Enum.UserInputType.MouseButton1)

        coroutine.wrap(function()
            wait(config.EquipCooldown)
            equipDebounce = false
        end)()
    end

    function Unequip()
        if equipDebounce == true then
            return
        end

        weapon:Unequip()
        ContextActionService:UnbindAction("Attack")

        coroutine.wrap(function()
            wait(config.EquipCooldown)
            equipDebounce = false
        end)()
    end

    config.Tool.Equipped:Connect(Equip)
end

return Weapon