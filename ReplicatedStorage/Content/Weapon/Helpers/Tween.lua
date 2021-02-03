local TweenService = game:GetService("TweenService")

local function Tween(instance, props, info)
    local tween = TweenService:Create(instance, props, info)
    tween:Play()
end

return Tween