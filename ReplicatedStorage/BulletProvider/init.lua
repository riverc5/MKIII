--[[
    API for constructing cosmetic bullet templates.
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BULLET_TEMPLATE = ReplicatedStorage.Storage.Bullet

local BulletProvider = {}

type Bullet = {
    Color: Color3,
    Lifetime: number,
} | nil

function BulletProvider:Construct(bullet: Bullet)
    local newBullet = BULLET_TEMPLATE:Clone()

    if not bullet then
        return newBullet
    end

    newBullet.Tracer.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, bullet.Color),
        ColorSequenceKeypoint.new(1, bullet.Color:Lerp(Color3.new(1, 1, 1), 0.4))
    })
    newBullet.Tracer.Lifetime = bullet.Lifetime

    return newBullet
end

return BulletProvider

