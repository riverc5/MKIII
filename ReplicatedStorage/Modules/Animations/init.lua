local Animations = {}

type Animations = {Animation}

function Animations:Setup(animator: Animator, animations: Animations)
    for i, animation in pairs(animations) do
        local animationTrack = animator:LoadAnimation(animation)
        animations[i] = animationTrack
    end

    return animations
end

function Animations:_BENCHMARKINGSetup2(animator: Animator, animations: Animations)
    for i, animation in ipairs(animations) do
        local animationTrack = animator:LoadAnimation(animation)
        animations[i] = animationTrack
    end

    return animations
end

return Animations
