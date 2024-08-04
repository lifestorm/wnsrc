--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

local npc_sounds = {}
	npc_sounds["npc_headcrab"] = "npc/headcrab/idle" -- 1-3
	npc_sounds["npc_headcrab_fast"] = "npc/headcrab_fast/idle" -- 1-3
	npc_sounds["npc_headcrab_black"] = "npc/headcrab_poison/ph_idle" -- 1-3
	npc_sounds["npc_zombie"] = "npc/zombie/zombie_voice_idle" -- 1-14
	npc_sounds["npc_zombie_torso"] = "npc/zombie/zombie_voice_idle" -- 1-14
	npc_sounds["npc_fastzombie"] = "npc/fast_zombie/idle" -- 1-3
	npc_sounds["npc_fastzombie_torso"] = "npc/fast_zombie/idle" -- 1-3
	npc_sounds["npc_poisonzombie"] = "npc/zombie_poison/pz_breathe_loop1" -- "npc/zombie_poison/pz_idle"-- 2-4
	npc_sounds["npc_manhack"] = "npc/manhack/mh_engine_loop1"
	npc_sounds["npc_crow"] = "npc/crow/idle" -- 1-4
	npc_sounds["combine_mine"] = "npc/roller/mine/combine_mine_active_loop1"
	npc_sounds["npc_rollermine"] = "npc/roller/mine/rmine_seek_loop2"

function ENT:Initialize(model, health, npc)
	if (!model or !health or !npc) then return end

	self.Entity:SetModel(model)
	self.Entity:SetHealth(health)
	self.Entity.crate_npc = npc

	if (self.sound_loop) then
		self.sound_int = nil
		self.sound_loop:Stop()
		self.sound_loop = nil
	end

	if (npc == "npc_headcrab" || npc == "npc_headcrab_fast" || npc == "npc_headcrab_black" || npc == "npc_fastzombie" || npc == "npc_fastzombie_torso") then
		self.sound_int = 3
	elseif (npc == "npc_zombie" || npc == "npc_zombie_torso") then
		self.sound_int = 14
	elseif (npc == "npc_crow") then
		self.sound_int = 4
	elseif (npc == "npc_poisonzombie" || npc == "npc_manhack" || npc == "combine_mine" || npc == "npc_rollermine") then
		self.sound_int = nil
		self.sound_loop = CreateSound(self.Entity, npc_sounds[npc] ..".wav" )
		self.sound_loop:Play()
	end

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_NONE )
	self.Entity:SetColor( Color(255,255,255,255) )
	local phys = self.Entity:GetPhysicsObject()
		if phys and phys:IsValid() then 
			phys:Wake()
			phys:EnableMotion(true)
		end
end

function ENT:Think()
	if (self.sound_loop) then
		self.sound_loop:Stop()
		self.sound_loop:Play()
	elseif (self.sound_int) then
		self:EmitSound(npc_sounds[self.crate_npc] .. math.random(1, self.sound_int) ..".wav", 100, 100)
	end
	self:NextThink(CurTime() + math.random(5, 13))
	return true
end

local NPC = FindMetaTable("Entity")
function NPC:IsHuman()
	local humans = {
		"npc_metropolice",
		"npc_combine_s",
		"npc_citizen",
		"npc_alyx",
		"npc_kleiner",
		"npc_monk",
		"npc_breen",
		"npc_gman",
		"npc_barney",
		"npc_mossman",
		"npc_eli",
		"npc_magnusson",
	}
	for _,v in pairs(humans) do
		if (self:GetClass() == v) then
			return true
		end
	end
end

function ENT:OnTakeDamage(dmg)
	self:TakePhysicsDamage(dmg)
	 
	if (self:Health() <= 0) then return end
	 
	self:SetHealth(self:Health() - dmg:GetDamage())
	 
	if (self:Health() <= 0) then
		local npc = ents.Create(self.crate_npc)
			npc:SetPos(self:GetPos())
			if (IsValid(dmg:GetAttacker())) then
				local angles = (dmg:GetAttacker():LocalToWorld(dmg:GetAttacker():OBBCenter()) - npc:GetPos()):Angle()
				npc:SetAngles(Angle(0, angles.y, 0))
				if (dmg:GetAttacker():IsPlayer()) then
					undo.Create("npc")
						undo.AddEntity(npc)
						undo.SetPlayer(dmg:GetAttacker())
					undo.Finish()
				end
			end

			local wep = self.npcTbl["wep"]
			local citType = self.npcTbl["citType"]
			local citMed = self.npcTbl["citMed"]
			local skin = self.npcTbl["skin"]
			local model = self.npcTbl["model"]
	
			if (model && skin) then
				npc:SetModel(model)
				npc:SetSkin(skin)
			end

			if (npc:IsHuman() == true) then
				if (wep) then
					npc:SetKeyValue("additionalequipment", wep)
				end
				if (self.crate_npc == "npc_citizen") then
					npc:SetKeyValue("citizentype", citType)
					if (citType == "3" && citMed == 1) then
						npc:SetKeyValue("spawnflags","131072")
					end
				end
			end
			--npc:DropToFloor()
			npc:Spawn()
			npc:Activate()

		local des_mdl = ents.Create( "prop_physics" )
			des_mdl:SetModel( self:GetModel() )
			des_mdl:PhysicsInit( SOLID_VPHYSICS )
			des_mdl:SetMoveType( MOVETYPE_VPHYSICS )
			des_mdl:SetSolid( SOLID_VPHYSICS )
			des_mdl:SetCollisionGroup( COLLISION_GROUP_NONE )
			des_mdl:SetPos( self:GetPos() )
			des_mdl:SetAngles(self:GetAngles() )
			des_mdl:SetColor( self:GetColor() )
			des_mdl:Spawn()
			des_mdl:Activate()
			des_mdl:Fire("Break", "", 0)
		self:Remove()
	end
end
function ENT:OnRemove()
	if (self.sound_loop) then
		self.sound_loop:Stop()
	elseif (self.sound_int) then
		for i = 1,14 do
			self:StopSound( npc_sounds[self.crate_npc] .. tostring(i) ..".wav" )
		end
	end
end