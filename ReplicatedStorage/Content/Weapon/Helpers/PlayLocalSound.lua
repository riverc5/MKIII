local SoundService = game:GetService("SoundService")
local ContentProvider = game:GetService("ContentProvider")

-- TODO: set up optional Parent argument
local function PlayLocalSound(props)
    local sound = Instance.new("Sound")

    for name, value in pairs(props) do
        local prop = sound[name]
        
        if prop then
            sound[name] = value
        end
    end

    ContentProvider:PreloadAsync({sound})
    SoundService:PlayLocalSound(sound)
    
    coroutine.wrap(function()
        sound.Ended:Wait()
        sound:Destroy()
    end)()
end

return PlayLocalSound