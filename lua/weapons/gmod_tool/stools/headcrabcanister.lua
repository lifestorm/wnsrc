--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

// STool by Nekres ( 4ndy )
TOOL.Category = "Half-Life 2"
TOOL.Name = "#tool.headcrabcanister"
TOOL.Command = nil
TOOL.ConfigName = ""

TOOL.ClientConVar["damage"] = 130 --damage of each canister
TOOL.ClientConVar["damage_radius"] = 700 --explode radius of canister
TOOL.ClientConVar["speed"] = 3000 --speed of cannister while fly in
TOOL.ClientConVar["height"] = 2000 --how high in the sky. 0 means height from the skybox
TOOL.ClientConVar["flight_time"] = 5 --how long the cannister 'fly in'
TOOL.ClientConVar["smoke"] = -1 --smoke lifetime of the cannister. -1 means always smoke
TOOL.ClientConVar["headcrab_type"] = "models/headcrabclassic.mdl"
TOOL.ClientConVar["headcrab_count"] = 4
TOOL.ClientConVar["height_skybox"] = "0"
TOOL.ClientConVar["smoke_always"] = "0"

TOOL.ClientConVar["fire"] = "38"
TOOL.ClientConVar["solid"] = "37"

cleanup.Register("prop_headcrabcanister")

if (CLIENT) then
	language.Add("tool.headcrabcanister", "Headcrabcanister")
	language.Add("tool.headcrabcanister.name", "Headcrabcanister Tool")
	language.Add("tool.headcrabcanister.desc", "Spawn a Headcrabcanister")
	language.Add("tool.headcrabcanister.0", "Left click to spawn an custom adjusted Headcrabcanister.")

	language.Add("tool.headcrabcanister.fire", "Fire Canister")
	language.Add("tool.headcrabcanister.solid", "Toggle Solid")
	language.Add("tool.headcrabcanister.headcrab_type", "Headcrab Type")
	language.Add("tool.headcrabcanister.headcrab_count", "Headcrab Count")
	language.Add("tool.headcrabcanister.headcrab_count.help", "Number of headcrabs to spawn on impact.")
	
	language.Add("tool.headcrabcanister.damage", "Damage")
	language.Add("tool.headcrabcanister.damage.help", "Max damage the canister applies on impact.")

	language.Add("tool.headcrabcanister.damage_radius", "Damage Radius")
	language.Add("tool.headcrabcanister.damage_radius.help", "Max radius of the impact damage for the canister.")
	
	language.Add("tool.headcrabcanister.speed", "Flight Speed")
	language.Add("tool.headcrabcanister.speed.help", "Speed to fly through the air.")
	
	language.Add("tool.headcrabcanister.height", "Starting Height")
	language.Add("tool.headcrabcanister.height.help", "Relative height from the landing position at which the canister should be launched.")
	language.Add("tool.headcrabcanister.height_skybox", "Start from skybox height")

	language.Add("tool.headcrabcanister.flight_time", "Flight Time")
	language.Add("tool.headcrabcanister.flight_time.help", "Time to fly through the air in seconds.")
	
	language.Add("tool.headcrabcanister.smoke", "Smoke Duration")
	language.Add("tool.headcrabcanister.smoke.help", "Duration that the canister smokes in seconds.")
	language.Add("tool.headcrabcanister.smoke_always", "Always smoke")
	language.Add("tool.headcrabcanister.reset", "Reset Settings")

	language.Add("Cleanup_prop_headcrabcanister", "Headcrabcanister")
	language.Add("Cleaned_prop_headcrabcanister", "Cleaned up all Headcrabcanister")
	language.Add("SBoxLimit_prop_headcrabcanister", "You've hit the Headcrabcanister limit!")
	language.Add("Undone_prop_headcrabcanister", "Headcrabcanister undone")

	language.Add("env_headcrabcanister", "Headcrabcanister")

	concommand.Add("headcrabcanister_reset", function(ply)
		RunConsoleCommand("headcrabcanister_damage", "130")
		RunConsoleCommand("headcrabcanister_damage_radius", "700")
		RunConsoleCommand("headcrabcanister_speed", "3000")
		RunConsoleCommand("headcrabcanister_height", "2000")
		RunConsoleCommand("headcrabcanister_flight_time", "5")
		RunConsoleCommand("headcrabcanister_smoke", "-1")
		RunConsoleCommand("headcrabcanister_headcrab_type", "models/headcrabclassic.mdl")
		RunConsoleCommand("headcrabcanister_headcrab_count", "4")
		RunConsoleCommand("headcrabcanister_height_skybox", "0")
		RunConsoleCommand("headcrabcanister_smoke_always", "0")
		RunConsoleCommand("headcrabcanister_fire", "38")
		RunConsoleCommand("headcrabcanister_solid", "37")
	end)
end

if (SERVER) then
	CreateConVar("sbox_maxheadcrabcanisters", 10)

	numpad.Register("headcrabcanister_fire", function(ply, prop_headcrabcanister, activate)
		if (!IsValid(prop_headcrabcanister)) then return false end
		prop_headcrabcanister:Launch()
	end)
	numpad.Register("headcrabcanister_solid", function(ply, prop_headcrabcanister, activate)
		if (!IsValid(prop_headcrabcanister)) then return false end
		if (prop_headcrabcanister.solid) then
			prop_headcrabcanister:DrawShadow(false)
			prop_headcrabcanister:SetNotSolid(true)
			prop_headcrabcanister:SetNoDraw(true)
			prop_headcrabcanister.solid = false
		else
			prop_headcrabcanister:DrawShadow(true)
			prop_headcrabcanister:SetNotSolid(false)
			prop_headcrabcanister:SetNoDraw(false)
			prop_headcrabcanister.solid = true
		end
	end)

	function MakeHeadcrabcanister(ply, pos, ang, keyFire, keySolid, settings)
		if (!ply:CheckLimit("headcrabcanisters")) then return false end

		local prop_headcrabcanister = ents.Create("prop_headcrabcanister")
		if (!prop_headcrabcanister:IsValid()) then return false end

		prop_headcrabcanister:SetAngles( Angle(-75, ang.y, 90) )
		prop_headcrabcanister:SetPos(pos)
		prop_headcrabcanister:Spawn()
		prop_headcrabcanister:Activate()
		prop_headcrabcanister.solid = true
		prop_headcrabcanister.Activate = numpad.OnDown(ply, keyFire, "headcrabcanister_fire", prop_headcrabcanister)
		prop_headcrabcanister.ToggleSolid = numpad.OnDown(ply, keySolid, "headcrabcanister_solid", prop_headcrabcanister)

		table.Merge(prop_headcrabcanister:GetTable(), {
			ply = ply,
			keyFire = keyFire,
			keySolid = keySolid,
			settings = settings,
		})

		ply:AddCount("headcrabcanisters", prop_headcrabcanister)

		DoPropSpawnedEffect(prop_headcrabcanister)

		return prop_headcrabcanister
	end
	
	duplicator.RegisterEntityClass("prop_headcrabcanister", MakeHeadcrabcanister, "pos", "ang", "keyFire", "keySolid", "settings")
end

function TOOL:LeftClick(trace)
	if (trace.HitSky or !trace.HitPos or IsValid(trace.Entity) and (trace.Entity:IsPlayer() or trace.Entity:IsNPC())) then return false end
	if (CLIENT) then return true end

	local Tbl = { }
		Tbl["damage"] = self:GetClientNumber("damage")
		Tbl["damage_radius"] = self:GetClientNumber("damage_radius")
		Tbl["speed"] = self:GetClientNumber("speed")
		Tbl["height"] = self:GetClientNumber("height")
		Tbl["flight_time"] = self:GetClientNumber("flight_time")
		Tbl["smoke"] = self:GetClientNumber("smoke")
		Tbl["headcrab_count"] = self:GetClientNumber("headcrab_count")

		if (self:GetClientInfo("height_skybox") != "0") then
			Tbl["height"] = 0
		end
		if (self:GetClientInfo("smoke_always") != "0") then
			Tbl["smoke"] = -1
		end
		if (self:GetClientInfo("headcrab_type") == "models/headcrabclassic.mdl") then
			Tbl["headcrab_type"] = "0"
		elseif (self:GetClientInfo("headcrab_type") == "models/headcrab.mdl") then
			Tbl["headcrab_type"] = "1"
		elseif (self:GetClientInfo("headcrab_type") == "models/headcrabblack.mdl") then
			Tbl["headcrab_type"] = "2"
		end

	local ply = self:GetOwner()

	// Update existing Headcrabcanister
	if (trace.Entity:GetClass() == "prop_headcrabcanister") then
		table.Merge(trace.Entity:GetTable(), {
			ply = ply,
			keyFire = self:GetClientInfo("fire"),
			keySolid = self:GetClientInfo("solid"),
			settings = Tbl,
		})
		return true
	end

	// Create a new Headcrabcanister
	local ang = trace.HitNormal:Angle()
	ang.pitch = ang.pitch - 270

	local prop_headcrabcanister = MakeHeadcrabcanister(ply, trace.HitPos, ang, self:GetClientNumber("fire"), self:GetClientNumber("solid"), Tbl)
	
	undo.Create("prop_headcrabcanister")
		undo.AddEntity(prop_headcrabcanister)
		undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCleanup("prop_headcrabcanister", prop_headcrabcanister)

	return true
end
function TOOL:UpdateGhostHeadcrabcanister(ent,player)
	if (!ent or !ent:IsValid()) then return end
	
	local tr = util.GetPlayerTrace(player, player:GetAimVector())
	local trace = util.TraceLine(tr)

	if (!trace.Hit) then return end
	
	if (trace.Entity && (trace.Entity:GetClass() == "prop_headcrabcanister" || trace.Entity:IsPlayer()) || trace.Entity:IsNPC()) then
		ent:SetNoDraw(true)
		return
	end
	
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch - 270
	
	local min = ent:OBBMins()
	ent:SetPos(trace.HitPos - trace.HitNormal)
	
	ent:SetAngles(Angle(-75, Ang.y, 90 ))
	ent:SetNoDraw(false)
end

function TOOL:Think()
	if (!self.GhostEntity || !self.GhostEntity:IsValid()) then
		self:MakeGhostEntity("models/props_combine/headcrabcannister01b.mdl", Vector(0, 0, 0), Angle(0, 0, 0))
	end
	
	self:UpdateGhostHeadcrabcanister(self.GhostEntity, self:GetOwner())
end
function TOOL.BuildCPanel(panel)
	panel:AddControl("Numpad", {Label = "#tool.headcrabcanister.fire", Label2 = "#tool.headcrabcanister.solid", Command = "headcrabcanister_fire", Command2 = "headcrabcanister_solid"})
	panel:AddControl("PropSelect", {Label = "#tool.headcrabcanister.headcrab_type", Height = 1, ConVar = "headcrabcanister_headcrab_type", Models = list.Get("HeadcrabTypes")})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.headcrab_count", Type = "Integer", Min = 0, Max = 10, Command = "headcrabcanister_headcrab_count", Help = true})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.damage", Type = "Integer", Min = 0, Max = 1000, Command = "headcrabcanister_damage", Help = true})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.damage_radius", Type = "Integer", Min = 10, Max = 1000, Command = "headcrabcanister_damage_radius", Help = true})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.speed", Type = "Integer", Min = 500, Max = 5000, Command = "headcrabcanister_speed", Help = true})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.height", Type = "Integer", Min = 1000, Max = 10000, Command = "headcrabcanister_height", Help = true})
	panel:AddControl("Checkbox", {Label = "#tool.headcrabcanister.height_skybox", Command = "headcrabcanister_height_skybox"})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.flight_time", Type = "Integer", Min = 1, Max = 10, Command = "headcrabcanister_flight_time", Help = true})
	panel:AddControl("Slider", {Label = "#tool.headcrabcanister.smoke", Type = "Integer", Min = 5, Max = 120, Command = "headcrabcanister_smoke", Help = true})
	panel:AddControl("Checkbox", {Label = "#tool.headcrabcanister.smoke_always", Command = "headcrabcanister_smoke_always"})
	panel:AddControl("Button", {Label = "#tool.headcrabcanister.reset", Command = "headcrabcanister_reset"})
end
list.Set("HeadcrabTypes", "models/headcrabclassic.mdl", {})
list.Set("HeadcrabTypes", "models/headcrab.mdl", {})
list.Set("HeadcrabTypes", "models/headcrabblack.mdl", {})