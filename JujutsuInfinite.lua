local GX_HUB = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local TabContainer = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Icon = Instance.new("ImageLabel")
local ContentFrame = Instance.new("Frame")
local AuthOverlay = Instance.new("Frame")

GX_HUB.Name = "GX_HUB"
GX_HUB.Parent = game:GetService("CoreGui")
GX_HUB.ResetOnSpawn = false

AuthOverlay.Name = "AuthOverlay"
AuthOverlay.Parent = GX_HUB
AuthOverlay.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
AuthOverlay.Size = UDim2.new(1, 0, 1, 0)
AuthOverlay.ZIndex = 10

local AuthBox = Instance.new("Frame")
AuthBox.Size = UDim2.new(0, 300, 0, 200)
AuthBox.Position = UDim2.new(0.5, -150, 0.5, -100)
AuthBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
AuthBox.Parent = AuthOverlay
Instance.new("UICorner", AuthBox)
local Stroke = Instance.new("UIStroke", AuthBox)
Stroke.Color = Color3.fromRGB(170, 0, 255)
Stroke.Thickness = 2

local PassInput = Instance.new("TextBox")
PassInput.Size = UDim2.new(0.8, 0, 0, 40)
PassInput.Position = UDim2.new(0.1, 0, 0.3, 0)
PassInput.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
PassInput.PlaceholderText = "ENTER PASSWORD..."
PassInput.Text = ""
PassInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PassInput.Parent = AuthBox
Instance.new("UICorner", PassInput)

local KeyBtn = Instance.new("TextButton")
KeyBtn.Size = UDim2.new(0.8, 0, 0, 35)
KeyBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 200)
KeyBtn.Text = "GET KEY (TELEGRAM)"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.Parent = AuthBox
Instance.new("UICorner", KeyBtn)

KeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://t.me/+CNWsHkaEGAkxOWJl")
end)

PassInput:GetPropertyChangedSignal("Text"):Connect(function()
    if PassInput.Text == "GX999" then
        AuthOverlay.Visible = false
    end
end)

MainFrame.Name = "MainFrame"
MainFrame.Parent = GX_HUB
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(170, 0, 255)

LeftPanel.Size = UDim2.new(0, 150, 1, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
LeftPanel.Parent = MainFrame
Instance.new("UICorner", LeftPanel)

Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "GX ULTIMATE"
Title.TextColor3 = Color3.fromRGB(170, 0, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = LeftPanel

Icon.Size = UDim2.new(0, 40, 0, 40)
Icon.Position = UDim2.new(0.5, -20, 0.15, 0)
Icon.Image = "rbxassetid://6031289129"
Icon.BackgroundTransparency = 1
Icon.Parent = LeftPanel

TabContainer.Size = UDim2.new(1, 0, 0.6, 0)
TabContainer.Position = UDim2.new(0, 0, 0.3, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = LeftPanel
local TabList = Instance.new("UIListLayout", TabContainer)
TabList.Padding = UDim.new(0, 5)

ContentFrame.Size = UDim2.new(0, 380, 0, 280)
ContentFrame.Position = UDim2.new(0, 160, 0, 50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentFrame.Parent = MainFrame
Instance.new("UICorner", ContentFrame)

local function createTab(name, id)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.Gotham
    btn.Parent = TabContainer
    Instance.new("UICorner", btn)
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Name = name .. "Page"
    page.Parent = ContentFrame
    Instance.new("UIListLayout", page).Padding = UDim.new(0, 10)
    
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(ContentFrame:GetChildren()) do
            if v:IsA("ScrollingFrame") then v.Visible = false end
        end
        page.Visible = true
    end)
    
    return page
end

local ClassicPage = createTab("Classic Mod")
local PowerPage = createTab("Get Power")
local MovementPage = createTab("Other")

local function addToggle(name, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = parent
    Instance.new("UICorner", btn)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. " : " .. (state and "ON" or "OFF")
        btn.TextColor3 = state and Color3.fromRGB(170, 0, 255) or Color3.fromRGB(255, 255, 255)
        callback(state)
    end)
end

local function addButton(name, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Parent = parent
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

addToggle("Fast Mode", ClassicPage, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val and 100 or 16
end)

addToggle("No Cooldown", ClassicPage, function(val)
    _G.NoCD = val
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if _G.NoCD and getnamecallmethod() == "FireServer" then return end
        return old(self, ...)
    end)
end)

addButton("Boost FPS", ClassicPage, function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then v.Material = Enum.Material.SmoothPlastic end
    end
end)

addButton("Get Ten Shadows", PowerPage, function()
    game:GetService("ReplicatedStorage").Remotes.Server.Spin:InvokeServer("Ten Shadows")
end)

addButton("Get Idle Transfiguration", PowerPage, function()
    game:GetService("ReplicatedStorage").Remotes.Server.Spin:InvokeServer("Idle Transfiguration")
end)

addButton("Get Limitless", PowerPage, function()
    game:GetService("ReplicatedStorage").Remotes.Server.Spin:InvokeServer("Limitless")
end)

local flying = false
addToggle("Fly", MovementPage, function(val)
    flying = val
    local bv = Instance.new("BodyVelocity")
    if flying then
        bv.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

addToggle("Noclip", MovementPage, function(val)
    game:GetService("RunService").Stepped:Connect(function()
        if val and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

addToggle("Infinity Jump", MovementPage, function(val)
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if val then game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
    end)
end)

ClassicPage.Visible = true
