--Variables
local plr = game:GetService("Players").LocalPlayer
local chr = plr.Character
local hrp = plr.Character.HumanoidRootPart
local humanoid = chr.Humanoid
local switch = false
local site = "A"
local coorA = {-22, -14}
local lookX
local lookZ
local blockcheck = false
local action = plr.PlayerGui["HUD"].Bars.Action 
local RunService = game:GetService("RunService")

--check site
function checksite()
	if hrp.Position.Z > 0 then
		site = "A"
	else
		site = "B"
	end
end

--checkpos
function checkpos()
	checksite()
	if site == "A" then
		lookX = coorA[1]
		lookZ = coorA[2]
	else
		lookX = math.abs(coorA[1])
		lookZ = math.abs(coorA[2])
	end
end
--rotate player
function lookAt() 
	checkpos()
	if chr.PrimaryPart then 
		local chrPos=chr.PrimaryPart.Position 
		local modTPos=Vector3.new(lookX,chrPos.Y,lookZ)  
		local newCF=CFrame.new(chrPos,modTPos)
		chr:SetPrimaryPartCFrame(newCF) 
	end
end
--lag server
function spam()
    local v1 = "BamJump"
    local v2 = CFrame.new(-203.705383, 3.50000501, 200.0729723, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    game:GetService("ReplicatedStorage").Remotes.CreateEffect:FireServer(v1, v2)
end

function spam1()
    local v1 = "BamJump"
    local v2 = CFrame.new(-203.705383, 3.50000501, 200.0729723, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    game:GetService("ReplicatedStorage").Remotes.CreateEffect:FireServer(v1, v2)
end

--UI library
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiwi-i/wallys-ui-fork/master/lib.lua", true))()
local w = library:CreateWindow('AimGod')
w:Section('Top')
local t = w:Toggle('Short Gan', {flag = "toggle1"})
w:Section("Dangerous")
local m = w:Toggle('Lag server', {flag = "toggle2"})
--jump
humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
	if w.flags.toggle1 and blockcheck == false then
		lookAt()
	end
end)


action:GetPropertyChangedSignal("Text"):Connect(function(i,v)
    if action.Text == "BLOCK" then
        blockcheck = true
	else
		blockcheck = false
    end
end)

RunService.RenderStepped:Connect(function(step)
    if w.flags.toggle2 then
		RunService.RenderStepped:Connect(function(step)
			game:GetService("ReplicatedStorage").Assets.EffectParts:Destroy()
			spam()
			spam1()
		end)
	end
end)