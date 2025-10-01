-- Services
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- UI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0.5, -100, 0.5, -60)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Buttons
local MarkButton = Instance.new("TextButton", Frame)
MarkButton.Size = UDim2.new(1, -20, 0, 40)
MarkButton.Position = UDim2.new(0, 10, 0, 10)
MarkButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MarkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MarkButton.Text = "Fire ClickedMark"

local RejoinButton = Instance.new("TextButton", Frame)
RejoinButton.Size = UDim2.new(1, -20, 0, 40)
RejoinButton.Position = UDim2.new(0, 10, 0, 60)
RejoinButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
RejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinButton.Text = "Reconnect Same Server"

local CloseButton = Instance.new("TextButton", Frame)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Button Functions
MarkButton.MouseButton1Click:Connect(function()
    game.ReplicatedStorage.Remotes.ClickedMark:FireServer("\u{D800}")
end)

RejoinButton.MouseButton1Click:Connect(function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
