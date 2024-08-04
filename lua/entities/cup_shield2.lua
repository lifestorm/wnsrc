--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Tactical Combine Shield"
ENT.Author			= "Comrade Communist"
ENT.Purpose			= ""
ENT.Category		= ""

ENT.Spawnable		= true
ENT.AdminOnly		= false

if SERVER then

function ENT:Initialize()
self:SetModel("models/weapons/ballisticshield_mod.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetHealth(44420) -- Blaze It ( ͡° ͜ʖ ͡°) --
self:SetMaxHealth(self:Health())
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
end	
local self_name = "shield" .. self:EntIndex()
self:SetName( self_name )
local spawnpos = self:GetPos() + self:GetForward() * 1 + self:GetUp() * 0 + self:GetRight() * 0
self.shield2 = ents.Create("prop_physics")
self.shield2:SetModel("models/weapons/ballisticshield_mod.mdl")
self.shield2:SetPos( spawnpos )
self.shield2:SetAngles( self:GetAngles() )
self.shield2:SetParent(self)
self.shield2:SetNoDraw( true )
self.shield2:DrawShadow( false )
self.shield2:SetCollisionGroup(COLLISION_GROUP_WEAPON)
self.shield2:SetOwner( self.Owner )
self.shield2:Spawn()
self.shield2:Activate()

end

function ENT:Think()
if IsValid(self.shield2) then
self.shield2:SetModel(self:GetModel())
end
end

function ENT:PhysicsCollide(data,phys)
if data.Speed > 50 and data.Speed < 300 then
self:EmitSound("physics/metal/metal_canister_impact_soft" .. math.random(1,3) .. ".wav", 75, math.random(90,110))
end
if data.Speed > 300 then
self:EmitSound("physics/metal/metal_canister_impact_hard" .. math.random(1,3) .. ".wav", 75, math.random(90,110))
end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
	self:SetHealth(self:Health() - dmginfo:GetDamage())
	self:EmitSound("physics/metal/metal_sheet_impact_bullet" .. math.random(1,2) .. ".wav", 75, math.random(90,110))
	if self:Health() <= 0 then
	if IsValid(self.shield2) then
	self.shield2:Remove()
	end
	self:EmitSound("physics/metal/metal_box_break" .. math.random(1,2) .. ".wav", 75, math.random(90,110))
	self.shield = ents.Create("prop_physics")
	self.shield:SetModel("models/weapons/ballisticshield_mod.mdl")
	self.shield:SetPos( self:GetPos() )
	self.shield:SetAngles( self:GetAngles() )
	self.shield:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self.shield:SetOwner( self.Owner )
	self.shield:Spawn()
	self.shield:Activate()
	local phys2 = self.shield:GetPhysicsObject()	
	if (phys2:IsValid()) then
	phys2:SetVelocity(self:GetForward() * math.random(-200,200) + self:GetUp() * math.random(-200,200) + self:GetRight() * math.random(-200,200))
	end	
	SafeRemoveEntityDelayed(self.shield,5)
	self.dissolver = ents.Create("env_entity_dissolver")
	self.dissolver:SetKeyValue("dissolvetype", "0")
	self.dissolver:SetKeyValue("magnitude", "1")
	self.dissolver:SetPos(self.shield:GetPos())
	self.dissolver:Spawn()
	local name = "Dissolving_"..math.random(1,9999)
	self.shield:SetName(name)
	self.dissolver:Fire("Dissolve",name,0)
	self.dissolver:Fire("kill","",0.01)
	self:Remove()
	end
end

end
