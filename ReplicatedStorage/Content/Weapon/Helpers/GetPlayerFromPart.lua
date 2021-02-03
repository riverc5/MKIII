--[[
	This piece of code was taken and modified from https://git.io/JteyQ
]]

local Players = game:GetService("Players")

local function GetPlayerFromPart(part)
	if not part then
		return nil
	end

	for _, player in pairs(Players:GetPlayers()) do
		local character = player.Character
		if character then
			if part:IsDescendantOf(character) then
				return player
			end
		end
	end

	return nil
end

return GetPlayerFromPart