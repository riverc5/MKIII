local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local MOUSE = Players.LocalPlayer:GetMouse()

local Mouse = {}

function Mouse:ResetToDefault()
    if UserInputService.MouseEnabled then
        MOUSE.Icon = ""
    end
end

function Mouse:SetVisible(visible: boolean)
    if UserInputService.MouseEnabled then
        UserInputService.MouseIconEnabled = visible
    end
end

function Mouse:SetIcon(iconId: number)
    if UserInputService.MouseEnabled then
        MOUSE.Icon = "rbxassetid://"..iconId
    end
end

function Mouse:SetSensitivity(sensitivity: number)
    if UserInputService.MouseEnabled then
        UserInputService.MouseDeltaSensitivity = sensitivity
    end
end

return Mouse