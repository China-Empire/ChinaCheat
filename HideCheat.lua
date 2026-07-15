-- Hide from Villain ESP + Inf Jump v9.8 (Spacing fix)
local p=game.Players.LocalPlayer
local g=p:WaitForChild("PlayerGui")
local vE,sE,cE,jE=false,false,false,false
local hV=Instance.new("Folder",workspace)hV.Name="HL_V"
local hS=Instance.new("Folder",workspace)hS.Name="HL_S"
local hC=Instance.new("Folder",workspace)hC.Name="HL_C"
local tV=Instance.new("Folder",workspace)tV.Name="TR_V"
local tS=Instance.new("Folder",workspace)tS.Name="TR_S"
local tC=Instance.new("Folder",workspace)tC.Name="TR_C"
local R=1000
local run=true

local s=Instance.new("ScreenGui",g)s.Name="ESP" s.ResetOnSpawn=false s.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

local f=Instance.new("Frame",s)f.Size=UDim2.new(0,260,0,150)f.Position=UDim2.new(0.5,-130,0.08,0)
f.BackgroundColor3=Color3.fromRGB(0,0,0)f.BackgroundTransparency=0 f.BorderSizePixel=0 f.ZIndex=1 f.ClipsDescendants=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,14)

local tb=Instance.new("Frame",s)tb.Size=UDim2.new(0,260,0,34)tb.Position=UDim2.new(0.5,-130,0.08,-1)tb.BackgroundColor3=Color3.fromRGB(30,30,40)tb.BackgroundTransparency=0 tb.BorderSizePixel=0 tb.ZIndex=101
Instance.new("UICorner",tb).CornerRadius=UDim.new(0,17)

local ti=Instance.new("TextLabel",tb)ti.Size=UDim2.new(0,140,1,0)ti.Position=UDim2.new(0,10,0,0)ti.Text="Hide Cheat"ti.TextColor3=Color3.fromRGB(255,255,255)ti.TextSize=13 ti.BackgroundTransparency=1 ti.Font=Enum.Font.GothamBlack ti.TextXAlignment=Enum.TextXAlignment.Left ti.ZIndex=10

local mn=Instance.new("TextButton",tb)mn.Size=UDim2.new(0,26,0,26)mn.Position=UDim2.new(1,-70,0,4)mn.Text="−"mn.BackgroundTransparency=1 mn.TextColor3=Color3.fromRGB(255,255,255)mn.TextSize=18 mn.BorderSizePixel=0 mn.ZIndex=10 mn.AutoButtonColor=false

local cl=Instance.new("TextButton",tb)cl.Size=UDim2.new(0,26,0,26)cl.Position=UDim2.new(1,-38,0,4)cl.Text=""cl.BackgroundTransparency=1 cl.BorderSizePixel=0 cl.ZIndex=10 cl.AutoButtonColor=false
local x1=Instance.new("Frame",cl)x1.Size=UDim2.new(0,14,0,2)x1.Position=UDim2.new(0.5,-7,0.5,-1)x1.Rotation=45 x1.BackgroundColor3=Color3.fromRGB(255,255,255)x1.BorderSizePixel=0 x1.ZIndex=11
local x2=Instance.new("Frame",cl)x2.Size=UDim2.new(0,14,0,2)x2.Position=UDim2.new(0.5,-7,0.5,-1)x2.Rotation=-45 x2.BackgroundColor3=Color3.fromRGB(255,255,255)x2.BorderSizePixel=0 x2.ZIndex=11

local function toggleSwitch(y,text,color,tag)
 local bg=Instance.new("Frame",f)bg.Size=UDim2.new(0,44,0,22)bg.Position=UDim2.new(1,-68,0,y)bg.BackgroundColor3=Color3.fromRGB(60,60,60)bg.BorderSizePixel=0 bg.ZIndex=3
 Instance.new("UICorner",bg).CornerRadius=UDim.new(0,11)
 local knob=Instance.new("Frame",bg)knob.Size=UDim2.new(0,18,0,18)knob.Position=UDim2.new(0,2,0,2)knob.BackgroundColor3=Color3.fromRGB(255,255,255)knob.BorderSizePixel=0 knob.ZIndex=4
 Instance.new("UICorner",knob).CornerRadius=UDim.new(0,9)
 local lb=Instance.new("TextLabel",f)lb.Size=UDim2.new(0,110,0,20)lb.Position=UDim2.new(0,16,0,y+1)lb.Text=text lb.TextColor3=color lb.TextSize=12 lb.BackgroundTransparency=1 lb.Font=Enum.Font.GothamBold lb.ZIndex=2 lb.TextXAlignment=Enum.TextXAlignment.Left
 local on=false
 local function upd()
  if on then bg.BackgroundColor3=Color3.fromRGB(0,160,0)knob.Position=UDim2.new(1,-20,0,2)
  else bg.BackgroundColor3=Color3.fromRGB(60,60,60)knob.Position=UDim2.new(0,2,0,2)end
 end
 bg.InputBegan:Connect(function(i)
  if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then
   on=not on upd()
   if tag=="V"then vE=on if not on then for _,h in pairs(hV:GetChildren())do h:Destroy()end for _,t in pairs(tV:GetChildren())do t:Destroy()end end end
   if tag=="S"then sE=on if not on then for _,h in pairs(hS:GetChildren())do h:Destroy()end for _,t in pairs(tS:GetChildren())do t:Destroy()end end end
   if tag=="C"then cE=on if not on then for _,h in pairs(hC:GetChildren())do h:Destroy()end for _,t in pairs(tC:GetChildren())do t:Destroy()end end end
   if tag=="J"then jE=on if on then enableInfJump()else disableInfJump()end end
  end
 end)
end

toggleSwitch(40,"Villain",Color3.fromRGB(255,100,100),"V")
toggleSwitch(66,"Survivor",Color3.fromRGB(100,255,100),"S")
toggleSwitch(92,"Cases",Color3.fromRGB(255,255,255),"C")
toggleSwitch(118,"Inf Jump",Color3.fromRGB(255,255,100),"J")

local infJumpLoop=nil
local function findJumpButton()
 for _,v in pairs(g:GetDescendants())do
  if v:IsA("TextButton")or v:IsA("ImageButton")then
   if v.Name:lower():find("jump")or v.Name:lower():find("space")then return v end
  end
 end
 return nil
end
local function enableInfJump()
 if infJumpLoop then return end
 infJumpLoop=game:GetService("RunService").Heartbeat:Connect(function()
  local btn=findJumpButton()
  if btn then btn.Visible=true btn.Active=true btn.AutoButtonColor=false btn.BackgroundTransparency=0 end
  local char=p.Character
  if char and char:FindFirstChild("Humanoid")then
   char.Humanoid.Jump=true char.Humanoid.AutoJumpEnabled=true char.Humanoid.UseJumpPower=true char.Humanoid.JumpPower=50
  end
 end)
end
local function disableInfJump()
 if infJumpLoop then infJumpLoop:Disconnect()infJumpLoop=nil end
 if p.Character and p.Character:FindFirstChild("Humanoid")then
  p.Character.Humanoid.Jump=false p.Character.Humanoid.AutoJumpEnabled=false p.Character.Humanoid.UseJumpPower=false
 end
end

local dr=false local sx,sy,fx,fy,tx,ty=0,0,0,0,0,0
tb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true sx=i.Position.X sy=i.Position.Y fx=f.Position.X.Offset fy=f.Position.Y.Offset tx=tb.Position.X.Offset ty=tb.Position.Y.Offset end end)
tb.InputEnded:Connect(function()dr=false end)
game:GetService("UserInputService").InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement)then local dx=i.Position.X-sx local dy=i.Position.Y-sy f.Position=UDim2.new(0,fx+dx,0,fy+dy)tb.Position=UDim2.new(0,tx+dx,0,ty+dy)end end)

local minimized=false
mn.MouseButton1Click:Connect(function()minimized=not minimized if minimized then f.Visible=false mn.Text="+"else f.Visible=true mn.Text="−"end end)

cl.MouseButton1Click:Connect(function()
 run=false vE,sE,cE,jE=false,false,false,false
 disableInfJump()
 for _,v in pairs({hV,hS,hC,tV,tS,tC})do for _,x in pairs(v:GetChildren())do x:Destroy()end v:Destroy()end
 s:Destroy()
end)

local function getTeam(pl)
 if pl.Team then
  local n=pl.Team.Name
  if n=="Villain"then return"Villain"end
  if n=="Survivors"then return"Survivors"end
 end
 local ls=pl:FindFirstChild("leaderstats")
 if ls then
  local r=ls:FindFirstChild("Role")or ls:FindFirstChild("Team")
  if r and r.Value then
   local v=r.Value
   if v=="Villain"then return"Villain"end
   if v=="Survivors"then return"Survivors"end
  end
 end
 return nil
end

local function inRange(pos)
 if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart")then return false end
 return(p.Character.HumanoidRootPart.Position-pos).Magnitude<=R
end

local function scan()
 if not run then return end
 if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart")then return end
 
 for _,h in pairs(hV:GetChildren())do h:Destroy()end
 for _,t in pairs(tV:GetChildren())do t:Destroy()end
 if vE then
  for _,pl in pairs(game.Players:GetPlayers())do
   if pl~=p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")and getTeam(pl)=="Villain"then
    local rt=pl.Character.HumanoidRootPart
    for _,part in pairs(pl.Character:GetChildren())do
     if part:IsA("BasePart")then
      local h=Instance.new("Highlight",hV)h.FillColor=Color3.fromRGB(255,0,0)h.FillTransparency=0.35 h.OutlineColor=Color3.fromRGB(255,0,0)h.OutlineTransparency=0 h.Adornee=part h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
     end
    end
    if inRange(rt.Position)then
     local b=Instance.new("Beam",tV)b.Color=ColorSequence.new(Color3.fromRGB(255,0,0))b.Width0=0.1 b.Width1=0.1 b.FaceCamera=true
     b.Attachment0=Instance.new("Attachment",p.Character.HumanoidRootPart)b.Attachment1=Instance.new("Attachment",rt)
    end
   end
  end
 end
 
 for _,h in pairs(hS:GetChildren())do h:Destroy()end
 for _,t in pairs(tS:GetChildren())do t:Destroy()end
 if sE then
  for _,pl in pairs(game.Players:GetPlayers())do
   if pl~=p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")and getTeam(pl)=="Survivors"then
    local rt=pl.Character.HumanoidRootPart
    for _,part in pairs(pl.Character:GetChildren())do
     if part:IsA("BasePart")then
      local h=Instance.new("Highlight",hS)h.FillColor=Color3.fromRGB(0,255,0)h.FillTransparency=0.35 h.OutlineColor=Color3.fromRGB(0,255,0)h.OutlineTransparency=0 h.Adornee=part h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
     end
    end
    if inRange(rt.Position)then
     local b=Instance.new("Beam",tS)b.Color=ColorSequence.new(Color3.fromRGB(0,255,0))b.Width0=0.1 b.Width1=0.1 b.FaceCamera=true
     b.Attachment0=Instance.new("Attachment",p.Character.HumanoidRootPart)b.Attachment1=Instance.new("Attachment",rt)
    end
   end
  end
 end
 
 for _,h in pairs(hC:GetChildren())do h:Destroy()end
 for _,t in pairs(tC:GetChildren())do t:Destroy()end
 if cE then
  local spawns=workspace:FindFirstChild("Map1")
  if spawns then spawns=spawns:FindFirstChild("CrateSpawns")end
  if spawns then
   local cnt=0
   for _,v in pairs(spawns:GetChildren())do
    if cnt>=30 then break end
    if v.Name=="VoughtCrate"and v:IsA("Model")then
     cnt=cnt+1
     local main=v:FindFirstChild("Main")or v:FindFirstChild("Crate")
     if not main or not main:IsA("BasePart")then for _,x in pairs(v:GetChildren())do if x:IsA("BasePart")then main=x break end end end
     if main and inRange(main.Position)then
      local h=Instance.new("Highlight",hC)h.FillColor=Color3.fromRGB(255,255,255)h.FillTransparency=0.35 h.OutlineColor=Color3.fromRGB(255,255,255)h.OutlineTransparency=0 h.Adornee=v h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
      local b=Instance.new("Beam",tC)b.Color=ColorSequence.new(Color3.fromRGB(255,255,255))b.Width0=0.1 b.Width1=0.1 b.FaceCamera=true
      b.Attachment0=Instance.new("Attachment",p.Character.HumanoidRootPart)b.Attachment1=Instance.new("Attachment",main)
     end
    end
   end
  end
 end
end

spawn(function()while run do pcall(scan)wait(0.3)end end)
