if not game:IsLoaded() then
    game.Loaded:Wait()
end
repeat task.wait() until game.Players.LocalPlayer
local safeGuiParent
pcall(function() if gethui then safeGuiParent = gethui() end end)
if not safeGuiParent then
    pcall(function()
        local cg = game:GetService("CoreGui")
        local t = Instance.new("Folder")
        t.Parent = cg
        t:Destroy()
        safeGuiParent = cg
    end)
end
if not safeGuiParent then
    pcall(function()
        safeGuiParent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 5) or game:GetService("Players").LocalPlayer.PlayerGui
    end)
end
local setclipboard = setclipboard or toclipboard or set_clipboard or function(...) end

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/tnyurii/bloxfruit/main/UI.lua"))()
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local camera = workspace.CurrentCamera
local vpX = camera and camera.ViewportSize.X or 800
local vpY = camera and camera.ViewportSize.Y or 600
local winWidth = isMobile and math.clamp(vpX - 40, 360, 480) or 540
local winHeight = isMobile and math.clamp(vpY - 40, 260, 320) or 360

local Window = Fluent:CreateWindow({
    Title = "Banana Cat Hub",
    SubTitle = "Blox Fruits [ Premium ]",
    TabWidth = isMobile and 130 or 150,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(winWidth, winHeight),
    MinimizeKey = Enum.KeyCode.End
})

local Tabs = {
    Home = Window:AddTab({ Title = "Information", Icon = "home" }),
    Main = Window:AddTab({ Title = "Auto Farm", Icon = "swords" }),
    Sea = Window:AddTab({ Title = "Sea Events", Icon = "waves" }),
    ITM = Window:AddTab({ Title = "Other Farms", Icon = "package" }),
    Setting = Window:AddTab({ Title = "Farm Settings", Icon = "settings" }),
    Status = Window:AddTab({ Title = "Status & Server", Icon = "server" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "bar-chart-2" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "navigation" }),
    Visual = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Fruit = Window:AddTab({ Title = "Fruit & ESP", Icon = "cherry" }),
    Raid = Window:AddTab({ Title = "Raid", Icon = "flame" }),
    Race = Window:AddTab({ Title = "Race Upgrade", Icon = "crown" }),
    Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "layers" })
}

Tabs.Home:AddParagraph({
    Title = "Banana Cat Hub - Blox Fruits",
    Content = "Welcome to Banana Cat Hub [ Premium ]\nVersion: 1.1.0\nPress [ End ] key or tap the screen floating button to toggle Menu."
})

local playerInfoCard = Tabs.Home:AddParagraph({
    Title = "Player Information",
    Content = "Loading data..."
})

task.spawn(function()
    while task.wait(3) do
        pcall(function()
            local lp = game:GetService("Players").LocalPlayer
            local lvl = (lp:FindFirstChild("Data") and lp.Data:FindFirstChild("Level")) and tostring(lp.Data.Level.Value) or "N/A"
            local beli = (lp:FindFirstChild("Data") and lp.Data:FindFirstChild("Beli")) and tostring(lp.Data.Beli.Value) or "N/A"
            local frag = (lp:FindFirstChild("Data") and lp.Data:FindFirstChild("Fragments")) and tostring(lp.Data.Fragments.Value) or "N/A"
            local fruit = (lp:FindFirstChild("Data") and lp.Data:FindFirstChild("DevilFruit")) and tostring(lp.Data.DevilFruit.Value) or "None"
            playerInfoCard:SetDesc("Name: " .. lp.DisplayName .. " (@" .. lp.Name .. ")\nLevel: " .. lvl .. "\nBeli: " .. beli .. " | Fragments: " .. frag .. "\nDevil Fruit: " .. fruit)
        end)
    end
end)

Window:SelectTab(1)
local v231 = Instance.new("ScreenGui")
local toggleGuiBtn = Instance.new("ImageButton")
local v233 = Instance.new("UICorner")
local toggleBtnParticles = Instance.new("ParticleEmitter")
local toggleTweenService = game:GetService("TweenService")
v231.Parent = safeGuiParent or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 5) or game:GetService("Players").LocalPlayer.PlayerGui
v231.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
v231.ResetOnSpawn = false
toggleGuiBtn.Parent = v231
toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleGuiBtn.BackgroundTransparency = 0.5
toggleGuiBtn.BorderSizePixel = 0
toggleGuiBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
toggleGuiBtn.Size = UDim2.new(0, 46, 0, 46)
toggleGuiBtn.Draggable = true
toggleGuiBtn.Image = "http://www.roblox.com/asset/?id=130947856929902"
v233.Parent = toggleGuiBtn
v233.CornerRadius = UDim.new(1, 0)
toggleBtnParticles.Parent = toggleGuiBtn
toggleBtnParticles.LightEmission = 1
toggleBtnParticles.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.1),
    NumberSequenceKeypoint.new(1, 0)
})
toggleBtnParticles.Lifetime = NumberRange.new(0.5, 1)
toggleBtnParticles.Rate = 0
toggleBtnParticles.Speed = NumberRange.new(5, 10)
toggleBtnParticles.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255))
local v236 = toggleTweenService
local toggleBtnTween = toggleTweenService:Create(toggleGuiBtn, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    ["Rotation"] = 0
})
local isToggleBtnActive = true
local function toggleMenu()
    toggleBtnParticles.Rate = 100
    task.delay(1, function()
        toggleBtnParticles.Rate = 0
    end)
    toggleBtnTween:Play()
    pcall(function()
        if Window and Window.Minimize then
            Window:Minimize()
        else
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.End, false, game)
        end
    end)
    toggleBtnTween.Completed:Connect(function()
        toggleGuiBtn.Rotation = 0
    end)
    if isToggleBtnActive then
        isToggleBtnActive = false
        toggleGuiBtn.BackgroundTransparency = 0.5
        toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleTweenService:Create(toggleGuiBtn, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(0, 46, 0, 46)
        }):Play()
    else
        isToggleBtnActive = true
        toggleGuiBtn.BackgroundTransparency = 0
        toggleGuiBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleTweenService:Create(toggleGuiBtn, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            ["Size"] = UDim2.new(0, 46, 0, 46)
        }):Play()
    end
end
toggleGuiBtn.MouseButton1Down:Connect(toggleMenu)
toggleGuiBtn.Activated:Connect(toggleMenu)
local UIOptions = Fluent.Options
pcall(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        pcall(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end)
end)
Sea1 = false
Sea2 = false
Sea3 = false
local currentPlaceId = game.PlaceId
if currentPlaceId == 2753915549 then
    Sea1 = true
elseif currentPlaceId == 4442272183 then
    Sea2 = true
elseif currentPlaceId == 7449423635 then
    Sea3 = true
end
function CheckLevel()
    local myLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    if Sea1 then
        if myLevel == 1 or (myLevel <= 9 or SelectMonster == "Bandit") then
            Ms = "Bandit"
            NameQuest = "BanditQuest1"
            QuestLv = 1
            NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif myLevel == 10 or (myLevel <= 14 or SelectMonster == "Monkey") then
            Ms = "Monkey"
            NameQuest = "JungleQuest"
            QuestLv = 1
            NameMon = "Monkey"
            CFrameQ = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(- 1448.1446533203, 50.851993560791, 63.60718536377)
        elseif myLevel == 15 or (myLevel <= 29 or SelectMonster == "Gorilla") then
            Ms = "Gorilla"
            NameQuest = "JungleQuest"
            QuestLv = 2
            NameMon = "Gorilla"
            CFrameQ = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(- 1142.6488037109, 40.462348937988, - 515.39227294922)
        elseif myLevel == 30 or (myLevel <= 39 or SelectMonster == "Pirate") then
            Ms = "Pirate"
            NameQuest = "BuggyQuest1"
            QuestLv = 1
            NameMon = "Pirate"
            CFrameQ = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(- 1201.0881347656, 40.628940582275, 3857.5966796875)
        elseif myLevel == 40 or (myLevel <= 59 or SelectMonster == "Brute") then
            Ms = "Brute"
            NameQuest = "BuggyQuest1"
            QuestLv = 2
            NameMon = "Brute"
            CFrameQ = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(- 1387.5324707031, 24.592035293579, 4100.9575195313)
        elseif myLevel == 60 or (myLevel <= 74 or SelectMonster == "Desert Bandit") then
            Ms = "Desert Bandit"
            NameQuest = "DesertQuest"
            QuestLv = 1
            NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
        elseif myLevel == 75 or (myLevel <= 89 or SelectMonster == "Desert Officer") then
            Ms = "Desert Officer"
            NameQuest = "DesertQuest"
            QuestLv = 2
            NameMon = "Desert Officer"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
        elseif myLevel == 90 or (myLevel <= 99 or SelectMonster == "Snow Bandit") then
            Ms = "Snow Bandit"
            NameQuest = "SnowQuest"
            QuestLv = 1
            NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
            CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, - 1328.2418212891)
        elseif myLevel == 100 or (myLevel <= 119 or SelectMonster == "Snowman") then
            Ms = "Snowman"
            NameQuest = "SnowQuest"
            QuestLv = 2
            NameMon = "Snowman"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
            CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, - 1488.0262451172)
        elseif myLevel == 120 or (myLevel <= 149 or SelectMonster == "Chief Petty Officer") then
            Ms = "Chief Petty Officer"
            NameQuest = "MarineQuest2"
            QuestLv = 1
            NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(- 5035.49609375, 28.677835464478, 4324.1840820313)
            CFrameMon = CFrame.new(- 4931.1552734375, 65.793113708496, 4121.8393554688)
        elseif myLevel == 150 or (myLevel <= 174 or SelectMonster == "Sky Bandit") then
            Ms = "Sky Bandit"
            NameQuest = "SkyQuest"
            QuestLv = 1
            NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(- 4842.1372070313, 717.69543457031, - 2623.0483398438)
            CFrameMon = CFrame.new(- 4955.6411132813, 365.46365356445, - 2908.1865234375)
        elseif myLevel == 175 or (myLevel <= 189 or SelectMonster == "Dark Master") then
            Ms = "Dark Master"
            NameQuest = "SkyQuest"
            QuestLv = 2
            NameMon = "Dark Master"
            CFrameQ = CFrame.new(- 4842.1372070313, 717.69543457031, - 2623.0483398438)
            CFrameMon = CFrame.new(- 5148.1650390625, 439.04571533203, - 2332.9611816406)
        elseif myLevel == 190 or (myLevel <= 209 or SelectMonster == "Prisoner") then
            Ms = "Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 1
            NameMon = "Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, - 0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524, 0.694649816, 0, - 0.719348073, 0, 1, 0, 0.719348073, 0, 0.694649816)
        elseif myLevel == 210 or (myLevel <= 249 or SelectMonster == "Dangerous Prisoner") then
            Ms = "Dangerous Prisoner"
            NameQuest = "PrisonerQuest"
            QuestLv = 2
            NameMon = "Dangerous Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, - 0.999846935, 0, 0.0175017118)
            CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583, 0.898906827, 0, - 0.438139856, 0, 1, 0, 0.438139856, 0, 0.898906827)
        elseif myLevel == 250 or (myLevel <= 274 or SelectMonster == "Toga Warrior") then
            Ms = "Toga Warrior"
            NameQuest = "ColosseumQuest"
            QuestLv = 1
            NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(- 1577.7890625, 7.4151420593262, - 2984.4838867188)
            CFrameMon = CFrame.new(- 1872.5166015625, 49.080215454102, - 2913.810546875)
        elseif myLevel == 275 or (myLevel <= 299 or SelectMonster == "Gladiator") then
            Ms = "Gladiator"
            NameQuest = "ColosseumQuest"
            QuestLv = 2
            NameMon = "Gladiator"
            CFrameQ = CFrame.new(- 1577.7890625, 7.4151420593262, - 2984.4838867188)
            CFrameMon = CFrame.new(- 1521.3740234375, 81.203170776367, - 3066.3139648438)
        elseif myLevel == 300 or (myLevel <= 324 or SelectMonster == "Military Soldier") then
            Ms = "Military Soldier"
            NameQuest = "MagmaQuest"
            QuestLv = 1
            NameMon = "Military Soldier"
            CFrameQ = CFrame.new(- 5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(- 5369.0004882813, 61.24352645874, 8556.4921875)
        elseif myLevel == 325 or (myLevel <= 374 or SelectMonster == "Military Spy") then
            Ms = "Military Spy"
            NameQuest = "MagmaQuest"
            QuestLv = 2
            NameMon = "Military Spy"
            CFrameQ = CFrame.new(- 5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(- 5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, - 0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
        elseif myLevel == 375 or (myLevel <= 399 or SelectMonster == "Fishman Warrior") then
            Ms = "Fishman Warrior"
            NameQuest = "FishmanQuest"
            QuestLv = 1
            NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif myLevel == 400 or (myLevel <= 449 or SelectMonster == "Fishman Commando") then
            Ms = "Fishman Commando"
            NameQuest = "FishmanQuest"
            QuestLv = 2
            NameMon = "Fishman Commando"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif myLevel == 10 or (myLevel <= 474 or SelectMonster == "God\'s Guard") then
            Ms = "God\'s Guard"
            NameQuest = "SkyExp1Quest"
            QuestLv = 1
            NameMon = "God\'s Guard"
            CFrameQ = CFrame.new(- 4721.8603515625, 845.30297851563, - 1953.8489990234)
            CFrameMon = CFrame.new(- 4628.0498046875, 866.92877197266, - 1931.2352294922)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688))
            end
        elseif myLevel == 475 or (myLevel <= 524 or SelectMonster == "Shanda") then
            Ms = "Shanda"
            NameQuest = "SkyExp1Quest"
            QuestLv = 2
            NameMon = "Shanda"
            CFrameQ = CFrame.new(- 7863.1596679688, 5545.5190429688, - 378.42266845703)
            CFrameMon = CFrame.new(- 7685.1474609375, 5601.0751953125, - 441.38876342773)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
            end
        elseif myLevel == 525 or (myLevel <= 549 or SelectMonster == "Royal Squad") then
            Ms = "Royal Squad"
            NameQuest = "SkyExp2Quest"
            QuestLv = 1
            NameMon = "Royal Squad"
            CFrameQ = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
            CFrameMon = CFrame.new(- 7654.2514648438, 5637.1079101563, - 1407.7550048828)
        elseif myLevel == 550 or (myLevel <= 624 or SelectMonster == "Royal Soldier") then
            Ms = "Royal Soldier"
            NameQuest = "SkyExp2Quest"
            QuestLv = 2
            NameMon = "Royal Soldier"
            CFrameQ = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
            CFrameMon = CFrame.new(- 7760.4106445313, 5679.9077148438, - 1884.8112792969)
        elseif myLevel == 625 or (myLevel <= 649 or SelectMonster == "Galley Pirate") then
            Ms = "Galley Pirate"
            NameQuest = "FountainQuest"
            QuestLv = 1
            NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
        elseif myLevel >= 650 or SelectMonster == "Galley Captain" then
            Ms = "Galley Captain"
            NameQuest = "FountainQuest"
            QuestLv = 2
            NameMon = "Galley Captain"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
        end
    end
    if Sea2 then
        if myLevel == 700 or (myLevel <= 724 or SelectMonster == "Raider") then
            Ms = "Raider"
            NameQuest = "Area1Quest"
            QuestLv = 1
            NameMon = "Raider"
            CFrameQ = CFrame.new(- 427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
        elseif myLevel == 725 or (myLevel <= 774 or SelectMonster == "Mercenary") then
            Ms = "Mercenary"
            NameQuest = "Area1Quest"
            QuestLv = 2
            NameMon = "Mercenary"
            CFrameQ = CFrame.new(- 427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(- 864.85009765625, 122.47104644775, 1453.1505126953)
        elseif myLevel == 775 or (myLevel <= 799 or SelectMonster == "Swan Pirate") then
            Ms = "Swan Pirate"
            NameQuest = "Area2Quest"
            QuestLv = 1
            NameMon = "Swan Pirate"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
        elseif myLevel == 800 or (myLevel <= 874 or SelectMonster == "Factory Staff") then
            Ms = "Factory Staff"
            NameQuest = "Area2Quest"
            QuestLv = 2
            NameMon = "Factory Staff"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
        elseif myLevel == 875 or (myLevel <= 899 or SelectMonster == "Marine Lieutenan") then
            Ms = "Marine Lieutenant"
            NameQuest = "MarineQuest3"
            QuestLv = 1
            NameMon = "Marine Lieutenant"
            CFrameQ = CFrame.new(- 2440.9934082031, 73.04190826416, - 3217.7082519531)
            CFrameMon = CFrame.new(- 2489.2622070313, 84.613594055176, - 3151.8830566406)
        elseif myLevel == 900 or (myLevel <= 949 or SelectMonster == "Marine Captain") then
            Ms = "Marine Captain"
            NameQuest = "MarineQuest3"
            QuestLv = 2
            NameMon = "Marine Captain"
            CFrameQ = CFrame.new(- 2440.9934082031, 73.04190826416, - 3217.7082519531)
            CFrameMon = CFrame.new(- 2335.2026367188, 79.786659240723, - 3245.8674316406)
        elseif myLevel == 950 or (myLevel <= 974 or SelectMonster == "Zombie") then
            Ms = "Zombie"
            NameQuest = "ZombieQuest"
            QuestLv = 1
            NameMon = "Zombie"
            CFrameQ = CFrame.new(- 5494.3413085938, 48.505931854248, - 794.59094238281)
            CFrameMon = CFrame.new(- 5536.4970703125, 101.08577728271, - 835.59075927734)
        elseif myLevel == 975 or (myLevel <= 999 or SelectMonster == "Vampire") then
            Ms = "Vampire"
            NameQuest = "ZombieQuest"
            QuestLv = 2
            NameMon = "Vampire"
            CFrameQ = CFrame.new(- 5494.3413085938, 48.505931854248, - 794.59094238281)
            CFrameMon = CFrame.new(- 5806.1098632813, 16.722528457642, - 1164.4384765625)
        elseif myLevel == 1000 or (myLevel <= 1049 or SelectMonster == "Snow Trooper") then
            Ms = "Snow Trooper"
            NameQuest = "SnowMountainQuest"
            QuestLv = 1
            NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, - 5370.5546875)
            CFrameMon = CFrame.new(535.21051025391, 432.74209594727, - 5484.9165039063)
        elseif myLevel == 1050 or (myLevel <= 1099 or SelectMonster == "Winter Warrior") then
            Ms = "Winter Warrior"
            NameQuest = "SnowMountainQuest"
            QuestLv = 2
            NameMon = "Winter Warrior"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, - 5370.5546875)
            CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, - 5174.130859375)
        elseif myLevel == 1100 or (myLevel <= 1124 or SelectMonster == "Lab Subordinate") then
            Ms = "Lab Subordinate"
            NameQuest = "IceSideQuest"
            QuestLv = 1
            NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(- 6061.841796875, 15.926671981812, - 4902.0385742188)
            CFrameMon = CFrame.new(- 5720.5576171875, 63.309471130371, - 4784.6103515625)
        elseif myLevel == 1125 or (myLevel <= 1174 or SelectMonster == "Horned Warrior") then
            Ms = "Horned Warrior"
            NameQuest = "IceSideQuest"
            QuestLv = 2
            NameMon = "Horned Warrior"
            CFrameQ = CFrame.new(- 6061.841796875, 15.926671981812, - 4902.0385742188)
            CFrameMon = CFrame.new(- 6292.751953125, 91.181983947754, - 5502.6499023438)
        elseif myLevel == 1175 or (myLevel <= 1199 or SelectMonster == "Magma Ninja") then
            Ms = "Magma Ninja"
            NameQuest = "FireSideQuest"
            QuestLv = 1
            NameMon = "Magma Ninja"
            CFrameQ = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
            CFrameMon = CFrame.new(- 5461.8388671875, 130.36347961426, - 5836.4702148438)
        elseif myLevel == 1200 or (myLevel <= 1249 or SelectMonster == "Lava Pirate") then
            Ms = "Lava Pirate"
            NameQuest = "FireSideQuest"
            QuestLv = 2
            NameMon = "Lava Pirate"
            CFrameQ = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
            CFrameMon = CFrame.new(- 5251.1889648438, 55.164535522461, - 4774.4096679688)
        elseif myLevel == 1250 or (myLevel <= 1274 or SelectMonster == "Ship Deckhand") then
            Ms = "Ship Deckhand"
            NameQuest = "ShipQuest1"
            QuestLv = 1
            NameMon = "Ship Deckhand"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif myLevel == 1275 or (myLevel <= 1299 or SelectMonster == "Ship Engineer") then
            Ms = "Ship Engineer"
            NameQuest = "ShipQuest1"
            QuestLv = 2
            NameMon = "Ship Engineer"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif myLevel == 1300 or (myLevel <= 1324 or SelectMonster == "Ship Steward") then
            Ms = "Ship Steward"
            NameQuest = "ShipQuest2"
            QuestLv = 1
            NameMon = "Ship Steward"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif myLevel == 1325 or (myLevel <= 1349 or SelectMonster == "Ship Officer") then
            Ms = "Ship Officer"
            NameQuest = "ShipQuest2"
            QuestLv = 2
            NameMon = "Ship Officer"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif myLevel == 1350 or (myLevel <= 1374 or SelectMonster == "Arctic Warrior") then
            Ms = "Arctic Warrior"
            NameQuest = "FrostQuest"
            QuestLv = 1
            NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, - 6484.6005859375)
            CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, - 6472.7568359375)
            if _G.AutoLevel and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422))
            end
        elseif myLevel == 1375 or (myLevel <= 1424 or SelectMonster == "Snow Lurker") then
            Ms = "Snow Lurker"
            NameQuest = "FrostQuest"
            QuestLv = 2
            NameMon = "Snow Lurker"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, - 6484.6005859375)
            CFrameMon = CFrame.new(5628.482421875, 57.574996948242, - 6618.3481445313)
        elseif myLevel == 1425 or (myLevel <= 1449 or SelectMonster == "Sea Soldier") then
            Ms = "Sea Soldier"
            NameQuest = "ForgottenQuest"
            QuestLv = 1
            NameMon = "Sea Soldier"
            CFrameQ = CFrame.new(- 3054.5827636719, 236.87213134766, - 10147.790039063)
            CFrameMon = CFrame.new(- 3185.0153808594, 58.789089202881, - 9663.6064453125)
        elseif myLevel >= 1450 or SelectMonster == "Water Fighter" then
            Ms = "Water Fighter"
            NameQuest = "ForgottenQuest"
            QuestLv = 2
            NameMon = "Water Fighter"
            CFrameQ = CFrame.new(- 3054.5827636719, 236.87213134766, - 10147.790039063)
            CFrameMon = CFrame.new(- 3262.9301757813, 298.69036865234, - 10552.529296875)
        end
    end
    if Sea3 then
        if myLevel == 1500 or (myLevel <= 1524 or SelectMonster == "Pirate Millionaire") then
            Ms = "Pirate Millionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 1
            NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(- 450.1046447753906, 107.68145751953125, 5950.72607421875)
            CFrameMon = CFrame.new(- 193.99227905273438, 56.12502670288086, 5755.7880859375)
        elseif myLevel == 1525 or (myLevel <= 1574 or SelectMonster == "Pistol Billionaire") then
            Ms = "Pistol Billionaire"
            NameQuest = "PiratePortQuest"
            QuestLv = 2
            NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(- 450.1046447753906, 107.68145751953125, 5950.72607421875)
            CFrameMon = CFrame.new(- 188.14462280273438, 84.49613189697266, 6337.0419921875)
        elseif myLevel == 1575 or (myLevel <= 1599 or SelectMonster == "Dragon Crew Warrior") then
            Ms = "Dragon Crew Warrior"
            NameQuest = "DragonCrewQuest"
            QuestLv = 1
            NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(6735.11083984375, 126.99046325683594, - 711.0979614257812)
            CFrameMon = CFrame.new(6615.2333984375, 50.847679138183594, - 978.93408203125)
        elseif myLevel == 1600 or (myLevel <= 1624 or SelectMonster == "Dragon Crew Archer") then
            Ms = "Dragon Crew Archer"
            NameQuest = "DragonCrewQuest"
            QuestLv = 2
            NameMon = "Dragon Crew Archer"
            CFrameQ = CFrame.new(6735.11083984375, 126.99046325683594, - 711.0979614257812)
            CFrameMon = CFrame.new(6818.58935546875, 483.718994140625, 512.726806640625)
        elseif myLevel == 1625 or (myLevel <= 1649 or SelectMonster == "Hydra Enforcer") then
            Ms = "Hydra Enforcer"
            NameQuest = "VenomCrewQuest"
            QuestLv = 1
            NameMon = "Hydra Enforcer"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4547.115234375, 1001.60205078125, 334.1954650878906)
        elseif myLevel == 1650 or (myLevel <= 1699 or SelectMonster == "Venomous Assailant") then
            Ms = "Venomous Assailant"
            NameQuest = "VenomCrewQuest"
            QuestLv = 2
            NameMon = "Venomous Assailant"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4637.88525390625, 1077.85595703125, 882.4183959960938)
        elseif myLevel == 1700 or (myLevel <= 1724 or SelectMonster == "Marine Commodore") then
            Ms = "Marine Commodore"
            NameQuest = "MarineTreeIsland"
            QuestLv = 1
            NameMon = "Marine Commodore"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, - 6740.0551757813)
            CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, - 7109.5043945313)
        elseif myLevel == 1725 or (myLevel <= 1774 or SelectMonster == "Marine Rear Admiral") then
            Ms = "Marine Rear Admiral"
            NameQuest = "MarineTreeIsland"
            QuestLv = 2
            NameMon = "Marine Rear Admiral"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, - 6740.0551757813)
            CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, - 7048.6342773438)
        elseif myLevel == 1775 or (myLevel <= 1799 or SelectMonster == "Fishman Raider") then
            Ms = "Fishman Raider"
            NameQuest = "DeepForestIsland3"
            QuestLv = 1
            NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(- 10582.759765625, 331.78845214844, - 8757.666015625)
            CFrameMon = CFrame.new(- 10553.268554688, 521.38439941406, - 8176.9458007813)
        elseif myLevel == 1800 or (myLevel <= 1824 or SelectMonster == "Fishman Captain") then
            Ms = "Fishman Captain"
            NameQuest = "DeepForestIsland3"
            QuestLv = 2
            NameMon = "Fishman Captain"
            CFrameQ = CFrame.new(- 10583.099609375, 331.78845214844, - 8759.4638671875)
            CFrameMon = CFrame.new(- 10789.401367188, 427.18637084961, - 9131.4423828125)
        elseif myLevel == 1825 or (myLevel <= 1849 or SelectMonster == "Forest Pirate") then
            Ms = "Forest Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 1
            NameMon = "Forest Pirate"
            CFrameQ = CFrame.new(- 13232.662109375, 332.40396118164, - 7626.4819335938)
            CFrameMon = CFrame.new(- 13489.397460938, 400.30349731445, - 7770.251953125)
        elseif myLevel == 1850 or (myLevel <= 1899 or SelectMonster == "Mythological Pirate") then
            Ms = "Mythological Pirate"
            NameQuest = "DeepForestIsland"
            QuestLv = 2
            NameMon = "Mythological Pirate"
            CFrameQ = CFrame.new(- 13232.662109375, 332.40396118164, - 7626.4819335938)
            CFrameMon = CFrame.new(- 13508.616210938, 582.46228027344, - 6985.3037109375)
        elseif myLevel == 1900 or (myLevel <= 1924 or SelectMonster == "Jungle Pirate") then
            Ms = "Jungle Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 1
            NameMon = "Jungle Pirate"
            CFrameQ = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
            CFrameMon = CFrame.new(- 12267.103515625, 459.75262451172, - 10277.200195313)
        elseif myLevel == 1925 or (myLevel <= 1974 or SelectMonster == "Musketeer Pirate") then
            Ms = "Musketeer Pirate"
            NameQuest = "DeepForestIsland2"
            QuestLv = 2
            NameMon = "Musketeer Pirate"
            CFrameQ = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
            CFrameMon = CFrame.new(- 13291.5078125, 520.47338867188, - 9904.638671875)
        elseif myLevel == 1975 or (myLevel <= 1999 or SelectMonster == "Reborn Skeleton") then
            Ms = "Reborn Skeleton"
            NameQuest = "HauntedQuest1"
            QuestLv = 1
            NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(- 9480.80762, 142.130661, 5566.37305, - 0.00655503059, 4.5295423e-8, - 0.999978542, 2.0492047e-8, 1, 4.5162068e-8, 0.999978542, - 2.0195568e-8, - 0.00655503059)
            CFrameMon = CFrame.new(- 8761.77148, 183.431747, 6168.33301, 0.978073597, - 0.000013950732, - 0.208259016, - 1.0807393e-6, 1, - 0.00007206303, 0.208259016, 0.00007070804, 0.978073597)
        elseif myLevel == 2000 or (myLevel <= 2024 or SelectMonster == "Living Zombie") then
            Ms = "Living Zombie"
            NameQuest = "HauntedQuest1"
            QuestLv = 2
            NameMon = "Living Zombie"
            CFrameQ = CFrame.new(- 9480.80762, 142.130661, 5566.37305, - 0.00655503059, 4.5295423e-8, - 0.999978542, 2.0492047e-8, 1, 4.5162068e-8, 0.999978542, - 2.0195568e-8, - 0.00655503059)
            CFrameMon = CFrame.new(- 10103.7529, 238.565979, 6179.75977, 0.999474227, 2.7754714e-8, 0.0324240364, - 2.5800633e-8, 1, - 6.068485e-8, - 0.0324240364, 5.981639e-8, 0.999474227)
        elseif myLevel == 2025 or (myLevel <= 2049 or SelectMonster == "Demonic Soul") then
            Ms = "Demonic Soul"
            NameQuest = "HauntedQuest2"
            QuestLv = 1
            NameMon = "Demonic Soul"
            CFrameQ = CFrame.new(- 9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(- 9712.03125, 204.69589233398, 6193.322265625)
        elseif myLevel == 2050 or (myLevel <= 2074 or SelectMonster == "Posessed Mummy") then
            Ms = "Posessed Mummy"
            NameQuest = "HauntedQuest2"
            QuestLv = 2
            NameMon = "Posessed Mummy"
            CFrameQ = CFrame.new(- 9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(- 9545.7763671875, 69.619895935059, 6339.5615234375)
        elseif myLevel == 2075 or (myLevel <= 2099 or SelectMonster == "Peanut Scout") then
            Ms = "Peanut Scout"
            NameQuest = "NutsIslandQuest"
            QuestLv = 1
            NameMon = "Peanut Scout"
            CFrameQ = CFrame.new(- 2105.53198, 37.2495995, - 10195.5088, - 0.766061664, 0, - 0.642767608, 0, 1, 0, 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 2150.587890625, 122.49767303467, - 10358.994140625)
        elseif myLevel == 2100 or (myLevel <= 2124 or SelectMonster == "Peanut President") then
            Ms = "Peanut President"
            NameQuest = "NutsIslandQuest"
            QuestLv = 2
            NameMon = "Peanut President"
            CFrameQ = CFrame.new(- 2105.53198, 37.2495995, - 10195.5088, - 0.766061664, 0, - 0.642767608, 0, 1, 0, 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 2150.587890625, 122.49767303467, - 10358.994140625)
        elseif myLevel == 2125 or (myLevel <= 2149 or SelectMonster == "Ice Cream Chef") then
            Ms = "Ice Cream Chef"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 1
            NameMon = "Ice Cream Chef"
            CFrameQ = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 789.941528, 209.382889, - 11009.9805, - 0.0703101531, "-0", - 0.997525156, "-0", 1.00000012, "-0", 0.997525275, 0, - 0.0703101456)
        elseif myLevel == 2150 or (myLevel <= 2199 or SelectMonster == "Ice Cream Commander") then
            Ms = "Ice Cream Commander"
            NameQuest = "IceCreamIslandQuest"
            QuestLv = 2
            NameMon = "Ice Cream Commander"
            CFrameQ = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664)
            CFrameMon = CFrame.new(- 789.941528, 209.382889, - 11009.9805, - 0.0703101531, "-0", - 0.997525156, "-0", 1.00000012, "-0", 0.997525275, 0, - 0.0703101456)
        elseif myLevel == 2200 or (myLevel <= 2224 or SelectMonster == "Cookie Crafter") then
            Ms = "Cookie Crafter"
            NameQuest = "CakeQuest1"
            QuestLv = 1
            NameMon = "Cookie Crafter"
            CFrameQ = CFrame.new(- 2022.29858, 36.9275894, - 12030.9766, - 0.961273909, 0, - 0.275594592, 0, 1, 0, 0.275594592, 0, - 0.961273909)
            CFrameMon = CFrame.new(- 2321.71216, 36.699482, - 12216.7871, - 0.780074954, 0, 0.625686109, 0, 1, 0, - 0.625686109, 0, - 0.780074954)
        elseif myLevel == 2225 or (myLevel <= 2249 or SelectMonster == "Cake Guard") then
            Ms = "Cake Guard"
            NameQuest = "CakeQuest1"
            QuestLv = 2
            NameMon = "Cake Guard"
            CFrameQ = CFrame.new(- 2022.29858, 36.9275894, - 12030.9766, - 0.961273909, 0, - 0.275594592, 0, 1, 0, 0.275594592, 0, - 0.961273909)
            CFrameMon = CFrame.new(- 1418.11011, 36.6718941, - 12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, - 0.997700036, 0, 0.0677844882)
        elseif myLevel == 2250 or (myLevel <= 2274 or SelectMonster == "Baking Staff") then
            Ms = "Baking Staff"
            NameQuest = "CakeQuest2"
            QuestLv = 1
            NameMon = "Baking Staff"
            CFrameQ = CFrame.new(- 1928.31763, 37.7296638, - 12840.626, 0.951068401, "-0", - 0.308980465, 0, 1, "-0", 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(- 1980.43848, 36.6716766, - 12983.8418, - 0.254443765, 0, - 0.967087567, 0, 1, 0, 0.967087567, 0, - 0.254443765)
        elseif myLevel == 2275 or (myLevel <= 2299 or SelectMonster == "Head Baker") then
            Ms = "Head Baker"
            NameQuest = "CakeQuest2"
            QuestLv = 2
            NameMon = "Head Baker"
            CFrameQ = CFrame.new(- 1928.31763, 37.7296638, - 12840.626, 0.951068401, "-0", - 0.308980465, 0, 1, "-0", 0.308980465, 0, 0.951068401)
            CFrameMon = CFrame.new(- 2251.5791, 52.2714615, - 13033.3965, - 0.991971016, 0, - 0.126466095, 0, 1, 0, 0.126466095, 0, - 0.991971016)
        elseif myLevel == 2300 or (myLevel <= 2324 or SelectMonster == "Cocoa Warrior") then
            Ms = "Cocoa Warrior"
            NameQuest = "ChocQuest1"
            QuestLv = 1
            NameMon = "Cocoa Warrior"
            CFrameQ = CFrame.new(231.75, 23.9003029, - 12200.292, - 1, 0, 0, 0, 1, 0, 0, 0, - 1)
            CFrameMon = CFrame.new(167.978516, 26.2254658, - 12238.874, - 0.939700961, 0, 0.341998369, 0, 1, 0, - 0.341998369, 0, - 0.939700961)
        elseif myLevel == 2325 or (myLevel <= 2349 or SelectMonster == "Chocolate Bar Battler") then
            Ms = "Chocolate Bar Battler"
            NameQuest = "ChocQuest1"
            QuestLv = 2
            NameMon = "Chocolate Bar Battler"
            CFrameQ = CFrame.new(231.75, 23.9003029, - 12200.292, - 1, 0, 0, 0, 1, 0, 0, 0, - 1)
            CFrameMon = CFrame.new(701.312073, 25.5824986, - 12708.2148, - 0.342042685, 0, - 0.939684391, 0, 1, 0, 0.939684391, 0, - 0.342042685)
        elseif myLevel == 2350 or (myLevel <= 2374 or SelectMonster == "Sweet Thief") then
            Ms = "Sweet Thief"
            NameQuest = "ChocQuest2"
            QuestLv = 1
            NameMon = "Sweet Thief"
            CFrameQ = CFrame.new(151.198242, 23.8907146, - 12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, - 0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(- 140.258301, 25.5824986, - 12652.3115, 0.173624337, "-0", - 0.984811902, 0, 1, "-0", 0.984811902, 0, 0.173624337)
        elseif myLevel == 2375 or (myLevel <= 2400 or SelectMonster == "Candy Rebel") then
            Ms = "Candy Rebel"
            NameQuest = "ChocQuest2"
            QuestLv = 2
            NameMon = "Candy Rebel"
            CFrameQ = CFrame.new(151.198242, 23.8907146, - 12774.6172, 0.422592998, 0, 0.906319618, 0, 1, 0, - 0.906319618, 0, 0.422592998)
            CFrameMon = CFrame.new(47.9231453, 25.5824986, - 13029.2402, - 0.819156051, 0, - 0.573571265, 0, 1, 0, 0.573571265, 0, - 0.819156051)
        elseif myLevel == 2400 or (myLevel <= 2424 or SelectMonster == "Candy Pirate") then
            Ms = "Candy Pirate"
            NameQuest = "CandyQuest1"
            QuestLv = 1
            NameMon = "Candy Pirate"
            CFrameQ = CFrame.new(- 1149.328, 13.5759039, - 14445.6143, - 0.156446099, 0, - 0.987686574, 0, 1, 0, 0.987686574, 0, - 0.156446099)
            CFrameMon = CFrame.new(- 1437.56348, 17.1481285, - 14385.6934, 0.173624337, "-0", - 0.984811902, 0, 1, "-0", 0.984811902, 0, 0.173624337)
        elseif myLevel == 2425 or (myLevel <= 2449 or SelectMonster == "Snow Demon") then
            Ms = "Snow Demon"
            NameQuest = "CandyQuest1"
            QuestLv = 2
            NameMon = "Snow Demon"
            CFrameQ = CFrame.new(- 1149.328, 13.5759039, - 14445.6143, - 0.156446099, 0, - 0.987686574, 0, 1, 0, 0.987686574, 0, - 0.156446099)
            CFrameMon = CFrame.new(- 916.222656, 17.1481285, - 14638.8125, 0.866007268, 0, 0.500031412, 0, 1, 0, - 0.500031412, 0, 0.866007268)
        elseif myLevel == 2450 or (myLevel <= 2474 or SelectMonster == "Isle Outlaw") then
            Ms = "Isle Outlaw"
            NameQuest = "TikiQuest1"
            QuestLv = 1
            NameMon = "Isle Outlaw"
            CFrameQ = CFrame.new(- 16549.890625, 55.68635559082031, - 179.91360473632812)
            CFrameMon = CFrame.new(- 16162.8193359375, 11.6863374710083, - 96.45481872558594)
        elseif myLevel == 2475 or (myLevel <= 2499 or SelectMonster == "Island Boy") then
            Ms = "Island Boy"
            NameQuest = "TikiQuest1"
            QuestLv = 2
            NameMon = "Island Boy"
            CFrameQ = CFrame.new(- 16549.890625, 55.68635559082031, - 179.91360473632812)
            CFrameMon = CFrame.new(- 16357.3125, 20.632822036743164, 1005.64892578125)
        elseif myLevel == 2500 or (myLevel <= 2524 or SelectMonster == "Sun-kissed Warrior") then
            Ms = "Sun-kissed Warrior"
            NameQuest = "TikiQuest2"
            QuestLv = 1
            NameMon = "Sun-kissed Warrior"
            CFrameQ = CFrame.new(- 16541.021484375, 54.77081298828125, 1051.461181640625)
            CFrameMon = CFrame.new(- 16357.3125, 20.632822036743164, 1005.64892578125)
        elseif myLevel == 2525 or (myLevel <= 2549 or SelectMonster == "Isle Champion") then
            Ms = "Isle Champion"
            NameQuest = "TikiQuest2"
            QuestLv = 2
            NameMon = "Isle Champion"
            CFrameQ = CFrame.new(- 16541.021484375, 54.77081298828125, 1051.461181640625)
            CFrameMon = CFrame.new(- 16848.94140625, 21.68633460998535, 1041.4490966796875)
        elseif myLevel == 2550 or (myLevel <= 2574 or SelectMonster == "Serpent Hunter") then
            Ms = "Serpent Hunter"
            NameQuest = "TikiQuest3"
            QuestLv = 1
            NameMon = "Serpent Hunter"
            CFrameQ = CFrame.new(- 16665.19140625, 104.59640502929688, 1579.6943359375)
            CFrameMon = CFrame.new(- 16621.4140625, 121.40631103515625, 1290.6881103515625)
        elseif myLevel == 2575 or (myLevel <= 2599 or (SelectMonster == "Skull Slayer" or myLevel == 2600)) then
            Ms = "Skull Slayer"
            NameQuest = "TikiQuest3"
            QuestLv = 2
            NameMon = "Skull Slayer"
            CFrameQ = CFrame.new(- 16665.19140625, 104.59640502929688, 1579.6943359375)
            CFrameMon = CFrame.new(- 16811.5703125, 84.625244140625, 1542.235107421875)
        end
    end
end
if Sea1 then
    tableMon = {
        "Bandit",
        "Monkey",
        "Gorilla",
        "Pirate",
        "Brute",
        "Desert Bandit",
        "Desert Officer",
        "Snow Bandit",
        "Snowman",
        "Chief Petty Officer",
        "Sky Bandit",
        "Dark Master",
        "Prisoner",
        "Dangerous Prisoner",
        "Toga Warrior",
        "Gladiator",
        "Military Soldier",
        "Military Spy",
        "Fishman Warrior",
        "Fishman Commando",
        "God\'s Guard",
        "Shanda",
        "Royal Squad",
        "Royal Soldier",
        "Galley Pirate",
        "Galley Captain"
    }
elseif Sea2 then
    tableMon = {
        "Raider",
        "Mercenary",
        "Swan Pirate",
        "Factory Staff",
        "Marine Lieutenant",
        "Marine Captain",
        "Zombie",
        "Vampire",
        "Snow Trooper",
        "Winter Warrior",
        "Lab Subordinate",
        "Horned Warrior",
        "Magma Ninja",
        "Lava Pirate",
        "Ship Deckhand",
        "Ship Engineer",
        "Ship Steward",
        "Ship Officer",
        "Arctic Warrior",
        "Snow Lurker",
        "Sea Soldier",
        "Water Fighter"
    }
elseif Sea3 then
    tableMon = {
        "Pirate Millionaire",
        "Dragon Crew Warrior",
        "Dragon Crew Archer",
        "Hydra Enforcer",
        "Venomous Assailant",
        "Marine Commodore",
        "Marine Rear Admiral",
        "Fishman Raider",
        "Fishman Captain",
        "Forest Pirate",
        "Mythological Pirate",
        "Jungle Pirate",
        "Musketeer Pirate",
        "Reborn Skeleton",
        "Living Zombie",
        "Demonic Soul",
        "Posessed Mummy",
        "Peanut Scout",
        "Peanut President",
        "Ice Cream Chef",
        "Ice Cream Commander",
        "Cookie Crafter",
        "Cake Guard",
        "Baking Staff",
        "Head Baker",
        "Cocoa Warrior",
        "Chocolate Bar Battler",
        "Sweet Thief",
        "Candy Rebel",
        "Candy Pirate",
        "Snow Demon",
        "Isle Outlaw",
        "Island Boy",
        "Sun-kissed Warrior",
        "Isle Champion",
        "Serpent Hunter",
        "Skull Slayer"
    }
end
if Sea1 then
    AreaList = {
        "Jungle",
        "Buggy",
        "Desert",
        "Snow",
        "Marine",
        "Sky",
        "Prison",
        "Colosseum",
        "Magma",
        "Fishman",
        "Sky Island",
        "Fountain"
    }
elseif Sea2 then
    AreaList = {
        "Area 1",
        "Area 2",
        "Zombie",
        "Marine",
        "Snow Mountain",
        "Ice fire",
        "Ship",
        "Frost",
        "Forgotten"
    }
elseif Sea3 then
    AreaList = {
        "Pirate Port",
        "Amazon",
        "Marine Tree",
        "Deep Forest",
        "Haunted Castle",
        "Nut Island",
        "Ice Cream Island",
        "Cake Island",
        "Choco Island",
        "Candy Island",
        "Tiki Outpost"
    }
end
function CheckBossQuest()
    if Sea1 then
        if SelectBoss ~= "The Gorilla King" then
            if SelectBoss ~= "Bobby" then
                if SelectBoss ~= "The Saw" then
                    if SelectBoss ~= "Yeti" then
                        if SelectBoss ~= "Mob Leader" then
                            if SelectBoss ~= "Vice Admiral" then
                                if SelectBoss ~= "Saber Expert" then
                                    if SelectBoss ~= "Warden" then
                                        if SelectBoss ~= "Chief Warden" then
                                            if SelectBoss ~= "Swan" then
                                                if SelectBoss ~= "Magma Admiral" then
                                                    if SelectBoss ~= "Fishman Lord" then
                                                        if SelectBoss ~= "Wysper" then
                                                            if SelectBoss ~= "Thunder God" then
                                                                if SelectBoss ~= "Cyborg" then
                                                                    if SelectBoss ~= "Ice Admiral" then
                                                                        if SelectBoss == "Greybeard" then
                                                                            BossMon = "Greybeard"
                                                                            NameBoss = "Greybeard"
                                                                            CFrameBoss = CFrame.new(- 5081.3452148438, 85.221641540527, 4257.3588867188)
                                                                        end
                                                                    else
                                                                        BossMon = "Ice Admiral"
                                                                        NameBoss = "Ice Admiral"
                                                                        CFrameBoss = CFrame.new(1266.08948, 26.1757946, - 1399.57678, - 0.573599219, 0, - 0.81913656, 0, 1, 0, 0.81913656, 0, - 0.573599219)
                                                                    end
                                                                else
                                                                    BossMon = "Cyborg"
                                                                    NameBoss = "Cyborg"
                                                                    NameQuestBoss = "FountainQuest"
                                                                    QuestLvBoss = 3
                                                                    RewardBoss = "Reward:\n$20,000\n7,500,000 Exp."
                                                                    CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
                                                                    CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
                                                                end
                                                            else
                                                                BossMon = "Thunder God"
                                                                NameBoss = "Thunder God"
                                                                NameQuestBoss = "SkyExp2Quest"
                                                                QuestLvBoss = 3
                                                                RewardBoss = "Reward:\n$20,000\n5,800,000 Exp."
                                                                CFrameQBoss = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
                                                                CFrameBoss = CFrame.new(- 7994.984375, 5761.025390625, - 2088.6479492188)
                                                            end
                                                        else
                                                            BossMon = "Wysper"
                                                            NameBoss = "Wysper"
                                                            NameQuestBoss = "SkyExp1Quest"
                                                            QuestLvBoss = 3
                                                            RewardBoss = "Reward:\n$15,000\n4,800,000 Exp."
                                                            CFrameQBoss = CFrame.new(- 7861.947265625, 5545.517578125, - 379.85974121094)
                                                            CFrameBoss = CFrame.new(- 7866.1333007813, 5576.4311523438, - 546.74816894531)
                                                        end
                                                    else
                                                        BossMon = "Fishman Lord"
                                                        NameBoss = "Fishman Lord"
                                                        NameQuestBoss = "FishmanQuest"
                                                        QuestLvBoss = 3
                                                        RewardBoss = "Reward:\n$15,000\n4,000,000 Exp."
                                                        CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
                                                        CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
                                                    end
                                                else
                                                    BossMon = "Magma Admiral"
                                                    NameBoss = "Magma Admiral"
                                                    NameQuestBoss = "MagmaQuest"
                                                    QuestLvBoss = 3
                                                    RewardBoss = "Reward:\n$15,000\n2,800,000 Exp."
                                                    CFrameQBoss = CFrame.new(- 5314.6220703125, 12.262420654297, 8517.279296875)
                                                    CFrameBoss = CFrame.new(- 5765.8969726563, 82.92064666748, 8718.3046875)
                                                end
                                            else
                                                BossMon = "Swan"
                                                NameBoss = "Swan"
                                                NameQuestBoss = "ImpelQuest"
                                                QuestLvBoss = 3
                                                RewardBoss = "Reward:\n$15,000\n1,600,000 Exp."
                                                CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, - 0.309060812, 0, 0.951042235, 0, 1, 0, - 0.951042235, 0, - 0.309060812)
                                                CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635)
                                            end
                                        else
                                            BossMon = "Chief Warden"
                                            NameBoss = "Chief Warden"
                                            NameQuestBoss = "ImpelQuest"
                                            QuestLvBoss = 2
                                            RewardBoss = "Reward:\n$10,000\n1,000,000 Exp."
                                            CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, - 0.00062915677, 0.939684749, 0.00191645394, 0.999998152, - 0.000028042234, - 0.939682961, 0.00181045406, 0.342041939)
                                            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635)
                                        end
                                    else
                                        BossMon = "Warden"
                                        NameBoss = "Warden"
                                        NameQuestBoss = "ImpelQuest"
                                        QuestLvBoss = 1
                                        RewardBoss = "Reward:\n$6,000\n850,000 Exp."
                                        CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, - 4.499464e-6, 0.975376427, - 0.000019541258, 1, 9.031621e-6, - 0.975376427, - 0.000021051976, 0.220546961)
                                        CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635)
                                    end
                                else
                                    NameBoss = "Saber Expert"
                                    BossMon = "Saber Expert"
                                    CFrameBoss = CFrame.new(- 1458.89502, 29.8870335, - 50.633564)
                                end
                            else
                                BossMon = "Vice Admiral"
                                NameBoss = "Vice Admiral"
                                NameQuestBoss = "MarineQuest2"
                                QuestLvBoss = 2
                                RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                                CFrameQBoss = CFrame.new(- 5036.2465820313, 28.677835464478, 4324.56640625)
                                CFrameBoss = CFrame.new(- 5006.5454101563, 88.032081604004, 4353.162109375)
                            end
                        else
                            BossMon = "Mob Leader"
                            NameBoss = "Mob Leader"
                            CFrameBoss = CFrame.new(- 2844.7307128906, 7.4180502891541, 5356.6723632813)
                        end
                    else
                        BossMon = "Yeti"
                        NameBoss = "Yeti"
                        NameQuestBoss = "SnowQuest"
                        QuestLvBoss = 3
                        RewardBoss = "Reward:\n$10,000\n180,000 Exp."
                        CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
                        CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, - 1488.0262451172)
                    end
                else
                    BossMon = "The Saw"
                    NameBoss = "The Saw"
                    CFrameBoss = CFrame.new(- 784.89715576172, 72.427383422852, 1603.5822753906)
                end
            else
                BossMon = "Bobby"
                NameBoss = "Bobby"
                NameQuestBoss = "BuggyQuest1"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$8,000\n35,000 Exp."
                CFrameQBoss = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
                CFrameBoss = CFrame.new(- 1087.3760986328, 46.949409484863, 4040.1462402344)
            end
        else
            BossMon = "The Gorilla King"
            NameBoss = "The Gorrila King"
            NameQuestBoss = "JungleQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$2,000\n7,000 Exp."
            CFrameQBoss = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameBoss = CFrame.new(- 1088.75977, 8.13463783, - 488.559906, - 0.707134247, 0, 0.707079291, 0, 1, 0, - 0.707079291, 0, - 0.707134247)
        end
    end
    if Sea2 then
        if SelectBoss ~= "Diamond" then
            if SelectBoss ~= "Jeremy" then
                if SelectBoss ~= "Fajita" then
                    if SelectBoss ~= "Don Swan" then
                        if SelectBoss ~= "Smoke Admiral" then
                            if SelectBoss ~= "Awakened Ice Admiral" then
                                if SelectBoss ~= "Tide Keeper" then
                                    if SelectBoss ~= "Darkbeard" then
                                        if SelectBoss ~= "Cursed Captain" then
                                            if SelectBoss == "Order" then
                                                BossMon = "Order"
                                                NameBoss = "Order"
                                                CFrameBoss = CFrame.new(- 6217.2021484375, 28.047645568848, - 5053.1357421875)
                                            end
                                        else
                                            BossMon = "Cursed Captain"
                                            NameBoss = "Cursed Captain"
                                            CFrameBoss = CFrame.new(916.928589, 181.092773, 33422)
                                        end
                                    else
                                        BossMon = "Darkbeard"
                                        NameBoss = "Darkbeard"
                                        CFrameMon = CFrame.new(3677.08203125, 62.751937866211, - 3144.8332519531)
                                    end
                                else
                                    BossMon = "Tide Keeper"
                                    NameBoss = "Tide Keeper"
                                    NameQuestBoss = "ForgottenQuest"
                                    QuestLvBoss = 3
                                    RewardBoss = "Reward:\n$12,500\n38,000,000 Exp."
                                    CFrameQBoss = CFrame.new(- 3053.9814453125, 237.18954467773, - 10145.0390625)
                                    CFrameBoss = CFrame.new(- 3795.6423339844, 105.88877105713, - 11421.307617188)
                                end
                            else
                                BossMon = "Awakened Ice Admiral"
                                NameBoss = "Awakened Ice Admiral"
                                NameQuestBoss = "FrostQuest"
                                QuestLvBoss = 3
                                RewardBoss = "Reward:\n$20,000\n36,000,000 Exp."
                                CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, - 6483.3520507813)
                                CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, - 6894.5595703125)
                            end
                        else
                            BossMon = "Smoke Admiral"
                            NameBoss = "Smoke Admiral"
                            NameQuestBoss = "IceSideQuest"
                            QuestLvBoss = 3
                            RewardBoss = "Reward:\n$20,000\n25,000,000 Exp."
                            CFrameQBoss = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
                            CFrameBoss = CFrame.new(- 5275.1987304688, 20.757257461548, - 5260.6669921875)
                        end
                    else
                        BossMon = "Don Swan"
                        NameBoss = "Don Swan"
                        CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
                    end
                else
                    BossMon = "Fajita"
                    NameBoss = "Fajita"
                    NameQuestBoss = "MarineQuest3"
                    QuestLvBoss = 3
                    RewardBoss = "Reward:\n$25,000\n15,000,000 Exp."
                    CFrameQBoss = CFrame.new(- 2441.986328125, 73.359344482422, - 3217.5324707031)
                    CFrameBoss = CFrame.new(- 2172.7399902344, 103.32216644287, - 4015.025390625)
                end
            else
                BossMon = "Jeremy"
                NameBoss = "Jeremy"
                NameQuestBoss = "Area2Quest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$25,000\n11,500,000 Exp."
                CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
                CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
            end
        else
            BossMon = "Diamond"
            NameBoss = "Diamond"
            NameQuestBoss = "Area1Quest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n9,000,000 Exp."
            CFrameQBoss = CFrame.new(- 427.5666809082, 73.313781738281, 1835.4208984375)
            CFrameBoss = CFrame.new(- 1576.7166748047, 198.59265136719, 13.724286079407)
        end
    end
    if Sea3 then
        if SelectBoss ~= "Stone" then
            if SelectBoss ~= "Hydra Leader" then
                if SelectBoss ~= "Kilo Admiral" then
                    if SelectBoss ~= "Captain Elephant" then
                        if SelectBoss ~= "Beautiful Pirate" then
                            if SelectBoss ~= "Cake Queen" then
                                if SelectBoss ~= "Longma" then
                                    if SelectBoss ~= "Soul Reaper" then
                                        if SelectBoss == "rip_indra True Form" then
                                            BossMon = "rip_indra True Form"
                                            NameBoss = "rip_indra True Form"
                                            CFrameBoss = CFrame.new(- 5415.3920898438, 505.74133300781, - 2814.0166015625)
                                        end
                                    else
                                        BossMon = "Soul Reaper"
                                        NameBoss = "Soul Reaper"
                                        CFrameBoss = CFrame.new(- 9524.7890625, 315.80429077148, 6655.7192382813)
                                    end
                                else
                                    BossMon = "Longma"
                                    NameBoss = "Longma"
                                    CFrameBoss = CFrame.new(- 10238.875976563, 389.7912902832, - 9549.7939453125)
                                end
                            else
                                BossMon = "Cake Queen"
                                NameBoss = "Cake Queen"
                                NameQuestBoss = "IceCreamIslandQuest"
                                QuestLvBoss = 3
                                RewardBoss = "Reward:\n$30,000\n112,500,000 Exp."
                                CFrameQBoss = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664)
                                CFrameBoss = CFrame.new(- 678.648804, 381.353943, - 11114.2012, - 0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, - 0.417492568, 0.0167988986, - 0.90852499)
                            end
                        else
                            BossMon = "Beautiful Pirate"
                            NameBoss = "Beautiful Pirate"
                            NameQuestBoss = "DeepForestIsland2"
                            QuestLvBoss = 3
                            RewardBoss = "Reward:\n$50,000\n70,000,000 Exp."
                            CFrameQBoss = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
                            CFrameBoss = CFrame.new(5283.609375, 22.56223487854, - 110.78285217285)
                        end
                    else
                        BossMon = "Captain Elephant"
                        NameBoss = "Captain Elephant"
                        NameQuestBoss = "DeepForestIsland"
                        QuestLvBoss = 3
                        RewardBoss = "Reward:\n$40,000\n67,000,000 Exp."
                        CFrameQBoss = CFrame.new(- 13232.682617188, 332.40396118164, - 7626.01171875)
                        CFrameBoss = CFrame.new(- 13376.7578125, 433.28689575195, - 8071.392578125)
                    end
                else
                    BossMon = "Kilo Admiral"
                    NameBoss = "Kilo Admiral"
                    NameQuestBoss = "MarineTreeIsland"
                    QuestLvBoss = 3
                    RewardBoss = "Reward:\n$35,000\n56,000,000 Exp."
                    CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, - 6739.9741210938)
                    CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, - 7144.4580078125)
                end
            else
                BossMon = "Hydra Leader"
                NameBoss = "Hydra Leader"
                NameQuestBoss = "VenomCrewQuest"
                QuestLvBoss = 3
                RewardBoss = "Reward:\n$30,000\n52,000,000 Exp."
                CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609)
                CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875)
            end
        else
            BossMon = "Stone"
            NameBoss = "Stone"
            NameQuestBoss = "PiratePortQuest"
            QuestLvBoss = 3
            RewardBoss = "Reward:\n$25,000\n40,000,000 Exp."
            CFrameQBoss = CFrame.new(- 289.76705932617, 43.819011688232, 5579.9384765625)
            CFrameBoss = CFrame.new(- 1027.6512451172, 92.404174804688, 6578.8530273438)
        end
    end
end
function MaterialMon()
    if SelectMaterial ~= "Radioactive Material" then
        if SelectMaterial ~= "Mystic Droplet" then
            if SelectMaterial ~= "Magma Ore" then
                if SelectMaterial ~= "Angel Wings" then
                    if SelectMaterial ~= "Leather" then
                        if SelectMaterial ~= "Scrap Metal" then
                            if SelectMaterial ~= "Fish Tail" then
                                if SelectMaterial ~= "Demonic Wisp" then
                                    if SelectMaterial ~= "Vampire Fang" then
                                        if SelectMaterial ~= "Conjured Cocoa" then
                                            if SelectMaterial ~= "Dragon Scale" then
                                                if SelectMaterial ~= "Gunpowder" then
                                                    if SelectMaterial ~= "Hydra Enforcer" then
                                                        if SelectMaterial ~= "Venomous Assailant" then
                                                            if SelectMaterial == "Mini Tusk" then
                                                                MMon = "Mythological Pirate"
                                                                MPos = CFrame.new()
                                                                SP = "Default"
                                                            end
                                                        else
                                                            MMon = "Venomous Assailant"
                                                            MPos = CFrame.new(4879.92041015625, 1089.46142578125, 1104.00830078125)
                                                            SP = "Default"
                                                        end
                                                    else
                                                        MMon = "Hydra Enforcer"
                                                        MPos = CFrame.new(4581.517578125, 1001.55908203125, 704.9378662109375)
                                                        SP = "Default"
                                                    end
                                                else
                                                    MMon = "Pistol Billionaire"
                                                    MPos = CFrame.new(- 469, 74, 5904)
                                                    SP = "Default"
                                                end
                                            else
                                                MMon = "Dragon Crew Archer"
                                                MPos = CFrame.new(6827.91455078125, 609.4127197265625, 252.3538055419922)
                                                SP = "Default"
                                            end
                                        else
                                            MMon = "Chocolate Bar Battler"
                                            MPos = CFrame.new(620.6344604492188, 78.93644714355469, - 12581.369140625)
                                            SP = "Default"
                                        end
                                    else
                                        MMon = "Vampire"
                                        MPos = CFrame.new(- 6033, 7, - 1317)
                                        SP = "Default"
                                    end
                                else
                                    MMon = "Demonic Soul"
                                    MPos = CFrame.new(- 9507, 172, 6158)
                                    SP = "Default"
                                end
                            elseif Sea3 then
                                MMon = "Fishman Raider"
                                MPos = CFrame.new(- 10993, 332, - 8940)
                                SP = "Default"
                            elseif Sea1 then
                                MMon = "Fishman Warrior"
                                MPos = CFrame.new(61123, 19, 1569)
                                SP = "Default"
                                if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875)).Magnitude >= 17000 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 5.342342376708984, 1819.7841796875))
                                end
                            end
                        elseif Sea1 then
                            MMon = "Brute"
                            MPos = CFrame.new(- 1145, 15, 4350)
                            SP = "Default"
                        elseif Sea2 then
                            MMon = "Swan Pirate"
                            MPos = CFrame.new(878, 122, 1235)
                            SP = "Default"
                        elseif Sea3 then
                            MMon = "Jungle Pirate"
                            MPos = CFrame.new(- 12107, 332, - 10549)
                            SP = "Default"
                        end
                    elseif Sea1 then
                        MMon = "Brute"
                        MPos = CFrame.new(- 1145, 15, 4350)
                        SP = "Default"
                    elseif Sea2 then
                        MMon = "Marine Captain"
                        MPos = CFrame.new(- 2010.5059814453125, 73.00115966796875, - 3326.620849609375)
                        SP = "Default"
                    elseif Sea3 then
                        MMon = "Jungle Pirate"
                        MPos = CFrame.new(- 11975.78515625, 331.7734069824219, - 10620.0302734375)
                        SP = "Default"
                    end
                else
                    MMon = "God\'s Guard"
                    MPos = CFrame.new(- 4698, 845, - 1912)
                    SP = "Default"
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 7859.09814, 5544.19043, - 381.476196)).Magnitude >= 5000 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7859.09814, 5544.19043, - 381.476196))
                    end
                end
            elseif Sea1 then
                MMon = "Military Spy"
                MPos = CFrame.new(- 5815, 84, 8820)
                SP = "Default"
            elseif Sea2 then
                MMon = "Magma Ninja"
                MPos = CFrame.new(- 5428, 78, - 5959)
                SP = "Default"
            end
        else
            MMon = "Water Fighter"
            MPos = CFrame.new(- 3385, 239, - 10542)
            SP = "Default"
        end
    else
        MMon = "Factory Staff"
        MPos = CFrame.new(295, 73, - 56)
        SP = "Default"
    end
end
function UpdateIslandESP()
    for v10, islandObj in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if IslandESP then
                if islandObj.Name ~= "Sea" then
                    if islandObj:FindFirstChild("NameEsp") then
                        islandObj.NameEsp.TextLabel.Text = islandObj.Name .. "   \n" .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - islandObj.Position).Magnitude / 3) .. " Distance"
                    else
                        local v12 = Instance.new("BillboardGui", islandObj)
                        v12.Name = "NameEsp"
                        v12.ExtentsOffset = Vector3.new(0, 1, 0)
                        v12.Size = UDim2.new(1, 200, 1, 30)
                        v12.Adornee = islandObj
                        v12.AlwaysOnTop = true
                        local v13 = Instance.new("TextLabel", v12)
                        v13.Font = "GothamBold"
                        v13.FontSize = "Size14"
                        v13.TextWrapped = true
                        v13.Size = UDim2.new(1, 0, 1, 0)
                        v13.TextYAlignment = "Top"
                        v13.BackgroundTransparency = 1
                        v13.TextStrokeTransparency = 0.5
                        v13.TextColor3 = Color3.fromRGB(8, 0, 0)
                    end
                end
            elseif islandObj:FindFirstChild("NameEsp") then
                islandObj:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function isnil(value)
    return value == nil
end
local function formatDistance(distance)
    return math.floor(tonumber(distance) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for v19, playerObj in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if not isnil(playerObj.Character) then
                if ESPPlayer then
                    if isnil(playerObj.Character.Head) or playerObj.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        playerObj.Character.Head["NameEsp" .. Number].TextLabel.Text = playerObj.Name .. " | " .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - playerObj.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. formatDistance(playerObj.Character.Humanoid.Health * 100 / playerObj.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v21 = Instance.new("BillboardGui", playerObj.Character.Head)
                        v21.Name = "NameEsp" .. Number
                        v21.ExtentsOffset = Vector3.new(0, 1, 0)
                        v21.Size = UDim2.new(1, 200, 1, 30)
                        v21.Adornee = playerObj.Character.Head
                        v21.AlwaysOnTop = true
                        local v22 = Instance.new("TextLabel", v21)
                        v22.Font = Enum.Font.GothamSemibold
                        v22.FontSize = "Size10"
                        v22.TextWrapped = true
                        v22.Text = playerObj.Name .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - playerObj.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v22.Size = UDim2.new(1, 0, 1, 0)
                        v22.TextYAlignment = "Top"
                        v22.BackgroundTransparency = 1
                        v22.TextStrokeTransparency = 0.5
                        if playerObj.Team ~= game.Players.LocalPlayer.Team then
                            v22.TextColor3 = Color3.new(255, 0, 0)
                        else
                            v22.TextColor3 = Color3.new(0, 0, 254)
                        end
                    end
                elseif playerObj.Character.Head:FindFirstChild("NameEsp" .. Number) then
                    playerObj.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateChestChams()
    for v25, chestObj in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(chestObj.Name, "Chest") then
                if ChestESP then
                    if string.find(chestObj.Name, "Chest") then
                        if chestObj:FindFirstChild("NameEsp" .. Number) then
                            chestObj["NameEsp" .. Number].TextLabel.Text = chestObj.Name .. "   \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj.Position).Magnitude / 3) .. " Distance"
                        else
                            local v27 = Instance.new("BillboardGui", chestObj)
                            v27.Name = "NameEsp" .. Number
                            v27.ExtentsOffset = Vector3.new(0, 1, 0)
                            v27.Size = UDim2.new(1, 200, 1, 30)
                            v27.Adornee = chestObj
                            v27.AlwaysOnTop = true
                            local v28 = Instance.new("TextLabel", v27)
                            v28.Font = Enum.Font.GothamSemibold
                            v28.FontSize = "Size14"
                            v28.TextWrapped = true
                            v28.Size = UDim2.new(1, 0, 1, 0)
                            v28.TextYAlignment = "Top"
                            v28.BackgroundTransparency = 1
                            v28.TextStrokeTransparency = 0.5
                            if chestObj.Name == "Chest1" then
                                v28.TextColor3 = Color3.fromRGB(109, 109, 109)
                                v28.Text = "Chest 1" .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj.Position).Magnitude / 3) .. " Distance"
                            end
                            if chestObj.Name == "Chest2" then
                                v28.TextColor3 = Color3.fromRGB(173, 158, 21)
                                v28.Text = "Chest 2" .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj.Position).Magnitude / 3) .. " Distance"
                            end
                            if chestObj.Name == "Chest3" then
                                v28.TextColor3 = Color3.fromRGB(85, 255, 255)
                                v28.Text = "Chest 3" .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj.Position).Magnitude / 3) .. " Distance"
                            end
                        end
                    end
                elseif chestObj:FindFirstChild("NameEsp" .. Number) then
                    chestObj:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateDevilChams()
    for v31, fruitObj in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(fruitObj.Name, "Fruit") then
                    if fruitObj.Handle:FindFirstChild("NameEsp" .. Number) then
                        fruitObj.Handle["NameEsp" .. Number].TextLabel.Text = fruitObj.Name .. "   \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - fruitObj.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v33 = Instance.new("BillboardGui", fruitObj.Handle)
                        v33.Name = "NameEsp" .. Number
                        v33.ExtentsOffset = Vector3.new(0, 1, 0)
                        v33.Size = UDim2.new(1, 200, 1, 30)
                        v33.Adornee = fruitObj.Handle
                        v33.AlwaysOnTop = true
                        local v34 = Instance.new("TextLabel", v33)
                        v34.Font = Enum.Font.GothamSemibold
                        v34.FontSize = "Size14"
                        v34.TextWrapped = true
                        v34.Size = UDim2.new(1, 0, 1, 0)
                        v34.TextYAlignment = "Top"
                        v34.BackgroundTransparency = 1
                        v34.TextStrokeTransparency = 0.5
                        v34.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v34.Text = fruitObj.Name .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - fruitObj.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            elseif fruitObj.Handle:FindFirstChild("NameEsp" .. Number) then
                fruitObj.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end)
    end
end
function UpdateFlowerChams()
    for v37, flowerObj in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if flowerObj.Name == "Flower2" or flowerObj.Name == "Flower1" then
                if FlowerESP then
                    if flowerObj:FindFirstChild("NameEsp" .. Number) then
                        flowerObj["NameEsp" .. Number].TextLabel.Text = flowerObj.Name .. "   \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - flowerObj.Position).Magnitude / 3) .. " Distance"
                    else
                        local v39 = Instance.new("BillboardGui", flowerObj)
                        v39.Name = "NameEsp" .. Number
                        v39.ExtentsOffset = Vector3.new(0, 1, 0)
                        v39.Size = UDim2.new(1, 200, 1, 30)
                        v39.Adornee = flowerObj
                        v39.AlwaysOnTop = true
                        local v40 = Instance.new("TextLabel", v39)
                        v40.Font = Enum.Font.GothamSemibold
                        v40.FontSize = "Size14"
                        v40.TextWrapped = true
                        v40.Size = UDim2.new(1, 0, 1, 0)
                        v40.TextYAlignment = "Top"
                        v40.BackgroundTransparency = 1
                        v40.TextStrokeTransparency = 0.5
                        v40.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if flowerObj.Name == "Flower1" then
                            v40.Text = "Blue Flower" .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - flowerObj.Position).Magnitude / 3) .. " Distance"
                            v40.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if flowerObj.Name == "Flower2" then
                            v40.Text = "Red Flower" .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - flowerObj.Position).Magnitude / 3) .. " Distance"
                            v40.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                elseif flowerObj:FindFirstChild("NameEsp" .. Number) then
                    flowerObj:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateRealFruitChams()
    for v43, v44 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v44:IsA("Tool") then
            if RealFruitESP then
                if v44.Handle:FindFirstChild("NameEsp" .. Number) then
                    v44.Handle["NameEsp" .. Number].TextLabel.Text = v44.Name .. " " .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - v44.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v45 = Instance.new("BillboardGui", v44.Handle)
                    v45.Name = "NameEsp" .. Number
                    v45.ExtentsOffset = Vector3.new(0, 1, 0)
                    v45.Size = UDim2.new(1, 200, 1, 30)
                    v45.Adornee = v44.Handle
                    v45.AlwaysOnTop = true
                    local v46 = Instance.new("TextLabel", v45)
                    v46.Font = Enum.Font.GothamSemibold
                    v46.FontSize = "Size14"
                    v46.TextWrapped = true
                    v46.Size = UDim2.new(1, 0, 1, 0)
                    v46.TextYAlignment = "Top"
                    v46.BackgroundTransparency = 1
                    v46.TextStrokeTransparency = 0.5
                    v46.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v46.Text = v44.Name .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - v44.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v44.Handle:FindFirstChild("NameEsp" .. Number) then
                v44.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for v49, v50 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v50:IsA("Tool") then
            if RealFruitESP then
                if v50.Handle:FindFirstChild("NameEsp" .. Number) then
                    v50.Handle["NameEsp" .. Number].TextLabel.Text = v50.Name .. " " .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v51 = Instance.new("BillboardGui", v50.Handle)
                    v51.Name = "NameEsp" .. Number
                    v51.ExtentsOffset = Vector3.new(0, 1, 0)
                    v51.Size = UDim2.new(1, 200, 1, 30)
                    v51.Adornee = v50.Handle
                    v51.AlwaysOnTop = true
                    local v52 = Instance.new("TextLabel", v51)
                    v52.Font = Enum.Font.GothamSemibold
                    v52.FontSize = "Size14"
                    v52.TextWrapped = true
                    v52.Size = UDim2.new(1, 0, 1, 0)
                    v52.TextYAlignment = "Top"
                    v52.BackgroundTransparency = 1
                    v52.TextStrokeTransparency = 0.5
                    v52.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v52.Text = v50.Name .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - v50.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v50.Handle:FindFirstChild("NameEsp" .. Number) then
                v50.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for v55, v56 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v56:IsA("Tool") then
            if RealFruitESP then
                if v56.Handle:FindFirstChild("NameEsp" .. Number) then
                    v56.Handle["NameEsp" .. Number].TextLabel.Text = v56.Name .. " " .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - v56.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v57 = Instance.new("BillboardGui", v56.Handle)
                    v57.Name = "NameEsp" .. Number
                    v57.ExtentsOffset = Vector3.new(0, 1, 0)
                    v57.Size = UDim2.new(1, 200, 1, 30)
                    v57.Adornee = v56.Handle
                    v57.AlwaysOnTop = true
                    local v58 = Instance.new("TextLabel", v57)
                    v58.Font = Enum.Font.GothamSemibold
                    v58.FontSize = "Size14"
                    v58.TextWrapped = true
                    v58.Size = UDim2.new(1, 0, 1, 0)
                    v58.TextYAlignment = "Top"
                    v58.BackgroundTransparency = 1
                    v58.TextStrokeTransparency = 0.5
                    v58.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v58.Text = v56.Name .. " \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - v56.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v56.Handle:FindFirstChild("NameEsp" .. Number) then
                v56.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
function UpdateIslandESP()
    for v61, locationObj in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if IslandESP then
                if locationObj.Name ~= "Sea" then
                    if locationObj:FindFirstChild("NameEsp") then
                        locationObj.NameEsp.TextLabel.Text = locationObj.Name .. "   \n" .. formatDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - locationObj.Position).Magnitude / 3) .. " Distance"
                    else
                        local v63 = Instance.new("BillboardGui", locationObj)
                        v63.Name = "NameEsp"
                        v63.ExtentsOffset = Vector3.new(0, 1, 0)
                        v63.Size = UDim2.new(1, 200, 1, 30)
                        v63.Adornee = locationObj
                        v63.AlwaysOnTop = true
                        local v64 = Instance.new("TextLabel", v63)
                        v64.Font = "GothamBold"
                        v64.FontSize = "Size14"
                        v64.TextWrapped = true
                        v64.Size = UDim2.new(1, 0, 1, 0)
                        v64.TextYAlignment = "Top"
                        v64.BackgroundTransparency = 1
                        v64.TextStrokeTransparency = 0.5
                        v64.TextColor3 = Color3.fromRGB(7, 236, 240)
                    end
                end
            elseif locationObj:FindFirstChild("NameEsp") then
                locationObj:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function isnil(value)
    return value == nil
end
local function formatDistance2(distance)
    return math.floor(tonumber(distance) + 0.5)
end
Number = math.random(1, 1000000)
function UpdatePlayerChams()
    for v70, playerObj2 in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if not isnil(playerObj2.Character) then
                if ESPPlayer then
                    if isnil(playerObj2.Character.Head) or playerObj2.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        playerObj2.Character.Head["NameEsp" .. Number].TextLabel.Text = playerObj2.Name .. " | " .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - playerObj2.Character.Head.Position).Magnitude / 3) .. " Distance\nHealth : " .. formatDistance2(playerObj2.Character.Humanoid.Health * 100 / playerObj2.Character.Humanoid.MaxHealth) .. "%"
                    else
                        local v72 = Instance.new("BillboardGui", playerObj2.Character.Head)
                        v72.Name = "NameEsp" .. Number
                        v72.ExtentsOffset = Vector3.new(0, 1, 0)
                        v72.Size = UDim2.new(1, 200, 1, 30)
                        v72.Adornee = playerObj2.Character.Head
                        v72.AlwaysOnTop = true
                        local v73 = Instance.new("TextLabel", v72)
                        v73.Font = Enum.Font.GothamSemibold
                        v73.FontSize = "Size14"
                        v73.TextWrapped = true
                        v73.Text = playerObj2.Name .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - playerObj2.Character.Head.Position).Magnitude / 3) .. " Distance"
                        v73.Size = UDim2.new(1, 0, 1, 0)
                        v73.TextYAlignment = "Top"
                        v73.BackgroundTransparency = 1
                        v73.TextStrokeTransparency = 0.5
                        if playerObj2.Team ~= game.Players.LocalPlayer.Team then
                            v73.TextColor3 = Color3.new(255, 0, 0)
                        else
                            v73.TextColor3 = Color3.new(0, 255, 0)
                        end
                    end
                elseif playerObj2.Character.Head:FindFirstChild("NameEsp" .. Number) then
                    playerObj2.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateChestChams()
    for v76, chestObj2 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(chestObj2.Name, "Chest") then
                if ChestESP then
                    if string.find(chestObj2.Name, "Chest") then
                        if chestObj2:FindFirstChild("NameEsp" .. Number) then
                            chestObj2["NameEsp" .. Number].TextLabel.Text = chestObj2.Name .. "   \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj2.Position).Magnitude / 3) .. " Distance"
                        else
                            local v78 = Instance.new("BillboardGui", chestObj2)
                            v78.Name = "NameEsp" .. Number
                            v78.ExtentsOffset = Vector3.new(0, 1, 0)
                            v78.Size = UDim2.new(1, 200, 1, 30)
                            v78.Adornee = chestObj2
                            v78.AlwaysOnTop = true
                            local v79 = Instance.new("TextLabel", v78)
                            v79.Font = Enum.Font.GothamSemibold
                            v79.FontSize = "Size14"
                            v79.TextWrapped = true
                            v79.Size = UDim2.new(1, 0, 1, 0)
                            v79.TextYAlignment = "Top"
                            v79.BackgroundTransparency = 1
                            v79.TextStrokeTransparency = 0.5
                            if chestObj2.Name == "Chest1" then
                                v79.TextColor3 = Color3.fromRGB(109, 109, 109)
                                v79.Text = "Chest 1" .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj2.Position).Magnitude / 3) .. " Distance"
                            end
                            if chestObj2.Name == "Chest2" then
                                v79.TextColor3 = Color3.fromRGB(173, 158, 21)
                                v79.Text = "Chest 2" .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj2.Position).Magnitude / 3) .. " Distance"
                            end
                            if chestObj2.Name == "Chest3" then
                                v79.TextColor3 = Color3.fromRGB(85, 255, 255)
                                v79.Text = "Chest 3" .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - chestObj2.Position).Magnitude / 3) .. " Distance"
                            end
                        end
                    end
                elseif chestObj2:FindFirstChild("NameEsp" .. Number) then
                    chestObj2:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateDevilChams()
    for v82, fruitObj2 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(fruitObj2.Name, "Fruit") then
                    if fruitObj2.Handle:FindFirstChild("NameEsp" .. Number) then
                        fruitObj2.Handle["NameEsp" .. Number].TextLabel.Text = fruitObj2.Name .. "   \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - fruitObj2.Handle.Position).Magnitude / 3) .. " Distance"
                    else
                        local v84 = Instance.new("BillboardGui", fruitObj2.Handle)
                        v84.Name = "NameEsp" .. Number
                        v84.ExtentsOffset = Vector3.new(0, 1, 0)
                        v84.Size = UDim2.new(1, 200, 1, 30)
                        v84.Adornee = fruitObj2.Handle
                        v84.AlwaysOnTop = true
                        local v85 = Instance.new("TextLabel", v84)
                        v85.Font = Enum.Font.GothamSemibold
                        v85.FontSize = "Size14"
                        v85.TextWrapped = true
                        v85.Size = UDim2.new(1, 0, 1, 0)
                        v85.TextYAlignment = "Top"
                        v85.BackgroundTransparency = 1
                        v85.TextStrokeTransparency = 0.5
                        v85.TextColor3 = Color3.fromRGB(255, 255, 255)
                        v85.Text = fruitObj2.Name .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - fruitObj2.Handle.Position).Magnitude / 3) .. " Distance"
                    end
                end
            elseif fruitObj2.Handle:FindFirstChild("NameEsp" .. Number) then
                fruitObj2.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end)
    end
end
function UpdateFlowerChams()
    for v88, flowerObj2 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if flowerObj2.Name == "Flower2" or flowerObj2.Name == "Flower1" then
                if FlowerESP then
                    if flowerObj2:FindFirstChild("NameEsp" .. Number) then
                        flowerObj2["NameEsp" .. Number].TextLabel.Text = flowerObj2.Name .. "   \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - flowerObj2.Position).Magnitude / 3) .. " Distance"
                    else
                        local v90 = Instance.new("BillboardGui", flowerObj2)
                        v90.Name = "NameEsp" .. Number
                        v90.ExtentsOffset = Vector3.new(0, 1, 0)
                        v90.Size = UDim2.new(1, 200, 1, 30)
                        v90.Adornee = flowerObj2
                        v90.AlwaysOnTop = true
                        local v91 = Instance.new("TextLabel", v90)
                        v91.Font = Enum.Font.GothamSemibold
                        v91.FontSize = "Size14"
                        v91.TextWrapped = true
                        v91.Size = UDim2.new(1, 0, 1, 0)
                        v91.TextYAlignment = "Top"
                        v91.BackgroundTransparency = 1
                        v91.TextStrokeTransparency = 0.5
                        v91.TextColor3 = Color3.fromRGB(255, 0, 0)
                        if flowerObj2.Name == "Flower1" then
                            v91.Text = "Blue Flower" .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - flowerObj2.Position).Magnitude / 3) .. " Distance"
                            v91.TextColor3 = Color3.fromRGB(0, 0, 255)
                        end
                        if flowerObj2.Name == "Flower2" then
                            v91.Text = "Red Flower" .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - flowerObj2.Position).Magnitude / 3) .. " Distance"
                            v91.TextColor3 = Color3.fromRGB(255, 0, 0)
                        end
                    end
                elseif flowerObj2:FindFirstChild("NameEsp" .. Number) then
                    flowerObj2:FindFirstChild("NameEsp" .. Number):Destroy()
                end
            end
        end)
    end
end
function UpdateRealFruitChams()
    for v94, v95 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v95:IsA("Tool") then
            if RealFruitESP then
                if v95.Handle:FindFirstChild("NameEsp" .. Number) then
                    v95.Handle["NameEsp" .. Number].TextLabel.Text = v95.Name .. " " .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - v95.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v96 = Instance.new("BillboardGui", v95.Handle)
                    v96.Name = "NameEsp" .. Number
                    v96.ExtentsOffset = Vector3.new(0, 1, 0)
                    v96.Size = UDim2.new(1, 200, 1, 30)
                    v96.Adornee = v95.Handle
                    v96.AlwaysOnTop = true
                    local v97 = Instance.new("TextLabel", v96)
                    v97.Font = Enum.Font.GothamSemibold
                    v97.FontSize = "Size14"
                    v97.TextWrapped = true
                    v97.Size = UDim2.new(1, 0, 1, 0)
                    v97.TextYAlignment = "Top"
                    v97.BackgroundTransparency = 1
                    v97.TextStrokeTransparency = 0.5
                    v97.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v97.Text = v95.Name .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - v95.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v95.Handle:FindFirstChild("NameEsp" .. Number) then
                v95.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for v100, v101 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v101:IsA("Tool") then
            if RealFruitESP then
                if v101.Handle:FindFirstChild("NameEsp" .. Number) then
                    v101.Handle["NameEsp" .. Number].TextLabel.Text = v101.Name .. " " .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - v101.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v102 = Instance.new("BillboardGui", v101.Handle)
                    v102.Name = "NameEsp" .. Number
                    v102.ExtentsOffset = Vector3.new(0, 1, 0)
                    v102.Size = UDim2.new(1, 200, 1, 30)
                    v102.Adornee = v101.Handle
                    v102.AlwaysOnTop = true
                    local v103 = Instance.new("TextLabel", v102)
                    v103.Font = Enum.Font.GothamSemibold
                    v103.FontSize = "Size14"
                    v103.TextWrapped = true
                    v103.Size = UDim2.new(1, 0, 1, 0)
                    v103.TextYAlignment = "Top"
                    v103.BackgroundTransparency = 1
                    v103.TextStrokeTransparency = 0.5
                    v103.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v103.Text = v101.Name .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - v101.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v101.Handle:FindFirstChild("NameEsp" .. Number) then
                v101.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for v106, v107 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v107:IsA("Tool") then
            if RealFruitESP then
                if v107.Handle:FindFirstChild("NameEsp" .. Number) then
                    v107.Handle["NameEsp" .. Number].TextLabel.Text = v107.Name .. " " .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - v107.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v108 = Instance.new("BillboardGui", v107.Handle)
                    v108.Name = "NameEsp" .. Number
                    v108.ExtentsOffset = Vector3.new(0, 1, 0)
                    v108.Size = UDim2.new(1, 200, 1, 30)
                    v108.Adornee = v107.Handle
                    v108.AlwaysOnTop = true
                    local v109 = Instance.new("TextLabel", v108)
                    v109.Font = Enum.Font.GothamSemibold
                    v109.FontSize = "Size14"
                    v109.TextWrapped = true
                    v109.Size = UDim2.new(1, 0, 1, 0)
                    v109.TextYAlignment = "Top"
                    v109.BackgroundTransparency = 1
                    v109.TextStrokeTransparency = 0.5
                    v109.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v109.Text = v107.Name .. " \n" .. formatDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - v107.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v107.Handle:FindFirstChild("NameEsp" .. Number) then
                v107.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
spawn(function()
    while wait() do
        pcall(function()
            if MobESP then
                for v112, v113 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v113:FindFirstChild("HumanoidRootPart") then
                        if not v113:FindFirstChild("MobEap") then
                            local v114 = Instance.new("BillboardGui")
                            local v115 = Instance.new("TextLabel")
                            v114.Parent = v113
                            v114.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            v114.Active = true
                            v114.Name = "MobEap"
                            v114.AlwaysOnTop = true
                            v114.LightInfluence = 1
                            v114.Size = UDim2.new(0, 200, 0, 50)
                            v114.StudsOffset = Vector3.new(0, 2.5, 0)
                            v115.Parent = v114
                            v115.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v115.BackgroundTransparency = 1
                            v115.Size = UDim2.new(0, 200, 0, 50)
                            v115.Font = Enum.Font.GothamBold
                            v115.TextColor3 = Color3.fromRGB(7, 236, 240)
                            v115.Text.Size = 35
                        end
                        local v116 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v113.HumanoidRootPart.Position).Magnitude)
                        v113.MobEap.TextLabel.Text = v113.Name .. "-" .. v116 .. " Distance"
                    end
                end
            else
                for v119, v120 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v120:FindFirstChild("MobEap") then
                        v120.MobEap:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if SeaESP then
                for v123, v124 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v124:FindFirstChild("HumanoidRootPart") then
                        if not v124:FindFirstChild("Seaesps") then
                            local v125 = Instance.new("BillboardGui")
                            local v126 = Instance.new("TextLabel")
                            v125.Parent = v124
                            v125.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            v125.Active = true
                            v125.Name = "Seaesps"
                            v125.AlwaysOnTop = true
                            v125.LightInfluence = 1
                            v125.Size = UDim2.new(0, 200, 0, 50)
                            v125.StudsOffset = Vector3.new(0, 2.5, 0)
                            v126.Parent = v125
                            v126.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v126.BackgroundTransparency = 1
                            v126.Size = UDim2.new(0, 200, 0, 50)
                            v126.Font = Enum.Font.GothamBold
                            v126.TextColor3 = Color3.fromRGB(7, 236, 240)
                            v126.Text.Size = 35
                        end
                        local v127 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v124.HumanoidRootPart.Position).Magnitude)
                        v124.Seaesps.TextLabel.Text = v124.Name .. "-" .. v127 .. " Distance"
                    end
                end
            else
                for v130, v131 in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
                    if v131:FindFirstChild("Seaesps") then
                        v131.Seaesps:Destroy()
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if NpcESP then
                for v134, v135 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v135:FindFirstChild("HumanoidRootPart") then
                        if not v135:FindFirstChild("NpcEspes") then
                            local v136 = Instance.new("BillboardGui")
                            local v137 = Instance.new("TextLabel")
                            v136.Parent = v135
                            v136.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                            v136.Active = true
                            v136.Name = "NpcEspes"
                            v136.AlwaysOnTop = true
                            v136.LightInfluence = 1
                            v136.Size = UDim2.new(0, 200, 0, 50)
                            v136.StudsOffset = Vector3.new(0, 2.5, 0)
                            v137.Parent = v136
                            v137.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            v137.BackgroundTransparency = 1
                            v137.Size = UDim2.new(0, 200, 0, 50)
                            v137.Font = Enum.Font.GothamBold
                            v137.TextColor3 = Color3.fromRGB(7, 236, 240)
                            v137.Text.Size = 35
                        end
                        local v138 = math.floor((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v135.HumanoidRootPart.Position).Magnitude)
                        v135.NpcEspes.TextLabel.Text = v135.Name .. "-" .. v138 .. " Distance"
                    end
                end
            else
                for v141, v142 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
                    if v142:FindFirstChild("NpcEspes") then
                        v142.NpcEspes:Destroy()
                    end
                end
            end
        end)
    end
end)
function isnil(value)
    return value == nil
end
local function formatMeterDistance(distance)
    return math.floor(tonumber(distance) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateIslandMirageESP()
    for v148, mirageIslandLocation in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP then
                if mirageIslandLocation.Name == "Mirage Island" then
                    if mirageIslandLocation:FindFirstChild("NameEsp") then
                        mirageIslandLocation.NameEsp.TextLabel.Text = mirageIslandLocation.Name .. "   \n" .. formatMeterDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - mirageIslandLocation.Position).Magnitude / 3) .. " M"
                    else
                        local v150 = Instance.new("BillboardGui", mirageIslandLocation)
                        v150.Name = "NameEsp"
                        v150.ExtentsOffset = Vector3.new(0, 1, 0)
                        v150.Size = UDim2.new(1, 200, 1, 30)
                        v150.Adornee = mirageIslandLocation
                        v150.AlwaysOnTop = true
                        local v151 = Instance.new("TextLabel", v150)
                        v151.Font = "Code"
                        v151.FontSize = "Size14"
                        v151.TextWrapped = true
                        v151.Size = UDim2.new(1, 0, 1, 0)
                        v151.TextYAlignment = "Top"
                        v151.BackgroundTransparency = 1
                        v151.TextStrokeTransparency = 0.5
                        v151.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif mirageIslandLocation:FindFirstChild("NameEsp") then
                mirageIslandLocation:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function UpdateAuraESP()
    for v154, enhancementLocation in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        pcall(function()
            if AuraESP then
                if enhancementLocation.Name == "Master of Enhancement" then
                    if enhancementLocation:FindFirstChild("NameEsp") then
                        enhancementLocation.NameEsp.TextLabel.Text = enhancementLocation.Name .. "   \n" .. formatMeterDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - enhancementLocation.Position).Magnitude / 3) .. " M"
                    else
                        local v156 = Instance.new("BillboardGui", enhancementLocation)
                        v156.Name = "NameEsp"
                        v156.ExtentsOffset = Vector3.new(0, 1, 0)
                        v156.Size = UDim2.new(1, 200, 1, 30)
                        v156.Adornee = enhancementLocation
                        v156.AlwaysOnTop = true
                        local v157 = Instance.new("TextLabel", v156)
                        v157.Font = "Code"
                        v157.FontSize = "Size14"
                        v157.TextWrapped = true
                        v157.Size = UDim2.new(1, 0, 1, 0)
                        v157.TextYAlignment = "Top"
                        v157.BackgroundTransparency = 1
                        v157.TextStrokeTransparency = 0.5
                        v157.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif enhancementLocation:FindFirstChild("NameEsp") then
                enhancementLocation:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function UpdateLSDESP()
    for v160, swordDealerLocation in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        pcall(function()
            if LADESP then
                if swordDealerLocation.Name == "Legendary Sword Dealer" then
                    if swordDealerLocation:FindFirstChild("NameEsp") then
                        swordDealerLocation.NameEsp.TextLabel.Text = swordDealerLocation.Name .. "   \n" .. formatMeterDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - swordDealerLocation.Position).Magnitude / 3) .. " M"
                    else
                        local v162 = Instance.new("BillboardGui", swordDealerLocation)
                        v162.Name = "NameEsp"
                        v162.ExtentsOffset = Vector3.new(0, 1, 0)
                        v162.Size = UDim2.new(1, 200, 1, 30)
                        v162.Adornee = swordDealerLocation
                        v162.AlwaysOnTop = true
                        local v163 = Instance.new("TextLabel", v162)
                        v163.Font = "Code"
                        v163.FontSize = "Size14"
                        v163.TextWrapped = true
                        v163.Size = UDim2.new(1, 0, 1, 0)
                        v163.TextYAlignment = "Top"
                        v163.BackgroundTransparency = 1
                        v163.TextStrokeTransparency = 0.5
                        v163.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif swordDealerLocation:FindFirstChild("NameEsp") then
                swordDealerLocation:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function UpdateGeaESP()
    for v166, gearLocation in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
        pcall(function()
            if GearESP then
                if gearLocation.Name == "MeshPart" then
                    if gearLocation:FindFirstChild("NameEsp") then
                        gearLocation.NameEsp.TextLabel.Text = gearLocation.Name .. "   \n" .. formatMeterDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - gearLocation.Position).Magnitude / 3) .. " M"
                    else
                        local v168 = Instance.new("BillboardGui", gearLocation)
                        v168.Name = "NameEsp"
                        v168.ExtentsOffset = Vector3.new(0, 1, 0)
                        v168.Size = UDim2.new(1, 200, 1, 30)
                        v168.Adornee = gearLocation
                        v168.AlwaysOnTop = true
                        local v169 = Instance.new("TextLabel", v168)
                        v169.Font = "Code"
                        v169.FontSize = "Size14"
                        v169.TextWrapped = true
                        v169.Size = UDim2.new(1, 0, 1, 0)
                        v169.TextYAlignment = "Top"
                        v169.BackgroundTransparency = 1
                        v169.TextStrokeTransparency = 0.5
                        v169.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif gearLocation:FindFirstChild("NameEsp") then
                gearLocation:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
function Tween2(targetCFrame)
    local v171 = (targetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local _ = 350 <= v171
    local v172 = 350
    local v173 = TweenInfo.new(v171 / v172, Enum.EasingStyle.Linear)
    local v174 = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, v173, {
        ["CFrame"] = targetCFrame
    })
    v174:Play()
    if _G.CancelTween2 then
        v174:Cancel()
    end
    _G.Clip2 = true
    wait(v171 / v172)
    _G.Clip2 = false
end
function BTPZ(targetCFrame)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
    task.wait()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
end
TweenSpeed = 350
function Tween(targetCFrame)
    local v177 = (targetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local v178 = TweenSpeed
    if v177 >= 350 then
        v178 = TweenSpeed
    end
    local v179 = TweenInfo.new(v177 / v178, Enum.EasingStyle.Linear)
    local v180 = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, v179, {
        ["CFrame"] = targetCFrame
    })
    v180:Play()
    if _G.StopTween then
        v180:Cancel()
    end
end
function CancelTween(shouldStop)
    if not shouldStop then
        _G.StopTween = true
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        _G.StopTween = false
    end
end
function EquipTool(toolName)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(toolName) then
        local v183 = game.Players.LocalPlayer.Backpack:FindFirstChild(toolName)
        wait()
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v183)
    end
end
spawn(function()
    local v184 = getrawmetatable(game)
    local originalNamecallHook = v184.__namecall
    setreadonly(v184, false)
    v184.__namecall = newcclosure(function(...)
        local v186 = getnamecallmethod()
        local v187 = {
            ...
        }
        if tostring(v186) ~= "FireServer" or (tostring(v187[1]) ~= "RemoteEvent" or (tostring(v187[2]) == "true" or (tostring(v187[2]) == "false" or not _G.UseSkill))) then
            return originalNamecallHook(...)
        end
        if type(v187[2]) ~= "vector" then
            v187[2] = CFrame.new(PositionSkillMasteryDevilFruit)
        else
            v187[2] = PositionSkillMasteryDevilFruit
        end
        return originalNamecallHook(unpack(v187))
    end)
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.AutoEvoRace or (_G.CastleRaid or (_G.CollectAzure or (_G.TweenToKitsune or (_G.GhostShip or (_G.Ship or (_G.Auto_Holy_Torch or (_G.TeleportPly or (_G.Auto_Sea3 or (_G.Auto_Sea2 or (_G.Tweenfruit or (_G.AutoFishCrew or (_G.Auto_Saber or (_G.AutoShark or (_G.Auto_Warden or (_G.Auto_RainbowHaki or (AutoFarmRace or (_G.AutoQuestRace or (Auto_Law or (AutoTushita or (_G.AutoHolyTorch or (_G.AutoTerrorshark or (_G.farmpiranya or (_G.Auto_MusketeerHat or (_G.Auto_ObservationV2 or (_G.AutoNear or (_G.Auto_PoleV1 or (_G.Auto_Buddy or (_G.Ectoplasm or (AutoEvoRace or (AutoBartilo or (_G.Auto_Canvander or (_G.AutoLevel or (_G.Auto_DualKatana or (Auto_Quest_Yama_3 or (Auto_Quest_Yama_2 or (Auto_Quest_Yama_1 or (Auto_Quest_Tushita_1 or (Auto_Quest_Tushita_2 or (Auto_Quest_Tushita_3 or (_G.Clip2 or (_G.Auto_Regoku or (_G.AutoBone or (_G.AutoBoneNoQuest or (_G.AutoBoss or (AutoFarmMasDevilFruit or (AutoHallowSycthe or (AutoTushita or (_G.CakePrince or (_G.Auto_SkullGuitar or (_G.AutoFarmSwan or (_G.DoughKing or (_G.AutoEliteor or (AutoNextIsland or (Musketeer or (_G.AutoMaterial or (AutoFarmRaceQuest or (_G.Factory or (_G.Auto_Saw or (_G.AutoFrozenDimension or (_G.AutoKillTrial or (_G.AutoUpgrade or _G.TweenToFrozenDimension))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) then
                if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local v188 = Instance.new("BodyVelocity")
                    v188.Name = "BodyClip"
                    v188.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                    v188.MaxForce = Vector3.new(100000, 100000, 100000)
                    v188.Velocity = Vector3.new(0, 0, 0)
                end
            else
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
            end
        end)
    end
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.AutoEvoRace or (_G.Auto_RainbowHaki or (_G.Auto_SkullGuitar or (_G.CastleRaid or (_G.CollectAzure or (_G.TweenToKitsune or (_G.Auto_Sea3 or (_G.Auto_Sea2 or (_G.GhostShip or (_G.Ship or (_G.Auto_Holy_Torch or (_G.TeleportPly or (_G.Tweenfruit or (_G.Auto_Saber or (_G.Auto_PoleV1 or (_G.Auto_MusketeerHat or (_G.AutoFishCrew or (_G.AutoShark or (AutoFarmRace or (_G.AutoQuestRace or (_G.Auto_Warden or (Auto_Law or (_G.Auto_DualKatana or (Auto_Quest_Tushita_1 or (Auto_Quest_Tushita_2 or (Auto_Quest_Tushita_3 or (AutoTushita or (_G.AutoHolyTorch or (_G.Auto_Buddy or (_G.AutoTerrorshark or (_G.farmpiranya or (Auto_Quest_Yama_3 or (_G.Auto_ObservationV2 or (Auto_Quest_Yama_2 or (Auto_Quest_Yama_1 or (_G.AutoNear or (_G.Ectoplasm or (AutoEvoRace or (_G.AutoKillTrial or (AutoBartilo or (_G.Auto_Regoku or (_G.AutoLevel or (_G.Clip2 or (_G.AutoBone or (_G.Auto_Canvander or (_G.AutoBoneNoQuest or (_G.AutoBoss or (_G.Auto_Saw or (AutoFarmMasDevilFruit or (AutoHallowSycthe or (AutoTushita or (_G.CakePrince or (_G.DoughKing or (_G.AutoFarmSwan or (_G.AutoEliteor or (AutoNextIsland or (Musketeer or (_G.AutoMaterial or (_G.Factory or (_G.AutoFrozenDimension or (AutoFarmRaceQuest or (_G.AutoUpgrade or _G.TweenToFrozenDimension))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))) then
                for v191, v192 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v192:IsA("BasePart") then
                        v192.CanCollide = false
                    end
                end
            end
        end)
    end)
end)
task.spawn(function()
    if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
        game.Players.LocalPlayer.Character.Stun.Changed:connect(function()
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
                    game.Players.LocalPlayer.Character.Stun.Value = 0
                end
            end)
        end)
    end
end)
function CheckMaterial(materialName)
    for v196, v197 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v197) == "table" and (v197.Type == "Material" and v197.Name == materialName) then
            return v197.Count
        end
    end
    return 0
end
function GetWeaponInventory(weaponName)
    for v201, v202 in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(v202) == "table" and (v202.Type == "Sword" and v202.Name == weaponName) then
            return true
        end
    end
    return false
end
local localPlayerInstance = game.Players.LocalPlayer
function FindEnemiesInRange(enemyList, characterList)
    local v206 = (localPlayerInstance.Character or localPlayerInstance.CharacterAdded:Wait()):GetPivot().Position
    local v207, v208, v209 = ipairs(characterList)
    local v210 = nil
    while true do
        local v211
        v209, v211 = v207(v208, v209)
        if v209 == nil then
            break
        end
        if not v211:GetAttribute("IsBoat") and (v211:FindFirstChildOfClass("Humanoid") and v211.Humanoid.Health > 0) then
            local v212 = v211:FindFirstChild("Head")
            if v212 and ((v206 - v212.Position).Magnitude <= 60 and v211 ~= localPlayerInstance.Character) then
                table.insert(enemyList, {
                    v211,
                    v212
                })
                v210 = v212
            end
        end
    end
    for v215, v216 in ipairs(game.Players:GetPlayers()) do
        if v216.Character and v216 ~= localPlayerInstance then
            local v217 = v216.Character:FindFirstChild("Head")
            if v217 and (v206 - v217.Position).Magnitude <= 60 then
                table.insert(enemyList, {
                    v216.Character,
                    v217
                })
                v210 = v217
            end
        end
    end
    return v210
end
function GetEquippedTool()
    local v218 = localPlayerInstance.Character
    if not v218 then
        return nil
    end
    for v221, v222 in ipairs(v218:GetChildren()) do
        if v222:IsA("Tool") then
            return v222
        end
    end
    return nil
end
function AttackNoCoolDown()
    local enemyTargetList = {}
    local v224 = game:GetService("Workspace").Enemies:GetChildren()
    local primaryTargetHead = FindEnemiesInRange(enemyTargetList, v224)
    if primaryTargetHead then
        if GetEquippedTool() then
            pcall(function()
                local v226 = game:GetService("ReplicatedStorage")
                local v227 = v226:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
                local v228 = v226:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")
                if # enemyTargetList <= 0 then
                    task.wait(1e-9)
                else
                    v227:FireServer(1e-9)
                    v228:FireServer(primaryTargetHead, enemyTargetList)
                end
            end)
        end
    else
        return
    end
end
Type = 1
spawn(function()
    while wait() do
        if Type ~= 1 then
            if Type ~= 2 then
                if Type ~= 3 then
                    if Type ~= 4 then
                        if Type == 5 then
                            Pos = CFrame.new(0, 40, - 40)
                        end
                    else
                        Pos = CFrame.new(0, 40, 40)
                    end
                else
                    Pos = CFrame.new(40, 40, 0)
                end
            else
                Pos = CFrame.new(- 40, 40, 0)
            end
        else
            Pos = CFrame.new(0, 40, 0)
        end
    end
end)
spawn(function()
    while wait() do
        Type = 1
        wait(0.2)
        Type = 2
        wait(0.2)
        Type = 3
        wait(0.2)
        Type = 4
        wait(0.2)
        Type = 5
        wait(0.2)
    end
end)
function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end
function to(targetCFrame)
    repeat
        wait(_G.Fast_Delay)
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(15)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
        task.wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
    until (targetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000
end
function to(targetCFrame)
    pcall(function()
        if (targetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 and (not Auto_Raid and game.Players.LocalPlayer.Character.Humanoid.Health > 0) then
            if NameMon ~= "FishmanQuest" then
                if Mon ~= "God\'s Guard" then
                    if NameMon ~= "SkyExp1Quest" then
                        if NameMon ~= "ShipQuest1" then
                            if NameMon ~= "ShipQuest2" then
                                if NameMon ~= "FrostQuest" then
                                    repeat
                                        wait(_G.Fast_Delay)
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
                                        wait(0.05)
                                        game.Players.LocalPlayer.Character.Head:Destroy()
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
                                    until (targetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2500 and game.Players.LocalPlayer.Character.Humanoid.Health > 0
                                    wait()
                                else
                                    Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                    wait()
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422))
                                end
                            else
                                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                                wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                            end
                        else
                            Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                            wait()
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                        end
                    else
                        Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                        wait()
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
                    end
                else
                    Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                    wait()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688))
                end
            else
                Tween(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
                wait()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        end
    end)
end
local v239 = Tabs.Main:AddDropdown("DropdownSelectWeapon", {
    ["Title"] = "Select Weapon",
    ["Description"] = "",
    ["Values"] = {
        "Melee",
        "Sword",
        "Blox Fruits"
    },
    ["Multi"] = false,
    ["Default"] = 1
})
v239:SetValue("Melee")
v239:OnChanged(function(state)
    ChooseWeapon = state
end)
task.spawn(function()
    while wait() do
        pcall(function()
            if ChooseWeapon ~= "Melee" then
                if ChooseWeapon ~= "Sword" then
                    if ChooseWeapon == "Blox Fruit" then
                        for v243, v244 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v244.ToolTip == "Blox Fruit" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v244.Name)) then
                                SelectWeapon = v244.Name
                            end
                        end
                    end
                else
                    for v247, v248 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        if v248.ToolTip == "Sword" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v248.Name)) then
                            SelectWeapon = v248.Name
                        end
                    end
                end
            else
                for v251, v252 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v252.ToolTip == "Melee" and game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v252.Name)) then
                        SelectWeapon = v252.Name
                    end
                end
            end
        end)
    end
end)
Tabs.Main:AddToggle("ToggleLevel", {
    ["Title"] = "Auto Farm Level",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoLevel = state
    if state == false then
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
    end
end)
UIOptions.ToggleLevel:SetValue(false)
spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                CheckLevel()
                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                        for v256, v257 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v257:FindFirstChild("Humanoid") and (v257:FindFirstChild("HumanoidRootPart") and (v257.Humanoid.Health > 0 and v257.Name == Ms)) then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    bringmob = true
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    Tween(v257.HumanoidRootPart.CFrame * Pos)
                                    v257.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v257.HumanoidRootPart.Transparency = 1
                                    v257.Humanoid.JumpPower = 0
                                    v257.Humanoid.WalkSpeed = 0
                                    v257.HumanoidRootPart.CanCollide = false
                                    FarmPos = v257.HumanoidRootPart.CFrame
                                    MonFarm = v257.Name
                                until not _G.AutoLevel or (not v257.Parent or v257.Humanoid.Health <= 0) or (not game:GetService("Workspace").Enemies:FindFirstChild(v257.Name) or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false)
                                bringmob = false
                            end
                        end
                        for v260, v261 in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
                            if string.find(v261.Name, NameMon) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v261.Position).Magnitude >= 10 then
                                Tween(v261.HumanoidRootPart.CFrame * Pos)
                            end
                        end
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    Tween(CFrameQ)
                    if (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                    end
                end
            end)
        end
    end
end)
Tabs.Main:AddToggle("ToggleMobAura", {
    ["Title"] = "Mob Aura",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoNear = state
    if state == false then
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
    end
end)
UIOptions.ToggleMobAura:SetValue(false)
spawn(function()
    while wait() do
        if _G.AutoNear then
            pcall(function()
                for v265, v266 in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v266:FindFirstChild("Humanoid") and (v266:FindFirstChild("HumanoidRootPart") and (v266.Humanoid.Health > 0 and (v266.Name and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v266:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 5000))) then
                        repeat
                            wait(_G.Fast_Delay)
                            AttackNoCoolDown()
                            bringmob = true
                            AutoHaki()
                            EquipTool(SelectWeapon)
                            Tween(v266.HumanoidRootPart.CFrame * Pos)
                            v266.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v266.HumanoidRootPart.Transparency = 1
                            v266.Humanoid.JumpPower = 0
                            v266.Humanoid.WalkSpeed = 0
                            v266.HumanoidRootPart.CanCollide = false
                            FarmPos = v266.HumanoidRootPart.CFrame
                            MonFarm = v266.Name
                        until not _G.AutoNear or (not v266.Parent or v266.Humanoid.Health <= 0) or not game.Workspace.Enemies:FindFirstChild(v266.Name)
                        bringmob = false
                    end
                end
            end)
        end
    end
end)
Tabs.Main:AddToggle("ToggleCastleRaid", {
    ["Title"] = "Auto Pirate Raid",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.CastleRaid = state
end)
UIOptions.ToggleCastleRaid:SetValue(false)
spawn(function()
    while wait() do
        if _G.CastleRaid then
            pcall(function()
                local v268 = CFrame.new(- 5496.17432, 313.768921, - 2841.53027, 0.924894512, 7.37058e-9, 0.380223751, 3.588102e-8, 1, - 1.06665446e-7, - 0.380223751, 1.1229711e-7, 0.924894512)
                if (CFrame.new(- 5539.3115234375, 313.800537109375, - 2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                    Tween(v268)
                else
                    for v271, v272 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if _G.CastleRaid and (v272:FindFirstChild("HumanoidRootPart") and (v272:FindFirstChild("Humanoid") and (v272.Humanoid.Health > 0 and (v272.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000))) then
                            repeat
                                wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v272.HumanoidRootPart.CanCollide = false
                                v272.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                Tween(v272.HumanoidRootPart.CFrame * Pos)
                            until v272.Humanoid.Health <= 0 or not (v272.Parent and _G.CastleRaid)
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.Main:AddToggle("ToggleHakiFortress", {
    ["Title"] = "Activate Color Haki (Fortress)",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.EnableHakiFortress = state
end)
UIOptions.ToggleHakiFortress:SetValue(false)
local function EquipHakiAndTween(colorName, targetPosition)
    local v276 = {
        {
            ["StorageName"] = colorName,
            ["Type"] = "AuraSkin",
            ["Context"] = "Equip"
        }
    }
    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/FruitCustomizerRF"):InvokeServer(unpack(v276))
    Tween2(targetPosition)
end
local function IsPlayerNear(targetPosition, maxDistance)
    local v280 = game.Players.LocalPlayer.Character
    if v280 and v280:FindFirstChild("HumanoidRootPart") then
        return (v280.HumanoidRootPart.Position - targetPosition).Magnitude < maxDistance
    else
        return false
    end
end
spawn(function()
    while true do
        if _G.EnableHakiFortress then
            EquipHakiAndTween("Snow White", Vector3.new(- 4971.71826171875, 335.9582214355469, - 3720.0595703125))
            while not IsPlayerNear(Vector3.new(- 4971.71826171875, 335.9582214355469, - 3720.0595703125), 1) do
                wait(0.1)
            end
            wait(0.5)
            EquipHakiAndTween("Pure Red", Vector3.new(- 5414.92041015625, 314.2582092285156, - 2212.20166015625))
            while not IsPlayerNear(Vector3.new(- 5414.92041015625, 314.2582092285156, - 2212.20166015625), 1) do
                wait(0.1)
            end
            wait(0.5)
            EquipHakiAndTween("Winter Sky", Vector3.new(- 5420.26318359375, 1089.3582763671875, - 2666.8193359375))
            while not IsPlayerNear(Vector3.new(- 5420.26318359375, 1089.3582763671875, - 2666.8193359375), 1) do
                wait(0.1)
            end
            wait(0.5)
            _G.EnableHakiFortress = false
        end
        wait(0.5)
    end
end)
Tabs.Main:AddToggle("ToggleCollectChest", {
    ["Title"] = "Auto Collect Chests",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoCollectChest = state
end)
spawn(function()
    while wait() do
        if _G.AutoCollectChest then
            local v283 = game:GetService("Players").LocalPlayer
            local v284 = (v283.Character or v283.CharacterAdded:Wait()):GetPivot().Position
            local v285 = game:GetService("CollectionService"):GetTagged("_ChestTagged")
            local v286 = math.huge
            local v287 = nil
            for v288 = 1, # v285 do
                local v289 = v285[v288]
                local v290 = (v289:GetPivot().Position - v284).Magnitude
                if not v289:GetAttribute("IsDisabled") then
                    if v290 < v286 then
                        v287 = v289
                        v286 = v290
                    end
                end
            end
            if v287 then
                local v291 = v287:GetPivot().Position
                local v292 = CFrame.new(v291)
                Tween2(v292)
            end
        end
    end
end)
Tabs.Main:AddSection("Mastery")
local v293 = Tabs.Main:AddDropdown("DropdownMastery", {
    ["Title"] = "Auto Farm Mastery",
    ["Description"] = "",
    ["Values"] = {
        "Near Mobs"
    },
    ["Multi"] = false,
    ["Default"] = 1
})
v293:SetValue(TypeMastery)
v293:OnChanged(function(state)
    TypeMastery = state
end)
Tabs.Main:AddToggle("ToggleMasteryFruit", {
    ["Title"] = "Auto Farm Fruit Mastery",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    AutoFarmMasDevilFruit = state
end)
UIOptions.ToggleMasteryFruit:SetValue(false)
local v297 = Tabs.Main:AddSlider("SliderHealt", {
    ["Title"] = "Mob Health",
    ["Description"] = "",
    ["Default"] = 20,
    ["Min"] = 0,
    ["Max"] = 100,
    ["Rounding"] = 1,
    ["Callback"] = function(value)
        KillPercent = value
    end
})
v297:OnChanged(function(value)
    KillPercent = value
end)
v297:SetValue(20)
spawn(function()
    while task.wait() do
        if _G.UseSkill then
            pcall(function()
				
                if not _G.UseSkill then
					
                    return
                end
                local v299, v300, v301 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				
                local v302
                v301, v302 = v299(v300, v301)
                if v301 == nil then
					
                end
                if v302.Name ~= MonFarm or (not v302:FindFirstChild("Humanoid") or (not v302:FindFirstChild("HumanoidRootPart") or v302.Humanoid.Health > v302.Humanoid.MaxHealth * KillPercent / 100)) then
					
                end
				
                game:GetService("RunService").Heartbeat:wait()
                EquipTool(game.Players.LocalPlayer.Data.DevilFruit.Value)
                Tween(v302.HumanoidRootPart.CFrame * Pos)
                PositionSkillMasteryDevilFruit = v302.HumanoidRootPart.Position
                if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value) then
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).MousePos.Value = PositionSkillMasteryDevilFruit
                    local v303 = game:GetService("Players").LocalPlayer.Character:FindFirstChild(game.Players.LocalPlayer.Data.DevilFruit.Value).Level.Value
                    if SkillZ and 1 <= v303 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "Z", false, game)
                    end
                    if SkillX and 2 <= v303 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "X", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "X", false, game)
                    end
                    if SkillC and 3 <= v303 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "C", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "C", false, game)
                    end
                    if SkillV and 4 <= v303 then
                        game:service("VirtualInputManager"):SendKeyEvent(true, "V", false, game)
                        wait()
                        game:service("VirtualInputManager"):SendKeyEvent(false, "V", false, game)
                    end
                    if SkillF and 5 <= v303 then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                        wait()
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                    end
                end
                if AutoFarmMasDevilFruit and (_G.UseSkill and v302.Humanoid.Health ~= 0) then
					
                else
					
                end
				
				
				
            end)
        end
    end
end)
spawn(function()
    while task.wait(0.1) do
        if AutoFarmMasDevilFruit and TypeMastery == "Near Mobs" then
            pcall(function()
                local v304, v305, v306 = pairs(game.Workspace.Enemies:GetChildren())
                while true do
                    local v307
                    v306, v307 = v304(v305, v306)
                    if v306 == nil then
                        return
                    end
                    if v307.Name and (v307:FindFirstChild("Humanoid") and (v307:FindFirstChild("HumanoidRootPart") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v307:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 5000)) then
                        repeat
                            if true then
                                wait(_G.Fast_Delay)
                                if v307.Humanoid.Health > v307.Humanoid.MaxHealth * KillPercent / 100 then
                                    _G.UseSkill = false
                                    AutoHaki()
                                    bringmob = true
                                    EquipTool(SelectWeapon)
                                    Tween(v307.HumanoidRootPart.CFrame * Pos)
                                    v307.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v307.HumanoidRootPart.Transparency = 1
                                    v307.Humanoid.JumpPower = 0
                                    v307.Humanoid.WalkSpeed = 0
                                    v307.HumanoidRootPart.CanCollide = false
                                    FarmPos = v307.HumanoidRootPart.CFrame
                                    MonFarm = v307.Name
                                    AttackNoCoolDown()
                                else
                                    _G.UseSkill = true
                                end
                            end
                        until not AutoFarmMasDevilFruit or (not MasteryType == "Near Mobs" or (not v307.Parent or v307.Humanoid.Health == 0))
                        bringmob = false
                        _G.UseSkill = false
                    end
                end
            end)
        end
    end
end)
if Sea3 then
    Tabs.Main:AddSection("Bones")
    local bonesStatusLabel = Tabs.Main:AddParagraph({
        ["Title"] = "Bone Status",
        ["Content"] = ""
    })
    spawn(function()
        pcall(function()
            while wait() do
                local v309 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check")
                bonesStatusLabel:SetDesc("You have: " .. tostring(v309) .. " Bones")
            end
        end)
    end)
    Tabs.Main:AddToggle("ToggleBone", {
        ["Title"] = "Auto Farm Bones",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoBone = state
        if state == false then
            wait()
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            wait()
        end
    end)
    UIOptions.ToggleBone:SetValue(false)
    local bonesPosTarget1 = CFrame.new(- 9515.75, 174.8521728515625, 6079.40625)
    spawn(function()
        while wait() do
            if _G.AutoBone then
                pcall(function()
                    local v312 = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    if not string.find(v312, "Demonic Soul") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= false then
                        if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true and (game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy")))) then
                            for v315, v316 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v316:FindFirstChild("HumanoidRootPart") and (v316:FindFirstChild("Humanoid") and (v316.Humanoid.Health > 0 and (v316.Name == "Reborn Skeleton" or (v316.Name == "Living Zombie" or (v316.Name == "Demonic Soul" or v316.Name == "Posessed Mummy"))))) then
                                    if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Demonic Soul") then
                                        repeat
                                            wait(_G.Fast_Delay)
                                            AttackNoCoolDown()
                                            AutoHaki()
                                            bringmob = true
                                            EquipTool(SelectWeapon)
                                            Tween(v316.HumanoidRootPart.CFrame * Pos)
                                            v316.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                            v316.HumanoidRootPart.Transparency = 1
                                            v316.Humanoid.JumpPower = 0
                                            v316.Humanoid.WalkSpeed = 0
                                            v316.HumanoidRootPart.CanCollide = false
                                            FarmPos = v316.HumanoidRootPart.CFrame
                                            MonFarm = v316.Name
                                        until not _G.AutoBone or (v316.Humanoid.Health <= 0 or not v316.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                    else
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        bringmob = false
                                    end
                                end
                            end
                        end
                    else
                        Tween(bonesPosTarget1)
                        if (bonesPosTarget1.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "HauntedQuest2", 1)
                        end
                    end
                end)
            end
        end
    end)
    local bonesPosTarget2 = CFrame.new(- 9515.75, 174.8521728515625, 6079.40625)
    spawn(function()
        while wait() do
            if _G.AutoBoneNoQuest then
                pcall(function()
                    Tween(bonesPosTarget2)
                    local _ = (bonesPosTarget2.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3
                    if game:GetService("Workspace").Enemies:FindFirstChild("Reborn Skeleton") or (game:GetService("Workspace").Enemies:FindFirstChild("Living Zombie") or (game:GetService("Workspace").Enemies:FindFirstChild("Demonic Soul") or game:GetService("Workspace").Enemies:FindFirstChild("Posessed Mummy"))) then
                        for v320, v321 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v321:FindFirstChild("HumanoidRootPart") and (v321:FindFirstChild("Humanoid") and (v321.Humanoid.Health > 0 and (v321.Name == "Reborn Skeleton" or (v321.Name == "Living Zombie" or (v321.Name == "Demonic Soul" or v321.Name == "Posessed Mummy"))))) then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    bringmob = true
                                    EquipTool(SelectWeapon)
                                    Tween(v321.HumanoidRootPart.CFrame * Pos)
                                    v321.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v321.HumanoidRootPart.Transparency = 1
                                    v321.Humanoid.JumpPower = 0
                                    v321.Humanoid.WalkSpeed = 0
                                    v321.HumanoidRootPart.CanCollide = false
                                    FarmPos = v321.HumanoidRootPart.CFrame
                                    MonFarm = v321.Name
                                until not _G.AutoBoneNoQuest or (v321.Humanoid.Health <= 0 or not v321.Parent)
                            end
                        end
                    end
                end)
            end
        end
    end)
    Tabs.Main:AddToggle("ToggleRandomBone", {
        ["Title"] = "Random Surprise (Bones)",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoRandomBone = state
    end)
    UIOptions.ToggleRandomBone:SetValue(false)
    spawn(function()
        while wait() do
            if _G.AutoRandomBone then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "Bones",
                    "Buy",
                    1,
                    1
                }))
            end
        end
    end)
end
if Sea3 then
    Tabs.Main:AddSection("Cake Prince")
    local cakePrinceStatusLabel = Tabs.Main:AddParagraph({
        ["Title"] = "Status",
        ["Content"] = ""
    })
    spawn(function()
        while wait() do
            pcall(function()
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) ~= 88 then
                    if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) ~= 87 then
                        if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) ~= 86 then
                            cakePrinceStatusLabel:SetDesc("Cake Prince : ✅️")
                        else
                            cakePrinceStatusLabel:SetDesc("Remaining: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 39) .. " ")
                        end
                    else
                        cakePrinceStatusLabel:SetDesc("Remaining: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 40) .. "")
                    end
                else
                    cakePrinceStatusLabel:SetDesc("Left: " .. string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"), 39, 41) .. "")
                end
            end)
        end
    end)
    local v324 = Tabs.Main:AddToggle("ToggleCake", {
        ["Title"] = "Auto Cake Prince",
        ["Description"] = "",
        ["Default"] = false
    })
    local cakePrinceCheckFlag = true
    v324:OnChanged(function(state)
        _G.CakePrince = state
        if state then
            if cakePrinceCheckFlag then
                cakePrinceCheckFlag = false
                local v327 = CFrame.new(- 2003.932861328125, 380.4824523925781, - 12561.0185546875)
                Tween(v327)
            end
        else
            cakePrinceCheckFlag = true
            wait()
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            wait()
        end
    end)
    UIOptions.ToggleCake:SetValue(false)
    spawn(function()
        while wait() do
            if _G.CakePrince then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince") then
                        for v330, v331 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v331.Name == "Cake Prince" and (v331:FindFirstChild("Humanoid") and (v331:FindFirstChild("HumanoidRootPart") and v331.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v331.HumanoidRootPart.CanCollide = false
                                    v331.Humanoid.WalkSpeed = 0
                                    v331.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v331.HumanoidRootPart.CFrame * Pos)
                                    AttackNoCoolDown()
                                until not _G.CakePrince or (not v331.Parent or v331.Humanoid.Health <= 0)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    elseif game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 1 and (game:GetService("Workspace").Enemies:FindFirstChild("Cookie Crafter") or (game:GetService("Workspace").Enemies:FindFirstChild("Cake Guard") or (game:GetService("Workspace").Enemies:FindFirstChild("Baking Staff") or game:GetService("Workspace").Enemies:FindFirstChild("Head Baker")))) then
                        for v334, v335 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v335.Name == "Cookie Crafter" or (v335.Name == "Cake Guard" or (v335.Name == "Baking Staff" or v335.Name == "Head Baker"))) and (v335:FindFirstChild("Humanoid") and (v335:FindFirstChild("HumanoidRootPart") and v335.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    AutoHaki()
                                    bringmob = true
                                    EquipTool(SelectWeapon)
                                    v335.HumanoidRootPart.CanCollide = false
                                    v335.Humanoid.WalkSpeed = 0
                                    v335.Head.CanCollide = false
                                    v335.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    FarmPos = v335.HumanoidRootPart.CFrame
                                    MonFarm = v335.Name
                                    Tween(v335.HumanoidRootPart.CFrame * Pos)
                                    AttackNoCoolDown()
                                until not _G.CakePrince or (not v335.Parent or v335.Humanoid.Health <= 0) or (game:GetService("Workspace").Map.CakeLoaf.BigMirror.Other.Transparency == 0 or (game:GetService("ReplicatedStorage"):FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]")))
                                bringmob = false
                            end
                        end
                    end
                end)
            end
        end
    end)
    Tabs.Main:AddToggle("ToggleDoughKing", {
        ["Title"] = "Auto Dough King",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.DoughKing = state
        if state == false then
            wait()
            Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            wait()
        end
    end)
    UIOptions.ToggleDoughKing:SetValue(false)
    spawn(function()
        while wait() do
            if _G.DoughKing then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                        for v339, v340 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v340.Name == "Dough King" and (v340:FindFirstChild("Humanoid") and (v340:FindFirstChild("HumanoidRootPart") and v340.Humanoid.Health > 0)) then
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v340.HumanoidRootPart.CanCollide = false
                                    v340.Humanoid.WalkSpeed = 0
                                    v340.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v340.HumanoidRootPart.CFrame * Pos)
                                    AttackNoCoolDown()
                                until not _G.DoughKing or (not v340.Parent or v340.Humanoid.Health <= 0)
                            end
                        end
                    end
                end)
            end
        end
    end)
    Tabs.Main:AddToggle("ToggleSpawnCake", {
        ["Title"] = "Auto Spawn Cake Prince",
        ["Description"] = "",
        ["Default"] = true
    }):OnChanged(function(state)
        _G.SpawnCakePrince = state
    end)
    UIOptions.ToggleSpawnCake:SetValue(true)
end
spawn(function()
    while wait() do
        if _G.SpawnCakePrince then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "CakePrinceSpawner",
                true
            }))
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "CakePrinceSpawner"
            }))
        end
    end
end)
if Sea2 then
    Tabs.Main:AddSection("Ectoplasm Farm")
    Tabs.Main:AddToggle("ToggleVatChatKiDi", {
        ["Title"] = "Auto Farm Ectoplasm",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.Ectoplasm = state
    end)
    UIOptions.ToggleVatChatKiDi:SetValue(false)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.Ectoplasm then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Ship Deckhand") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Engineer") or (game:GetService("Workspace").Enemies:FindFirstChild("Ship Steward") or game:GetService("Workspace").Enemies:FindFirstChild("Ship Officer"))) then
                        for v345, v346 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if (v346.Name == "Ship Steward" or (v346.Name == "Ship Engineer" or (v346.Name == "Ship Deckhand" or v346.Name == "Ship Officer" and v346:FindFirstChild("Humanoid")))) and v346.Humanoid.Health > 0 then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    bringmob = true
                                    EquipTool(SelectWeapon)
                                    Tween(v346.HumanoidRootPart.CFrame * Pos)
                                    v346.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v346.HumanoidRootPart.Transparency = 1
                                    v346.Humanoid.JumpPower = 0
                                    v346.Humanoid.WalkSpeed = 0
                                    v346.HumanoidRootPart.CanCollide = false
                                    FarmPos = v346.HumanoidRootPart.CFrame
                                    MonFarm = v346.Name
                                until _G.Ectoplasm == false or (not v346.Parent or v346.Humanoid.Health == 0) or not game:GetService("Workspace").Enemies:FindFirstChild(v346.Name)
                                bringmob = false
                            end
                        end
                    else
                        if (Vector3.new(904.4072265625, 181.05767822266, 33341.38671875) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                        end
                        Tween(CFrame.new(904.4072265625, 181.05767822266, 33341.38671875))
                    end
                end
            end)
        end
    end)
end
Tabs.Main:AddSection("Boss")
if Sea1 then
    tableBoss = {
        "The Gorilla King",
        "Bobby",
        "Yeti",
        "Mob Leader",
        "Vice Admiral",
        "Warden",
        "Chief Warden",
        "Swan",
        "Magma Admiral",
        "Fishman Lord",
        "Wysper",
        "Thunder God",
        "Cyborg",
        "Saber Expert"
    }
elseif Sea2 then
    tableBoss = {
        "Diamond",
        "Jeremy",
        "Fajita",
        "Don Swan",
        "Smoke Admiral",
        "Cursed Captain",
        "Darkbeard",
        "Order",
        "Awakened Ice Admiral",
        "Tide Keeper"
    }
elseif Sea3 then
    tableBoss = {
        "Stone",
        "Hydra Leader",
        "Kilo Admiral",
        "Captain Elephant",
        "Beautiful Pirate",
        "rip_indra True Form",
        "Longma",
        "Soul Reaper",
        "Cake Queen"
    }
end
local v347 = Tabs.Main:AddDropdown("DropdownBoss", {
    ["Title"] = "Select Boss",
    ["Description"] = "",
    ["Values"] = tableBoss,
    ["Multi"] = false,
    ["Default"] = 1
})
v347:SetValue(_G.SelectBoss)
v347:OnChanged(function(state)
    _G.SelectBoss = state
end)
Tabs.Main:AddToggle("ToggleAutoFarmBoss", {
    ["Title"] = "Auto Farm Boss",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoBoss = state
end)
UIOptions.ToggleAutoFarmBoss:SetValue(false)
spawn(function()
    while wait() do
        if _G.AutoBoss then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    for v352, v353 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v353.Name == _G.SelectBoss and (v353:FindFirstChild("Humanoid") and (v353:FindFirstChild("HumanoidRootPart") and v353.Humanoid.Health > 0)) then
                            repeat
                                wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v353.HumanoidRootPart.CanCollide = false
                                v353.Humanoid.WalkSpeed = 0
                                v353.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                Tween(v353.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                            until not _G.AutoBoss or (not v353.Parent or v353.Humanoid.Health <= 0)
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
                end
            end)
        end
    end
end)
Tabs.Main:AddSection("Material")
if Sea1 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Angel Wings",
        "Magma Ore",
        "Fish Tail"
    }
elseif Sea2 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Radioactive Material",
        "Mystic Droplet",
        "Magma Ore",
        "Vampire Fang"
    }
elseif Sea3 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Demonic Wisp",
        "Conjured Cocoa",
        "Dragon Scale",
        "Gunpowder",
        "Fish Tail",
        "Mini Tusk",
        "Hydra Enforcer",
        "Venomous Assailant"
    }
end
local v354 = Tabs.Main:AddDropdown("DropdownMaterial", {
    ["Title"] = "Select Material",
    ["Description"] = "",
    ["Values"] = MaterialList,
    ["Multi"] = false,
    ["Default"] = 1
})
v354:SetValue(SelectMaterial)
v354:OnChanged(function(state)
    SelectMaterial = state
end)
Tabs.Main:AddToggle("ToggleMaterial", {
    ["Title"] = "Auto Farm Material",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoMaterial = state
    if state == false then
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
    end
end)
UIOptions.ToggleMaterial:SetValue(false)
spawn(function()
    while task.wait() do
        if _G.AutoMaterial then
            pcall(function()
                MaterialMon(SelectMaterial)
                Tween(MPos)
                if game:GetService("Workspace").Enemies:FindFirstChild(MMon) then
                    for v359, v360 in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v360:FindFirstChild("Humanoid") and (v360:FindFirstChild("HumanoidRootPart") and (v360.Humanoid.Health > 0 and v360.Name == MMon)) then
                            repeat
                                wait(_G.Fast_Delay)
                                AttackNoCoolDown()
                                AutoHaki()
                                bringmob = true
                                EquipTool(SelectWeapon)
                                Tween(v360.HumanoidRootPart.CFrame * Pos)
                                v360.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                v360.HumanoidRootPart.Transparency = 1
                                v360.Humanoid.JumpPower = 0
                                v360.Humanoid.WalkSpeed = 0
                                v360.HumanoidRootPart.CanCollide = false
                                FarmPos = v360.HumanoidRootPart.CFrame
                                MonFarm = v360.Name
                            until not _G.AutoMaterial or (not v360.Parent or v360.Humanoid.Health <= 0)
                            bringmob = false
                        end
                    end
                else
                    for v363, v364 in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
                        if string.find(v364.Name, Mon) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v364.Position).Magnitude >= 10 then
                            Tween(v364.HumanoidRootPart.CFrame * Pos)
                        end
                    end
                end
            end)
        end
    end
end)
if Sea3 then
    Tabs.Sea:AddSection("Kitsune Island Status")
    local kitsuneStatusLabel = Tabs.Sea:AddParagraph({
        ["Title"] = "",
        ["Content"] = ""
    })
    function UpdateKitsune()
        if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
            kitsuneStatusLabel:SetDesc("Kitsune Island : ✅️")
        else
            kitsuneStatusLabel:SetDesc("Kitsune Island : ❌️")
        end
    end
    spawn(function()
        pcall(function()
            while wait() do
                UpdateKitsune()
            end
        end)
    end)
    Tabs.Sea:AddToggle("ToggleEspKitsune", {
        ["Title"] = "Mark Kitsune Island",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        KitsuneIslandEsp = state
        while KitsuneIslandEsp do
            wait()
            UpdateIslandKisuneESP()
        end
    end)
    UIOptions.ToggleEspKitsune:SetValue(false)
    function UpdateIslandKisuneESP()
        for v369, kitsuneIslandLocation in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
            pcall(function()
                if KitsuneIslandEsp then
                    if kitsuneIslandLocation.Name == "Kitsune Island" then
                        if kitsuneIslandLocation:FindFirstChild("NameEsp") then
                            kitsuneIslandLocation.NameEsp.TextLabel.Text = kitsuneIslandLocation.Name .. "   \n" .. formatMeterDistance((game:GetService("Players").LocalPlayer.Character.Head.Position - kitsuneIslandLocation.Position).Magnitude / 3) .. " M"
                        else
                            local v371 = Instance.new("BillboardGui", kitsuneIslandLocation)
                            v371.Name = "NameEsp"
                            v371.ExtentsOffset = Vector3.new(0, 1, 0)
                            v371.Size = UDim2.new(1, 200, 1, 30)
                            v371.Adornee = kitsuneIslandLocation
                            v371.AlwaysOnTop = true
                            local v372 = Instance.new("TextLabel", v371)
                            v372.Font = "Code"
                            v372.FontSize = "Size14"
                            v372.TextWrapped = true
                            v372.Size = UDim2.new(1, 0, 1, 0)
                            v372.TextYAlignment = "Top"
                            v372.BackgroundTransparency = 1
                            v372.TextStrokeTransparency = 0.5
                            v372.TextColor3 = Color3.fromRGB(80, 245, 245)
                        end
                    end
                elseif kitsuneIslandLocation:FindFirstChild("NameEsp") then
                    kitsuneIslandLocation:FindFirstChild("NameEsp"):Destroy()
                end
            end)
        end
    end
    Tabs.Sea:AddToggle("ToggleTPKitsune", {
        ["Title"] = "Fly to Kitsune Island",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.TweenToKitsune = state
    end)
    UIOptions.ToggleTPKitsune:SetValue(false)
    spawn(function()
        local v374 = nil
        while not v374 do
            v374 = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland")
            wait()
        end
        while wait() do
            if _G.TweenToKitsune then
                local v375 = v374:FindFirstChild("ShrineActive")
                if v375 then
                    for v378, v379 in pairs(v375:GetDescendants()) do
                        if v379:IsA("BasePart") and v379.Name:find("NeonShrinePart") then
                            Tween(v379.CFrame)
                        end
                    end
                end
            end
        end
    end)
    Tabs.Sea:AddToggle("ToggleCollectAzure", {
        ["Title"] = "Auto Collect Azure Ember",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.CollectAzure = state
    end)
    UIOptions.ToggleCollectAzure:SetValue(false)
    spawn(function()
        while wait() do
            if _G.CollectAzure then
                pcall(function()
                    if game:GetService("Workspace"):FindFirstChild("AttachedAzureEmber") then
                        Tween(game:GetService("Workspace"):WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
                    end
                end)
            end
        end
    end)
end
Tabs.Sea:AddButton({
    ["Title"] = "Auto Trade Azure Ember",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/KitsuneStatuePray"):InvokeServer()
    end
})
if Sea3 then
    Tabs.Sea:AddSection("Sea")
    local PlayersService = game:GetService("Players")
    local RunServiceModule = game:GetService("RunService")
    local VirtualInputModule = game:GetService("VirtualInputManager")
    local WorkspaceModule = game:GetService("Workspace")
    local configuredBoatSpeed = 350
    Tabs.Sea:AddSlider("SliderSpeedBoat", {
        ["Title"] = "Boat Speed",
        ["Description"] = "",
        ["Default"] = configuredBoatSpeed,
        ["Min"] = 0,
        ["Max"] = 350,
        ["Rounding"] = 1,
        ["Callback"] = function(value)
            configuredBoatSpeed = value
        end
    }):SetValue(configuredBoatSpeed)
    local v387 = Tabs.Sea:AddToggle("AutoFindPrehistoric", {
        ["Title"] = "Auto Find Volcano Island",
        ["Description"] = "",
        ["Default"] = false
    })
    UIOptions.AutoFindPrehistoric:SetValue(false)
    v387:OnChanged(function(state)
        _G.AutoFindPrehistoric = state
    end)
    local savedPrehistoricBoatSeats = {}
    local isSittingInPrehistoricSeat = false
    local hasNotifiedPrehistoric = false
    RunServiceModule.RenderStepped:Connect(function()
        if _G.AutoFindPrehistoric then
            local character = PlayersService.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local function enterEmptyPrehistoricSeat()
                    if isSittingInPrehistoricSeat then
                        return
                    end
                    isSittingInPrehistoricSeat = true
                    for _, seat in pairs(savedPrehistoricBoatSeats) do
                        if seat and seat.Parent and seat.Name == "VehicleSeat" and not seat.Occupant then
                            Tween2(seat.CFrame)
                            break
                        end
                    end
                    isSittingInPrehistoricSeat = false
                end
                local humanoid = character.Humanoid
                local isDriving = false
                local activeSeat = nil
                for _, boat in pairs(WorkspaceModule.Boats:GetChildren()) do
                    local seat = boat:FindFirstChild("VehicleSeat")
                    if seat and seat.Occupant == humanoid then
                        savedPrehistoricBoatSeats[boat.Name] = seat
                        activeSeat = seat
                        isDriving = true
                    elseif seat and seat.Occupant == nil then
                        enterEmptyPrehistoricSeat()
                    end
                end
                if isDriving then
                    activeSeat.MaxSpeed = configuredBoatSpeed
                    activeSeat.CFrame = CFrame.new(Vector3.new(activeSeat.Position.X, activeSeat.Position.Y, activeSeat.Position.Z)) * activeSeat.CFrame.Rotation
                    VirtualInputModule:SendKeyEvent(true, "W", false, game)
                    for _, part in pairs(WorkspaceModule.Boats:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    local clutterIslands = {
                        "ShipwreckIsland",
                        "SandIsland",
                        "TreeIsland",
                        "TinyIsland",
                        "MysticIsland",
                        "KitsuneIsland",
                        "FrozenDimension"
                    }
                    for _, islandName in ipairs(clutterIslands) do
                        local island = WorkspaceModule.Map:FindFirstChild(islandName)
                        if island and island:IsA("Model") then
                            island:Destroy()
                        end
                    end
                    if WorkspaceModule.Map:FindFirstChild("PrehistoricIsland") then
                        VirtualInputModule:SendKeyEvent(false, "W", false, game)
                        _G.AutoFindPrehistoric = false
                        if not hasNotifiedPrehistoric then
                            Fluent:Notify({
                                ["Title"] = "Banana Cat Hub",
                                ["Content"] = "Found Lava Island",
                                ["Duration"] = 10
                            })
                            hasNotifiedPrehistoric = true
                        end
                    end
                end
            end
        else
            hasNotifiedPrehistoric = false
        end
    end)
    local v419 = Tabs.Sea:AddToggle("AutoFindMirage", {
        ["Title"] = "Auto Find Mirage Island",
        ["Description"] = "",
        ["Default"] = false
    })
    UIOptions.AutoFindMirage:SetValue(false)
    v419:OnChanged(function(state)
        _G.AutoFindMirage = state
    end)
    local savedBoatSeats = {}
    local isSittingInSeat = false
    local hasNotifiedMirage = false
    RunServiceModule.RenderStepped:Connect(function()
        if _G.AutoFindMirage then
            local character = PlayersService.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local function enterEmptySeat()
                    if isSittingInSeat then
                        return
                    end
                    isSittingInSeat = true
                    for _, seat in pairs(savedBoatSeats) do
                        if seat and seat.Parent and seat.Name == "VehicleSeat" and not seat.Occupant then
                            Tween2(seat.CFrame)
                            break
                        end
                    end
                    isSittingInSeat = false
                end
                local humanoid = character.Humanoid
                local isDriving = false
                local activeSeat = nil
                for _, boat in pairs(WorkspaceModule.Boats:GetChildren()) do
                    local seat = boat:FindFirstChild("VehicleSeat")
                    if seat and seat.Occupant == humanoid then
                        savedBoatSeats[boat.Name] = seat
                        activeSeat = seat
                        isDriving = true
                    elseif seat and seat.Occupant == nil then
                        enterEmptySeat()
                    end
                end
                if isDriving then
                    activeSeat.MaxSpeed = configuredBoatSpeed
                    activeSeat.CFrame = CFrame.new(Vector3.new(activeSeat.Position.X, activeSeat.Position.Y, activeSeat.Position.Z)) * activeSeat.CFrame.Rotation
                    VirtualInputModule:SendKeyEvent(true, "W", false, game)
                    for _, part in pairs(WorkspaceModule.Boats:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    local clutterIslands = {
                        "ShipwreckIsland",
                        "SandIsland",
                        "TreeIsland",
                        "TinyIsland",
                        "PrehistoricIsland",
                        "KitsuneIsland",
                        "FrozenDimension"
                    }
                    for _, islandName in ipairs(clutterIslands) do
                        local island = WorkspaceModule.Map:FindFirstChild(islandName)
                        if island and island:IsA("Model") then
                            island:Destroy()
                        end
                    end
                    if WorkspaceModule.Map:FindFirstChild("MysticIsland") then
                        VirtualInputModule:SendKeyEvent(false, "W", false, game)
                        _G.AutoFindMirage = false
                        if not hasNotifiedMirage then
                            Fluent:Notify({
                                ["Title"] = "Banana Cat Hub",
                                ["Content"] = "Found Mysterious Island",
                                ["Duration"] = 10
                            })
                            hasNotifiedMirage = true
                        end
                    end
                end
            end
        else
            hasNotifiedMirage = false
        end
    end)
    local v451 = Tabs.Sea:AddToggle("AutoFindFrozen", {
        ["Title"] = "Auto Find Leviathan Island",
        ["Description"] = "",
        ["Default"] = false
    })
    UIOptions.AutoFindFrozen:SetValue(false)
    v451:OnChanged(function(state)
        _G.AutoFindFrozen = state
    end)
    local savedLeviBoatSeats = {}
    local isSittingInLeviSeat = false
    local hasNotifiedLevi = false
    RunServiceModule.RenderStepped:Connect(function()
        if _G.AutoFindFrozen then
            local character = PlayersService.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local function enterEmptyLeviSeat()
                    if isSittingInLeviSeat then
                        return
                    end
                    isSittingInLeviSeat = true
                    for _, seat in pairs(savedLeviBoatSeats) do
                        if seat and seat.Parent and seat.Name == "VehicleSeat" and not seat.Occupant then
                            Tween2(seat.CFrame)
                            break
                        end
                    end
                    isSittingInLeviSeat = false
                end
                local humanoid = character.Humanoid
                local isDriving = false
                local activeSeat = nil
                for _, boat in pairs(WorkspaceModule.Boats:GetChildren()) do
                    local seat = boat:FindFirstChild("VehicleSeat")
                    if seat and seat.Occupant == humanoid then
                        savedLeviBoatSeats[boat.Name] = seat
                        activeSeat = seat
                        isDriving = true
                    elseif seat and seat.Occupant == nil then
                        enterEmptyLeviSeat()
                    end
                end
                if isDriving then
                    activeSeat.MaxSpeed = configuredBoatSpeed
                    activeSeat.CFrame = CFrame.new(Vector3.new(activeSeat.Position.X, activeSeat.Position.Y, activeSeat.Position.Z)) * activeSeat.CFrame.Rotation
                    VirtualInputModule:SendKeyEvent(true, "W", false, game)
                    for _, part in pairs(WorkspaceModule.Boats:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                    local clutterIslands = {
                        "ShipwreckIsland",
                        "SandIsland",
                        "TreeIsland",
                        "TinyIsland",
                        "PrehistoricIsland",
                        "KitsuneIsland",
                        "FrozenDimension"
                    }
                    for _, islandName in ipairs(clutterIslands) do
                        local island = WorkspaceModule.Map:FindFirstChild(islandName)
                        if island and island:IsA("Model") then
                            island:Destroy()
                        end
                    end
                    if WorkspaceModule.Map:FindFirstChild("FrozenDimension") then
                        VirtualInputModule:SendKeyEvent(false, "W", false, game)
                        _G.AutoFindFrozen = false
                        if not hasNotifiedLevi then
                            Fluent:Notify({
                                ["Title"] = "Banana Cat Hub",
                                ["Content"] = "Found Leviathan Island",
                                ["Duration"] = 10
                            })
                            hasNotifiedLevi = true
                        end
                    end
                end
            end
        else
            hasNotifiedLevi = false
        end
    end)
    Tabs.Sea:AddToggle("AutoComeTiki", {
        ["Title"] = "Return to Tiki Outpost",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoComeTiki = state
    end)
    RunServiceModule.RenderStepped:Connect(function()
        if not _G.AutoComeTiki then
            return
        end
        local character = PlayersService.LocalPlayer.Character
        if not (character and character:FindFirstChild("Humanoid")) then
            return
        end
        local humanoid = character.Humanoid
        local targetSeat = nil
        for _, boat in pairs(WorkspaceModule.Boats:GetChildren()) do
            local seat = boat:FindFirstChild("VehicleSeat")
            if seat and seat.Occupant == humanoid then
                targetSeat = seat
                break
            end
        end
        if targetSeat then
            targetSeat.MaxSpeed = configuredBoatSpeed
            local tikiTargetCFrame = CFrame.new(- 16217.7568359375, 9.126761436462402, 446.06536865234375)
            local currentPos = targetSeat.Position
            local targetPos = tikiTargetCFrame.Position
            local moveStep = (targetPos - currentPos).unit * targetSeat.MaxSpeed * RunServiceModule.RenderStepped:Wait()
            targetSeat.CFrame = targetSeat.CFrame + moveStep
            targetSeat.CFrame = CFrame.new(targetSeat.Position, targetPos)
            if (targetSeat.Position - targetPos).magnitude < 120 then
                _G.AutoComeTiki = false
                VirtualInputModule:SendKeyEvent(false, "W", false, game)
            end
        end
    end)
    Tabs.Sea:AddToggle("AutoComeHydra", {
        ["Title"] = "Return to Hydra Island",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoComeHydra = state
    end)
    RunServiceModule.RenderStepped:Connect(function()
        if not _G.AutoComeHydra then
            return
        end
        local character = PlayersService.LocalPlayer.Character
        if not (character and character:FindFirstChild("Humanoid")) then
            return
        end
        local humanoid = character.Humanoid
        local targetSeat = nil
        for _, boat in pairs(WorkspaceModule.Boats:GetChildren()) do
            local seat = boat:FindFirstChild("VehicleSeat")
            if seat and seat.Occupant == humanoid then
                targetSeat = seat
                break
            end
        end
        if targetSeat then
            targetSeat.MaxSpeed = configuredBoatSpeed
            local hydraTargetCFrame = CFrame.new(5193.9375, - 0.04690289497375488, 1631.578369140625)
            local currentPos = targetSeat.Position
            local targetPos = hydraTargetCFrame.Position
            local moveStep = (targetPos - currentPos).unit * targetSeat.MaxSpeed * RunServiceModule.RenderStepped:Wait()
            targetSeat.CFrame = targetSeat.CFrame + moveStep
            targetSeat.CFrame = CFrame.new(targetSeat.Position, targetPos)
            if (targetSeat.Position - targetPos).magnitude < 120 then
                _G.AutoComeHydra = false
                VirtualInputModule:SendKeyEvent(false, "W", false, game)
            end
        end
    end)
    Tabs.Sea:AddButton({
        ["Title"] = "Fly to Boat Seller [ Tiki Outpost ]",
        ["Description"] = "",
        ["Callback"] = function()
            Tween2(CFrame.new(- 16917.154296875, 7.757596015930176, 511.8203125))
        end
    })
    local purchasedBoatSeats = {}
    local boatDropdown = Tabs.Sea:AddDropdown("DropdownBoat", {
        ["Title"] = "Select Boat",
        ["Description"] = "",
        ["Values"] = {
            "Beast Hunter",
            "Sleigh",
            "Miracle",
            "The Sentinel",
            "Guardian",
            "Lantern",
            "Dinghy",
            "PirateSloop",
            "PirateBrigade",
            "PirateGrandBrigade",
            "MarineGrandBrigade",
            "MarineBrigade",
            "MarineSloop"
        },
        ["Multi"] = false,
        ["Default"] = 1
    })
    boatDropdown:SetValue(selectedBoat)
    boatDropdown:OnChanged(function(boatName)
        selectedBoat = boatName
    end)
    local function buySelectedBoat(boatName)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", boatName)
        task.delay(2, function()
            for _, boat in pairs(WorkspaceModule.Boats:GetChildren()) do
                if boat:IsA("Model") and boat.Name == boatName then
                    local seat = boat:FindFirstChild("VehicleSeat")
                    if seat and not seat.Occupant then
                        purchasedBoatSeats[boatName] = seat
                    end
                end
            end
        end)
    end
    local function flyToPurchasedBoat()
        for _, seat in pairs(purchasedBoatSeats) do
            if seat and (seat.Parent and (seat.Name == "VehicleSeat" and not seat.Occupant)) then
                Tween2(seat.CFrame)
            end
        end
    end
    RunServiceModule.RenderStepped:Connect(function()
        for seatKey, seat in pairs(purchasedBoatSeats) do
            if seat and (seat.Parent and (seat.Name == "VehicleSeat" and not seat.Occupant)) then
                purchasedBoatSeats[seatKey] = seat
            end
        end
    end)
    Tabs.Sea:AddButton({
        ["Title"] = "Buy Boat",
        ["Description"] = "",
        ["Callback"] = function()
            buySelectedBoat(selectedBoat)
        end
    })
    Tabs.Sea:AddButton({
        ["Title"] = "Fly to My Boat",
        ["Description"] = "",
        ["Callback"] = function()
            flyToPurchasedBoat()
        end
    })
    Tabs.Sea:AddToggle("ToggleTerrorshark", {
        ["Title"] = "Attack Terrorshark",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoTerrorshark = state
    end)
    UIOptions.ToggleTerrorshark:SetValue(false)
    spawn(function()
        while wait() do
            if _G.AutoTerrorshark then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Terrorshark") then
                        for v531, v532 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v532.Name == "Terrorshark" and (v532:FindFirstChild("Humanoid") and (v532:FindFirstChild("HumanoidRootPart") and v532.Humanoid.Health > 0)) then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v532.HumanoidRootPart.CanCollide = false
                                    v532.Humanoid.WalkSpeed = 0
                                    v532.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v532.HumanoidRootPart.CFrame * Pos)
                                until not _G.AutoTerrorshark or (not v532.Parent or v532.Humanoid.Health <= 0)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end)
            end
        end
    end)
    Tabs.Sea:AddToggle("TogglePiranha", {
        ["Title"] = "Attack Piranhas",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.farmpiranya = state
    end)
    UIOptions.TogglePiranha:SetValue(false)
    spawn(function()
        while wait() do
            if _G.farmpiranya then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Piranha") then
                        for v536, v537 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v537.Name == "Piranha" and (v537:FindFirstChild("Humanoid") and (v537:FindFirstChild("HumanoidRootPart") and v537.Humanoid.Health > 0)) then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v537.HumanoidRootPart.CanCollide = false
                                    v537.Humanoid.WalkSpeed = 0
                                    v537.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v537.HumanoidRootPart.CFrame * Pos)
                                until not _G.farmpiranya or (not v537.Parent or v537.Humanoid.Health <= 0)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Piranha") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Piranha").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end)
            end
        end
    end)
    Tabs.Sea:AddToggle("ToggleShark", {
        ["Title"] = "Attack Sharks",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoShark = state
    end)
    UIOptions.ToggleShark:SetValue(false)
    spawn(function()
        while wait() do
            if _G.AutoShark then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Shark") then
                        for v541, v542 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v542.Name == "Shark" and (v542:FindFirstChild("Humanoid") and (v542:FindFirstChild("HumanoidRootPart") and v542.Humanoid.Health > 0)) then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v542.HumanoidRootPart.CanCollide = false
                                    v542.Humanoid.WalkSpeed = 0
                                    v542.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v542.HumanoidRootPart.CFrame * Pos)
                                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                until not _G.AutoShark or (not v542.Parent or v542.Humanoid.Health <= 0)
                            end
                        end
                    else
                        Tween(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Terrorshark").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Tabs.Sea:AddToggle("ToggleFishCrew", {
        ["Title"] = "Attack Fish Crew",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoFishCrew = state
    end)
    UIOptions.ToggleFishCrew:SetValue(false)
    spawn(function()
        while wait() do
            if _G.AutoFishCrew then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Fish Crew Member") then
                        for v546, v547 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v547.Name == "Fish Crew Member" and (v547:FindFirstChild("Humanoid") and (v547:FindFirstChild("HumanoidRootPart") and v547.Humanoid.Health > 0)) then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v547.HumanoidRootPart.CanCollide = false
                                    v547.Humanoid.WalkSpeed = 0
                                    v547.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v547.HumanoidRootPart.CFrame * Pos)
                                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                until not _G.AutoFishCrew or (not v547.Parent or v547.Humanoid.Health <= 0)
                            end
                        end
                    else
                        Tween(game:GetService("Workspace").Boats.PirateGrandBrigade.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Fish Crew Member") then
                            Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Fish Crew Member").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
    Tabs.Sea:AddToggle("ToggleShip", {
        ["Title"] = "Attack Ships",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.Ship = state
    end)
    UIOptions.ToggleShip:SetValue(false)
    function CheckPirateBoat()
        local v549 = next
        local v550, v551 = game:GetService("Workspace").Enemies:GetChildren()
        local v552 = {
            "PirateGrandBrigade",
            "PirateBrigade"
        }
        while true do
            local v553
            v551, v553 = v549(v550, v551)
            if v551 == nil then
                break
            end
            if table.find(v552, v553.Name) and (v553:FindFirstChild("Health") and v553.Health.Value > 0) then
                return v553
            end
        end
    end
    spawn(function()
        while wait() do
            if _G.Ship then
                pcall(function()
                    if CheckPirateBoat() then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                        wait(0.5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                        local v554 = CheckPirateBoat()
                        repeat
                            wait()
                            spawn(Tween(v554.Engine.CFrame * CFrame.new(0, - 20, 0)), 1)
                            AimBotSkillPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, - 5, 0)
                            Skillaimbot = true
                            AutoSkill = false
                        until not v554 or (not v554.Parent or (v554.Health.Value <= 0 or not CheckPirateBoat()))
                        Skillaimbot = true
                        AutoSkill = false
                    end
                end)
            end
        end
    end)
    Tabs.Sea:AddToggle("ToggleGhostShip", {
        ["Title"] = "Attack Ghost Ships",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.GhostShip = state
    end)
    UIOptions.ToggleGhostShip:SetValue(false)
    function CheckPirateBoat()
        local v556 = next
        local v557, v558 = game:GetService("Workspace").Enemies:GetChildren()
        local v559 = {
            "FishBoat"
        }
        while true do
            local v560
            v558, v560 = v556(v557, v558)
            if v558 == nil then
                break
            end
            if table.find(v559, v560.Name) and (v560:FindFirstChild("Health") and v560.Health.Value > 0) then
                return v560
            end
        end
    end
    spawn(function()
        while wait() do
            pcall(function()
                if _G.bjirFishBoat and CheckPirateBoat() then
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 32, false, game)
                    wait()
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 32, false, game)
                    local v561 = CheckPirateBoat()
                    repeat
                        wait()
                        spawn(Tween(v561.Engine.CFrame * CFrame.new(0, - 20, 0), 1))
                        AutoSkill = true
                        Skillaimbot = true
                        AimBotSkillPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, - 5, 0)
                    until v561.Parent or (v561.Health.Value <= 0 or not CheckPirateBoat())
                    AutoSkill = false
                    Skillaimbot = false
                end
            end)
        end
    end)
    spawn(function()
        while wait() do
            if _G.bjirFishBoat then
                pcall(function()
                    if CheckPirateBoat() then
                        AutoHaki()
                        game:GetService("VirtualUser"):CaptureController()
                        game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                        for v564, v565 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v565:IsA("Tool") and v565.ToolTip == "Melee" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v565)
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "C", false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        for v568, v569 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v569:IsA("Tool") and v569.ToolTip == "Blox Fruit" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v569)
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "V", false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "V", false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait()
                        for v572, v573 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v573:IsA("Tool") and v573.ToolTip == "Sword" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v573)
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait()
                        for v576, v577 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if v577:IsA("Tool") and v577.ToolTip == "Gun" then
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(v577)
                            end
                        end
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        wait(0.2)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                    end
                end)
            end
        end
    end)
    Tabs.Main:AddSection("Elite")
    local eliteBossStatusLabel = Tabs.Main:AddParagraph({
        ["Title"] = "Elite Status",
        ["Content"] = ""
    })
    spawn(function()
        while wait() do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or (game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or (game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or (game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban"))))) then
                    eliteBossStatusLabel:SetDesc("Elite Boss: ✅️ | Killed:  " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
                else
                    eliteBossStatusLabel:SetDesc("Elite Boss: ❌️ | Killed: " .. game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
                end
            end)
        end
    end)
    Tabs.Main:AddToggle("ToggleElite", {
        ["Title"] = "Auto Elite Hunter",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoElite = state
    end)
    UIOptions.ToggleElite:SetValue(false)
    spawn(function()
        while task.wait() do
            if _G.AutoElite then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible ~= true then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") or string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban")) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or (game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                            for v582, v583 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v583:FindFirstChild("Humanoid") and (v583:FindFirstChild("HumanoidRootPart") and (v583.Humanoid.Health > 0 and (v583.Name == "Diablo" or (v583.Name == "Deandre" or v583.Name == "Urban")))) then
                                    repeat
                                        wait(_G.Fast_Delay)
                                        AttackNoCoolDown()
                                        EquipTool(SelectWeapon)
                                        AutoHaki()
                                        Tween2(v583.HumanoidRootPart.CFrame * Pos)
                                        v583.Humanoid.WalkSpeed = 0
                                        v583.HumanoidRootPart.CanCollide = false
                                        v583.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    until _G.AutoElite == false or (v583.Humanoid.Health <= 0 or not v583.Parent)
                                end
                            end
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") then
                            Tween2(game:GetService("ReplicatedStorage"):FindFirstChild("Diablo").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") then
                            Tween2(game:GetService("ReplicatedStorage"):FindFirstChild("Deandre").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        elseif game:GetService("ReplicatedStorage"):FindFirstChild("Urban") then
                            Tween2(game:GetService("ReplicatedStorage"):FindFirstChild("Urban").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                    end
                end)
            end
        end
    end)
end
if Sea3 then
    Tabs.Sea:AddSection("Mirage Island")
    local mirageSeaStatusLabel = Tabs.Sea:AddParagraph({
        ["Title"] = "Status",
        ["Content"] = ""
    })
    task.spawn(function()
        while task.wait() do
            pcall(function()
                local v585 = game:GetService("Lighting").Sky.MoonTextureId
                if v585 == "http://www.roblox.com/asset/?id=9709149431" then
                    FullMoonStatus = "100%"
                elseif v585 == "http://www.roblox.com/asset/?id=9709149052" then
                    FullMoonStatus = "75%"
                elseif v585 == "http://www.roblox.com/asset/?id=9709143733" then
                    FullMoonStatus = "50%"
                elseif v585 == "http://www.roblox.com/asset/?id=9709150401" then
                    FullMoonStatus = "25%"
                elseif v585 == "http://www.roblox.com/asset/?id=9709149680" then
                    FullMoonStatus = "15%"
                else
                    FullMoonStatus = "0%"
                end
            end)
        end
    end)
    task.spawn(function()
        while task.wait() do
            pcall(function()
                if game.Workspace.Map:FindFirstChild("MysticIsland") then
                    MirageStatus = "✅️"
                else
                    MirageStatus = "❌️"
                end
            end)
        end
    end)
    spawn(function()
        pcall(function()
            while wait() do
                mirageSeaStatusLabel:SetDesc("Mirage: " .. MirageStatus .. " | Full Moon: " .. FullMoonStatus)
            end
        end)
    end)
    Tabs.Sea:AddButton({
        ["Title"] = "Fly to High Mountain",
        ["Description"] = "",
        ["Callback"] = function()
            TweenToHighestPoint()
        end
    })
    function TweenToHighestPoint()
        local v586 = getHighestPoint()
        if v586 then
            Tween2(v586.CFrame * CFrame.new(0, 211.88, 0))
        end
    end
    function getHighestPoint()
        if not game.Workspace.Map:FindFirstChild("MysticIsland") then
            return nil
        end
        for v589, v590 in pairs(game:GetService("Workspace").Map.MysticIsland:GetDescendants()) do
            if v590:IsA("MeshPart") and v590.MeshId == "rbxassetid://83190276951914" then
                return v590
            end
        end
    end
end
Tabs.Sea:AddToggle("ToggleTpAdvanced", {
    ["Title"] = "Fly to Advanced Fruit Dealer",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoTpAdvanced = state
end)
spawn(function()
    while wait() do
        if _G.AutoTpAdvanced then
            local v592 = game.ReplicatedStorage.NPCs:FindFirstChild("Advanced Fruit Dealer")
            if v592 and v592:IsA("Model") then
                local v593 = v592.PrimaryPart
                if v593 then
                    v593 = v592.PrimaryPart.Position
                end
                if v593 then
                    Tween2(CFrame.new(v593))
                end
            end
        end
    end
end)
Tabs.Sea:AddToggle("ToggleTweenGear", {
    ["Title"] = "Fly to Gear",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.TweenToGear = state
end)
UIOptions.ToggleTweenGear:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.TweenToGear and game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
                for v597, v598 in pairs(game:GetService("Workspace").Map.MysticIsland:GetChildren()) do
                    if v598:IsA("MeshPart") and v598.Material == Enum.Material.Neon then
                        Tween2(v598.CFrame)
                    end
                end
            end
        end
    end)
end)
Tabs.Sea:AddToggle("Togglelockmoon", {
    ["Title"] = "Auto Look at Moon",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoLockMoon = state
end)
UIOptions.Togglelockmoon:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoLockMoon then
                local v600 = game.Lighting:GetMoonDirection()
                local v601 = game.Workspace.CurrentCamera.CFrame.p + v600 * 100
                game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, v601)
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoLockMoon then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
            end
        end)
    end
end)
Tabs.ITM:AddToggle("ToggleAutoSaber", {
    ["Title"] = "Auto Get Saber",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Saber = state
end)
UIOptions.ToggleAutoSaber:SetValue(false)
spawn(function()
    while task.wait() do
        if _G.Auto_Saber and game.Players.LocalPlayer.Data.Level.Value >= 200 then
            pcall(function()
                if game:GetService("Workspace").Map.Jungle.Final.Part.Transparency ~= 0 then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert") or game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert") then
                        for v605, v606 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v606:FindFirstChild("Humanoid") and (v606:FindFirstChild("HumanoidRootPart") and (v606.Humanoid.Health > 0 and v606.Name == "Saber Expert")) then
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    EquipTool(SelectWeapon)
                                    Tween(v606.HumanoidRootPart.CFrame * Pos)
                                    v606.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v606.HumanoidRootPart.Transparency = 1
                                    v606.Humanoid.JumpPower = 0
                                    v606.Humanoid.WalkSpeed = 0
                                    v606.HumanoidRootPart.CanCollide = false
                                    bringmob = true
                                    FarmPos = v606.HumanoidRootPart.CFrame
                                    MonFarm = v606.Name
                                    AttackNoCoolDown()
                                until v606.Humanoid.Health <= 0 or not _G.Auto_Saber
                                bringmob = true
                                if v606.Humanoid.Health <= 0 then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
                                end
                            end
                        end
                    end
                elseif game:GetService("Workspace").Map.Jungle.QuestPlates.Door.Transparency ~= 0 then
                    if game:GetService("Workspace").Map.Desert.Burn.Part.Transparency ~= 0 then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") == 0 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= nil then
                                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 0 then
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                                        wait(0.5)
                                        EquipTool("Relic")
                                        wait(0.5)
                                        Tween(CFrame.new(- 1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.6690688e-9, 0.481375456, 2.53852e-8, 1, - 5.799956e-8, - 0.481375456, 6.3057264e-8, 0.876514494))
                                    end
                                elseif game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader") or game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                                    Tween(CFrame.new(- 2967.59521, - 4.91089821, 5328.70703, 0.342208564, - 0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, - 0.939287126, 0.0184739735, 0.342634559))
                                    for v609, v610 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                        if v610.Name == "Mob Leader" then
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") and (v610:FindFirstChild("Humanoid") and (v610:FindFirstChild("HumanoidRootPart") and v610.Humanoid.Health > 0)) then
                                                repeat
                                                    task.wait(_G.Fast_Delay)
                                                    AutoHaki()
                                                    EquipTool(SelectWeapon)
                                                    v610.HumanoidRootPart.CanCollide = false
                                                    v610.Humanoid.WalkSpeed = 0
                                                    v610.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                    Tween(v610.HumanoidRootPart.CFrame * Pos)
                                                    AttackNoCoolDown()
                                                until v610.Humanoid.Health <= 0 or not _G.Auto_Saber
                                            end
                                            if game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                                                Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                            end
                                        end
                                    end
                                end
                            else
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
                            wait(0.5)
                            EquipTool("Cup")
                            wait(0.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", game:GetService("Players").LocalPlayer.Character.Cup)
                            wait(0)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
                        end
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                        EquipTool("Torch")
                        Tween(CFrame.new(1114.61475, 5.04679728, 4350.22803, - 0.648466587, - 1.2879909e-9, 0.761243105, - 5.706529e-10, 1, 1.2058454e-9, - 0.761243105, 3.4754488e-10, - 0.648466587))
                    else
                        Tween(CFrame.new(- 1610.00757, 11.5049858, 164.001587, 0.984807551, - 0.167722285, - 0.0449818149, 0.17364943, 0.951244235, 0.254912198, 0.00003423728, - 0.258850515, 0.965917408))
                    end
                elseif (CFrame.new(- 1612.55884, 36.9774132, 148.719543, 0.37091279, 3.071715e-9, - 0.928667724, 3.970995e-8, 1, 1.9167935e-8, 0.928667724, - 4.398698e-8, 0.37091279).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 100 then
                    Tween(CFrame.new(- 1612.55884, 36.9774132, 148.719543, 0.37091279, 3.071715e-9, - 0.928667724, 3.970995e-8, 1, 1.9167935e-8, 0.928667724, - 4.398698e-8, 0.37091279))
                else
                    Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate1.Button.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate2.Button.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate3.Button.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate4.Button.CFrame
                    wait(1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.Jungle.QuestPlates.Plate5.Button.CFrame
                    wait(1)
                end
            end)
        end
    end
end)
Tabs.ITM:AddToggle("ToggleAutoPoleV1", {
    ["Title"] = "Auto Get Pole V1",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_PoleV1 = state
end)
UIOptions.ToggleAutoPoleV1:SetValue(false)
local castleAtSeaCFrame = CFrame.new(- 7748.0185546875, 5606.80615234375, - 2305.898681640625)
spawn(function()
    while wait() do
        if _G.Auto_PoleV1 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Thunder God") then
                    for v615, v616 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v616.Name == "Thunder God" and (v616:FindFirstChild("Humanoid") and (v616:FindFirstChild("HumanoidRootPart") and v616.Humanoid.Health > 0)) then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v616.HumanoidRootPart.CanCollide = false
                                v616.Humanoid.WalkSpeed = 0
                                v616.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                Tween(v616.HumanoidRootPart.CFrame * Pos)
                                AttackNoCoolDown()
                            until not _G.Auto_PoleV1 or (not v616.Parent or v616.Humanoid.Health <= 0)
                        end
                    end
                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - castleAtSeaCFrame.Position).Magnitude < 1500 then
                    Tween(castleAtSeaCFrame)
                end
                Tween(CFrame.new(- 7748.0185546875, 5606.80615234375, - 2305.898681640625))
                if game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Thunder God").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                end
            end)
        end
    end
end)
Tabs.ITM:AddToggle("ToggleAutoSaw", {
    ["Title"] = "Auto Get Shark Saw",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Saw = state
end)
UIOptions.ToggleAutoSaw:SetValue(false)
local mansionCFrame = CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094)
spawn(function()
    while wait() do
        if _G.Auto_Saw then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                    for v621, v622 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v622.Name == "The Saw" and (v622:FindFirstChild("Humanoid") and (v622:FindFirstChild("HumanoidRootPart") and v622.Humanoid.Health > 0)) then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v622.HumanoidRootPart.CanCollide = false
                                v622.Humanoid.WalkSpeed = 0
                                v622.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                Tween(v622.HumanoidRootPart.CFrame * Pos)
                                AttackNoCoolDown()
                            until not _G.Auto_Saw or (not v622.Parent or v622.Humanoid.Health <= 0)
                        end
                    end
                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - mansionCFrame.Position).Magnitude < 1500 then
                    Tween(mansionCFrame)
                end
                Tween(CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094))
                if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("The Saw").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                end
            end)
        end
    end
end)
Tabs.ITM:AddToggle("ToggleAutoWarden", {
    ["Title"] = "Auto Get Warden's Sword",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Warden = state
end)
UIOptions.ToggleAutoWarden:SetValue(false)
local hydraIslandCFrame = CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562)
spawn(function()
    while wait() do
        if _G.Auto_Warden then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Chief Warden") then
                    for v627, v628 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v628.Name == "Chief Warden" and (v628:FindFirstChild("Humanoid") and (v628:FindFirstChild("HumanoidRootPart") and v628.Humanoid.Health > 0)) then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v628.HumanoidRootPart.CanCollide = false
                                v628.Humanoid.WalkSpeed = 0
                                v628.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                Tween(v628.HumanoidRootPart.CFrame * Pos)
                                AttackNoCoolDown()
                            until not _G.Auto_Warden or (not v628.Parent or v628.Humanoid.Health <= 0)
                        end
                    end
                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - hydraIslandCFrame.Position).Magnitude < 1500 then
                    Tween(hydraIslandCFrame)
                end
                Tween(CFrame.new(5186.14697265625, 24.86684226989746, 832.1885375976562))
                if game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Chief Warden").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                end
            end)
        end
    end
end)
if Sea3 then
    Tabs.ITM:AddToggle("ToggleHallow", {
        ["Title"] = "Auto Get Hallow Scythe",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        AutoHallowSycthe = state
    end)
    UIOptions.ToggleHallow:SetValue(false)
    spawn(function()
        while wait() do
            if AutoHallowSycthe then
                pcall(function()
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                        for v632, v633 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if string.find(v633.Name, "Soul Reaper") then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    v633.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    Tween(v633.HumanoidRootPart.CFrame * Pos)
                                    v633.HumanoidRootPart.Transparency = 1
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until v633.Humanoid.Health <= 0 or AutoHallowSycthe == false
                            end
                        end
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hallow Essence") then
                        repeat
                            Tween(CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125))
                            wait()
                        until (CFrame.new(- 8932.322265625, 146.83154296875, 6062.55078125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
                        wait()
                        EquipTool("Hallow Essence")
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper") then
                        Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                    end
                end)
            end
        end
    end)
    spawn(function()
        while wait() do
            if AutoHallowSycthe then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "Bones",
                    "Buy",
                    1,
                    1
                }))
            end
        end
    end)
    Tabs.ITM:AddToggle("ToggleYama", {
        ["Title"] = "Auto Get Yama",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoYama = state
    end)
    UIOptions.ToggleYama:SetValue(false)
    spawn(function()
        while wait() do
            if _G.AutoYama and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress") >= 30 then
                repeat
                    wait()
                    fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
                until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yama") or not _G.AutoYama
            end
        end
    end)
    Tabs.ITM:AddToggle("ToggleTushita", {
        ["Title"] = "Auto Get Tushita",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        AutoTushita = state
    end)
    UIOptions.ToggleTushita:SetValue(false)
    spawn(function()
		
        while true do
            repeat
                if not wait() then
                    return
                end
            until AutoTushita
            if game:GetService("Workspace").Enemies:FindFirstChild("Longma") then
                break
            end
            Tween(CFrame.new(- 10238.875976563, 389.7912902832, - 9549.7939453125))
        end
        local v636, v637, v638 = pairs(game:GetService("Workspace").Enemies:GetChildren())
		
        local v639
        v638, v639 = v636(v637, v638)
        if v638 ~= nil then
			
        end
		
		
        if v639.Name == ("Longma" or v639.Name == "Longma") and (v639.Humanoid.Health > 0 and (v639:IsA("Model") and (v639:FindFirstChild("Humanoid") and v639:FindFirstChild("HumanoidRootPart")))) then
			
        else
			
        end
		
		
        wait(_G.Fast_Delay)
        AttackNoCoolDown()
        AutoHaki()
        if not game.Players.LocalPlayer.Character:FindFirstChild(SelectWeapon) then
            wait()
            EquipTool(SelectWeapon)
        end
        FarmPos = v639.HumanoidRootPart.CFrame
        v639.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
        v639.Humanoid.JumpPower = 0
        v639.Humanoid.WalkSpeed = 0
        v639.HumanoidRootPart.CanCollide = false
        v639.Humanoid:ChangeState(11)
        Tween(v639.HumanoidRootPart.CFrame * Pos)
        if AutoTushita and (v639.Parent and v639.Humanoid.Health > 0) then
			
        else
			
        end
    end)
    Tabs.ITM:AddToggle("ToggleHoly", {
        ["Title"] = "Auto Light Torches",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.Auto_Holy_Torch = state
    end)
    UIOptions.ToggleHoly:SetValue(false)
    spawn(function()
        while wait() do
            if _G.Auto_Holy_Torch then
                pcall(function()
                    wait()
                    repeat
                        Tween(CFrame.new(- 10752, 417, - 9366))
                        wait()
                    until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 10752, 417, - 9366)).Magnitude <= 10
                    wait()
                    repeat
                        Tween(CFrame.new(- 11672, 334, - 9474))
                        wait()
                    until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 11672, 334, - 9474)).Magnitude <= 10
                    wait()
                    repeat
                        Tween(CFrame.new(- 12132, 521, - 10655))
                        wait()
                    until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 12132, 521, - 10655)).Magnitude <= 10
                    wait()
                    repeat
                        Tween(CFrame.new(- 13336, 486, - 6985))
                        wait()
                    until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 13336, 486, - 6985)).Magnitude <= 10
                    wait()
                    repeat
                        Tween(CFrame.new(- 13489, 332, - 7925))
                        wait()
                    until not _G.Auto_Holy_Torch or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 13489, 332, - 7925)).Magnitude <= 10
                end)
            end
        end
    end)
end
Tabs.ITM:AddToggle("ToggleAutoCanvander", {
    ["Title"] = "Auto Get Canvander",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Canvander = state
end)
UIOptions.ToggleAutoCanvander:SetValue(false)
local floatingTurtleCFrame = CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875)
spawn(function()
    while wait() do
        if _G.Auto_Canvander then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                    for v645, v646 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v646.Name == "Beautiful Pirate" and (v646:FindFirstChild("Humanoid") and (v646:FindFirstChild("HumanoidRootPart") and v646.Humanoid.Health > 0)) then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v646.HumanoidRootPart.CanCollide = false
                                v646.Humanoid.WalkSpeed = 0
                                v646.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                Tween(v646.HumanoidRootPart.CFrame * Pos)
                                AttackNoCoolDown()
                            until not _G.Auto_Canvander or (not v646.Parent or v646.Humanoid.Health <= 0)
                        end
                    end
                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - floatingTurtleCFrame.Position).Magnitude < 1500 then
                    Tween(floatingTurtleCFrame)
                end
                Tween(CFrame.new(5311.07421875, 426.0243835449219, 165.12762451171875))
                if game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Beautiful Pirate").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                end
            end)
        end
    end
end)
Tabs.ITM:AddToggle("ToggleAutoMusketeerHat", {
    ["Title"] = "Auto Get Musketeer Hat",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_MusketeerHat = state
end)
UIOptions.ToggleAutoMusketeerHat:SetValue(false)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Auto_MusketeerHat then
                if game:GetService("Players").LocalPlayer.Data.Level.Value < 1800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits ~= false then
                    if game:GetService("Players").LocalPlayer.Data.Level.Value < 1800 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss ~= false then
                        if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1800 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
                            Tween(CFrame.new(- 12512.138671875, 340.39279174805, - 9872.8203125))
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                            for v650, captainElephantMob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if captainElephantMob.Name == "Captain Elephant" then
                                    OldCFrameElephant = captainElephantMob.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        pcall(function()
                                            EquipTool(SelectWeapon)
                                            AutoHaki()
                                            captainElephantMob.HumanoidRootPart.CanCollide = false
                                            captainElephantMob.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                            Tween(captainElephantMob.HumanoidRootPart.CFrame * Pos)
                                            captainElephantMob.HumanoidRootPart.CanCollide = false
                                            captainElephantMob.HumanoidRootPart.CFrame = OldCFrameElephant
                                            AttackNoCoolDown()
                                        end)
                                    until _G.Auto_MusketeerHat == false or (captainElephantMob.Humanoid.Health <= 0 or not captainElephantMob.Parent) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        else
                            Tween(CFrame.new(- 13374.889648438, 421.27752685547, - 8225.208984375))
                        end
                    else
                        Tween(CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125))
                        if (CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
                        end
                    end
                elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true) then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Forest Pirate") then
                        for v654, forestPirateMob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if forestPirateMob.Name == "Forest Pirate" then
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    pcall(function()
                                        EquipTool(SelectWeapon)
                                        AutoHaki()
                                        forestPirateMob.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        Tween(forestPirateMob.HumanoidRootPart.CFrame * Pos)
                                        forestPirateMob.HumanoidRootPart.CanCollide = false
                                        AttackNoCoolDown()
                                        PosMon = forestPirateMob.HumanoidRootPart.CFrame
                                        MonFarm = forestPirateMob.Name
                                        bringmob = true
                                    end)
                                until _G.Auto_MusketeerHat == false or (not forestPirateMob.Parent or forestPirateMob.Humanoid.Health <= 0) or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                bringmob = false
                            end
                        end
                    else
                        bringmob = false
                        Tween(CFrame.new(- 13206.452148438, 425.89199829102, - 7964.5537109375))
                    end
                else
                    Tween(CFrame.new(- 12443.8671875, 332.40396118164, - 7675.4892578125))
                    if (Vector3.new(- 12443.8671875, 332.40396118164, - 7675.4892578125) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
                    end
                end
            end
        end
    end)
end)
Tabs.ITM:AddToggle("ToggleAutoObservationV2", {
    ["Title"] = "Auto Get Observation Haki V2",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_ObservationV2 = state
end)
UIOptions.ToggleAutoObservationV2:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_ObservationV2 then
                if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") ~= 3 then
                    _G.Auto_MusketeerHat = true
                else
                    _G.Auto_MusketeerHat = false
                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Banana") and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Apple") and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pineapple")) then
                        repeat
                            Tween(CFrame.new(- 12444.78515625, 332.40396118164, - 7673.1806640625))
                            wait()
                        until not _G.Auto_ObservationV2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 12444.78515625, 332.40396118164, - 7673.1806640625)).Magnitude <= 10
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
                    elseif game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Fruit Bowl") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Fruit Bowl") then
                        repeat
                            Tween(CFrame.new(- 10920.125, 624.20275878906, - 10266.995117188))
                            wait()
                        until not _G.Auto_ObservationV2 or (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(- 10920.125, 624.20275878906, - 10266.995117188)).Magnitude <= 10
                        wait(0.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Start")
                        wait(1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
                    else
                        for v659, v660 in pairs(game:GetService("Workspace"):GetDescendants()) do
                            if v660.Name == "Apple" or (v660.Name == "Banana" or v660.Name == "Pineapple") then
                                v660.Handle.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
                                wait()
                                firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, v660.Handle, 0)
                                wait()
                            end
                        end
                    end
                end
            end
        end)
    end
end)
Tabs.ITM:AddToggle("ToggleAutoRainbowHaki", {
    ["Title"] = "Auto Get Rainbow Haki",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_RainbowHaki = state
end)
UIOptions.ToggleAutoRainbowHaki:SetValue(false)
spawn(function()
    pcall(function()
        while wait(0.1) do
            if _G.Auto_RainbowHaki then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Stone") then
                            for v664, v665 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v665.Name == "Stone" then
                                    OldCFrameRainbow = v665.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        EquipTool(SelectWeapon)
                                        Tween(v665.HumanoidRootPart.CFrame * Pos)
                                        v665.HumanoidRootPart.CanCollide = false
                                        v665.HumanoidRootPart.CFrame = OldCFrameRainbow
                                        v665.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        AttackNoCoolDown()
                                    until not _G.Auto_RainbowHaki or (v665.Humanoid.Health <= 0 or not v665.Parent) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                end
                            end
                        else
                            Tween(CFrame.new(- 1086.11621, 38.8425903, 6768.71436))
                        end
                    elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Hydra Leader") then
                            for v668, v669 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v669.Name == "Hydra Leader" then
                                    OldCFrameRainbow = v669.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        EquipTool(SelectWeapon)
                                        Tween(v669.HumanoidRootPart.CFrame * Pos)
                                        v669.HumanoidRootPart.CanCollide = false
                                        v669.HumanoidRootPart.CFrame = OldCFrameRainbow
                                        v669.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        AttackNoCoolDown()
                                    until not _G.Auto_RainbowHaki or (v669.Humanoid.Health <= 0 or not v669.Parent) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                end
                            end
                        else
                            Tween(CFrame.new(5713.98877, 601.922974, 202.751251))
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Kilo Admiral") then
                            for v672, v673 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v673.Name == "Kilo Admiral" then
                                    OldCFrameRainbow = v673.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        EquipTool(SelectWeapon)
                                        Tween(v673.HumanoidRootPart.CFrame * Pos)
                                        v673.HumanoidRootPart.CanCollide = false
                                        v673.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v673.HumanoidRootPart.CFrame = OldCFrameRainbow
                                        AttackNoCoolDown()
                                    until not _G.Auto_RainbowHaki or (v673.Humanoid.Health <= 0 or not v673.Parent) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                end
                            end
                        else
                            Tween(CFrame.new(2877.61743, 423.558685, - 7207.31006))
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Captain Elephant") then
                            for v676, v677 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v677.Name == "Captain Elephant" then
                                    OldCFrameRainbow = v677.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        EquipTool(SelectWeapon)
                                        Tween(v677.HumanoidRootPart.CFrame * Pos)
                                        v677.HumanoidRootPart.CanCollide = false
                                        v677.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v677.HumanoidRootPart.CFrame = OldCFrameRainbow
                                        AttackNoCoolDown()
                                    until not _G.Auto_RainbowHaki or (v677.Humanoid.Health <= 0 or not v677.Parent) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                end
                            end
                        else
                            Tween(CFrame.new(- 13485.0283, 331.709259, - 8012.4873))
                        end
                    elseif string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Beautiful Pirate") then
                            for v680, v681 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v681.Name == "Beautiful Pirate" then
                                    OldCFrameRainbow = v681.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        EquipTool(SelectWeapon)
                                        Tween(v681.HumanoidRootPart.CFrame * Pos)
                                        v681.HumanoidRootPart.CanCollide = false
                                        v681.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v681.HumanoidRootPart.CFrame = OldCFrameRainbow
                                        AttackNoCoolDown()
                                    until not _G.Auto_RainbowHaki or (v681.Humanoid.Health <= 0 or not v681.Parent) or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                                end
                            end
                        else
                            Tween(CFrame.new(5312.3598632813, 20.141201019287, - 10.158538818359))
                        end
                    else
                        Tween(CFrame.new(- 11892.0703125, 930.57672119141, - 8760.1591796875))
                        if (Vector3.new(- 11892.0703125, 930.57672119141, - 8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                        end
                    end
                else
                    Tween(CFrame.new(- 11892.0703125, 930.57672119141, - 8760.1591796875))
                    if (Vector3.new(- 11892.0703125, 930.57672119141, - 8760.1591796875) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 30 then
                        wait(1.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("HornedMan", "Bet")
                    end
                end
            end
        end
    end)
end)
Tabs.ITM:AddToggle("ToggleAutoSkullGuitar", {
    ["Title"] = "Auto Skull Guitar",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_SkullGuitar = state
end)
UIOptions.ToggleAutoSkullGuitar:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_SkullGuitar and GetWeaponInventory("Skull Guitar") == false then
                if (CFrame.new(- 9681.458984375, 6.139880657196045, 6341.3720703125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5000 then
                    Tween(CFrame.new(- 9681.458984375, 6.139880657196045, 6341.3720703125))
                elseif game:GetService("Workspace").NPCs:FindFirstChild("Skeleton Machine") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
                elseif game:GetService("Workspace").Map["Haunted Castle"].Candle1.Transparency ~= 0 then
                    if string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2), "Error") then
                        Tween(CFrame.new(- 8653.2060546875, 140.98487854003906, 6160.033203125))
                    elseif string.find(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2), "Nothing") then
                        Tween("Wait Full Moon")
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
                    end
                elseif game:GetService("Workspace").Map["Haunted Castle"].Placard1.Left.Part.Transparency ~= 0 then
                    if game:GetService("Workspace").Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector") then
                        if game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part1:FindFirstChild("ClickDetector") then
                            Quest4 = true
                            repeat
                                wait()
                                Tween(CFrame.new(- 9553.5986328125, 65.62338256835938, 6041.58837890625))
                            until (CFrame.new(- 9553.5986328125, 65.62338256835938, 6041.58837890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_SkullGuitar
                            wait(1)
                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
                            wait(1)
                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
                            wait(1)
                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
                            wait(1)
                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
                            wait(1)
                            Tween(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                            wait(1)
                            fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
                        else
                            Quest3 = true
                        end
                    else
                        if game:GetService("Workspace").NPCs:FindFirstChild("Ghost") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                                "GuitarPuzzleProgress",
                                "Ghost"
                            }))
                        end
                        if game.Workspace.Enemies:FindFirstChild("Living Zombie") then
                            for v685, v686 in pairs(game.Workspace.Enemies:GetChildren()) do
                                if v686:FindFirstChild("HumanoidRootPart") and (v686:FindFirstChild("Humanoid") and (v686.Humanoid.Health > 0 and v686.Name == "Living Zombie")) then
                                    EquipTool(SelectWeapon)
                                    v686.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v686.HumanoidRootPart.Transparency = 1
                                    v686.Humanoid.JumpPower = 0
                                    v686.Humanoid.WalkSpeed = 0
                                    v686.HumanoidRootPart.CanCollide = false
                                    v686.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                                    Tween(CFrame.new(- 10160.787109375, 138.6616973876953, 5955.03076171875))
                                    game:GetService("VirtualUser"):CaptureController()
                                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                end
                            end
                        else
                            Tween(CFrame.new(- 10160.787109375, 138.6616973876953, 5955.03076171875))
                        end
                    end
                else
                    Quest2 = true
                    repeat
                        wait()
                        Tween(CFrame.new(- 8762.69140625, 176.84783935546875, 6171.3076171875))
                    until (CFrame.new(- 8762.69140625, 176.84783935546875, 6171.3076171875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_SkullGuitar
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard7.Left.ClickDetector)
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard6.Left.ClickDetector)
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard5.Left.ClickDetector)
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard4.Right.ClickDetector)
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard3.Left.ClickDetector)
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard2.Right.ClickDetector)
                    wait(1)
                    fireclickdetector(game:GetService("Workspace").Map["Haunted Castle"].Placard1.Right.ClickDetector)
                    wait(1)
                end
            end
        end)
    end
end)
Tabs.ITM:AddToggle("ToggleAutoBuddy", {
    ["Title"] = "Auto Get Buddy Sword",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Buddy = state
end)
UIOptions.ToggleAutoBuddy:SetValue(false)
local tikiOutpostCFrame = CFrame.new(- 731.2034301757812, 381.5658874511719, - 11198.4951171875)
spawn(function()
    while wait() do
        if _G.Auto_Buddy then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                    for v691, v692 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v692.Name == "Cake Queen" and (v692:FindFirstChild("Humanoid") and (v692:FindFirstChild("HumanoidRootPart") and v692.Humanoid.Health > 0)) then
                            repeat
                                task.wait(_G.Fast_Delay)
                                AutoHaki()
                                EquipTool(SelectWeapon)
                                v692.HumanoidRootPart.CanCollide = false
                                v692.Humanoid.WalkSpeed = 0
                                v692.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                Tween(v692.HumanoidRootPart.CFrame * Pos)
                                AttackNoCoolDown()
                            until not _G.Auto_Buddy or (not v692.Parent or v692.Humanoid.Health <= 0)
                        end
                    end
                elseif (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - tikiOutpostCFrame.Position).Magnitude < 1500 then
                    Tween(tikiOutpostCFrame)
                end
                Tween(CFrame.new(- 731.2034301757812, 381.5658874511719, - 11198.4951171875))
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen") then
                    Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                end
            end)
        end
    end
end)
Tabs.ITM:AddToggle("ToggleAutoDualKatana", {
    ["Title"] = "Auto Get Cursed Dual Katana",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_DualKatana = state
end)
UIOptions.ToggleAutoDualKatana:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_DualKatana then
                if game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or (game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") or (game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama"))) then
                    if game.Players.LocalPlayer.Character:FindFirstChild("Tushita") or game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Tushita") then
                            EquipTool("Tushita")
                        end
                    elseif (game.Players.LocalPlayer.Character:FindFirstChild("Yama") or game.Players.LocalPlayer.Backpack:FindFirstChild("Yama")) and game.Players.LocalPlayer.Backpack:FindFirstChild("Yama") then
                        EquipTool("Yama")
                    end
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Tushita")
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_DualKatana then
                if GetMaterial("Alucard Fragment") ~= 0 then
                    if GetMaterial("Alucard Fragment") ~= 1 then
                        if GetMaterial("Alucard Fragment") ~= 2 then
                            if GetMaterial("Alucard Fragment") ~= 3 then
                                if GetMaterial("Alucard Fragment") ~= 4 then
                                    if GetMaterial("Alucard Fragment") ~= 5 then
                                        if GetMaterial("Alucard Fragment") == 6 then
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or game:GetService("Workspace").ReplicatedStorage:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") then
                                                Auto_Quest_Yama_1 = false
                                                Auto_Quest_Yama_2 = false
                                                Auto_Quest_Yama_3 = false
                                                Auto_Quest_Tushita_1 = false
                                                Auto_Quest_Tushita_2 = false
                                                Auto_Quest_Tushita_3 = false
                                                if game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton Boss [Lv. 2025] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") then
                                                    for v696, v697 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                        if (v697.Name == "Cursed Skeleton Boss" or v697.Name == "Cursed Skeleton") and v697.Humanoid.Health > 0 then
                                                            EquipTool(Sword)
                                                            Tween(v697.HumanoidRootPart.CFrame * pos)
                                                            v697.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                                            v697.HumanoidRootPart.Transparency = 1
                                                            v697.Humanoid.JumpPower = 0
                                                            v697.Humanoid.WalkSpeed = 0
                                                            v697.HumanoidRootPart.CanCollide = false
                                                            bringmob = true
                                                            FarmPos = v697.HumanoidRootPart.CFrame
                                                            MonFarm = v697.Name
                                                            AttackNoCoolDown()
                                                        end
                                                    end
                                                end
                                            elseif (CFrame.new(- 12361.7060546875, 603.3547973632812, - 6550.5341796875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 100 then
                                                Tween(CFrame.new(- 12361.7060546875, 603.3547973632812, - 6550.5341796875))
                                            else
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
                                                wait(1)
                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
                                                wait(1)
                                                Tween(CFrame.new(- 12361.7060546875, 603.3547973632812, - 6550.5341796875))
                                                wait(1.5)
                                                game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                                                wait(1.5)
                                                Tween(CFrame.new(- 12253.5419921875, 598.8999633789062, - 6546.8388671875))
                                            end
                                        end
                                    else
                                        Auto_Quest_Yama_1 = false
                                        Auto_Quest_Yama_2 = false
                                        Auto_Quest_Yama_3 = false
                                        Auto_Quest_Tushita_1 = false
                                        Auto_Quest_Tushita_2 = false
                                        Auto_Quest_Tushita_3 = true
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
                                    end
                                else
                                    Auto_Quest_Yama_1 = false
                                    Auto_Quest_Yama_2 = false
                                    Auto_Quest_Yama_3 = false
                                    Auto_Quest_Tushita_1 = false
                                    Auto_Quest_Tushita_2 = true
                                    Auto_Quest_Tushita_3 = false
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
                                end
                            else
                                Auto_Quest_Yama_1 = false
                                Auto_Quest_Yama_2 = false
                                Auto_Quest_Yama_3 = false
                                Auto_Quest_Tushita_1 = true
                                Auto_Quest_Tushita_2 = false
                                Auto_Quest_Tushita_3 = false
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
                            end
                        else
                            Auto_Quest_Yama_1 = false
                            Auto_Quest_Yama_2 = false
                            Auto_Quest_Yama_3 = true
                            Auto_Quest_Tushita_1 = false
                            Auto_Quest_Tushita_2 = false
                            Auto_Quest_Tushita_3 = false
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
                        end
                    else
                        Auto_Quest_Yama_1 = false
                        Auto_Quest_Yama_2 = true
                        Auto_Quest_Yama_3 = false
                        Auto_Quest_Tushita_1 = false
                        Auto_Quest_Tushita_2 = false
                        Auto_Quest_Tushita_3 = false
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
                    end
                else
                    Auto_Quest_Yama_1 = true
                    Auto_Quest_Yama_2 = false
                    Auto_Quest_Yama_3 = false
                    Auto_Quest_Tushita_1 = false
                    Auto_Quest_Tushita_2 = false
                    Auto_Quest_Tushita_3 = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Yama_1 then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild("Mythological Pirate") then
                    for v700, v701 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v701.Name == "Mythological Pirate" then
                            repeat
                                wait()
                                Tween(v701.HumanoidRootPart.CFrame * CFrame.new(0, 0, - 2))
                            until _G.Auto_DualKatana == false or Auto_Quest_Yama_1 == false
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
                        end
                    end
                else
                    Tween(CFrame.new(- 13451.46484375, 543.712890625, - 6961.0029296875))
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            if Auto_Quest_Yama_2 then
                for v704, v705 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if v705:FindFirstChild("HazeESP") then
                        v705.HazeESP.Size = UDim2.new(50, 50, 50, 50)
                        v705.HazeESP.MaxDistance = "inf"
                    end
                end
                for v708, v709 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                    if v709:FindFirstChild("HazeESP") then
                        v709.HazeESP.Size = UDim2.new(50, 50, 50, 50)
                        v709.HazeESP.MaxDistance = "inf"
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        pcall(function()
            for v712, v713 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if Auto_Quest_Yama_2 and (v713:FindFirstChild("HazeESP") and (v713.HumanoidRootPart.Position - FarmPossEsp.Position).magnitude <= 300) then
                    v713.HumanoidRootPart.CFrame = FarmPossEsp
                    v713.HumanoidRootPart.CanCollide = false
                    v713.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                    if not v713.HumanoidRootPart:FindFirstChild("BodyVelocity") then
                        local v714 = Instance.new("BodyVelocity", v713.HumanoidRootPart)
                        v714.MaxForce = Vector3.new(1, 1, 1) * math.huge
                        v714.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Yama_2 then
            pcall(function()
                local v715, v716, v717 = pairs(game:GetService("Workspace").Enemies:GetChildren())
                while true do
                    while true do
                        local v718
                        v717, v718 = v715(v716, v717)
                        if v717 == nil then
                            return
                        end
                        if v718:FindFirstChild("HazeESP") then
                            break
                        end
                        for v721, v722 in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                            if v722:FindFirstChild("HazeESP") then
                                if (v722.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
                                    Tween(v722.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                                else
                                    Tween(v722.HumanoidRootPart.CFrameMon * CFrame.new(2, 20, 2))
                                end
                            end
                        end
                    end
                    if true then
                        wait()
                        if (v718.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2000 then
                            EquipTool(Sword)
                            Tween(v718.HumanoidRootPart.CFrame * Pos)
                            v718.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v718.HumanoidRootPart.Transparency = 1
                            v718.Humanoid.JumpPower = 0
                            v718.Humanoid.WalkSpeed = 0
                            v718.HumanoidRootPart.CanCollide = false
                            FarmPos = v718.HumanoidRootPart.CFrame
                            MonFarm = v718.Name
                            AttackNoCoolDown()
                            if v718.Humanoid.Health <= 0 and v718.Humanoid:FindFirstChild("Animator") then
                                v718.Humanoid.Animator:Destroy()
                            end
                        else
                            Tween(v718.HumanoidRootPart.CFrame * Pos)
                        end
                    end
                    if _G.Auto_DualKatana ~= false and (Auto_Quest_Yama_2 ~= false and (v718.Parent and (v718.Humanoid.Health > 0 and v718:FindFirstChild("HazeESP")))) then
                        break
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Yama_3 then
            pcall(function()
				
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") then
                    Tween(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
					
                end
                if not game:GetService("Workspace").Map:FindFirstChild("HellDimension") then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") or game.ReplicatedStorage:FindFirstChild("Soul Reaper [Lv. 2100] [Raid Boss]") then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Soul Reaper") then
                            for v725, v726 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v726.Name == "Soul Reaper" and v726.Humanoid.Health > 0 then
                                    repeat
                                        wait()
                                        Tween(v726.HumanoidRootPart.CFrame * Pos)
                                    until _G.Auto_DualKatana == false or Auto_Quest_Yama_3 == false or game:GetService("Workspace").Map:FindFirstChild("HellDimension")
                                end
                            end
                        else
                            Tween(CFrame.new(- 9570.033203125, 315.9346923828125, 6726.89306640625))
                        end
                    else
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
                    end
					
                    return
                end
				
				
                wait()
                if not (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Hell\'s Messenger [Lv. 2200] [Boss]"))) then
                    wait(5)
                    Tween(game:GetService("Workspace").Map.HellDimension.Torch1.CFrame)
                    wait(1.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    wait(1.5)
                    Tweem(game:GetService("Workspace").Map.HellDimension.Torch2.CFrame)
                    wait(1.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    wait(1.5)
                    Tween(game:GetService("Workspace").Map.HellDimension.Torch3.CFrame)
                    wait(1.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    wait(1.5)
                    Tween(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
					
                end
                local v727, v728, v729 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				
				
				
				
                local v730
                v729, v730 = v727(v728, v729)
                if v729 == nil then
					
                end
                if v730.Name ~= "Cursed Skeleton" and (v730.Name ~= "Cursed Skeleton" and v730.Name ~= "Hell\'s Messenger") or v730.Humanoid.Health <= 0 then
					
                end
				
                wait()
                EquipTool(Sword)
                Tween(v730.HumanoidRootPart.CFrame * Pos)
                v730.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                v730.HumanoidRootPart.Transparency = 1
                v730.Humanoid.JumpPower = 0
                v730.Humanoid.WalkSpeed = 0
                v730.HumanoidRootPart.CanCollide = false
                FarmPos = v730.HumanoidRootPart.CFrame
                MonFarm = v730.Name
                AttackNoCoolDown()
                if v730.Humanoid.Health <= 0 and v730.Humanoid:FindFirstChild("Animator") then
                    v730.Humanoid.Animator:Destroy()
                end
                if v730.Humanoid.Health <= 0 or (not v730.Parent or Auto_Quest_Yama_3 == false) then
					
                else
					
                end
				
                if _G.Auto_DualKatana == false or (Auto_Quest_Yama_3 == false or GetMaterial("Alucard Fragment") == 3) then
					
                end
				
                if true then
					
                else
					
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_1 then
            Tween(CFrame.new(- 9546.990234375, 21.139892578125, 4686.1142578125))
            wait(5)
            Tween(CFrame.new(- 6120.0576171875, 16.455780029296875, - 2250.697265625))
            wait(5)
            Tween(CFrame.new(- 9533.2392578125, 7.254445552825928, - 8372.69921875))
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_2 then
            pcall(function()
				
                if (CFrame.new(- 5539.3115234375, 313.800537109375, - 2972.372314453125).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                    Tween(CFrame.new(- 5545.1240234375, 313.800537109375, - 2976.616455078125))
					
                    return
                end
                local v731, v732, v733 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				
				
				
				
                wait()
                EquipTool(Sword)
                Tween(v734.HumanoidRootPart.CFrame * Pos)
                v734.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                v734.HumanoidRootPart.Transparency = 1
                v734.Humanoid.JumpPower = 0
                v734.Humanoid.WalkSpeed = 0
                v734.HumanoidRootPart.CanCollide = false
                FarmPos = v734.HumanoidRootPart.CFrame
                MonFarm = v734.Name
                AttackNoCoolDown()
                if v734.Humanoid.Health <= 0 and v734.Humanoid:FindFirstChild("Animator") then
                    v734.Humanoid.Animator:Destroy()
                end
                if v734.Humanoid.Health > 0 and (v734.Parent and Auto_Quest_Tushita_2 ~= false) then
					
                end
				
                local v734
                v733, v734 = v731(v732, v733)
                if v733 == nil then
					
                end
                if Auto_Quest_Tushita_2 and (v734:FindFirstChild("HumanoidRootPart") and (v734:FindFirstChild("Humanoid") and (v734.Humanoid.Health > 0 and (v734.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 2000))) then
					
                else
					
                end
            end)
        end
    end
end)
spawn(function()
    while wait() do
        if Auto_Quest_Tushita_3 then
            pcall(function()
				
                if not (game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") or game.ReplicatedStorage:FindFirstChild("Cake Queen [Lv. 2175] [Boss]")) then
					
                end
                if not game:GetService("Workspace").Enemies:FindFirstChild("Cake Queen") then
                    Tween(CFrame.new(- 709.3132934570312, 381.6005859375, - 11011.396484375))
					
                end
                local v735, v736, v737 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				
                local v738
                v737, v738 = v735(v736, v737)
                if v737 == nil then
					
                end
                if v738.Name ~= "Cake Queen" or v738.Humanoid.Health <= 0 then
					
                end
                while true do
                    wait()
                    EquipTool(Sword)
                    Tween(v738.HumanoidRootPart.CFrame * Pos)
                    v738.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    v738.HumanoidRootPart.Transparency = 1
                    v738.Humanoid.JumpPower = 0
                    v738.Humanoid.WalkSpeed = 0
                    v738.HumanoidRootPart.CanCollide = false
                    FarmPos = v738.HumanoidRootPart.CFrame
                    MonFarm = v738.Name
                    AttackNoCoolDown()
                    if v738.Humanoid.Health <= 0 and v738.Humanoid:FindFirstChild("Animator") then
                        v738.Humanoid.Animator:Destroy()
                    end
                    if _G.Auto_DualKatana == false or Auto_Quest_Tushita_3 == false or game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") then
						
                    end
                end
				
				
				
                local v739, v740 = v741(v742, v739)
                if v739 == nil then
					
                end
                if v740.Name ~= "Cursed Skeleton" and (v740.Name ~= "Cursed Skeleton" and v740.Name ~= "Heaven\'s Guardian") or v740.Humanoid.Health <= 0 then
					
                end
				
                wait()
                EquipTool(Sword)
                Tween(v740.HumanoidRootPart.CFrame * Pos)
                v740.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                v740.HumanoidRootPart.Transparency = 1
                v740.Humanoid.JumpPower = 0
                v740.Humanoid.WalkSpeed = 0
                v740.HumanoidRootPart.CanCollide = false
                FarmPos = v740.HumanoidRootPart.CFrame
                MonFarm = v740.Name
                AttackNoCoolDown()
                if v740.Humanoid.Health <= 0 and v740.Humanoid:FindFirstChild("Animator") then
                    v740.Humanoid.Animator:Destroy()
                end
                if v740.Humanoid.Health <= 0 or (not v740.Parent or Auto_Quest_Tushita_3 == false) then
					
                else
					
                end
				
                if not _G.Auto_DualKatana or (not Auto_Quest_Tushita_3 or GetMaterial("Alucard Fragment") == 6) then
					
                end
				
                if true then
					
                else
					
                end
				
                wait()
                if not (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200]") or (game:GetService("Workspace").Enemies:FindFirstChild("Cursed Skeleton [Lv. 2200] [Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Heaven\'s Guardian [Lv. 2200] [Boss]"))) then
                    wait(5)
                    Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch1.CFrame)
                    wait(1.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    wait(1.5)
                    Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch2.CFrame)
                    wait(1.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    wait(1.5)
                    Tween(game:GetService("Workspace").Map.HeavenlyDimension.Torch3.CFrame)
                    wait(1.5)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    wait(1.5)
                    Tween(game:GetService("Workspace").Map.HeavenlyDimension.Exit.CFrame)
					
                end
                local v741, v742
                v741, v742, v739 = pairs(game:GetService("Workspace").Enemies:GetChildren())
				
				
                if not game:GetService("Workspace").Map:FindFirstChild("HeavenlyDimension") then
					
                    return
                end
				
            end)
        end
    end
end)
if Sea2 then
    Tabs.ITM:AddToggle("ToggleFactory", {
        ["Title"] = "Auto Factory",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.Factory = state
    end)
    UIOptions.ToggleFactory:SetValue(false)
    spawn(function()
		
        while true do
            repeat
                if not wait() then
                    return
                end
            until _G.Factory
            if game.Workspace.Enemies:FindFirstChild("Core") then
                break
            end
            if game.ReplicatedStorage:FindFirstChild("Core") then
                Tween(CFrame.new(448.46756, 199.356781, - 441.389252))
                wait()
                if _G.Factory and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, - 441.389252)).Magnitude > 10 then
                    break
                end
            end
        end
        local v744, v745, v746 = pairs(game.Workspace.Enemies:GetChildren())
		
		
		
		
        if v747.Name == "Core" and v747.Humanoid.Health > 0 then
			
        end
		
        local v747
        v746, v747 = v744(v745, v746)
        if v746 ~= nil then
			
        end
		
		
        wait(_G.Fast_Delay)
        AttackNoCoolDown()
        repeat
            Tween(CFrame.new(448.46756, 199.356781, - 441.389252))
            wait()
        until not _G.Factory or (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(448.46756, 199.356781, - 441.389252)).Magnitude <= 10
        EquipTool(SelectWeapon)
        AutoHaki()
        Tween(v747.HumanoidRootPart.CFrame * Pos)
        v747.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
        v747.HumanoidRootPart.Transparency = 1
        v747.Humanoid.JumpPower = 0
        v747.Humanoid.WalkSpeed = 0
        v747.HumanoidRootPart.CanCollide = false
        FarmPos = v747.HumanoidRootPart.CFrame
        MonFarm = v747.Name
        if v747.Parent and (v747.Humanoid.Health > 0 and _G.Factory ~= false) then
			
        end
		
		
		
    end)
end
Tabs.ITM:AddToggle("ToggleAutoFarmSwan", {
    ["Title"] = "Auto Defeat Don Swan",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_FarmSwan = state
end)
UIOptions.ToggleAutoFarmSwan:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoFarmSwan then
                if game:GetService("Workspace").Enemies:FindFirstChild("Don Swan") then
                    for v751, donSwanBossMob in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if donSwanBossMob.Name == "Don Swan" and (donSwanBossMob.Humanoid.Health > 0 and (donSwanBossMob:IsA("Model") and (donSwanBossMob:FindFirstChild("Humanoid") and donSwanBossMob:FindFirstChild("HumanoidRootPart")))) then
                            repeat
                                task.wait()
                                pcall(function()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    donSwanBossMob.HumanoidRootPart.CanCollide = false
                                    donSwanBossMob.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                    Tween(donSwanBossMob.HumanoidRootPart.CFrame * Pos)
                                    AttackNoCoolDown()
                                end)
                            until _G.AutoFarmSwan == false or donSwanBossMob.Humanoid.Health <= 0
                        end
                    end
                else
                    task.wait()
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.537666320801, 905.48291015625))
                    if (CFrame.new(2284.912109375, 15.537666320801, 905.48291015625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 4 and _G.AutoFarmSwan ~= false then
                        break
                    end
                end
            end
        end
    end)
end)
Tabs.ITM:AddToggle("ToggleAutoRengoku", {
    ["Title"] = "Auto Get Rengoku",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Regoku = state
end)
UIOptions.ToggleAutoRengoku:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.Auto_Regoku then
                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Hidden Key") then
                    EquipTool("Hidden Key")
                    Tween(CFrame.new(6571.1201171875, 299.23028564453, - 6967.841796875))
                elseif game:GetService("Workspace").Enemies:FindFirstChild("Snow Lurker") or game:GetService("Workspace").Enemies:FindFirstChild("Arctic Warrior") then
                    for v756, v757 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v757.Name == "Snow Lurker" or v757.Name == "Arctic Warrior") and v757.Humanoid.Health > 0 then
                            repeat
                                task.wait(_G.Fast_Delay)
                                EquipTool(SelectWeapon)
                                AutoHaki()
                                v757.HumanoidRootPart.CanCollide = false
                                v757.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                FarmPos = v757.HumanoidRootPart.CFrame
                                MonFarm = v757.Name
                                Tween(v757.HumanoidRootPart.CFrame * Pos)
                                AttackNoCoolDown()
                                bringmob = true
                            until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Hidden Key") or (_G.Auto_Regoku == false or (not v757.Parent or v757.Humanoid.Health <= 0))
                            bringmob = false
                        end
                    end
                else
                    bringmob = false
                    Tween(CFrame.new(5439.716796875, 84.420944213867, - 6715.1635742188))
                end
            end
        end
    end)
end)
if Sea2 or Sea3 then
    Tabs.ITM:AddToggle("ToggleHakiColor", {
        ["Title"] = "Buy Color Haki",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.Auto_Buy_Enchancement = state
    end)
    UIOptions.ToggleHakiColor:SetValue(false)
    spawn(function()
        while wait() do
            if _G.Auto_Buy_Enchancement then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "ColorsDealer",
                    "2"
                }))
            end
        end
    end)
end
if Sea2 then
    Tabs.Main:AddToggle("ToggleSwordLengend", {
        ["Title"] = "Auto Buy Legendary Sword",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.BuyLengendSword = state
    end)
    UIOptions.ToggleSwordLengend:SetValue(false)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.BuyLengendSword or Triple_A then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "LegendarySwordDealer",
                        "2"
                    }))
                else
                    wait()
                end
            end)
        end
    end)
end
if Sea2 then
    Tabs.Main:AddToggle("ToggleEvoRace", {
        ["Title"] = "Auto Upgrade Race V2",
        ["Description"] = "",
        ["Default"] = false
    }):OnChanged(function(state)
        _G.AutoEvoRace = state
    end)
    UIOptions.ToggleEvoRace:SetValue(false)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.AutoEvoRace and not game:GetService("Players").LocalPlayer.Data.Race:FindFirstChild("Evolved") then
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 0 then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 1 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3")
                            end
                        else
                            pcall(function()
                                if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 1") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 1") then
                                    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 2") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 2") then
                                        if not (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flower 3")) then
                                            if game:GetService("Workspace").Enemies:FindFirstChild("Zombie") then
                                                for v763, v764 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                                    if v764.Name == "Zombie" then
                                                        repeat
                                                            task.wait(_G.Fast_Delay)
                                                            AutoHaki()
                                                            EquipTool(SelectWeapon)
                                                            Tween(v764.HumanoidRootPart.CFrame * Pos)
                                                            v764.HumanoidRootPart.CanCollide = false
                                                            v764.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                                            AttackNoCoolDown()
                                                            FarmPos = v764.HumanoidRootPart.CFrame
                                                            MonFarm = v764.Name
                                                            bringmob = true
                                                        until game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flower 3") or (not v764.Parent or (v764.Humanoid.Health <= 0 or _G.AutoEvoRace == false))
                                                        bringmob = false
                                                    end
                                                end
                                            else
                                                Tween(CFrame.new(- 5685.9233398438, 48.480125427246, - 853.23724365234))
                                            end
                                        end
                                    else
                                        Tween(game:GetService("Workspace").Flower2.CFrame)
                                    end
                                else
                                    Tween(game:GetService("Workspace").Flower1.CFrame)
                                end
                            end)
                        end
                    else
                        Tween(CFrame.new(- 2779.83521, 72.9661407, - 3574.02002, - 0.730484903, 6.390141e-8, - 0.68292886, 3.5996322e-8, 1, 5.5066703e-8, 0.68292886, 1.5642467e-8, - 0.730484903))
                        if (Vector3.new(- 2779.83521, 72.9661407, - 3574.02002) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                            wait(1.3)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "2")
                        end
                    end
                end
            end
        end)
    end)
end
Tabs.Setting:AddToggle("ToggleAutoT", {
    ["Title"] = "Auto Activate Race V3",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoT = state
end)
UIOptions.ToggleAutoT:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoT then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
            end
        end)
    end
end)
Tabs.Setting:AddToggle("ToggleAutoY", {
    ["Title"] = "Auto Activate Race V4",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoY = state
end)
UIOptions.ToggleAutoY:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoY then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)
                wait()
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "Y", false, game)
            end
        end)
    end
end)
Tabs.Setting:AddToggle("ToggleAutoKen", {
    ["Title"] = "Auto Enable Ken",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoKen = state
    if state then
        game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
    else
        game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", false)
    end
end)
UIOptions.ToggleAutoKen:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoKen then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
            end
        end)
    end
end)
Tabs.Setting:AddToggle("ToggleSaveSpawn", {
    ["Title"] = "Auto Set Spawn Point",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.SaveSpawn = state
    if state then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "SetSpawnPoint"
        }))
    end
end)
UIOptions.ToggleSaveSpawn:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.SaveSpawn then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "SetSpawnPoint"
                }))
            end
        end)
    end
end)
require(game.ReplicatedStorage.Util.CameraShaker):Stop()
Tabs.Setting:AddToggle("ToggleBringMob", {
    ["Title"] = "Bring Mobs",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    _G.BringMob = state
end)
UIOptions.ToggleBringMob:SetValue(true)
spawn(function()
    while wait() do
        pcall(function()
            for v772, v773 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if _G.BringMob and (bringmob and (v773.Name == MonFarm and (v773:FindFirstChild("Humanoid") and v773.Humanoid.Health > 0))) then
                    if v773.Name ~= "Factory Staff" then
                        if v773.Name == MonFarm and (v773.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000000000 then
                            v773.HumanoidRootPart.CFrame = FarmPos
                            v773.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            v773.HumanoidRootPart.Transparency = 1
                            v773.Humanoid.JumpPower = 0
                            v773.Humanoid.WalkSpeed = 0
                            if v773.Humanoid:FindFirstChild("Animator") then
                                v773.Humanoid.Animator:Destroy()
                            end
                            v773.HumanoidRootPart.CanCollide = false
                            v773.Head.CanCollide = false
                            v773.Humanoid:ChangeState(11)
                            v773.Humanoid:ChangeState(14)
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        end
                    elseif (v773.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000000000 then
                        v773.Head.CanCollide = false
                        v773.HumanoidRootPart.CanCollide = false
                        v773.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        v773.HumanoidRootPart.CFrame = FarmPos
                        if v773.Humanoid:FindFirstChild("Animator") then
                            v773.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                    end
                end
            end
        end)
    end
end)
Tabs.Setting:AddToggle("ToggleRemoveNotify", {
    ["Title"] = "Remove Notifications",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    RemoveNotify = state
end)
UIOptions.ToggleRemoveNotify:SetValue(false)
spawn(function()
    while wait() do
        if RemoveNotify then
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
        else
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
        end
    end
end)
Tabs.Setting:AddToggle("ToggleWhite", {
    ["Title"] = "White Screen",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.WhiteScreen = state
    if _G.WhiteScreen ~= true then
        if _G.WhiteScreen == false then
            game:GetService("RunService"):Set3dRenderingEnabled(true)
        end
    else
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    end
end)
UIOptions.ToggleWhite:SetValue(false)
Tabs.Setting:AddSection("Skill")
Tabs.Setting:AddToggle("ToggleZ", {
    ["Title"] = "Z",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    SkillZ = state
end)
UIOptions.ToggleZ:SetValue(true)
Tabs.Setting:AddToggle("ToggleX", {
    ["Title"] = "X",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    SkillX = state
end)
UIOptions.ToggleX:SetValue(true)
Tabs.Setting:AddToggle("ToggleC", {
    ["Title"] = "C",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    SkillC = state
end)
UIOptions.ToggleC:SetValue(true)
Tabs.Setting:AddToggle("ToggleV", {
    ["Title"] = "V",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    SkillV = state
end)
UIOptions.ToggleV:SetValue(true)
Tabs.Setting:AddToggle("ToggleF", {
    ["Title"] = "F",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    SkillF = state
end)
UIOptions.ToggleF:SetValue(true)
local v781 = Tabs.Status
local v782 = v781
local v783 = v781.AddParagraph
local v784 = {
    ["Title"] = "Information",
    ["Content"] = "━━━━━━━━━━━━━━━━━━━━━\n" .. "Name: " .. game.Players.LocalPlayer.DisplayName .. " (@" .. game.Players.LocalPlayer.Name .. ")\n" .. "Level: " .. game:GetService("Players").LocalPlayer.Data.Level.Value .. "\n" .. "Beli : " .. game:GetService("Players").LocalPlayer.Data.Beli.Value .. "\n" .. "Fragments : " .. game:GetService("Players").LocalPlayer.Data.Fragments.Value .. "\n" .. "Wanted Beli : " .. game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].Value .. "\n" .. "HP: " .. game.Players.LocalPlayer.Character.Humanoid.Health .. "/" .. game.Players.LocalPlayer.Character.Humanoid.MaxHealth .. "\n" .. "Energy : " .. game.Players.LocalPlayer.Character.Energy.Value .. "/" .. game.Players.LocalPlayer.Character.Energy.MaxValue .. "\n" .. "Race : " .. game:GetService("Players").LocalPlayer.Data.Race.Value .. "\n" .. "Fruit : " .. game:GetService("Players").LocalPlayer.Data.DevilFruit.Value .. "\n━━━━━━━━━━━━━━━━━━━━━"
}
v783(v782, v784)
local statusClockParagraph = Tabs.Status:AddParagraph({
    ["Title"] = "Time",
    ["Content"] = ""
})
local function updateClockDisplay()
    local v786 = os.date("*t")
    local v787 = v786.hour % 24
    local v788 = v787 < 12 and "AM" or "PM"
    local v789 = string.format("%02i:%02i:%02i %s", (v787 - 1) % 12 + 1, v786.min, v786.sec, v788)
    local v790 = string.format("%02d/%02d/%04d", v786.day, v786.month, v786.year)
    local LocalizationServiceInstance = game:GetService("LocalizationService")
    local statusLocalPlayerInstance = game:GetService("Players").LocalPlayer
    local _ = statusLocalPlayerInstance.Name
    local v793, v794 = pcall(function()
        return LocalizationServiceInstance:GetCountryRegionForPlayerAsync(statusLocalPlayerInstance)
    end)
    statusClockParagraph:SetDesc(v790 .. "-" .. v789 .. " [ " .. (not v793 and "Unknown" or v794) .. " ]")
end
spawn(function()
    while true do
        updateClockDisplay()
        game:GetService("RunService").RenderStepped:Wait()
    end
end)
local statusUptimeParagraph = Tabs.Status:AddParagraph({
    ["Title"] = "Server Time",
    ["Content"] = ""
})
local function updateUptimeDisplay()
    local v797 = math.floor(workspace.DistributedGameTime + 0.5)
    local v798 = math.floor(v797 / 3600) % 24
    local v799 = math.floor(v797 / 60) % 60
    local v800 = v797 % 60
    statusUptimeParagraph:SetDesc(string.format("%02d Hours-%02d Mins-%02d Secs", v798, v799, v800))
end
spawn(function()
    while task.wait() do
        pcall(updateUptimeDisplay)
    end
end)
local statusLeviathanParagraph = Tabs.Status:AddParagraph({
    ["Title"] = "Leviathan Island",
    ["Content"] = ""
})
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
                statusLeviathanParagraph:SetDesc("✅")
            else
                statusLeviathanParagraph:SetDesc("❌")
            end
        end
    end)
end)
Tabs.Status:AddInput("Input", {
    ["Title"] = "Server ID",
    ["Default"] = "",
    ["Placeholder"] = "",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Callback"] = function(value)
        _G.Job = value
    end
})
Tabs.Status:AddButton({
    ["Title"] = "Join Server ID",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer)
    end
})
Tabs.Status:AddButton({
    ["Title"] = "Copy Server ID",
    ["Description"] = "",
    ["Callback"] = function()
        setclipboard(tostring(game.JobId))
    end
})
Tabs.Status:AddToggle("MyToggle", {
    ["Title"] = "Spam Join Server ID",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Join = state
end)
spawn(function()
    while wait() do
        if _G.Join then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer)
        end
    end
end)
Tabs.Stats:AddToggle("ToggleMelee", {
    ["Title"] = "Melee",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Stats_Melee = state
end)
UIOptions.ToggleMelee:SetValue(false)
Tabs.Stats:AddToggle("ToggleDe", {
    ["Title"] = "Defense",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Stats_Defense = state
end)
UIOptions.ToggleDe:SetValue(false)
Tabs.Stats:AddToggle("ToggleSword", {
    ["Title"] = "Sword",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Stats_Sword = state
end)
UIOptions.ToggleSword:SetValue(false)
Tabs.Stats:AddToggle("ToggleGun", {
    ["Title"] = "Gun",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Stats_Gun = state
end)
UIOptions.ToggleGun:SetValue(false)
Tabs.Stats:AddToggle("ToggleFruit", {
    ["Title"] = "Devil Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Stats_Devil_Fruit = state
end)
UIOptions.ToggleFruit:SetValue(false)
spawn(function()
    while wait() do
        if _G.Auto_Stats_Devil_Fruit then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "AddPoint",
                "Demon Fruit",
                3
            }))
        end
    end
end)
spawn(function()
    while wait() do
        if _G.Auto_Stats_Gun then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "AddPoint",
                "Gun",
                3
            }))
        end
    end
end)
spawn(function()
    while wait() do
        if _G.Auto_Stats_Sword then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "AddPoint",
                "Sword",
                3
            }))
        end
    end
end)
spawn(function()
    while wait() do
        if _G.Auto_Stats_Defense then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "AddPoint",
                "Defense",
                3
            }))
        end
    end
end)
spawn(function()
    while wait() do
        if _G.Auto_Stats_Melee then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                "AddPoint",
                "Melee",
                3
            }))
        end
    end
end)
local v810, v811, v812 = pairs(game:GetService("Players"):GetChildren())
local formatDistance3 = formatMeterDistance
local islandDropdownList = {}
while true do
    local v815
    v812, v815 = v810(v811, v812)
    if v812 == nil then
        break
    end
    table.insert(islandDropdownList, v815.Name)
end
local v816 = Tabs.Player:AddDropdown("SelectedPly", {
    ["Title"] = "Select Player",
    ["Description"] = "",
    ["Values"] = islandDropdownList,
    ["Multi"] = false,
    ["Default"] = 1
})
v816:SetValue(_G.SelectPly)
v816:OnChanged(function(state)
    _G.SelectPly = state
end)
Tabs.Player:AddButton({
    ["Title"] = "Loading",
    ["Description"] = "",
    ["Callback"] = function()
        table.clear(islandDropdownList)
        for v820, v821 in pairs(game:GetService("Players"):GetChildren()) do
            table.insert(islandDropdownList, v821.Name)
        end
    end
})
Tabs.Player:AddToggle("ToggleTeleport", {
    ["Title"] = "Teleport to Player",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.TeleportPly = state
    if state == false then
        wait()
        AutoHaki()
        Tween2(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
    end
end)
UIOptions.ToggleTeleport:SetValue(false)
spawn(function()
    while wait() do
        if _G.TeleportPly then
            pcall(function()
                if game.Players:FindFirstChild(_G.SelectPly) then
                    Tween2(game.Players[_G.SelectPly].Character.HumanoidRootPart.CFrame)
                end
            end)
        end
    end
end)
Tabs.Player:AddSection("Other")
Tabs.Player:AddToggle("ToggleNoClip", {
    ["Title"] = "No Clip",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    _G.LOf = state
end)
UIOptions.ToggleNoClip:SetValue(true)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.LOf then
                for v826, v827 in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v827:IsA("BasePart") then
                        v827.CanCollide = false
                    end
                end
            end
        end)
    end)
end)
Tabs.Player:AddToggle("ToggleWalkonWater", {
    ["Title"] = "Walk on Water",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    _G.WalkonWater = state
end)
UIOptions.ToggleWalkonWater:SetValue(true)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.WalkonWater then
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
            else
                game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
            end
        end)
    end
end)
Tabs.Player:AddToggle("ToggleEnablePvp", {
    ["Title"] = "Auto Enable PVP",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.EnabledPvP = state
end)
UIOptions.ToggleEnablePvp:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.EnabledPvP and game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
            end
        end
    end)
end)
local teleportSeaSection = Tabs.Teleport:AddSection("Sea")
Tabs.Teleport:AddToggle("ToggleAutoSea2", {
    ["Title"] = "Auto Sea 2",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Sea2 = state
end)
UIOptions.ToggleAutoSea2:SetValue(false)
spawn(function()
    while wait() do
        if _G.Auto_Sea2 then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Level.Value >= 700 and World1 then
                    if game:GetService("Workspace").Map.Ice.Door.CanCollide ~= false or game:GetService("Workspace").Map.Ice.Door.Transparency ~= 1 then
                        if game:GetService("Workspace").Map.Ice.Door.CanCollide == false and game:GetService("Workspace").Map.Ice.Door.Transparency == 1 then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral") then
                                for v834, v835 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v835.Name == "Ice Admiral" then
                                        if not v835.Humanoid.Health > 0 then
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                        elseif v835:FindFirstChild("Humanoid") and (v835:FindFirstChild("HumanoidRootPart") and v835.Humanoid.Health > 0) then
                                            OldCFrameSecond = v835.HumanoidRootPart.CFrame
                                            repeat
                                                task.wait(_G.Fast_Delay)
                                                AutoHaki()
                                                EquipTool(SelectWeapon)
                                                v835.HumanoidRootPart.CanCollide = false
                                                v835.Humanoid.WalkSpeed = 0
                                                v835.Head.CanCollide = false
                                                v835.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                                v835.HumanoidRootPart.CFrame = OldCFrameSecond
                                                Tween(v835.HumanoidRootPart.CFrame * Pos)
                                                AttackNoCoolDown()
                                                sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                                            until not _G.Auto_Sea2 or (not v835.Parent or v835.Humanoid.Health <= 0)
                                        end
                                    end
                                end
                            elseif game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral") then
                                Tween(game:GetService("ReplicatedStorage"):FindFirstChild("Ice Admiral").HumanoidRootPart.CFrame * CFrame.new(5, 10, 7))
                            end
                        end
                    else
                        local v836 = CFrame.new(4849.29883, 5.65138149, 719.611877)
                        repeat
                            Tween(v836)
                            wait()
                        until (v836.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.Auto_Sea2 == false
                        wait(1.1)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
                        wait(0.5)
                        EquipTool("Key")
                        repeat
                            Tween(CFrame.new(1347.7124, 37.3751602, - 1325.6488))
                            wait()
                        until (Vector3.new(1347.7124, 37.3751602, - 1325.6488) - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or _G.Auto_Sea2 == false
                        wait(0.5)
                    end
                end
            end)
        end
    end
end)
Tabs.Teleport:AddToggle("ToggleAutoSea3", {
    ["Title"] = "Auto Sea 3",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Sea3 = state
end)
UIOptions.ToggleAutoSea3:SetValue(false)
spawn(function()
    while wait() do
        if _G.AutoSea3 then
            pcall(function()
                if game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500 and World2 then
                    _G.AutoLevel = false
                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "General") == 0 then
                        Tween(CFrame.new(- 1926.3221435547, 12.819851875305, 1738.3092041016))
                        if (CFrame.new(- 1926.3221435547, 12.819851875305, 1738.3092041016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            wait(1.5)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
                        end
                        wait(1.8)
                        if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                            for v840, v841 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if v841.Name == "rip_indra" then
                                    OldCFrameThird = v841.HumanoidRootPart.CFrame
                                    repeat
                                        task.wait(_G.Fast_Delay)
                                        AutoHaki()
                                        EquipTool(SelectWeapon)
                                        Tween(v841.HumanoidRootPart.CFrame * Pos)
                                        v841.HumanoidRootPart.CFrame = OldCFrameThird
                                        v841.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                        v841.HumanoidRootPart.CanCollide = false
                                        v841.Humanoid.WalkSpeed = 0
                                        AttackNoCoolDown()
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
                                    until _G.AutoSea3 == false or (v841.Humanoid.Health <= 0 or not v841.Parent)
                                end
                            end
                        elseif not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") and (CFrame.new(- 26880.93359375, 22.848554611206, 473.18951416016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000 then
                            Tween(CFrame.new(- 26880.93359375, 22.848554611206, 473.18951416016))
                        end
                    end
                end
            end)
        end
    end
end)
Tabs.Teleport:AddButton({
    ["Title"] = "Sea 1",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
    end
})
Tabs.Teleport:AddButton({
    ["Title"] = "Sea 2",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})
Tabs.Teleport:AddButton({
    ["Title"] = "Sea 3",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
    end
})
Tabs.Teleport:AddSection("Island")
if Sea1 then
    IslandList = {
        "WindMill",
        "Marine",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Snow Island",
        "MarineFord",
        "Colosseum",
        "Sky Island 1",
        "Sky Island 2",
        "Sky Island 3",
        "Prison",
        "Magma Village",
        "Under Water Island",
        "Fountain City",
        "Shank Room",
        "Mob Island"
    }
elseif Sea2 then
    IslandList = {
        "The Cafe",
        "Frist Spot",
        "Dark Area",
        "Flamingo Mansion",
        "Flamingo Room",
        "Green Zone",
        "Factory",
        "Colossuim",
        "Zombie Island",
        "Two Snow Mountain",
        "Punk Hazard",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Ussop Island",
        "Mini Sky Island"
    }
elseif Sea3 then
    IslandList = {
        "Mansion",
        "Port Town",
        "Great Tree",
        "Castle On The Sea",
        "MiniSky",
        "Hydra Island",
        "Floating Turtle",
        "Haunted Castle",
        "Ice Cream Island",
        "Peanut Island",
        "Cake Island",
        "Cocoa Island",
        "Candy Island",
        "Tiki Outpost"
    }
end
local v842 = Tabs.Teleport:AddDropdown("DropdownIsland", {
    ["Title"] = "Select Island",
    ["Description"] = "",
    ["Values"] = IslandList,
    ["Multi"] = false,
    ["Default"] = 1
})
v842:SetValue(_G.SelectIsland)
v842:OnChanged(function(state)
    _G.SelectIsland = state
end)
Tabs.Teleport:AddButton({
    ["Title"] = "Teleport to Island",
    ["Description"] = "",
    ["Callback"] = function()
        if _G.SelectIsland ~= "WindMill" then
            if _G.SelectIsland ~= "Marine" then
                if _G.SelectIsland ~= "Middle Town" then
                    if _G.SelectIsland ~= "Jungle" then
                        if _G.SelectIsland ~= "Pirate Village" then
                            if _G.SelectIsland ~= "Desert" then
                                if _G.SelectIsland ~= "Snow Island" then
                                    if _G.SelectIsland ~= "MarineFord" then
                                        if _G.SelectIsland ~= "Colosseum" then
                                            if _G.SelectIsland ~= "Sky Island 1" then
                                                if _G.SelectIsland ~= "Sky Island 2" then
                                                    if _G.SelectIsland ~= "Sky Island 3" then
                                                        if _G.SelectIsland ~= "Prison" then
                                                            if _G.SelectIsland ~= "Magma Village" then
                                                                if _G.SelectIsland ~= "Under Water Island" then
                                                                    if _G.SelectIsland ~= "Fountain City" then
                                                                        if _G.SelectIsland ~= "Shank Room" then
                                                                            if _G.SelectIsland ~= "Mob Island" then
                                                                                if _G.SelectIsland ~= "The Cafe" then
                                                                                    if _G.SelectIsland ~= "Frist Spot" then
                                                                                        if _G.SelectIsland ~= "Dark Area" then
                                                                                            if _G.SelectIsland ~= "Flamingo Mansion" then
                                                                                                if _G.SelectIsland ~= "Flamingo Room" then
                                                                                                    if _G.SelectIsland ~= "Green Zone" then
                                                                                                        if _G.SelectIsland ~= "Factory" then
                                                                                                            if _G.SelectIsland ~= "Colossuim" then
                                                                                                                if _G.SelectIsland ~= "Zombie Island" then
                                                                                                                    if _G.SelectIsland ~= "Two Snow Mountain" then
                                                                                                                        if _G.SelectIsland ~= "Punk Hazard" then
                                                                                                                            if _G.SelectIsland ~= "Cursed Ship" then
                                                                                                                                if _G.SelectIsland ~= "Ice Castle" then
                                                                                                                                    if _G.SelectIsland ~= "Forgotten Island" then
                                                                                                                                        if _G.SelectIsland ~= "Ussop Island" then
                                                                                                                                            if _G.SelectIsland ~= "Mini Sky Island" then
                                                                                                                                                if _G.SelectIsland ~= "Great Tree" then
                                                                                                                                                    if _G.SelectIsland ~= "Castle On The Sea" then
                                                                                                                                                        if _G.SelectIsland ~= "MiniSky" then
                                                                                                                                                            if _G.SelectIsland ~= "Port Town" then
                                                                                                                                                                if _G.SelectIsland ~= "Hydra Island" then
                                                                                                                                                                    if _G.SelectIsland ~= "Floating Turtle" then
                                                                                                                                                                        if _G.SelectIsland ~= "Mansion" then
                                                                                                                                                                            if _G.SelectIsland ~= "Castle On The Sea" then
                                                                                                                                                                                if _G.SelectIsland ~= "Haunted Castle" then
                                                                                                                                                                                    if _G.SelectIsland ~= "Ice Cream Island" then
                                                                                                                                                                                        if _G.SelectIsland ~= "Peanut Island" then
                                                                                                                                                                                            if _G.SelectIsland ~= "Cake Island" then
                                                                                                                                                                                                if _G.SelectIsland ~= "Cocoa Island" then
                                                                                                                                                                                                    if _G.SelectIsland ~= "Candy Island" then
                                                                                                                                                                                                        if _G.SelectIsland == "Tiki Outpost" then
                                                                                                                                                                                                            Tween2(CFrame.new(- 16542.447265625, 55.68632888793945, 1044.41650390625))
                                                                                                                                                                                                        end
                                                                                                                                                                                                    else
                                                                                                                                                                                                        Tween2(CFrame.new(- 1014.4241943359375, 149.11068725585938, - 14555.962890625))
                                                                                                                                                                                                    end
                                                                                                                                                                                                else
                                                                                                                                                                                                    Tween2(CFrame.new(87.94276428222656, 73.55451202392578, - 12319.46484375))
                                                                                                                                                                                                end
                                                                                                                                                                                            else
                                                                                                                                                                                                Tween2(CFrame.new(- 1884.7747802734375, 19.327526092529297, - 11666.8974609375))
                                                                                                                                                                                            end
                                                                                                                                                                                        else
                                                                                                                                                                                            Tween2(CFrame.new(- 2062.7475585938, 50.473892211914, - 10232.568359375))
                                                                                                                                                                                        end
                                                                                                                                                                                    else
                                                                                                                                                                                        Tween2(CFrame.new(- 902.56817626953, 79.93204498291, - 10988.84765625))
                                                                                                                                                                                    end
                                                                                                                                                                                else
                                                                                                                                                                                    Tween2(CFrame.new(- 9515.3720703125, 164.00624084473, 5786.0610351562))
                                                                                                                                                                                end
                                                                                                                                                                            else
                                                                                                                                                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375))
                                                                                                                                                                            end
                                                                                                                                                                        else
                                                                                                                                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 12468.5380859375, 375.0094299316406, - 7554.62548828125))
                                                                                                                                                                        end
                                                                                                                                                                    else
                                                                                                                                                                        Tween2(CFrame.new(- 13274.528320313, 531.82073974609, - 7579.22265625))
                                                                                                                                                                    end
                                                                                                                                                                else
                                                                                                                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906))
                                                                                                                                                                end
                                                                                                                                                            else
                                                                                                                                                                Tween2(CFrame.new(- 290.7376708984375, 6.729952812194824, 5343.5537109375))
                                                                                                                                                            end
                                                                                                                                                        else
                                                                                                                                                            Tween2(CFrame.new(- 260.65557861328, 49325.8046875, - 35253.5703125))
                                                                                                                                                        end
                                                                                                                                                    else
                                                                                                                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375))
                                                                                                                                                    end
                                                                                                                                                else
                                                                                                                                                    Tween2(CFrame.new(2681.2736816406, 1682.8092041016, - 7190.9853515625))
                                                                                                                                                end
                                                                                                                                            else
                                                                                                                                                Tween2(CFrame.new(- 288.74060058594, 49326.31640625, - 35248.59375))
                                                                                                                                            end
                                                                                                                                        else
                                                                                                                                            Tween2(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781))
                                                                                                                                        end
                                                                                                                                    else
                                                                                                                                        Tween2(CFrame.new(- 3032.7641601563, 317.89672851563, - 10075.373046875))
                                                                                                                                    end
                                                                                                                                else
                                                                                                                                    Tween2(CFrame.new(6148.4116210938, 294.38687133789, - 6741.1166992188))
                                                                                                                                end
                                                                                                                            else
                                                                                                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.40197753906, 125.05712890625, 32885.875))
                                                                                                                            end
                                                                                                                        else
                                                                                                                            Tween2(CFrame.new(- 6127.654296875, 15.951762199402, - 5040.2861328125))
                                                                                                                        end
                                                                                                                    else
                                                                                                                        Tween2(CFrame.new(753.14288330078, 408.23559570313, - 5274.6147460938))
                                                                                                                    end
                                                                                                                else
                                                                                                                    Tween2(CFrame.new(- 5622.033203125, 492.19604492188, - 781.78552246094))
                                                                                                                end
                                                                                                            else
                                                                                                                Tween2(CFrame.new(- 1503.6224365234, 219.7956237793, 1369.3101806641))
                                                                                                            end
                                                                                                        else
                                                                                                            Tween2(CFrame.new(424.12698364258, 211.16171264648, - 427.54049682617))
                                                                                                        end
                                                                                                    else
                                                                                                        Tween2(CFrame.new(- 2448.5300292969, 73.016105651855, - 3210.6306152344))
                                                                                                    end
                                                                                                else
                                                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.152034759521484, 905.48291015625))
                                                                                                end
                                                                                            else
                                                                                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 281.93707275390625, 306.130615234375, 609.280029296875))
                                                                                            end
                                                                                        else
                                                                                            Tween2(CFrame.new(3780.0302734375, 22.652164459229, - 3498.5859375))
                                                                                        end
                                                                                    else
                                                                                        Tween2(CFrame.new(- 11.311455726624, 29.276733398438, 2771.5224609375))
                                                                                    end
                                                                                else
                                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 281.93707275390625, 306.130615234375, 609.280029296875))
                                                                                    wait()
                                                                                    Tween2(CFrame.new(- 380.47927856445, 77.220390319824, 255.82550048828))
                                                                                end
                                                                            else
                                                                                Tween2(CFrame.new(- 2850.20068, 7.39224768, 5354.99268))
                                                                            end
                                                                        else
                                                                            Tween2(CFrame.new(- 1442.16553, 29.8788261, - 28.3547478))
                                                                        end
                                                                    else
                                                                        Tween2(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813))
                                                                    end
                                                                else
                                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                                                                end
                                                            else
                                                                Tween2(CFrame.new(- 5247.7163085938, 12.883934020996, 8504.96875))
                                                            end
                                                        else
                                                            Tween2(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656))
                                                        end
                                                    else
                                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
                                                    end
                                                else
                                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688))
                                                end
                                            else
                                                Tween2(CFrame.new(- 4869.1025390625, 733.46051025391, - 2667.0180664063))
                                            end
                                        else
                                            Tween2(CFrame.new(- 1427.6203613281, 7.2881078720093, - 2792.7722167969))
                                        end
                                    else
                                        Tween2(CFrame.new(- 4914.8212890625, 50.963626861572, 4281.0278320313))
                                    end
                                else
                                    Tween2(CFrame.new(1347.8067626953, 104.66806030273, - 1319.7370605469))
                                end
                            else
                                Tween2(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688))
                            end
                        else
                            Tween2(CFrame.new(- 1181.3093261719, 4.7514905929565, 3803.5456542969))
                        end
                    else
                        Tween2(CFrame.new(- 1612.7957763672, 36.852081298828, 149.12843322754))
                    end
                else
                    Tween2(CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094))
                end
            else
                Tween2(CFrame.new(- 2566.4296875, 6.8556680679321, 2045.2561035156))
            end
        else
            Tween2(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594))
        end
    end
})
Tabs.Teleport:AddButton({
    ["Title"] = "Stop Instant Teleport",
    ["Description"] = "",
    ["Callback"] = function()
        CancelTween()
    end
})
Tabs.Visual:AddButton({
    ["Title"] = "Fake",
    ["Description"] = "",
    ["Callback"] = function()
        local v844 = game:GetService("Players").LocalPlayer
        local v845 = require(game:GetService("ReplicatedStorage").Notification)
        local v846 = v844:WaitForChild("Data")
        local v847 = require(game.ReplicatedStorage:WaitForChild("EXPFunction"))
        local v848 = require(game:GetService("ReplicatedStorage").Effect.Container.LevelUp)
        local v849 = require(game:GetService("ReplicatedStorage").Util.Sound)
        local v850 = game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp_Proxy") or game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp")
        function v129(value)
            repeat
                local v852
                value, v852 = string.gsub(value, "^(-?%d+)(%d%d%d)", "%1,%2")
            until v852 == 0
            return value
        end
        v845.new("<Color=Yellow>QUEST COMPLETED!<Color=/>"):Display()
        v845.new("Earned<Color=Yellow>9,999,999,999,999 Exp.<Color=/>(+None)"):Display()
        v845.new("Earned<Color=Green>$9,999,999,999,999<Color=/>"):Display()
        v844.Data.Exp.Value = 999999999999
        v844.Data.Beli.Value = v844.Data.Beli.Value + 999999999999
        delay = 0
        count = 0
        while v844.Data.Exp.Value - v847(v846.Level.Value) > 0 do
            v844.Data.Exp.Value = v844.Data.Exp.Value - v847(v846.Level.Value)
            v844.Data.Level.Value = v844.Data.Level.Value + 1
            v844.Data.Points.Value = v844.Data.Points.Value + 3
            v848({
                v844
            })
            v849:Play(v850.Value)
            v845.new("<Color=Green>LEVEL UP!<Color=/>(" .. v844.Data.Level.Value .. ")"):Display()
            count = count + 1
            if count >= 5 then
                delay = tick()
                count = 0
                wait()
            end
        end
    end
})
Tabs.Visual:AddInput("Input_Level", {
    ["Title"] = "Level",
    ["Default"] = "",
    ["Placeholder"] = "...",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Callback"] = function(value)
        game:GetService("Players").LocalPlayer.Data.Level.Value = tonumber(value)
    end
})
Tabs.Visual:AddInput("Input_EXP", {
    ["Title"] = "Experience",
    ["Default"] = "",
    ["Placeholder"] = "...",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Callback"] = function(value)
        game:GetService("Players").LocalPlayer.Data.Exp.Value = tonumber(value)
    end
})
Tabs.Visual:AddInput("Input_Beli", {
    ["Title"] = "Beli",
    ["Default"] = "",
    ["Placeholder"] = "...",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Callback"] = function(value)
        game:GetService("Players").LocalPlayer.Data.Beli.Value = tonumber(value)
    end
})
Tabs.Visual:AddInput("Input_Fragments", {
    ["Title"] = "Fragments",
    ["Default"] = "",
    ["Placeholder"] = "...",
    ["Numeric"] = false,
    ["Finished"] = false,
    ["Callback"] = function(value)
        game:GetService("Players").LocalPlayer.Data.Fragments.Value = tonumber(value)
    end
})
local v857 = game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits")
Table_DevilFruitSniper = {}
ShopDevilSell = {}
local v858 = next
local v859 = nil
while true do
    local v860
    v859, v860 = v858(v857, v859)
    if v859 == nil then
        break
    end
    table.insert(Table_DevilFruitSniper, v860.Name)
    if v860.OnSale then
        table.insert(ShopDevilSell, v860.Name)
    end
end
_G.SelectFruit = "Dragon-Dragon"
_G.PermanentFruit = "Dragon-Dragon"
_G.AutoBuyFruitSniper = false
_G.AutoSwitchPermanentFruit = false
local v861 = Tabs.Fruit:AddDropdown("DropdownFruit", {
    ["Title"] = "Select Fruit",
    ["Description"] = "",
    ["Values"] = Table_DevilFruitSniper,
    ["Multi"] = false,
    ["Default"] = 1
})
v861:SetValue(_G.SelectFruit)
v861:OnChanged(function(state)
    _G.SelectFruit = state
end)
Tabs.Fruit:AddToggle("ToggleFruit", {
    ["Title"] = "Mua",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    if state then
        _G.AutoBuyFruitSniper = true
        pcall(function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", _G.SelectFruit, false)
        end)
        _G.AutoBuyFruitSniper = false
    end
end)
UIOptions.ToggleFruit:SetValue(false)
local v864 = Tabs.Fruit:AddDropdown("DropdownPermanentFruit", {
    ["Title"] = "Select Fruit",
    ["Description"] = "",
    ["Values"] = Table_DevilFruitSniper,
    ["Multi"] = false,
    ["Default"] = 1
})
v864:SetValue(_G.PermanentFruit)
v864:OnChanged(function(state)
    _G.PermanentFruit = state
end)
Tabs.Fruit:AddToggle("TogglePermanentFruit", {
    ["Title"] = "Use Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    if state then
        _G.AutoSwitchPermanentFruit = true
        pcall(function()
            local v867 = {
                "SwitchFruit",
                _G.PermanentFruit
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v867))
        end)
        _G.AutoSwitchPermanentFruit = false
    end
end)
UIOptions.TogglePermanentFruit:SetValue(false)
Tabs.Fruit:AddToggle("ToggleStore", {
    ["Title"] = "Store Devil Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoStoreFruit = state
end)
UIOptions.ToggleStore:SetValue(false)
spawn(function()
    while task.wait() do
        if _G.AutoStoreFruit then
            pcall(function()
                if _G.AutoStoreFruit then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bomb Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Bomb-Bomb", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Bomb Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spike Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spike-Spike", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Chop Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Chop Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Chop-Chop", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Blade Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spring Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spring-Spring", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rocket Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rocket-Rocket", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Smoke Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Smoke-Smoke", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spin-Spin", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Flame-Flame", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Falcon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Falcon Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Falcon", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("alcon Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Ice-Ice", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Sand-Sand", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dark-Dark", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ghost Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Ghost-Ghost", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Diamond Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Diamond-Diamond", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Light-Light", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Love Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Love-Love", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rubber Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rubber-Rubber", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Barrier Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Barrier-Barrier", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Magma-Magma", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Portal Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Portal Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Door-Door", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Portal Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Quake-Quake", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Buddha Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buddha", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Buddha Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spider Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spider Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spider-Spider", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spider Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Phoenix Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Phoenix", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Phoenix Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rumble-Rumble", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Pain Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pain Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Pain-Pain", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pain Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Gravity-Gravity", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dough-Dough", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Shadow-Shadow", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Venom-Venom", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Control-Control", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spirit Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spirit Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Soul-Soul", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spirit Fruit"))
                    end
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dragon-Dragon", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit"))
                        if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit") then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Leopard-Leopard", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit"))
                        end
                    end
                end
            end)
        end
        wait()
    end
end)
Tabs.Fruit:AddToggle("ToggleRandomFruit", {
    ["Title"] = "Random Devil Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Random_Auto = state
end)
UIOptions.ToggleRandomFruit:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.Random_Auto then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end
        end
    end)
end)
Tabs.Fruit:AddToggle("ToggleCollectTP", {
    ["Title"] = "Teleport to Fruit",
    ["Description"] = "Risk",
    ["Default"] = false
}):OnChanged(function(state)
    _G.CollectFruitTP = state
end)
UIOptions.ToggleCollectTP:SetValue(false)
spawn(function()
    while wait() do
        if _G.CollectFruitTP then
            for v873, v874 in pairs(game.Workspace:GetChildren()) do
                if string.find(v874.Name, "Fruit") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v874.Handle.CFrame
                end
            end
        end
    end
end)
Tabs.Fruit:AddToggle("ToggleCollect", {
    ["Title"] = "Collect Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Tweenfruit = state
end)
UIOptions.ToggleCollect:SetValue(false)
spawn(function()
    while wait() do
        if _G.Tweenfruit then
            for v878, v879 in pairs(game.Workspace:GetChildren()) do
                if string.find(v879.Name, "Fruit") then
                    Tween(v879.Handle.CFrame)
                end
            end
        end
    end
end)
Tabs.Fruit:AddSection("Esp")
Tabs.Fruit:AddToggle("ToggleEspPlayer", {
    ["Title"] = "Players",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    ESPPlayer = state
    UpdatePlayerChams()
end)
UIOptions.ToggleEspPlayer:SetValue(false)
Tabs.Fruit:AddToggle("ToggleEspFruit", {
    ["Title"] = "Devil Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    DevilFruitESP = state
    while DevilFruitESP do
        wait()
        UpdateDevilChams()
    end
end)
UIOptions.ToggleEspFruit:SetValue(false)
Tabs.Fruit:AddToggle("ToggleEspIsland", {
    ["Title"] = "Island",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    IslandESP = state
    while IslandESP do
        wait()
        UpdateIslandESP()
    end
end)
UIOptions.ToggleEspIsland:SetValue(false)
Tabs.Fruit:AddToggle("ToggleEspFlower", {
    ["Title"] = "Hoa",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    FlowerESP = state
    UpdateFlowerChams()
end)
UIOptions.ToggleEspFlower:SetValue(false)
spawn(function()
    while wait() do
        if FlowerESP then
            UpdateFlowerChams()
        end
        if DevilFruitESP then
            UpdateDevilChams()
        end
        if ChestESP then
            UpdateChestChams()
        end
        if ESPPlayer then
            UpdatePlayerChams()
        end
        if RealFruitESP then
            UpdateRealFruitChams()
        end
    end
end)
Tabs.Fruit:AddToggle("ToggleEspRealFruit", {
    ["Title"] = "Physical Fruits",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    RealFruitEsp = state
    while RealFruitEsp do
        wait()
        UpdateRealFruitEsp()
    end
end)
UIOptions.ToggleEspRealFruit:SetValue(false)
function UpdateRealFruitEsp()
    for v887, v888 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v888:IsA("Tool") then
            if RealFruitEsp then
                if v888.Handle:FindFirstChild("NameEsp" .. Number) then
                    v888.Handle["NameEsp" .. Number].TextLabel.Text = v888.Name .. " " .. formatDistance3((game:GetService("Players").LocalPlayer.Character.Head.Position - v888.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v889 = Instance.new("BillboardGui", v888.Handle)
                    v889.Name = "NameEsp" .. Number
                    v889.ExtentsOffset = Vector3.new(0, 1, 0)
                    v889.Size = UDim2.new(1, 200, 1, 30)
                    v889.Adornee = v888.Handle
                    v889.AlwaysOnTop = true
                    local v890 = Instance.new("TextLabel", v889)
                    v890.Font = Enum.Font.GothamSemibold
                    v890.FontSize = "Size14"
                    v890.TextWrapped = true
                    v890.Size = UDim2.new(1, 0, 1, 0)
                    v890.TextYAlignment = "Top"
                    v890.BackgroundTransparency = 1
                    v890.TextStrokeTransparency = 0.5
                    v890.TextColor3 = Color3.fromRGB(255, 0, 0)
                    v890.Text = v888.Name .. " \n" .. formatDistance3((game:GetService("Players").LocalPlayer.Character.Head.Position - v888.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v888.Handle:FindFirstChild("NameEsp" .. Number) then
                v888.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for v893, v894 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v894:IsA("Tool") then
            if RealFruitEsp then
                if v894.Handle:FindFirstChild("NameEsp" .. Number) then
                    v894.Handle["NameEsp" .. Number].TextLabel.Text = v894.Name .. " " .. formatDistance3((game:GetService("Players").LocalPlayer.Character.Head.Position - v894.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v895 = Instance.new("BillboardGui", v894.Handle)
                    v895.Name = "NameEsp" .. Number
                    v895.ExtentsOffset = Vector3.new(0, 1, 0)
                    v895.Size = UDim2.new(1, 200, 1, 30)
                    v895.Adornee = v894.Handle
                    v895.AlwaysOnTop = true
                    local v896 = Instance.new("TextLabel", v895)
                    v896.Font = Enum.Font.GothamSemibold
                    v896.FontSize = "Size14"
                    v896.TextWrapped = true
                    v896.Size = UDim2.new(1, 0, 1, 0)
                    v896.TextYAlignment = "Top"
                    v896.BackgroundTransparency = 1
                    v896.TextStrokeTransparency = 0.5
                    v896.TextColor3 = Color3.fromRGB(255, 174, 0)
                    v896.Text = v894.Name .. " \n" .. formatDistance3((game:GetService("Players").LocalPlayer.Character.Head.Position - v894.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v894.Handle:FindFirstChild("NameEsp" .. Number) then
                v894.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
    for v899, v900 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v900:IsA("Tool") then
            if RealFruitEsp then
                if v900.Handle:FindFirstChild("NameEsp" .. Number) then
                    v900.Handle["NameEsp" .. Number].TextLabel.Text = v900.Name .. " " .. formatDistance3((game:GetService("Players").LocalPlayer.Character.Head.Position - v900.Handle.Position).Magnitude / 3) .. " Distance"
                else
                    local v901 = Instance.new("BillboardGui", v900.Handle)
                    v901.Name = "NameEsp" .. Number
                    v901.ExtentsOffset = Vector3.new(0, 1, 0)
                    v901.Size = UDim2.new(1, 200, 1, 30)
                    v901.Adornee = v900.Handle
                    v901.AlwaysOnTop = true
                    local v902 = Instance.new("TextLabel", v901)
                    v902.Font = Enum.Font.GothamSemibold
                    v902.FontSize = "Size14"
                    v902.TextWrapped = true
                    v902.Size = UDim2.new(1, 0, 1, 0)
                    v902.TextYAlignment = "Top"
                    v902.BackgroundTransparency = 1
                    v902.TextStrokeTransparency = 0.5
                    v902.TextColor3 = Color3.fromRGB(251, 255, 0)
                    v902.Text = v900.Name .. " \n" .. formatDistance3((game:GetService("Players").LocalPlayer.Character.Head.Position - v900.Handle.Position).Magnitude / 3) .. " Distance"
                end
            elseif v900.Handle:FindFirstChild("NameEsp" .. Number) then
                v900.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
            end
        end
    end
end
Tabs.Fruit:AddToggle("ToggleIslandMirageEsp", {
    ["Title"] = "Mirage Island",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    IslandMirageEsp = state
    while IslandMirageEsp do
        wait()
        UpdateIslandMirageEsp()
    end
end)
UIOptions.ToggleIslandMirageEsp:SetValue(false)
function isnil(value)
    return value == nil
end
local function formatMeterDistance2(distance)
    return math.floor(tonumber(distance) + 0.5)
end
Number = math.random(1, 1000000)
function UpdateIslandMirageEsp()
    for v909, mirageIslandLocation2 in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP then
                if mirageIslandLocation2.Name == "Mirage Island" then
                    if mirageIslandLocation2:FindFirstChild("NameEsp") then
                        mirageIslandLocation2.NameEsp.TextLabel.Text = mirageIslandLocation2.Name .. "   \n" .. formatMeterDistance2((game:GetService("Players").LocalPlayer.Character.Head.Position - mirageIslandLocation2.Position).Magnitude / 3) .. " M"
                    else
                        local v911 = Instance.new("BillboardGui", mirageIslandLocation2)
                        v911.Name = "NameEsp"
                        v911.ExtentsOffset = Vector3.new(0, 1, 0)
                        v911.Size = UDim2.new(1, 200, 1, 30)
                        v911.Adornee = mirageIslandLocation2
                        v911.AlwaysOnTop = true
                        local v912 = Instance.new("TextLabel", v911)
                        v912.Font = Enum.Font.Code
                        v912.FontSize = Enum.FontSize.Size14
                        v912.TextWrapped = true
                        v912.Size = UDim2.new(1, 0, 1, 0)
                        v912.TextYAlignment = Enum.TextYAlignment.Top
                        v912.BackgroundTransparency = 1
                        v912.TextStrokeTransparency = 0.5
                        v912.TextColor3 = Color3.fromRGB(80, 245, 245)
                    end
                end
            elseif mirageIslandLocation2:FindFirstChild("NameEsp") then
                mirageIslandLocation2:FindFirstChild("NameEsp"):Destroy()
            end
        end)
    end
end
local v913 = Tabs.Raid:AddDropdown("DropdownRaid", {
    ["Title"] = "Select Chip",
    ["Description"] = "",
    ["Values"] = {
        "Flame",
        "Ice",
        "Quake",
        "Light",
        "Dark",
        "Spider",
        "Rumble",
        "Magma",
        "Buddha",
        "Sand",
        "Phoenix",
        "Dough"
    },
    ["Multi"] = false,
    ["Default"] = 1
})
v913:SetValue(SelectChip)
v913:OnChanged(function(state)
    SelectChip = state
end)
Tabs.Raid:AddToggle("ToggleBuy", {
    ["Title"] = "Mua Chip",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_Buy_Chips_Dungeon = state
end)
UIOptions.ToggleBuy:SetValue(false)
spawn(function()
    while wait() do
        if _G.Auto_Buy_Chips_Dungeon then
            pcall(function()
                local v916 = {
                    "RaidsNpc",
                    "Select",
                    SelectChip
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v916))
            end)
        end
    end
end)
Tabs.Raid:AddToggle("ToggleStart", {
    ["Title"] = "Auto Start Raid",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Auto_StartRaid = state
end)
UIOptions.ToggleStart:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Auto_StartRaid and (game:GetService("Players").LocalPlayer.PlayerGui.Main.Timer.Visible == false and (not game:GetService("Workspace")._WorldOrigin.Locations:FindFirstChild("Island 1") and (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game:GetService("Players").LocalPlayer.Character:FindFirstChild("Special Microchip")))) then
                if Sea2 then
                    Tween2(CFrame.new(- 6438.73535, 250.645355, - 4501.50684))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "SetSpawnPoint"
                    }))
                    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
                elseif Sea3 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375))
                    Tween2(CFrame.new(- 5017.40869, 314.844055, - 2823.0127, - 0.925743818, 4.482175e-8, - 0.378151238, 4.5550315e-9, 1, 1.0737756e-7, 0.378151238, 9.768162e-8, - 0.925743818))
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                        "SetSpawnPoint"
                    }))
                    fireclickdetector(game:GetService("Workspace").Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
                end
            end
        end)
    end
end)
Tabs.Raid:AddToggle("ToggleNextIsland", {
    ["Title"] = "Auto Complete Raid",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    AutoNextIsland = state
    if not state then
        _G.AutoNear = false
    end
end)
UIOptions.ToggleNextIsland:SetValue(false)
spawn(function()
    local visitedTrialIslandsMap = {}
    while task.wait() do
        if AutoNextIsland then
            pcall(function()
                local v920 = game.Players.LocalPlayer.Character
                if v920 and v920:FindFirstChild("HumanoidRootPart") then
                    local v921 = game:GetService("Workspace")._WorldOrigin.Locations
                    local v922 = v920.HumanoidRootPart.Position
                    if (v922 - Vector3.new(- 6438.73535, 250.645355, - 4501.50684)).Magnitude < 1 or (v922 - Vector3.new(- 5017.40869, 314.844055, - 2823.0127)).Magnitude < 1 then
                        visitedTrialIslandsMap = {}
                    end
                    if v921:FindFirstChild("Island 1") then
                        _G.AutoNear = true
                    end
                    if v921:FindFirstChild("Island 2") and not visitedTrialIslandsMap["Island 2"] then
                        Tween(v921:FindFirstChild("Island 2").CFrame)
                        visitedTrialIslandsMap["Island 2"] = true
                        AutoNextIsland = false
                        wait()
                        AutoNextIsland = true
                    elseif v921:FindFirstChild("Island 3") and not visitedTrialIslandsMap["Island 3"] then
                        Tween(v921:FindFirstChild("Island 3").CFrame)
                        visitedTrialIslandsMap["Island 3"] = true
                        AutoNextIsland = false
                        wait()
                        AutoNextIsland = true
                    elseif v921:FindFirstChild("Island 4") and not visitedTrialIslandsMap["Island 4"] then
                        Tween(v921:FindFirstChild("Island 4").CFrame)
                        visitedTrialIslandsMap["Island 4"] = true
                        AutoNextIsland = false
                        wait()
                        AutoNextIsland = true
                    elseif v921:FindFirstChild("Island 5") and not visitedTrialIslandsMap["Island 5"] then
                        Tween(v921:FindFirstChild("Island 5").CFrame)
                        visitedTrialIslandsMap["Island 5"] = true
                        AutoNextIsland = false
                        wait()
                        AutoNextIsland = true
                    end
                end
            end)
        end
    end
end)
Tabs.Raid:AddToggle("ToggleAwake", {
    ["Title"] = "Auto Awaken Devil Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    AutoAwakenAbilities = state
end)
UIOptions.ToggleAwake:SetValue(false)
spawn(function()
    while task.wait() do
        if AutoAwakenAbilities then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Awakener", "Awaken")
            end)
        end
    end
end)
Tabs.Raid:AddToggle("ToggleGetFruit", {
    ["Title"] = "Buy Chip with Common Fruit",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.Autofruit = state
end)
spawn(function()
    while wait() do
        pcall(function()
            if _G.Autofruit then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Rocket-Rocket"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Spin-Spin"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Chop-Chop"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Spring-Spring"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Bomb-Bomb"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Smoke-Smoke"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Spike-Spike"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Flame-Flame"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Falcon-Falcon"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Ice-Ice"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Sand-Sand"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Dark-Dark"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Ghost-Ghost"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Diamond-Diamond"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Light-Light"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Rubber-Rubber"
                }))
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
                    "LoadFruit",
                    "Barrier-Barrier"
                }))
            end
        end)
    end
end)
if Sea2 then
    Tabs.Raid:AddButton({
        ["Title"] = "Fly to Raid Room",
        ["Description"] = "",
        ["Callback"] = function()
            Tween2(CFrame.new(- 6438.73535, 250.645355, - 4501.50684))
        end
    })
elseif Sea3 then
    Tabs.Raid:AddButton({
        ["Title"] = "Fly to Raid Room",
        ["Description"] = "",
        ["Callback"] = function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375))
            Tween2(CFrame.new(- 5017.40869, 314.844055, - 2823.0127, - 0.925743818, 4.482175e-8, - 0.378151238, 4.5550315e-9, 1, 1.0737756e-7, 0.378151238, 9.768162e-8, - 0.925743818))
        end
    })
end
Tabs.Raid:AddSection("Law")
Tabs.Raid:AddToggle("ToggleLaw", {
    ["Title"] = "Auto Low Raid (Full)",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    Auto_Law = state
end)
UIOptions.ToggleLaw:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if Auto_Law and not (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or (game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip") or (game:GetService("Workspace").Enemies:FindFirstChild("Order") or game:GetService("ReplicatedStorage"):FindFirstChild("Order")))) then
                wait()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "1")
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
            end
        end
    end)
end)
spawn(function()
    pcall(function()
        while wait() do
            if Auto_Law then
                if not game:GetService("Workspace").Enemies:FindFirstChild("Order") and (not game:GetService("ReplicatedStorage"):FindFirstChild("Order") and (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Microchip") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Microchip"))) then
                    fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
                end
                if game:GetService("ReplicatedStorage"):FindFirstChild("Order") or game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Order") then
                        for v928, v929 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v929.Name == "Order" then
                                repeat
                                    wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    Tween(v929.HumanoidRootPart.CFrame * Pos)
                                    v929.HumanoidRootPart.CanCollide = false
                                    v929.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                until not v929.Parent or (v929.Humanoid.Health <= 0 or Auto_Law == false)
                            end
                        end
                    elseif game:GetService("ReplicatedStorage"):FindFirstChild("Order") then
                        Tween(CFrame.new(- 6217.2021484375, 28.047645568848, - 5053.1357421875))
                    end
                end
            end
        end
    end)
end)
Tabs.Race:AddButton({
    ["Title"] = "Temple of Time",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
    end
})
Tabs.Race:AddButton({
    ["Title"] = "Auto Pull Lever",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        Tween2(CFrame.new(28575.181640625, 14936.6279296875, 72.31636810302734))
    end
})
Tabs.Race:AddButton({
    ["Title"] = "Teleport to Gear NPC",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        Tween2(CFrame.new(28981.552734375, 14888.4267578125, - 120.245849609375))
    end
})
Tabs.Race:AddSection("Race")
Tabs.Race:AddButton({
    ["Title"] = "Race Door",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28286.35546875, 14895.3017578125, 102.62469482421875))
        if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Human" then
            if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Skypiea" then
                if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Fishman" then
                    if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Cyborg" then
                        if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Ghoul" then
                            if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                                Tween2(CFrame.new(29012.341796875, 14890.9755859375, - 380.1492614746094))
                            end
                        else
                            Tween2(CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156))
                        end
                    else
                        Tween2(CFrame.new(28502.681640625, 14895.9755859375, - 423.7279357910156))
                    end
                else
                    Tween2(CFrame.new(28231.17578125, 14890.9755859375, - 211.64173889160156))
                end
            else
                Tween2(CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375))
            end
        else
            Tween2(CFrame.new(29221.822265625, 14890.9755859375, - 205.99114990234375))
        end
    end
})
Tabs.Race:AddToggle("ToggleHumanandghoul", {
    ["Title"] = "Pass Trial [Human/Cyborg]",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    KillAura = state
end)
UIOptions.ToggleHumanandghoul:SetValue(false)
Tabs.Race:AddToggle("ToggleAutotrial", {
    ["Title"] = "Pass Trial",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoQuestRace = state
end)
UIOptions.ToggleAutotrial:SetValue(false)
spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoQuestRace then
                if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Human" then
                    if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Skypiea" then
                        if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Fishman" then
                            if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Cyborg" then
                                if game:GetService("Players").LocalPlayer.Data.Race.Value ~= "Ghoul" then
                                    if game:GetService("Players").LocalPlayer.Data.Race.Value == "Mink" then
                                        for v934, v935 in pairs(game:GetService("Workspace"):GetDescendants()) do
                                            if v935.Name == "StartPoint" then
                                                Tween(v935.CFrame * CFrame.new(0, 10, 0))
                                            end
                                        end
                                    end
                                else
                                    for v938, targetMobEntity1 in pairs(game.Workspace.Enemies:GetDescendants()) do
                                        if targetMobEntity1:FindFirstChild("Humanoid") and (targetMobEntity1:FindFirstChild("HumanoidRootPart") and targetMobEntity1.Humanoid.Health > 0) then
                                            pcall(function()
                                                repeat
                                                    wait()
                                                    targetMobEntity1.Humanoid.Health = 0
                                                    targetMobEntity1.HumanoidRootPart.CanCollide = false
                                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                                until not _G.AutoQuestRace or (not targetMobEntity1.Parent or targetMobEntity1.Humanoid.Health <= 0)
                                            end)
                                        end
                                    end
                                end
                            else
                                Tween(CFrame.new(28654, 14898.7832, - 30, 1, 0, 0, 0, 1, 0, 0, 0, 1))
                            end
                        else
                            for v942, v943 in pairs(game:GetService("Workspace").SeaBeasts.SeaBeast1:GetDescendants()) do
                                if v943.Name == "HumanoidRootPart" then
                                    Tween(v943.CFrame * Pos)
                                    for v946, v947 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if v947:IsA("Tool") and v947.ToolTip == "Melee" then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v947)
                                        end
                                    end
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    for v950, v951 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if v951:IsA("Tool") and v951.ToolTip == "Blox Fruit" then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v951)
                                        end
                                    end
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    for v954, v955 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if v955:IsA("Tool") and v955.ToolTip == "Sword" then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v955)
                                        end
                                    end
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait()
                                    for v958, v959 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                        if v959:IsA("Tool") and v959.ToolTip == "Gun" then
                                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v959)
                                        end
                                    end
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 122, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 120, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    wait(0.2)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(true, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    game:GetService("VirtualInputManager"):SendKeyEvent(false, 99, false, game.Players.LocalPlayer.Character.HumanoidRootPart)
                                end
                            end
                        end
                    else
                        for v962, v963 in pairs(game:GetService("Workspace").Map.SkyTrial.Model:GetDescendants()) do
                            if v963.Name == "snowisland_Cylinder.081" then
                                BTPZ(v963.CFrame * CFrame.new(0, 0, 0))
                            end
                        end
                    end
                else
                    for v966, targetMobEntity2 in pairs(game.Workspace.Enemies:GetDescendants()) do
                        if targetMobEntity2:FindFirstChild("Humanoid") and (targetMobEntity2:FindFirstChild("HumanoidRootPart") and targetMobEntity2.Humanoid.Health > 0) then
                            pcall(function()
                                repeat
                                    wait()
                                    targetMobEntity2.Humanoid.Health = 0
                                    targetMobEntity2.HumanoidRootPart.CanCollide = false
                                    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                                until not _G.AutoQuestRace or (not targetMobEntity2.Parent or targetMobEntity2.Humanoid.Health <= 0)
                            end)
                        end
                    end
                end
            end
        end
    end)
end)
Tabs.Race:AddToggle("ToggleKillTrial", {
    ["Title"] = "Kill Players in Trial",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoKillTrial = state
end)
UIOptions.ToggleKillTrial:SetValue(false)
spawn(function()
    while wait() do
        pcall(function()
            if _G.AutoKillTrial then
                for v971, v972 in pairs(game:GetService("Players"):GetChildren()) do
                    if v972.Name and (v972.Name ~= game.Players.LocalPlayer.Name and ((v972.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 and v972.Character.Humanoid.Health > 0)) then
                        repeat
                            wait(_G.Fast_Delay)
                            EquipTool(SelectWeapon)
                            AutoHaki()
                            Tween(v972.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5))
                            v972.Character.HumanoidRootPart.CanCollide = false
                            v972.Character.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                            AttackNoCoolDown()
                        until not _G.AutoKillTrial or (not v972.Parent or v972.Character.Humanoid.Health <= 0)
                    end
                end
            end
        end)
    end
end)
Tabs.Race:AddSection("")
local v973 = Tabs.Race:AddToggle("ToggleFarmRace", {
    ["Title"] = "Farm Race",
    ["Description"] = "",
    ["Default"] = false
})
local isMobAuraActive = false
v973:OnChanged(function(state)
    isMobAuraActive = state
end)
UIOptions.ToggleFarmRace:SetValue(false)
spawn(function()
    while wait() do
        if isMobAuraActive then
            pcall(function()
                if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
                    if game.Players.LocalPlayer.Character.RaceTransformed.Value ~= true then
                        if game.Players.LocalPlayer.Character.RaceTransformed.Value == false then
                            _G.AutoBoneNoQuest = true
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "Y", false, game)
                            wait()
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "Y", false, game)
                        end
                    else
                        _G.AutoBoneNoQuest = false
                        Tween(CFrame.new(- 9698.4736328125, 445.09442138671875, 6545.8525390625))
                    end
                end
            end)
        else
            _G.AutoBoneNoQuest = false
        end
    end
end)
Tabs.Race:AddToggle("ToggleUpgrade", {
    ["Title"] = "Buy Gear",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoUpgrade = state
    if _G.AutoUpgrade then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
    end
end)
UIOptions.ToggleUpgrade:SetValue(false)
Tabs.Shop:AddSection("Haki")
Tabs.Shop:AddButton({
    ["Title"] = "Infinite Jump",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Haki",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Teleport",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Observation Haki",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
    end
})
Tabs.Shop:AddSection("Sword")
Tabs.Shop:AddButton({
    ["Title"] = "Dual-Headed Blade",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "katana",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Katana")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Iron Mace",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Dual Katana",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Triple Katana",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Pipe",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Dual-Headed Blade",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Bisento",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Soul Cane",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Pole V2",
    ["Description"] = "",
    ["Callback"] = function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ThunderGodTalk")
    end
})
Tabs.Shop:AddSection("Combat")
Tabs.Shop:AddButton({
    ["Title"] = "Black leg",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Electro",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Fishman Karate",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Dragon Claw",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Superhuman",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Death Step",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Sharkman Karate",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Electric Claw",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Dragon Talon",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Godhuman",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Sanguine Art",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySanguineArt")
    end
})
Tabs.Shop:AddSection("Other")
Tabs.Shop:AddButton({
    ["Title"] = "Stats Reset",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Reroll Race",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "1")
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Change to Ghoul Race",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "Ectoplasm",
            "Change",
            4
        }))
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Change to Cyborg Race",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "CyborgTrainer",
            "Buy"
        }))
    end
})
Tabs.Shop:AddButton({
    ["Title"] = "Change to Dragon Race",
    ["Description"] = "Sea 3 Only",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906))
        Tween2(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
        local v977 = Vector3.new(5814.42724609375, 1208.3267822265625, 884.5785522460938)
        local v978 = game.Players.LocalPlayer
        local v979 = v978.Character
        if not v979 then
            v979 = v978.CharacterAdded:Wait()
        end
        repeat
            wait()
        until (v979.HumanoidRootPart.Position - v977).Magnitude < 1
        local v980 = {
            {
                ["NPC"] = "Dragon Wizard",
                ["Command"] = "DragonRace"
            }
        }
        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack(v980))
    end
})
Tabs.Misc:AddButton({
    ["Title"] = "Rejoin Server",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
    end
})
Tabs.Misc:AddButton({
    ["Title"] = "Join Other Server",
    ["Description"] = "",
    ["Callback"] = function()
        Hop()
    end
})
function Hop()
    local serverHopPlaceId = game.PlaceId
    local visitedServerIdsList = {}
    local serverHopCursor = ""
    local serverHopCurrentHour = os.date("!*t").hour
    function TPReturner()
        local v985
        if serverHopCursor ~= "" then
            v985 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. serverHopPlaceId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. serverHopCursor))
        else
            v985 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. serverHopPlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        end
        if v985.nextPageCursor and (v985.nextPageCursor ~= "null" and v985.nextPageCursor ~= nil) then
            serverHopCursor = v985.nextPageCursor
        end
        local v986, v987, v988 = pairs(v985.data)
        local v989 = 0
        while true do
            local v990
            v988, v990 = v986(v987, v988)
            if v988 == nil then
                break
            end
            local v991 = true
            local candidateServerId = tostring(v990.id)
            if tonumber(v990.maxPlayers) > tonumber(v990.playing) then
                for v995, v996 in pairs(visitedServerIdsList) do
                    if v989 == 0 then
                        if tonumber(serverHopCurrentHour) ~= tonumber(v996) then
                            pcall(function()
                                visitedServerIdsList = {}
                                table.insert(visitedServerIdsList, serverHopCurrentHour)
                            end)
                        end
                    elseif candidateServerId == tostring(v996) then
                        v991 = false
                    end
                    v989 = v989 + 1
                end
                if v991 == true then
                    table.insert(visitedServerIdsList, candidateServerId)
                    wait()
                    pcall(function()
                        wait()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(serverHopPlaceId, candidateServerId, game.Players.LocalPlayer)
                    end)
                    wait()
                end
            end
        end
    end
    teleportSeaSection = function()
        while wait() do
            pcall(function()
                TPReturner()
                if serverHopCursor ~= "" then
                    TPReturner()
                end
            end)
        end
    end
    teleportSeaSection()
end
Tabs.Misc:AddSection("Team")
Tabs.Misc:AddButton({
    ["Title"] = "Pirates",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end
})
Tabs.Misc:AddButton({
    ["Title"] = "Marines",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end
})
Tabs.Misc:AddSection("Code")
local v4TrialsOrderList = {
    "KITT_RESET",
    "Sub2UncleKizaru",
    "SUB2GAMERROBOT_RESET1",
    "Sub2Fer999",
    "Enyu_is_Pro",
    "JCWK",
    "StarcodeHEO",
    "MagicBus",
    "KittGaming",
    "Sub2CaptainMaui",
    "Sub2OfficalNoobie",
    "TheGreatAce",
    "Sub2NoobMaster123",
    "Sub2Daigrock",
    "Axiore",
    "StrawHatMaine",
    "TantaiGaming",
    "Bluxxy",
    "SUB2GAMERROBOT_EXP1",
    "Chandler",
    "NOMOREHACK",
    "BANEXPLOIT",
    "WildDares",
    "BossBuild",
    "GetPranked",
    "EARN_FRUITS",
    "FIGHT4FRUIT",
    "NOEXPLOITER",
    "NOOB2ADMIN",
    "CODESLIDE",
    "ADMINHACKED",
    "ADMINDARES",
    "fruitconcepts",
    "krazydares",
    "TRIPLEABUSE",
    "SEATROLLING",
    "24NOADMIN",
    "REWARDFUN",
    "NEWTROLL",
    "fudd10_v2",
    "Fudd10",
    "Bignews",
    "SECRET_ADMIN"
}
Tabs.Misc:AddButton({
    ["Title"] = "Redeem All Codes",
    ["Description"] = "",
    ["Callback"] = function()
        for v1000, v1001 in ipairs(v4TrialsOrderList) do
            RedeemCode(v1001)
        end
    end
})
function RedeemCode(value)
    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(value)
end
Tabs.Misc:AddSection("Title")
Tabs.Misc:AddButton({
    ["Title"] = "Title",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "getTitles"
        }))
        game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
    end
})
Tabs.Misc:AddSection("Awakening")
Tabs.Misc:AddButton({
    ["Title"] = "Awakening",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("Players").LocalPlayer.PlayerGui.Main.AwakeningToggler.Visible = true
    end
})
Tabs.Misc:AddSection("Misc")
Tabs.Misc:AddToggle("ToggleRejoin", {
    ["Title"] = "Rejoin Server",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    _G.AutoRejoin = state
end)
UIOptions.ToggleRejoin:SetValue(true)
spawn(function()
    pcall(function()
        local coreGui = (pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui"))
        local promptGui = coreGui and coreGui:FindFirstChild("RobloxPromptGui")
        if promptGui and promptGui:FindFirstChild("promptOverlay") then
            promptGui.promptOverlay.ChildAdded:Connect(function(prompt)
                if _G.AutoRejoin and prompt.Name == "ErrorPrompt" and prompt:FindFirstChild("MessageArea") and prompt.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                end
            end)
        end
    end)
end)
Tabs.Misc:AddSection("Fog")
local function clearDarkFogAndSky()
    local v1005 = game:GetService("Lighting")
    if v1005:FindFirstChild("BaseAtmosphere") then
        v1005.BaseAtmosphere:Destroy()
    end
    if v1005:FindFirstChild("SeaTerrorCC") then
        v1005.SeaTerrorCC:Destroy()
    end
    if v1005:FindFirstChild("LightingLayers") then
        if v1005.LightingLayers:FindFirstChild("Atmosphere") then
            v1005.LightingLayers.Atmosphere:Destroy()
        end
        wait()
        if v1005.LightingLayers:FindFirstChild("DarkFog") then
            v1005.LightingLayers.DarkFog:Destroy()
        end
    end
    v1005.FogEnd = 100000
end
Tabs.Misc:AddButton({
    ["Title"] = "Awakening",
    ["Description"] = "",
    ["Callback"] = function()
        clearDarkFogAndSky()
    end
})
Tabs.Misc:AddToggle("ToggleAntiBand", {
    ["Title"] = "Anti Ban",
    ["Description"] = "",
    ["Default"] = true
}):OnChanged(function(state)
    _G.AntiBand = state
end)
local adminUserIdWhitelist = {
    17884881,
    120173604,
    912348
}
spawn(function()
    while wait() do
        if _G.AntiBand then
            for v1011, v1012 in pairs(game:GetService("Players"):GetPlayers()) do
                if table.find(adminUserIdWhitelist, v1012.UserId) then
                    Hop()
                end
            end
        end
    end
end)
Tabs.Sea:AddSection("Leviathan")
Tabs.Sea:AddButton({
    ["Title"] = "Mua Chip Leviathan",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
    end
})
local v1013 = Tabs.Sea:AddToggle("ToggleTPFrozenDimension", {
    ["Title"] = "Fly to Frozen Dimension",
    ["Description"] = "",
    ["Default"] = false
})
v1013:OnChanged(function(state)
    _G.TweenToFrozenDimension = state
end)
v1013:SetValue(false)
spawn(function()
    local v1015 = nil
    while not v1015 do
        v1015 = game:GetService("Workspace").Map:FindFirstChild("FrozenDimension")
        wait()
    end
    while wait() do
        if _G.TweenToFrozenDimension and v1015 then
            Tween(v1015.CFrame)
        end
    end
end)
if Sea3 then
    local spyLeviathanStatusLabel = Tabs.Sea:AddParagraph({
        ["Title"] = "Leviathan Chip Status",
        ["Content"] = ""
    })
    spawn(function()
        pcall(function()
            while wait() do
                local v1017 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
                if v1017 == 5 then
                    spyLeviathanStatusLabel:SetDesc("Leviathan Is Out There")
                elseif v1017 == 0 then
                    spyLeviathanStatusLabel:SetDesc("I Don\'t Know")
                else
                    spyLeviathanStatusLabel:SetDesc("Mua: " .. tostring(v1017))
                end
            end
        end)
    end)
end
local v1018 = Tabs.Sea:AddSection("Draco")
Tabs.Sea:AddToggle("ToggleBlazeEmber", {
    ["Title"] = "Auto Blaze Ember",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoBlazeEmber = state
end)
spawn(function()
    while wait() do
        if _G.AutoBlazeEmber then
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/DragonDojoEmber"):FireServer()
            end)
        end
    end
end)
Tabs.Sea:AddToggle("ToggleReceiveQuest", {
    ["Title"] = "Get Blaze Ember Quest",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoReceiveQuest = state
    if _G.AutoReceiveQuest then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906))
        Tween2(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
        spawn(function()
            pcall(function()
                while wait() do
                    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/DragonHunter"):InvokeServer(unpack({
                        {
                            ["Context"] = "RequestQuest"
                        }
                    }))
                    game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/DragonHunter"):InvokeServer(unpack({
                        {
                            ["Context"] = "Check"
                        }
                    }))
                end
            end)
        end)
    end
end)
local scrollQuestStatusLabel = Tabs.Sea:AddParagraph({
    ["Title"] = "Blaze Ember Quest Status",
    ["Content"] = ""
})
spawn(function()
    pcall(function()
        while wait() do
            local v1022 = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/DragonHunter"):InvokeServer(unpack({
                {
                    ["Context"] = "Check"
                }
            }))
            if typeof(v1022) ~= "table" then
                print(v1022)
            else
                for v1025, v1026 in pairs(v1022) do
                    if v1026 == "Defeat 3 Venomous Assailants on Hydra Island." then
                        scrollQuestStatusLabel:SetDesc("Defeat 3 Venomous Assailants on Hydra Island.")
                    elseif v1026 == "Defeat 3 Hydra Enforcers on Hydra Island." then
                        scrollQuestStatusLabel:SetDesc("Defeat 3 Hydra Enforcers on Hydra Island.")
                    elseif v1026 == "Destroy 10 trees on Hydra Island." then
                        scrollQuestStatusLabel:SetDesc("Destroy 10 trees on Hydra Island.")
                    end
                end
            end
        end
    end)
end)
Tabs.Sea:AddToggle("ToggleHydraTree", {
    ["Title"] = "Destroy Trees on Hydra Island",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoHydraTree = state
end)
local function simulateKeyPress(keyName)
    local v1029 = game:GetService("VirtualInputManager")
    v1029:SendKeyEvent(true, keyName, false, game)
    v1029:SendKeyEvent(false, keyName, false, game)
end
local function equipAndCastSkills(toolType)
    local v1032 = game.Players.LocalPlayer
    local v1033 = v1032.Backpack
    for v1036, v1037 in pairs(v1033:GetChildren()) do
        if v1037:IsA("Tool") and v1037.ToolTip == toolType then
            v1037.Parent = v1032.Character
            local v1038, v1039, v1040 = ipairs({
                "Z",
                "X",
                "C",
                "V",
                "F"
            })
            while true do
                local activeSkillKey
                v1040, activeSkillKey = v1038(v1039, v1040)
                if v1040 == nil then
                    break
                end
                wait()
                pcall(function()
                    simulateKeyPress(activeSkillKey)
                end)
            end
            v1037.Parent = v1033
            break
        end
    end
end
local hydraTreeTargetCFrames = {
    CFrame.new(5288.61962890625, 1005.4000244140625, 392.43011474609375),
    CFrame.new(5343.39453125, 1004.1998901367188, 361.0687561035156),
    CFrame.new(5235.78564453125, 1004.1998901367188, 431.4530944824219),
    CFrame.new(5321.30615234375, 1004.1998901367188, 440.8951416015625),
    CFrame.new(5258.96484375, 1004.1998901367188, 345.5052490234375)
}
spawn(function()
    while wait() do
        if _G.AutoHydraTree then
            AutoHaki()
            local v1044, v1045, v1046 = ipairs(hydraTreeTargetCFrames)
            while true do
                local v1047
                v1046, v1047 = v1044(v1045, v1046)
                if v1046 == nil or not _G.AutoHydraTree then
                    break
                end
                Tween2(v1047)
                wait()
                local v1048 = game.Players.LocalPlayer.Character
                if v1048 and (v1048:FindFirstChild("HumanoidRootPart") and (v1048.HumanoidRootPart.Position - v1047.Position).Magnitude <= 1) then
                    equipAndCastSkills("Melee")
                    equipAndCastSkills("Sword")
                    equipAndCastSkills("Gun")
                end
            end
        end
    end
end)
v1018:AddButton({
    ["Title"] = "Teleport to Dragon Dojo",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906))
        Tween2(CFrame.new(5814.42724609375, 1208.3267822265625, 884.5785522460938))
    end
})
v1018:AddButton({
    ["Title"] = "Buy Volcano Magnet",
    ["Description"] = "",
    ["Callback"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({
            "CraftItem",
            "Craft",
            "Volcanic Magnet"
        }))
    end
})
Tabs.Sea:AddToggle("ToggleCollectFireFlowers", {
    ["Title"] = "Auto Collect Fire Flowers",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoCollectFireFlowers = state
end)
spawn(function()
    while wait() do
        local v1050 = _G.AutoCollectFireFlowers and workspace:FindFirstChild("FireFlowers")
        if v1050 then
            for v1053, v1054 in pairs(v1050:GetChildren()) do
                if v1054:IsA("Model") and v1054.PrimaryPart then
                    local v1055 = v1054.PrimaryPart.Position
                    if (v1055 - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 1 then
                        Tween2(CFrame.new(v1055))
                    else
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                        wait(1.5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                    end
                end
            end
        end
    end
end)
Tabs.Sea:AddToggle("ToggleWhiteBelt", {
    ["Title"] = "Auto White Belt",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoLevel = state
    if state then
        game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({
            {
                ["NPC"] = "Dojo Trainer",
                ["Command"] = "RequestQuest"
            }
        }))
        spawn(function()
            while _G.AutoLevel do
                game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({
                    {
                        ["NPC"] = "Dojo Trainer",
                        ["Command"] = "ClaimQuest"
                    }
                }))
                wait()
            end
        end)
    end
end)
Tabs.Sea:AddParagraph({
    ["Title"] = "Dragon Race",
    ["Content"] = ""
})
Tabs.Sea:AddToggle("ToggleTrialTeleport", {
    ["Title"] = "Fly to Dragon Trial Door",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoTrialTeleport = state
end)
spawn(function()
    while wait() do
        if _G.AutoTrialTeleport then
            local v1058 = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")
            if v1058 and v1058:IsA("Part") then
                Tween2(CFrame.new(v1058.Position))
            end
        end
    end
end)
Tabs.Sea:AddSection("Prehistoric Island")
local prehistoricIslandStatusLabel = Tabs.Sea:AddParagraph({
    ["Title"] = "Volcano Island Status",
    ["Content"] = ""
})
spawn(function()
    pcall(function()
        while wait() do
            if ggame:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                prehistoricIslandStatusLabel:SetDesc("Prehistoric Island: ✅️")
            else
                prehistoricIslandStatusLabel:SetDesc("Prehistoric Island: ❌️")
            end
        end
    end)
end)
Tabs.Sea:AddToggle("ToggleTPVolcano", {
    ["Title"] = "Fly to Volcano Island",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.TweenToPrehistoric = state
end)
UIOptions.ToggleTPVolcano:SetValue(false)
spawn(function()
    local v1061 = nil
    while not v1061 do
        v1061 = game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
        wait()
    end
    while wait() do
        local v1062 = _G.TweenToPrehistoric and game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland")
        if v1062 then
            local v1063 = v1062:FindFirstChild("Core")
            if v1063 then
                v1063 = v1062.Core:FindFirstChild("PrehistoricRelic")
            end
            if v1063 then
                v1063 = v1063:FindFirstChild("Skull")
            end
            if v1063 then
                Tween2(CFrame.new(v1063.Position))
                _G.TweenToPrehistoric = false
            end
        end
    end
end)
Tabs.Sea:AddToggle("ToggleDefendVolcano", {
    ["Title"] = "Safe",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoDefendVolcano = state
end)
Tabs.Sea:AddToggle("ToggleMelee", {
    ["Title"] = "Use Melee",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.UseMelee = state
end)
Tabs.Sea:AddToggle("ToggleSword", {
    ["Title"] = "Use Sword",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.UseSword = state
end)
Tabs.Sea:AddToggle("ToggleGun", {
    ["Title"] = "Use Gun",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.UseGun = state
end)
local function simulateVolcanoKeyPress(keyName)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, keyName, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, keyName, false, game)
end
local function cleanPrehistoricLavaParts()
    local v1070 = game.Workspace.Map.PrehistoricIsland.Core:FindFirstChild("InteriorLava")
    if v1070 and v1070:IsA("Model") then
        v1070:Destroy()
    end
    local v1071 = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
    if v1071 then
        for v1074, v1075 in pairs(v1071:GetDescendants()) do
            if v1075:IsA("Part") and v1075.Name:lower():find("lava") then
                v1075:Destroy()
            end
        end
    end
    local v1076 = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
    if v1076 then
        for v1079, v1080 in pairs(v1076:GetDescendants()) do
            if v1080:IsA("Model") then
                for v1083, v1084 in pairs(v1080:GetDescendants()) do
                    if v1084:IsA("MeshPart") and v1084.Name:lower():find("lava") then
                        v1084:Destroy()
                    end
                end
            end
        end
    end
end
local function findActiveVolcanoOre()
    local v1086 = game.Workspace.Map.PrehistoricIsland.Core.VolcanoRocks
    for v1089, v1090 in pairs(v1086:GetChildren()) do
        if v1090:IsA("Model") then
            local v1091 = v1090:FindFirstChild("volcanorock")
            if v1091 and v1091:IsA("MeshPart") then
                local v1092 = v1091.Color
                if v1092 == Color3.fromRGB(185, 53, 56) or v1092 == Color3.fromRGB(185, 53, 57) then
                    return v1091
                end
            end
        end
    end
    return nil
end
local function castVolcanoSkills(toolType)
    local v1095 = game.Players.LocalPlayer
    local v1096 = v1095.Backpack
    for v1099, v1100 in pairs(v1096:GetChildren()) do
        if v1100:IsA("Tool") and v1100.ToolTip == toolType then
            v1100.Parent = v1095.Character
            local v1101, v1102, v1103 = ipairs({
                "Z",
                "X",
                "C",
                "V",
                "F"
            })
            while true do
                local activeVolcanoSkillKey
                v1103, activeVolcanoSkillKey = v1101(v1102, v1103)
                if v1103 == nil then
                    break
                end
                wait()
                pcall(function()
                    simulateVolcanoKeyPress(activeVolcanoSkillKey)
                end)
            end
            v1100.Parent = v1096
            break
        end
    end
end
spawn(function()
    while wait() do
        if _G.AutoDefendVolcano then
            AutoHaki()
            pcall(cleanPrehistoricLavaParts)
            local v1106 = findActiveVolcanoOre()
            if v1106 then
                local v1107 = CFrame.new(v1106.Position + Vector3.new(0, 0, 0))
                Tween2(v1107)
                local v1108 = v1106.Color
                if v1108 == Color3.fromRGB(185, 53, 56) or v1108 == Color3.fromRGB(185, 53, 57) then
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1106.Position - Vector3.new(0, 0, 0)).Magnitude <= 1 then
                        if _G.UseMelee then
                            castVolcanoSkills("Melee")
                        end
                        if _G.UseSword then
                            castVolcanoSkills("Sword")
                        end
                        if _G.UseGun then
                            castVolcanoSkills("Gun")
                        end
                    end
                    _G.TweenToPrehistoric = false
                else
                    findActiveVolcanoOre()
                end
            else
                _G.TweenToPrehistoric = true
            end
        end
    end
end)
Tabs.Sea:AddToggle("ToggleKillAura", {
    ["Title"] = "Kill Aura Golems",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    KillAura = state
end)
UIOptions.ToggleKillAura:SetValue(false)
spawn(function()
    while wait() do
        if KillAura then
            pcall(function()
                for v1112, v1113 in pairs(game.Workspace.Enemies:GetDescendants()) do
                    if v1113:FindFirstChild("Humanoid") and (v1113:FindFirstChild("HumanoidRootPart") and v1113.Humanoid.Health > 0) then
                        repeat
                            task.wait()
                            sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge)
                            v1113.Humanoid.Health = 0
                            v1113.HumanoidRootPart.CanCollide = false
                        until not KillAura or (not v1113.Parent or v1113.Humanoid.Health <= 0)
                    end
                end
            end)
        end
    end
end)
Tabs.Sea:AddToggle("ToggleCollectBone", {
    ["Title"] = "Collect Bones",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoCollectBone = state
end)
spawn(function()
    while wait() do
        if _G.AutoCollectBone then
            for v1117, v1118 in pairs(workspace:GetDescendants()) do
                if v1118:IsA("BasePart") and v1118.Name == "DinoBone" then
                    Tween2(CFrame.new(v1118.Position))
                end
            end
        end
    end
end)
Tabs.Sea:AddToggle("ToggleCollectEgg", {
    ["Title"] = "Collect Dragon Eggs",
    ["Description"] = "",
    ["Default"] = false
}):OnChanged(function(state)
    _G.AutoCollectEgg = state
end)
spawn(function()
    while wait() do
        if _G.AutoCollectEgg then
            local v1120 = workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:GetChildren()
            if # v1120 > 0 then
                local v1121 = v1120[math.random(1, # v1120)]
                if v1121:IsA("Model") and v1121.PrimaryPart then
                    Tween2(v1121.PrimaryPart.CFrame)
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v1121.PrimaryPart.Position).Magnitude <= 1 then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                        wait(1.5)
                        game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                    end
                end
            end
        end
    end
end)
