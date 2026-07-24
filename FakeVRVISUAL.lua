-- этот скрипт толькотдля R6 персонажей и скрипт визуал
local p, r, u = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService")
local me, char = p.LocalPlayer, p.LocalPlayer.Character or p.LocalPlayer.CharacterAdded:Wait()
local body, hum = char:WaitForChild("Torso"), char:WaitForChild("Humanoid")
local lJ, rJ = body:WaitForChild("Left Shoulder"), body:WaitForChild("Right Shoulder")
local lA, rA = char:WaitForChild("Left Arm"), char:WaitForChild("Right Arm")
if me.PlayerGui:FindFirstChild("ArmJoystickGui") then me.PlayerGui.ArmJoystickGui:Destroy() end
if _G.ArmJoystickCleaner then _G.ArmJoystickCleaner() end
local ui = Instance.new("ScreenGui", me.PlayerGui)
ui.Name, ui.ResetOnSpawn = "ArmJoystickGui", false
local blk, spc = false, false
local function makeJ(pos, f)
    local b = Instance.new("Frame", ui)
    b.Size, b.Position, b.AnchorPoint, b.BackgroundColor3, b.BackgroundTransparency, b.Active = UDim2.new(0, 110, 0, 110), pos, Vector2.new(0.5, 0.5), Color3.new(), 0.5, true
    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
    local s = Instance.new("Frame", b)
    s.Size, s.Position, s.AnchorPoint, s.BackgroundColor3, s.BackgroundTransparency = UDim2.new(0, 45, 0, 45), UDim2.new(0.5, 0, 0.5, 0), Vector2.new(0.5, 0.5), Color3.new(1, 1, 1), 0.3
    Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
    local dir, hold, activeTouch = Vector2.zero, false, nil
    local function calc(pt)
        if (not f and (blk or spc)) or (f and blk and not spc) then return end
        local o = Vector2.new(pt.X, pt.Y) - (b.AbsolutePosition + (b.AbsoluteSize / 2))
        local lim = b.AbsoluteSize.X / 2
        if o.Magnitude > lim then o = o.Unit * lim end
        s.Position = UDim2.new(0.5, o.X, 0.5, o.Y)
        dir = o / lim
    end
    b.InputBegan:Connect(function(i)
        if not f and (blk or spc) then return end
        if (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) and not hold then hold, activeTouch = true, i calc(i.Position) end
    end)
    u.InputChanged:Connect(function(i)
        if ((not f and (blk or spc)) or (f and blk and not spc)) and hold then hold, activeTouch, s.Position, dir = false, nil, UDim2.new(0.5, 0, 0.5, 0), Vector2.zero
        elseif hold and i == activeTouch then calc(i.Position) end
    end)
    u.InputEnded:Connect(function(i) if hold and i == activeTouch then hold, activeTouch, s.Position, dir = false, nil, UDim2.new(0.5, 0, 0.5, 0), Vector2.zero end end)
    return function() return ((not f and (blk or spc)) or (f and blk and not spc)) and Vector2.zero or dir end, b, s
end
local getL, lB, lSt = makeJ(UDim2.new(0.15, 0, 0.6, 0), false)
local getR, rB, rSt = makeJ(UDim2.new(0.85, 0, 0.6, 0), false)
local getS, sB, sSt = makeJ(UDim2.new(0.5, 0, 0.7, 0), true)
sB.Visible = false
local wm = Instance.new("Frame", ui)
wm.Size, wm.Position, wm.BackgroundColor3, wm.Active = UDim2.new(0, 230, 0, 35), UDim2.new(0, 20, 1, -55), Color3.fromRGB(0, 0, 0), true
Instance.new("UICorner", wm).CornerRadius = UDim.new(0, 6)
local lbl = Instance.new("TextLabel", wm)
lbl.Size, lbl.Position, lbl.BackgroundTransparency, lbl.BorderSizePixel, lbl.Text, lbl.TextColor3, lbl.TextSize, lbl.Font, lbl.TextXAlignment = UDim2.new(0, 120, 1, 0), UDim2.new(0, 10, 0, 0), 1, 0, "by China Emipre", Color3.new(1, 1, 1), 15, Enum.Font.SourceSansBold, Enum.TextXAlignment.Left
local sBtn = Instance.new("TextButton", wm)
sBtn.Size, sBtn.Position, sBtn.AnchorPoint, sBtn.BackgroundColor3, sBtn.BorderSizePixel, sBtn.Text, sBtn.TextColor3, sBtn.TextSize, sBtn.Font = UDim2.new(0, 30, 0, 25), UDim2.new(1, -65, 0.5, 0), Vector2.new(0.5, 0.5), Color3.fromRGB(30, 30, 30), 0, "💦", Color3.new(1, 1, 1), 14, Enum.Font.SourceSansBold
Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 4)
local cls = Instance.new("TextButton", wm)
cls.Size, cls.Position, cls.AnchorPoint, cls.BackgroundColor3, cls.BorderSizePixel, cls.Text, cls.TextColor3, cls.TextSize, cls.Font = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0.5, 0), Vector2.new(0.5, 0.5), Color3.fromRGB(30, 30, 30), 0, "×", Color3.new(1, 1, 1), 18, Enum.Font.SourceSansBold
Instance.new("UICorner", cls).CornerRadius = UDim.new(1, 0)
local inf = Instance.new("TextLabel", wm)
inf.Size, inf.Position, inf.BackgroundTransparency, inf.Text, inf.TextColor3, inf.TextSize, inf.Font, inf.BackgroundColor3 = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, -25), 0, "[!] Скрипт только для R6 аватаров", Color3.new(1,1,1), 14, Enum.Font.SourceSansBold, Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", inf).CornerRadius = UDim.new(0, 4)
task.delay(4, function() if inf then inf:Destroy() end end)
local dT, dS, sP = false, nil, nil
wm.InputBegan:Connect(function(i) if (i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch) and i.Target ~= cls and i.Target ~= sBtn then dT, dS, sP = true, i.Position, wm.Position end end)
u.InputChanged:Connect(function(i) if dT and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - dS wm.Position = UDim2.new(sP.X.Scale, sP.X.Offset + d.X, sP.Y.Scale, sP.Y.Offset + d.Y) end end)
u.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dT = false end end)
local sC0 = lJ and lJ.C0 or CFrame.new(-1, 0.5, 0)
sBtn.MouseButton1Click:Connect(function()
    spc = not spc sB.Visible = spc sBtn.BackgroundColor3 = spc and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(30, 30, 30)
    if not spc then if lJ then lJ.C0 = sC0 end if lA then lA.Size = Vector3.new(1, 2, 1) end if rA then rA.Size = Vector3.new(1, 2, 1) end end
end)
local run = true
local function shut()
    run = false ui:Destroy()
    if lJ then lJ.C0, lJ.Part1 = sC0, lA end if rJ then rJ.Part1 = rA end
    if lA then lA.Size = Vector3.new(1, 2, 1) end if rA then rA.Size = Vector3.new(1, 2, 1) end
end
cls.MouseButton1Click:Connect(shut) _G.ArmJoystickCleaner = shut
local fL, fR, dO = CFrame.new(-1.5, 0.9, 0), CFrame.new(1.5, 0.9, 0), CFrame.new(0, -0.9, 0)
local loop
loop = r.RenderStepped:Connect(function()
    if not run then loop:Disconnect() return end
    if not char or not hum or hum.Health < 1 then shut() return end
    local mov = hum.Jump or u:IsKeyDown(Enum.KeyCode.Space) or hum.MoveDirection.Magnitude > 0.05
    if mov and not spc then
        blk = true lB.BackgroundTransparency, lSt.BackgroundTransparency, rB.BackgroundTransparency, rSt.BackgroundTransparency, sB.BackgroundTransparency, sSt.BackgroundTransparency = 0.85, 0.85, 0.85, 0.85, 0.85, 0.85
        if lJ.C0 ~= sC0 then lJ.C0 = sC0 end if lJ.Part1 ~= lA then lJ.Part1 = lA end if rJ.Part1 ~= rA then rJ.Part1 = rA end
    else
        blk = spc and false or mov lB.BackgroundTransparency, lSt.BackgroundTransparency = spc and 0.85 or 0.5, spc and 0.85 or 0.3
        rB.BackgroundTransparency, rSt.BackgroundTransparency = spc and 0.85 or 0.5, spc and 0.85 or 0.3
        sB.BackgroundTransparency, sSt.BackgroundTransparency = spc and 0.5 or 0.85, spc and 0.3 or 0.85
        if spc then
            if lJ.Part1 ~= nil then lJ.Part1 = nil end if rJ.Part1 ~= nil then rJ.Part1 = nil end
            if lA then lA.Size, lA.CanCollide = Vector3.new(1, 4, 1), false lA.CFrame = body.CFrame * CFrame.new(0, -0.8, -1.5) * CFrame.Angles(math.rad(90), 0, 0) end
            if rA then rA.CanCollide = false end
            local sPos = (body.CFrame * CFrame.new(1.0, 0.5, 0)).Position
            local tPos = lA.CFrame * CFrame.new(0, math.clamp(-getS().Y * 1.8, -1.8, 1.8), 0).Position
            local vec = tPos - sPos local len = math.clamp(vec.Magnitude, 0.5, 4.5)
            if rA then rA.Size = Vector3.new(1, len, 1) rA.CFrame = CFrame.lookAt(sPos + (vec.Unit * (len / 2)), tPos) * CFrame.Angles(math.rad(90), 0, 0) end
        else
            if lJ.Part1 ~= nil then lJ.Part1 = nil end if rJ.Part1 ~= nil then rJ.Part1 = nil end
            if lJ.C0 ~= sC0 then lJ.C0 = sC0 end if lA and lA.Size.Y ~= 2 then lA.Size = Vector3.new(1, 2, 1) end
            if lA then lA.CanCollide = false end if rA then rA.CanCollide = false end
            local lL, rR = getL(), getR()
            if lA then lA.CFrame = body.CFrame * fL * CFrame.Angles(-lL.Y * 2, 0, lL.X * 2) * dO end
            if rA then rA.CFrame = body.CFrame * fR * CFrame.Angles(-rR.Y * 2, 0, rR.X * 2) * dO end
        end
    end
end)
