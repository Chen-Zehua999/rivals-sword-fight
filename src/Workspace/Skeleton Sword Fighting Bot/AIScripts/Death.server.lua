Module = require(script.Parent.ModuleA)
AIDesign = Module.AIDesign
Clone = nil
if Module.Settings.Respawn == true then
	Clone = script.Parent.Parent:Clone()
end

function Died()
	script.Parent.Animation.Disabled = true
	script.Parent.FollowPlayer.Disabled = true
	AIDesign.Head.Death:Play()
	if AIDesign:FindFirstChild("LinkedSword") then
		AIDesign.LinkedSword:Destroy()
	end
	wait(0.5)
	for N = 0,1.05,0.05 do
		for _,Obj in pairs(AIDesign:GetChildren()) do
			if Obj:IsA("BasePart") and Obj.Name ~= "HumanoidRootPart" then
				Obj.Transparency = N
				if Obj.Name == "Head" then
					if Obj:FindFirstChild("Face") then
						Obj:FindFirstChild("Face").Transparency = N
					end
					if Obj:FindFirstChild("face") then
						Obj:FindFirstChild("face").Transparency = N
					end
					if Obj:FindFirstChild("Decal") then
						Obj:FindFirstChild("Decal").Transparency = N
					end
					if Obj:FindFirstChild("decal") then
						Obj:FindFirstChild("decal").Transparency = N
					end
					if Obj:FindFirstChild("HumanoidTag") then
						Obj.HumanoidTag.Backing.BackgroundTransparency = N + 0.5
						Obj.HumanoidTag.Health.BackgroundTransparency = N
						Obj.HumanoidTag.Username.TextTransparency = N
					end
				end
			end
			if Obj:IsA("Accessory") or Obj:IsA("Hat") or Obj:IsA("Accoutrement") then
				Obj.Handle.Transparency = N
			end
		end
		wait()
	end
	if Module.Settings.Respawn == true then
		wait(Module.Settings.RespawnTime)
		Clone.Parent = workspace
	end
	script.Parent.Parent:Destroy()
end

Module.Humanoid.Died:connect(function()
	Died()
end)

script.Parent.Parent.ChildRemoved:connect(function()
	if not script.Parent.Parent:FindFirstChild("AIDesign") then
		if Module.Settings.Respawn == true then
			Clone.Parent = workspace
		end
	end
end)