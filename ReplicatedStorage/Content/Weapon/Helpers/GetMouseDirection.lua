local UserInputService = game:GetService("UserInputService")

local Camera = workspace.CurrentCamera

-- TODO: test this
local function GetMouseDirection()
    local mouseLocation = UserInputService:GetMouseLocation()
    local ray = Camera:ScreenPointToRay(mouseLocation.X, mouseLocation.Y)
    return ray.Direction
end

return GetMouseDirection