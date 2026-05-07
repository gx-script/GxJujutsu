local GX_HUB = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LeftPanel = Instance.new("Frame")
local TabContainer = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ContentFrame = Instance.new("Frame")
local AuthOverlay = Instance.new("Frame")

GX_HUB.Name = "GX_HUB_PRO_FIXED"
GX_HUB.Parent = game:GetService("CoreGui")
GX_HUB.ResetOnSpawn = false

AuthOverlay.Name = "AuthOverlay"
AuthOverlay.Parent = GX_HUB
AuthOverlay.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
AuthOverlay.BackgroundTransparency = 0.1
AuthOverlay.Size = UDim2.new(1, 0, 1, 0)
AuthOverlay.ZIndex = 100

local AuthBox = Instance.new("Frame")
AuthBox.Size = UDim2.new(0, 320, 0, 190)
AuthBox.Position = UDim2.new(0.5, -160, 0.5, -95)
AuthBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
AuthBox.Parent = AuthOverlay
Instance.new("UICorner", AuthBox).CornerRadius = UDim.new(0, 14)
local AuthStroke = Instance.new("UIStroke", AuthBox)
AuthStroke.Color = Color3.fromRGB(170, 0, 255)
AuthStroke.Thickness = 2

local AuthTitle = Instance.new("TextLabel")
AuthTitle.Size = UDim2.new(1, 0, 0, 45)
AuthTitle.BackgroundTransparency = 1
AuthTitle.Text = "GX HUB LOGIN"
AuthTitle.TextColor3 = Color3.fromRGB(170, 0, 255)
AuthTitle.Font = Enum.Font.GothamBold
AuthTitle.TextSize = 20
AuthTitle.Parent = AuthBox

local PassInput = Instance.new("TextBox")
PassInput.Size = UDim2.new(0.82, 0, 0, 45)
PassInput.Position = UDim2.new(0.09, 0, 0.33, 0)
PassInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PassInput.PlaceholderText = "ENTER KEY (GX999)"
PassInput.Text = ""
PassInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 14
PassInput.Parent = AuthBox
Instance.new("UICorner", PassInput).CornerRadius = UDim.new(0, 10)

local KeyBtn = Instance.new("TextButton")
KeyBtn.Size = UDim2.new(0.82, 0, 0, 38)
KeyBtn.Position = UDim2.new(0.09, 0, 0.67, 0)
KeyBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
KeyBtn.Text = "GET KEY"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.TextSize = 14
KeyBtn.Parent = AuthBox
Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 10)

MainFrame.Name = "MainFrame"
MainFrame.Parent = GX_HUB
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(170, 0, 255)
MainStroke.Thickness = 2

LeftPanel.Size = UDim2.new(0, 160, 1, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
LeftPanel.Parent = MainFrame
Instance.new("UICorner", LeftPanel).CornerRadius = UDim.new(0, 14)

Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "GX HUB"
Title.TextColor3 = Color3.fromRGB(170, 0, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = LeftPanel

TabContainer.Size = UDim2.new(1, 0, 0.7, 0)
TabContainer.Position = UDim2.new(0, 0, 0.25, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = LeftPanel
Instance.new("UIListLayout", TabContainer).Padding = UDim.new(0, 6)

ContentFrame.Size = UDim2.new(0, 370, 0, 280)
ContentFrame.Position = UDim2.new(0, 170, 0, 55)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentFrame.Parent = MainFrame
Instance.new("UICorner", ContentFrame).CornerRadius = UDim.new(0, 12)

local pages = {}
local lp = game.Players.LocalPlayer

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 38)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = TabContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.new(0, 10, 0, 10)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 3
    page.Parent = ContentFrame
    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 10)
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)

    pages[name] = page
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)
    return page
end

local function addToggle(name, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name .. " : OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = name .. " : " .. (state and "ON" or "OFF")
        btn.TextColor3 = state and Color3.fromRGB(170, 0, 255) or Color3.fromRGB(255, 255, 255)
        callback(state)
    end)
end

local MainTab = createTab("Main Menu")
local PowerTab = createTab("Power")
local MiscTab = createTab("Misc")

local runService = game:GetService("RunService")
local fastModeLoop
addToggle("Fast Mode", MainTab, function(v)
    if v then
        fastModeLoop = runService.Heartbeat:Connect(function()
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                lp.Character.Humanoid.WalkSpeed = 100
            end
        end)
    else
        if fastModeLoop then fastModeLoop:Disconnect() end
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

addToggle("No Cooldown", MainTab, function(v)
    _G.NoCD = v
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        if _G.NoCD and getnamecallmethod() == "FireServer" and (self.Name:lower():find("skill") or self.Name:lower():find("cooldown")) then
            return
        end
        return old(self, ...)
    end)
end)

local flying = false
local flySpeed = 50
addToggle("Fly", MiscTab, function(v)
    flying = v
    if flying then
        local bv = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Name = "GX_Fly"
        task.spawn(function()
            while flying do
                bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

local noclipConn
addToggle("Noclip", MiscTab, function(v)
    if v then
        noclipConn = runService.Stepped:Connect(function()
            if lp.Character then
                for _, part in pairs(lp.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() end
    end
end)

PassInput:GetPropertyChangedSignal("Text"):Connect(function()
    if PassInput.Text == "GX999" then
        AuthOverlay:Destroy()
        MainFrame.Visible = true
        MainTab.Visible = true
    end
end)

KeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://t.me/+CNWsHkaEGAkxOWJl")
end)
