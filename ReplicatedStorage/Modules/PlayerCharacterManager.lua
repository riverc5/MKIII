--[[
	Parts of code in this module were taken and modified from https://git.io/JteyE
]]
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local CHARACTER_TAG_NAME = "Characters"

local PlayerCharacterManager = {}

local function waitForFirst(...)

	local shunt = Instance.new("BindableEvent")
	local slots = {...}

	local function fire(...)
		for i = 1, #slots do
			slots[i]:Disconnect()
		end

		return shunt:Fire(...)
	end

	for i = 1, #slots do
		slots[i] = slots[i]:Connect(fire)
	end

	return shunt.Event:Wait()
end

function PlayerCharacterManager:HumanoidReady(character: Model)
		
		local player = Players:GetPlayerFromCharacter(character)

		if not player then
			return
		end

		if not character.Parent then
			waitForFirst(character.AncestryChanged, player.CharacterAdded)
		end

		if player.Character ~= character or not character.Parent then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")
		while character:IsDescendantOf(game) and not humanoid do
			waitForFirst(character.ChildAdded, character.AncestryChanged, player.CharacterAdded)
			humanoid = character:FindFirstChildOfClass("Humanoid")
		end

		if player.Character ~= character or not character:IsDescendantOf(game) then
			return
		end

		local rootPart = character:FindFirstChild("HumanoidRootPart")
		while character:IsDescendantOf(game) and not rootPart do
			waitForFirst(character.ChildAdded, character.AncestryChanged, humanoid.AncestryChanged, player.CharacterAdded)
			rootPart = character:FindFirstChild("HumanoidRootPart")
		end

		if rootPart and humanoid:IsDescendantOf(game) and character:IsDescendantOf(game) and player.Character == character then
			return true
		end
end

function PlayerCharacterManager:Init()
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            local ready = PlayerCharacterManager:HumanoidReady(character)
            
            if ready then
                CollectionService:AddTag(character, CHARACTER_TAG_NAME)
            end
        end)
        
        player.CharacterRemoving:Connect(function(character)
            CollectionService:RemoveTag(character, CHARACTER_TAG_NAME)
        end)
    end)
end

function PlayerCharacterManager:GetCharacters()
    return CollectionService:GetTagged(CHARACTER_TAG_NAME)
end

return PlayerCharacterManager