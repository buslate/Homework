--[[ปิด JOB]]--
-------------------------------------------------[[Players]]--------------------------------------------
Player = {}
for i,v in pairs(game:GetService("Players"):GetChildren()) do 
    table.insert(Player,v.Name) 
end
-------------------------------------------------[[PVPMODE]]--------------------------------------------

PVP = {"Adove","Behind"}
MODE = PVP[1]

-------------------------------------------------[[UI]]--------------------------------------------

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()
local win = DiscordLib:Window("GAY")
local serv = win:Server("Alchemy", "rbxassetid://11433532654")
wait(1)
DiscordLib:Notification("Notification", "Download Virus", "😨")
local Home = serv:Channel("Main")
local Setting = serv:Channel("Setting")

-------------------------------------------------[[Kill Player]]--------------------------------------------
Home:Seperator()
local drop1 = Home:Dropdown("Select Players", Player, function(Value)
     SelectPlayers = Value
end)

--[[PVPMODE]]--

local drop = Home:Dropdown("PvP Mode", PVP, function(Value)
     PVPMODE = Value
end)

--[[Kill]]--

Home:Toggle("Kill",false, function(Value)
_G.kill = Value
     if _G.kill then
          pcall(function()
               repeat task.wait()
                    if PVPMODE == "Adove" then
                         Tween(game.Players[SelectPlayers].Character.HumanoidRootPart.CFrame * CFrame.new(0,_G.Distance,2) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)))
                    elseif PVPMODE == "Behind" then
                         Tween(game.Players[SelectPlayers].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,_G.Distance))
                    end
               until _G.kill == false
          end)
     end
end)

--[[Teleport To SaftZone]]--

Home:Button("Teleport To SaftZone", function()
     game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2842.63843, 224.26123, -3851.45508, -0.0743552372, 8.89961811e-08, -0.997231841, 4.95854522e-08, 1, 8.55460485e-08, 0.997231841, -4.30873932e-08, -0.0743552372)
end)
local sldr = Home:Slider("Distance [Recommend: 3-4]", 1, 10, 0, function(Value)
     _G.Distance = Value
end)

--[[RefreshPlayer]]--

Home:Button("RefreshPlayer", function()
drop1:Clear()
     for i,v in pairs(game:GetService("Players"):GetChildren()) do 
         if v.Name ~= game.Players.LocalPlayer.Name then 
             table.insert(Player,v.Name)
     drop1:Add(v.Name)
          end
     end
end)
Home:Seperator()

-------------------------------------------------[[AutoEquip]]--------------------------------------------

local weapon = {}

for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
     table.insert(weapon,v.name)
end
local drop = Home:Dropdown("Select Weapon", weapon, function(Value)
     weapon = Value
end)
Home:Toggle("AutoEquip",false, function(Value)
     AutoEquip = Value
end)

spawn(function()
     while task.wait() do
          if AutoEquip then
               pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(weapon))
               end)
          end
     end
end)

-------------------------------------------------[[Fun]]--------------------------------------------

Home:Seperator()
Home:Textbox("Speed [Don't Work with Kill Function]", "Type here!", false, function(Value)
     degrees = Value
end)
Home:Toggle("spinXD",false, function(Value)
_G.SpinMode = Value
     if _G.SpinMode then
          local player = game.Players.LocalPlayer
               local function SpinPlayer()
                    while _G.SpinMode do
                         player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(degrees), 0)
                    task.wait()
               end
          end
     SpinPlayer()
     end
end)
-------------------------------------------------[[AutoClick]]--------------------------------------------

spawn(function()
     while task.wait(.5) do
          pcall(function()
               if _G.kill then
               game:GetService("VirtualInputManager"):SendMouseButtonEvent(500,250,0,true,game,1)
               end
          end)
     end
end)

-------------------------------------------------[[Noclip]]--------------------------------------------

spawn(function()
     while task.wait() do
          pcall(function()
               if _G.kill then 
                    if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                         local Noclip = Instance.new("BodyVelocity")
                         Noclip.Name = "BodyClip"
                         Noclip.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                         Noclip.MaxForce = Vector3.new(100000,100000,100000)
                         Noclip.Velocity = Vector3.new(0,0,0)
                    end
               else
                 game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
             end
         end)
     end
end)

-------------------------------------------------[[Tween]]--------------------------------------------

function Tween(P)
     Distance = (P.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
     speed = 75
     game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/speed, Enum.EasingStyle.Linear),{CFrame = P}):Play()
end

-------------------------------------------------[[Setting]]--------------------------------------------

Setting:Button("Rejoin", function()
     local ts = game:GetService("TeleportService")
     local p = game:GetService("Players").LocalPlayer
     ts:Teleport(game.PlaceId, p)
end)
Setting:Button("Hop To Low Player", function()
     local Http = game:GetService("HttpService")
     local TPS = game:GetService("TeleportService")
     local Api = "https://games.roblox.com/v1/games/"
     local _place = game.PlaceId
     local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
     function ListServers(cursor)
         local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
         return Http:JSONDecode(Raw)
     end
     local Server, Next; repeat
          local Servers = ListServers(Next)
          Server = Servers.data[1]
          Next = Servers.nextPageCursor
     until Server
     TPS:TeleportToPlaceInstance(_place,Server.id,game.Players.LocalPlayer)
end)
Setting:Seperator()
Setting:Button("Don't Click!!❌", function()
     wait(1)
     game.Players.LocalPlayer:Kick("I Said Don't Click NIGGER")
end)
