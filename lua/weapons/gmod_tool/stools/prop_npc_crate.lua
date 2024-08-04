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
TOOL.Name = "#tool.prop_npc_crate"
TOOL.Command = nil
TOOL.ConfigName = ""

TOOL.Models = {}
TOOL.Models["models/props_junk/wood_crate001a.mdl"] = 0
TOOL.Models["models/props_junk/wood_crate001a_damaged.mdl"] = 1
TOOL.Models["models/props_junk/wood_crate002a.mdl"] = 2
TOOL.Models["models/items/item_item_crate.mdl"] = 3
TOOL.Models["models/items/item_beacon_crate.mdl"] = 4
TOOL.Models["models/props_junk/cardboard_box001a.mdl"] = 5
TOOL.Models["models/props_junk/cardboard_box001b.mdl"] = 6
TOOL.Models["models/props_junk/cardboard_box002a.mdl"] = 7
TOOL.Models["models/props_junk/cardboard_box002b.mdl"] = 8
TOOL.Models["models/props_junk/cardboard_box003a.mdl"] = 9
TOOL.Models["models/props_junk/cardboard_box003b.mdl"] = 10
TOOL.Models["models/props_junk/cardboard_box004a.mdl"] = 11

TOOL.ClientConVar["model"] = "models/props_junk/wood_crate001a.mdl"
TOOL.ClientConVar["npc"] = "npc_headcrab_poison"
TOOL.ClientConVar["health"] = "25"

cleanup.Register("prop_npc_crate")

if (CLIENT) then
	language.Add("tool.prop_npc_crate", "NPC Crate")
	language.Add("tool.prop_npc_crate.name", "NPC Crate Tool")
	language.Add("tool.prop_npc_crate.desc", "Spawn crates with an NPC in them")
	language.Add("tool.prop_npc_crate.0", "Left click to spawn an custom adjusted NPC Crate. Right to pack an existing NPC in a custom crate.")
	
	language.Add("tool.prop_npc_crate.model", "Crate Model")
	language.Add("tool.prop_npc_crate.npc", "Crate NPC")
	language.Add("tool.prop_npc_crate.health", "Crate Health")
	language.Add("tool.prop_npc_crate.health.help", "Amount of damage the npc crate can take before it will break.")

	language.Add("Cleanup_prop_npc_crate", "NPC Crates")
	language.Add("Cleaned_prop_npc_crate", "Cleaned up all NPC Crates")
	language.Add("SBoxLimit_prop_npc_crate", "You've hit the NPC Crates limit!")
	language.Add("Undone_prop_npc_crate", "NPC Crate undone")

	language.Add("prop_npc_crate", "NPC Crate")

	language.Add("#combine_mine", "Combine Mine")
	language.Add("combine_mine", "Combine Mine")
	language.Add("#npc_fastzombie_torso", "Fast Zombie Torso")
	language.Add("#grenade_helicopter", "Helicopter Grenade")
	language.Add("grenade_helicopter", "Helicopter Grenade")
end

if (SERVER) then
	CreateConVar("sbox_maxprop_npc_crates", 10)
	
	function MakeNpcCrate(ply, pos, ang, model, health, npc, npcTbl)
		if (!ply:CheckLimit("prop_npc_crates")) then return false end
	
		local prop_npc_crate = ents.Create("prop_npc_crate")
		if (!prop_npc_crate:IsValid()) then return false end

		prop_npc_crate:Initialize(model, math.Clamp(health, 1, 100), npc)

		prop_npc_crate:SetPos(Vector(pos.x, pos.y, pos.z - prop_npc_crate:OBBMins().z))
		prop_npc_crate:SetAngles(ang)

		prop_npc_crate:Spawn()
		prop_npc_crate:Activate()

		table.Merge(prop_npc_crate:GetTable(), {
			ply = ply,
			model = model,
			health = health,
			npc = npc,
			npcTbl = npcTbl,
		})

		ply:AddCount("prop_npc_crates", prop_npc_crate)

		DoPropSpawnedEffect(prop_npc_crate)

		return prop_npc_crate
	end
	
	duplicator.RegisterEntityClass("prop_npc_crate", MakeNpcCrate, "pos", "ang", "model", "health", "npc", "npcTbl")
end

function TOOL:LeftClick(trace)
	if (trace.HitSky or !trace.HitPos or IsValid(trace.Entity) and (trace.Entity:IsPlayer() or trace.Entity:IsNPC())) then return false end
	if (CLIENT) then return true end

	local Tbl = { }
		Tbl["wep"] = ""
		Tbl["citType"] = ""
		Tbl["citMed"] = 0
		Tbl["skin"] = nil
		Tbl["model"] = nil

	local ply = self:GetOwner()

	// Update existing NPC Crate
	if (trace.Entity:GetClass() == "prop_npc_crate") then
		trace.Entity:Initialize(self:GetClientInfo("model"), self:GetClientNumber("health"), self:GetClientInfo("npc"))
		table.Merge(trace.Entity:GetTable(), {
			ply = ply,
			model = self:GetClientInfo("model"),
			health = self:GetClientNumber("health"),
			npc = self:GetClientInfo("npc"),
			npcTbl = Tbl,
		})
		return true
	end
	
	// Create a new NPC Crate
	local ang = trace.HitNormal:Angle()
	ang.pitch = ang.pitch - 270

	local prop_npc_crate = MakeNpcCrate(ply, trace.HitPos, ang, self:GetClientInfo("model"), self:GetClientNumber("health"), self:GetClientInfo("npc"), Tbl)
	
	undo.Create("prop_npc_crate")
		undo.AddEntity(prop_npc_crate)
		undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCleanup("prop_npc_crate", prop_npc_crate)

	return true
end
function TOOL:RightClick(trace)
	if (trace.HitSky or !trace.HitPos or IsValid(trace.Entity) and (trace.Entity:IsPlayer())) then return false end
	if (!trace.Entity:IsNPC()) then return false end
	if (CLIENT) then return true end

	local npc = trace.Entity
	local ply = self:GetOwner()
	local ang = trace.HitNormal:Angle()

	local npcTbl = {}

		local wep = ""
		local possibleWep = ents.FindInSphere(npc:GetPos(),0.01)
		for k, v in pairs(possibleWep) do 
			if string.find(v:GetClass(),"weapon_") == 1 then 
				wep = v:GetClass()
			end
		end
		local citType = ""
		local citMed = 0
		if (npc:GetClass() == "npc_citizen") then
			citType = string.sub(npc:GetModel(),21,21)
			if (string.sub(npc:GetModel(),22,22) == "m") then citMed = 1 end
		end

		npcTbl["wep"] = wep
		npcTbl["citType"] = citType
		npcTbl["citMed"] = citMed
		npcTbl["skin"] = npc:GetSkin()
		npcTbl["model"] = npc:GetModel()

	local prop_npc_crate = MakeNpcCrate(ply, npc:GetPos(), Angle(0, ang.y, 0), self:GetClientInfo("model"), self:GetClientNumber("health"), npc:GetClass(), npcTbl)
	npc:Remove()

	undo.Create("prop_npc_crate")
		undo.AddEntity(prop_npc_crate)
		undo.SetPlayer(ply)
	undo.Finish()

	ply:AddCleanup("prop_npc_crate", prop_npc_crate)
	return true
end
function TOOL:UpdateGhostNpcCrate(ent,player)
	if (!ent or !ent:IsValid()) then return end
	
	local tr = util.GetPlayerTrace(player, player:GetAimVector())
	local trace = util.TraceLine(tr)

	if (!trace.Hit) then return end
	
	if (trace.Entity && (trace.Entity:GetClass() == "prop_npc_crate" || trace.Entity:IsPlayer()) || trace.Entity:IsNPC()) then
		ent:SetNoDraw(true)
		return
	end
	
	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch - 270
	
	local min = ent:OBBMins()
	ent:SetPos(trace.HitPos - trace.HitNormal * min.z)
	
	ent:SetAngles(Ang)
	ent:SetNoDraw(false)
end

function TOOL:Think()
	if (!self.GhostEntity || !self.GhostEntity:IsValid() || self.GhostEntity:GetModel() != self:GetClientInfo("model")) then
		self:MakeGhostEntity(self:GetClientInfo("model"), Vector(0, 0, 0), Angle(0, 0, 0))
	end
	
	self:UpdateGhostNpcCrate(self.GhostEntity, self:GetOwner())
end
function TOOL.BuildCPanel(panel)
	panel:AddControl("PropSelect", {Label = "#tool.prop_npc_crate.model", Height = 3, ConVar = "prop_npc_crate_model", Models = list.Get("NpcCrateModels")})
	panel:AddControl("ListBox", {Label = "#tool.prop_npc_crate.npc", Height = 237, Options = list.Get("NpcCrateNpcs")})
	panel:AddControl("Slider", {Label = "#tool.prop_npc_crate.health", Type = "Integer", Min = 1, Max = 100, Command = "prop_npc_crate_health", Help = true})
end

list.Set("NpcCrateModels", "models/props_junk/wood_crate001a.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/wood_crate001a_damaged.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/wood_crate002a.mdl", {})
list.Set("NpcCrateModels", "models/items/item_item_crate.mdl", {})
list.Set("NpcCrateModels", "models/items/item_beacon_crate.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box001a.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box001b.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box002a.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box002b.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box003a.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box003b.mdl", {})
list.Set("NpcCrateModels", "models/props_junk/cardboard_box004a.mdl", {})

list.Set("NpcCrateNpcs", "#npc_headcrab", {prop_npc_crate_npc = "npc_headcrab"})
list.Set("NpcCrateNpcs", "#npc_headcrab_fast", {prop_npc_crate_npc = "npc_headcrab_fast"})
list.Set("NpcCrateNpcs", "#npc_headcrab_poison", {prop_npc_crate_npc = "npc_headcrab_black"})
list.Set("NpcCrateNpcs", "#npc_zombie", {prop_npc_crate_npc = "npc_zombie"})
list.Set("NpcCrateNpcs", "#npc_zombie_torso", {prop_npc_crate_npc = "npc_zombie_torso"})
list.Set("NpcCrateNpcs", "#npc_fastzombie", {prop_npc_crate_npc = "npc_fastzombie"})
list.Set("NpcCrateNpcs", "#npc_fastzombie_torso", {prop_npc_crate_npc = "npc_fastzombie_torso"})
list.Set("NpcCrateNpcs", "#npc_poisonzombie", {prop_npc_crate_npc = "npc_poisonzombie"})
list.Set("NpcCrateNpcs", "#npc_manhack", {prop_npc_crate_npc = "npc_manhack"})
list.Set("NpcCrateNpcs", "#npc_crow", {prop_npc_crate_npc = "npc_crow"})
list.Set("NpcCrateNpcs", "#combine_mine", {prop_npc_crate_npc = "combine_mine"})
list.Set("NpcCrateNpcs", "#npc_rollermine", {prop_npc_crate_npc = "npc_rollermine"})
list.Set("NpcCrateNpcs", "#grenade_helicopter", {prop_npc_crate_npc = "grenade_helicopter"})