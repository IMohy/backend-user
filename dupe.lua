-- Better Custom UI

local UserInputService = game:GetService("UserInputService")

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "CustomUI"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 180)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Parent = gui

-- Rounded frame
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🌟 Custom UI"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame

-- Layout
local layout = Instance.new("UIListLayout")
layout.Parent = mainFrame
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 12)

-- Padding so title isn't covered
local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 45)
padding.Parent = mainFrame

-- Function to make nicer buttons
local function createButton(text, color)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 200, 0, 45)
	button.Text = text
	button.Font = Enum.Font.GothamBold
	button.TextSize = 18
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = color or Color3.fromRGB(60, 120, 220)
	button.AutoButtonColor = false

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = button

	-- Drop shadow
	local shadow = Instance.new("UIStroke")
	shadow.Thickness = 2
	shadow.Color = Color3.fromRGB(0, 0, 0)
	shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	shadow.Parent = button

	-- Hover effect
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = (color or Color3.fromRGB(60, 120, 220)):Lerp(Color3.new(1,1,1), 0.2)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = color or Color3.fromRGB(60, 120, 220)
	end)

	return button
end

-- Buttons
local markButton = createButton("Send Mark", Color3.fromRGB(0, 170, 255))
local rejoinButton = createButton("Rejoin Server", Color3.fromRGB(0, 200, 120))

markButton.Parent = mainFrame
rejoinButton.Parent = mainFrame

-- Functionality
markButton.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.ClickedMark:FireServer("\u{D800}")
end)

rejoinButton.MouseButton1Click:Connect(function()
	local TeleportService = game:GetService("TeleportService")
	local player = game.Players.LocalPlayer
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)

-- Toggle with RightShift
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
		mainFrame.Visible = not mainFrame.Visible
	end
end)
