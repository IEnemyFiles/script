--// Settings \\--
local Damage = 999999999999 -- How much DMG you want the script to give you - Larger number equals longer wait

--// Services \\--
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--// Variables \\--
local Player = Players.LocalPlayer
local Module = require(ReplicatedStorage:WaitForChild("ModuleScripts"):WaitForChild("SwordData"))
local Player_Damage = Player:WaitForChild("leaderstats"):WaitForChild("DMG")

--// Get Best Sword \\--
local Highest = 2
local Sword = nil
for _, A_1 in next, Module do
    if type(A_1) == "table" and A_1.Attack and A_1.Attack > Highest then
        Highest = A_1.Attack
        Sword = _
    end
end

--// Reduce Lag \\--
Workspace:WaitForChild("Swords").ChildAdded:Connect(function(A_1)
    RunService.RenderStepped:wait()
    A_1:Destroy()
end)
Player.Character.ChildAdded:Connect(function(A_1)
    if A_1:IsA("Tool") then
        RunService.RenderStepped:wait()
        A_1:Destroy()
    end
end)
Player:WaitForChild("Backpack").ChildAdded:Connect(function(A_1)
    wait()
    A_1.Parent = Player.Character
end)

--// Increase DMG \\--
if Sword ~= nil then
    for i = Player_Damage.Value, Damage, Highest do
        ReplicatedStorage:WaitForChild("PetEvents"):WaitForChild("StartSwordEvent"):FireServer(Sword)
        RunService.RenderStepped:wait()
    end
else
    --warn("Patched :(")
end

--// Rejoin to Prevent Lag \\--
TeleportService:Teleport(game.PlaceId)
