-- Library
Design = script.Parent.Parent.Parent
AI = Design.Parent
AIScripts = AI.AIScripts
Humanoid = script.Parent.Parent.Parent:FindFirstChild("Humanoid")
Module = require(AIScripts.ModuleA)

if Humanoid then
	script.Parent.Username.Text = Module.Settings.Name
	while wait() do
		if Humanoid.Health > Humanoid.MaxHealth then
			script.Parent.Health.Size = UDim2.new(1,0,0.05,0)
		else
			script.Parent.Health.Size = UDim2.new(Humanoid.Health/Humanoid.MaxHealth,0,0.1,0)
		end
		if Humanoid.Health > 1e200 then
			script.Parent.Health.BackgroundColor3 = Color3.new(2/3,2/3,2/3)
		else
			script.Parent.Health.BackgroundColor3 = Color3.fromHSV((Humanoid.Health/Humanoid.MaxHealth)/2.75,1/3,1)
		end
	end
else
	script.Parent:Destroy()
end