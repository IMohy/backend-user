-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "CustomUI"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 180)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Drop shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Parent = mainFrame
shadow.BackgroundTransparency = 1
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 6)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Custom UI"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame

-- UIListLayout for buttons
local layout = Instance.new("UIListLayout")
layout.Parent = mainFrame
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 12)

-- Function to make styled buttons
local function createButton(text)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 180, 0, 45)
	button.Text = text
	button.Font = Enum.Font.Gotham
	button.TextSize = 18
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
	button.AutoButtonColor = false
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = button

	-- Hover effect
	button.MouseEnter:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(80, 140, 240)
	end)
	button.MouseLeave:Connect(function()
		button.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
	end)

	return button
end

-- Create buttons
local markButton = createButton("Send Mark")
local rejoinButton = createButton("Rejoin Server")

markButton.Parent = mainFrame
rejoinButton.Parent = mainFrame

-- Button functionality
markButton.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.Remotes.ClickedMark:FireServer("\u{D800}")
end)

rejoinButton.MouseButton1Click:Connect(function()
	local TeleportService = game:GetService("TeleportService")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
end)
