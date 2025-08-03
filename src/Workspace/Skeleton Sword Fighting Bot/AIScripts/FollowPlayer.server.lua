Module = require(script.Parent.ModuleA)
AIDesign = script.Parent.Parent:FindFirstChild("AIDesign")

for _,Obj in pairs(AIDesign:GetChildren()) do -- Jump over obstacles
	if Obj:IsA("BasePart") and not Obj.Name:match("Foot") and not Obj.Name:match("Leg") then
		Obj.Touched:connect(function(Part)
			local PosY = Part.Position.Y
			if AIDesign:FindFirstChild("Head") and AIDesign:FindFirstChild("Humanoid") and not Part.Parent:FindFirstChild("Humanoid") and Part.CanCollide == true then
				if AIDesign.Head.Position.Y > PosY then
					AIDesign.Humanoid.Jump = true
				end
			end
		end)
	end
end

while true do
	local Char = Module:LocateNearestPlayer()
	if Char then
		delay(1/33,
		function() Module:ChasePlayer(Char) end)
	else
		local Distance = Module:LocateNearestDistance()
		if Distance > Module.Settings.AttackDistance * 2 then
			-- script.Parent.Parent:Destroy()
		end
	end
	wait(0.1)
end