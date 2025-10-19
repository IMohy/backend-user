--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

--// GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoDigUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

--// Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 180)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

--// Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -35, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "Rifton Auto Dig + Logger"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

--// Close Button
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.BackgroundTransparency = 1
close.Text = "✖"
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

--// Buttons
local function makeButton(text, color, posY)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Position = UDim2.new(0.05, 0, 0, posY)
	btn.BackgroundColor3 = color
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 16
	btn.Text = text
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local startButton = makeButton("Start Dig", Color3.fromRGB(50, 200, 50), 40)
local stopButton  = makeButton("Stop Dig",  Color3.fromRGB(200, 50, 50), 80)
local sellButton  = makeButton("Sell Inventory", Color3.fromRGB(50, 150, 200), 120)
local logButton   = makeButton("Start Logger", Color3.fromRGB(150, 100, 250), 160)

--// Digging logic
local running = false
local digLoop

local function startDigging()
	if running then return end
	running = true
	game.StarterGui:SetCore("SendNotification", {Title = "Rifton", Text = "Auto Dig Started!", Duration = 3})
	digLoop = task.spawn(function()
		while running do
			local net = ReplicatedStorage:WaitForChild("Network")
			local rf = net.RemoteFunctions.StartDigging
			local re = net.RemoteEvents.EndDigging
			rf:InvokeServer()
			task.wait(0.1)
			re:FireServer("Succeeded")
			task.wait(0.1)
		end
	end)
end

local function stopDigging()
	running = false
	game.StarterGui:SetCore("SendNotification", {Title = "Rifton", Text = "Auto Dig Stopped!", Duration = 3})
end

local function sellInventory()
	local network = ReplicatedStorage:WaitForChild("Network")
	local pawn = network.RemoteEvents:WaitForChild("PawnShopInteraction")
	pawn:FireServer("SellInventory")
	game.StarterGui:SetCore("SendNotification", {Title = "Rifton", Text = "Inventory sold!", Duration = 3})
end

--// Logger (for research/debug only)
local logging = false
local connections = {}

local function startLogger()
	if logging then
		game.StarterGui:SetCore("SendNotification", {Title = "Logger", Text = "Already running.", Duration = 3})
		return
	end
	logging = true

	game.StarterGui:SetCore("SendNotification", {Title = "Logger", Text = "ReplicatedStorage logger started!", Duration = 4})
	print("=== ReplicatedStorage Logger Started ===")

	local function connectRemote(obj)
		if obj:IsA("RemoteEvent") then
			local c = obj.OnClientEvent:Connect(function(...)
				print("[RemoteEvent]", obj:GetFullName(), ...)
			end)
			table.insert(connections, c)
		elseif obj:IsA("RemoteFunction") then
			local c = obj.OnClientInvoke:Connect(function(...)
				print("[RemoteFunction]", obj:GetFullName(), ...)
			end)
			table.insert(connections, c)
		end
	end

	-- Connect all existing remotes
	for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
		if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
			connectRemote(obj)
		end
	end

	-- Watch for new remotes being added
	local c = ReplicatedStorage.DescendantAdded:Connect(function(obj)
		if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
			connectRemote(obj)
			print("[Logger] New remote found:", obj:GetFullName())
		end
	end)
	table.insert(connections, c)
end

local function stopLogger()
	if not logging then return end
	logging = false
	for _, c in pairs(connections) do
		c:Disconnect()
	end
	table.clear(connections)
	print("=== ReplicatedStorage Logger Stopped ===")
	game.StarterGui:SetCore("SendNotification", {Title = "Logger", Text = "Logger stopped.", Duration = 3})
end

--// Button Connections
startButton.MouseButton1Click:Connect(startDigging)
stopButton.MouseButton1Click:Connect(stopDigging)
sellButton.MouseButton1Click:Connect(sellInventory)
logButton.MouseButton1Click:Connect(function()
	if not logging then
		startLogger()
		logButton.Text = "Stop Logger"
		logButton.BackgroundColor3 = Color3.fromRGB(255, 120, 50)
	else
		stopLogger()
		logButton.Text = "Start Logger"
		logButton.BackgroundColor3 = Color3.fromRGB(150, 100, 250)
	end
end)
