--[[
    Handles initialization of PlayerCharacterManager
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerCharacterManager = require(ReplicatedStorage.Modules.PlayerCharacterManager)

PlayerCharacterManager:Init()