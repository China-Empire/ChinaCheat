local p = game:GetService("Players").LocalPlayer
local guiName = "CleanDeleteFlyGui"
if p.PlayerGui:FindFirstChild(guiName) then p.PlayerGui[guiName]:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = guiName
sg.ResetOnSpawn = false
sg.Parent = p:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 190, 0, 185)
mainFrame.Position = UDim2.new(0, 10, 0, 150)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BackgroundTransparency = 0.2
mainFrame.Parent = sg

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = mainFrame

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local cam = workspace.CurrentCamera

local FlySpeed = 50
local FlyEnabled = false
local DeleteModeEnabled = false
local FlyConnection = nil
local TouchConnection = nil

local function GetRoot() return p.Character and p.Character:FindFirstChild("HumanoidRootPart") end
local function GetHum() return p.Character and p.Character:FindFirstChildOfClass("Humanoid") end

local function ShutdownCheat()
    FlyEnabled = false
    DeleteModeEnabled = false
    
    if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    if TouchConnection then TouchConnection:Disconnect() TouchConnection = nil end
    
    local root = GetRoot()
    local hum = GetHum()
    if root then
        if root:FindFirstChild("FlightVelocity") then root.FlightVelocity:Destroy() end
        if root:FindFirstChild("FlightGyro") then root.FlightGyro:Destroy() end
    end
    if hum then 
        hum.WalkSpeed = 16 
        hum:ChangeState(Enum.HumanoidStateType.GettingUp) 
    end
    
    sg:Destroy()
    print("Чит полностью отключен и удален.")
end

local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(0, 25, 0, 25)
btnClose.Position = UDim2.new(1, -30, 0, 5)
btnClose.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
btnClose.TextColor3 = Color3.fromRGB(255, 255, 255)
btnClose.TextSize = 14
btnClose.Font = Enum.Font.SourceSansBold
btnClose.Text = "X"
btnClose.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = btnClose

btnClose.MouseButton1Click:Connect(ShutdownCheat)

local btnDel = Instance.new("TextButton")
btnDel.Size = UDim2.new(0, 170, 0, 40)
btnDel.Position = UDim2.new(0, 10, 0, 35)
btnDel.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
btnDel.TextColor3 = Color3.fromRGB(255, 255, 255)
btnDel.TextSize = 13
btnDel.Font = Enum.Font.SourceSansBold
btnDel.Text = "Режим удаления: ВЫКЛ"
btnDel.Parent = mainFrame

local delCorner = Instance.new("UICorner")
delCorner.CornerRadius = UDim.new(0, 6)
delCorner.Parent = btnDel

local boxSpeed = Instance.new("TextBox")
boxSpeed.Size = UDim2.new(0, 170, 0, 30)
boxSpeed.Position = UDim2.new(0, 10, 0, 85)
boxSpeed.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
boxSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
boxSpeed.TextSize = 13
boxSpeed.Font = Enum.Font.SourceSans
boxSpeed.Text = "50"
boxSpeed.PlaceholderText = "Скорость полета..."
boxSpeed.Parent = mainFrame

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = boxSpeed

boxSpeed.FocusLost:Connect(function()
    local num = tonumber(boxSpeed.Text)
    if num then FlySpeed = num else boxSpeed.Text = tostring(FlySpeed) end
end)

local btnFly = Instance.new("TextButton")
btnFly.Size = UDim2.new(0, 170, 0, 40)
btnFly.Position = UDim2.new(0, 10, 0, 125)
btnFly.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Изначально красная
btnFly.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFly.TextSize = 13
btnFly.Font = Enum.Font.SourceSansBold
btnFly.Text = "Полет: ВЫКЛ"
btnFly.Parent = mainFrame

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 6)
flyCorner.Parent = btnFly

local function AttemptDelete(screenPosition)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    if p.Character then params.FilterDescendantsInstances = {p.Character} end

    local unitRay = cam:ScreenPointToRay(screenPosition.X, screenPosition.Y)
    local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000, params)

    if result and result.Instance then
        local target = result.Instance
        if target ~= workspace.Terrain and target.Name ~= "Baseplate" then
            local root = target
            if target.Parent and target.Parent ~= workspace and not target.Parent:IsA("Folder") then
                root = target.Parent
            end

            local function clean(obj)
                if obj:IsA("BasePart") then obj.CanCollide = false obj.Transparency = 1 end
                for _, c in ipairs(obj:GetChildren()) do clean(c) end
            end
            clean(root)

            task.delay(1, function() if root and root.Parent then root:Destroy() end end)
        end
    end
end

TouchConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if not DeleteModeEnabled then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        AttemptDelete(UserInputService:GetMouseLocation())
    end
end)

btnDel.MouseButton1Click:Connect(function()
    DeleteModeEnabled = not DeleteModeEnabled
    if DeleteModeEnabled then
        btnDel.Text = "Режим удаления: ВКЛ"
        btnDel.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Зеленая
    else
        btnDel.Text = "Режим удаления: ВЫКЛ"
        btnDel.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Красная
    end
end)

local function UpdateFlight()
    local root = GetRoot()
    local hum = GetHum()
    if not root or not hum then return end

    if FlyEnabled then
        hum.WalkSpeed = 0
        local vel = root:FindFirstChild("FlightVelocity") or Instance.new("BodyVelocity", root)
        vel.Name = "FlightVelocity"
        vel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

        local gyro = root:FindFirstChild("FlightGyro") or Instance.new("BodyGyro", root)
        gyro.Name = "FlightGyro"
        gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        gyro.P = 10000

        if not FlyConnection then
            FlyConnection = RunService.RenderStepped:Connect(function()
                local r, h = GetRoot(), GetHum()
                if not r or not h or not FlyEnabled then return end
                if r:FindFirstChild("FlightGyro") then r.FlightGyro.CFrame = cam.CFrame end
                if r:FindFirstChild("FlightVelocity") then
                    local md = h.MoveDirection
                    if md.Magnitude > 0 then
                        local forward = md:Dot(cam.CFrame.LookVector)
                        local right = md:Dot(cam.CFrame.RightVector)
                        r.FlightVelocity.Velocity = ((cam.CFrame.LookVector * forward) + (cam.CFrame.RightVector * right)).Unit * FlySpeed
                    else
                        r.FlightVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        end
    else
        if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
        if root:FindFirstChild("FlightVelocity") then root.FlightVelocity:Destroy() end
        if root:FindFirstChild("FlightGyro") then root.FlightGyro:Destroy() end
        if hum then hum.WalkSpeed = 16 hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
    end
end

btnFly.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    if FlyEnabled then
        btnFly.Text = "Полет: ВКЛ"
        btnFly.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Зеленая
    else
        btnFly.Text = "Полет: ВЫКЛ"
        btnFly.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Красная
    end
    UpdateFlight()
end)

p.CharacterRemoving:Connect(function()
    if FlyEnabled then
        FlyEnabled = false
        btnFly.Text = "Полет: ВЫКЛ"
        btnFly.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    end
    if DeleteModeEnabled then
        DeleteModeEnabled = false
        btnDel.Text = "Режим удаления: ВЫКЛ"
        btnDel.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    end
end)
