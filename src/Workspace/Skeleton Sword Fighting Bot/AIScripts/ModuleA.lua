local Module = {}
Module.AIScripts = script.Parent
Module.AIDesign = script.Parent.Parent:FindFirstChild("AIDesign")
Module.Settings = {
	Name = "Skeleton Robot",
	Respawn = true,
	RespawnTime = 5,
	
	AttackDistance = 500,
}
Module.Humanoid = Module.AIDesign:FindFirstChild("Humanoid")
Module.Root = Module.AIDesign:FindFirstChild("HumanoidRootPart")
PathFindingService = game:GetService("PathfindingService")
Module.StartPos = Module.Root.Position

function Module:LocateNearestPlayer()
	local Players = game:GetService("Players")
	local ClosestMagnitude = math.huge
	local MagList = {}
	for _,Player in pairs(Players:GetPlayers()) do
		if Player.Character ~= nil then
			if Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") then
				local Root = Player.Character:FindFirstChild("HumanoidRootPart")
				local Magnitude = (Root.Position - Module.Root.Position).magnitude
				if Magnitude < ClosestMagnitude and Magnitude <= Module.Settings.AttackDistance then
					ClosestMagnitude = Magnitude
					table.insert(MagList,{Player,Magnitude})
				end
			end
		end
	end
	if #MagList ~= 0 then
		for _,Obj in pairs(MagList) do
			if Obj[2] == ClosestMagnitude then
				script.Parent.TargetRoot.Value = Obj[1].Character.HumanoidRootPart
				return Obj[1].Character
			end
		end
	else
		script.Parent.TargetRoot.Value = nil
		if Module.Settings.ReturnToStartingPosition == true then
			Module.Humanoid:MoveTo(Module.StartPos)
		else
			Module.Humanoid:MoveTo(Module.Root.Position)
		end
		return nil
	end
end

function Module:LocateNearestDistance()
	local Players = game:GetService("Players")
	local ClosestMagnitude = math.huge
	local MagList = {}
	for _,Player in pairs(Players:GetPlayers()) do
		if Player.Character ~= nil then
			if Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("HumanoidRootPart") then
				local Root = Player.Character:FindFirstChild("HumanoidRootPart")
				local Magnitude = (Root.Position - Module.AIDesign.HumanoidRootPart.Position).magnitude
				if Magnitude < ClosestMagnitude then
					ClosestMagnitude = Magnitude
					table.insert(MagList,Magnitude)
				end
			end
		end
	end
	if #MagList ~= 0 then
		for _,Obj in pairs(MagList) do
			if Obj == ClosestMagnitude then
				return Obj
			end
		end
	else
		script.Parent.TargetRoot.Value = nil
		if Module.Settings.ReturnToStartingPosition == true then
			Module.Humanoid:MoveTo(Module.StartPos)
		else
			Module.Humanoid:MoveTo(Module.Root.Position)
		end
		return ClosestMagnitude
	end
end

function Module:ChasePlayer(Character)
	if Character:FindFirstChild("Humanoid") and Character:FindFirstChild("HumanoidRootPart") then
		local Humanoid = Character:FindFirstChild("Humanoid")
		local Root = Character:FindFirstChild("HumanoidRootPart")
		if Humanoid.Health > 0 then
			local ray = Ray.new(
			    Module.Root.Position,                           -- origin
			    (Root.Position - Module.Root.Position).unit * 500 -- direction
			) 
			local Part,Position, normal = workspace:FindPartOnRay(ray,script.Parent.Parent)
			if Part.Parent == Character then
				Module.Humanoid:MoveTo(Root.Position)
			else
				local Path = PathFindingService:FindPathAsync(Module.Root.Position,Root.Position)
				local Waypoints = Path:GetWaypoints()
				for N = 1,#Waypoints do
					local Obj = Waypoints[N]
					local WaypointType = Obj.Action
					if WaypointType == Enum.PathWaypointAction.Jump then
						Module.Humanoid.Jump = true
					end
					Module.Humanoid:MoveTo(Obj.Position)
					Module.Humanoid.MoveToFinished:Wait()
				end
			end
		end
	end
end

return Module
