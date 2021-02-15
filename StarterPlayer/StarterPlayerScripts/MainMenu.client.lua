local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MainMenu = require(ReplicatedStorage.Content.MainMenu.MainMenu)

local mainMenu = MainMenu.new({
    {
        Name = "Home",
        Text = "HOME",
        Icon = "rbxassetid://6119732925",
    },
    {
        Name = "Rules",
        Text = "RULES",
        Icon = "rbxassetid://6119732925",
    },
    {
        Name = "Store",
        Text = "STORE",
        Icon = "rbxassetid://6119732925",
    },
    {
        Name = "Donations",
        Text = "DONATE",
        Icon = "rbxassetid://6119732925",
    },
    {
        Name = "Credits",
        Text = "CREDITS",
        Icon = "rbxassetid://6119732925",
    },
}, {
    {
        Name = "Workpoints",
        Text = "25/25",
        Image = "rbxassetid://6301062966",
    },
    {
        Name = "Playtime",
        Text = "1d, 0h, 0m",
        Image = "rbxassetid://6301062839",
    },
    {
        Name = "Credits",
        Text = "100,000",
        Image = "rbxassetid://6301062902",
    },
})

--[[
StarterGui:SetCore("TopbarEnabled", true)
UserInputService.ModalEnabled = false
]]