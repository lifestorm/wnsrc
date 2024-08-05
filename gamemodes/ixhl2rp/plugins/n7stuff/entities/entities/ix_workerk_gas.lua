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
--[[-------------------------------------------------------------------------
TODO: PLAY ANIMATION WHEN DEPLOYING SUPPORT
---------------------------------------------------------------------------]]
ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "Broken (Gas)"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.RenderGroup = RENDERGROUP_BOTH

sound.Add( {
	name = "SteamLoop1.Play",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 70,
	pitch = { 100, 100 },
	sound = "ambient/gas/steam2.wav"
} )

sound.Add( {
	name = "SteamLoop2.Play",
	channel = CHAN_STATIC,
	volume = 0.6,
	level = 70,
	pitch = { 100, 100 },
	sound = "ambient/gas/steam_loop1.wav"
} )

if SERVER then
	function ENT:Initialize()

	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
		self.health = 200
		self:SetNetVar("destroyed", true)
	local self_name = "steam_base" .. self:EntIndex()
	self:SetName( self_name )

	local phys1 = self:GetPhysicsObject()
	if ( IsValid( phys1 ) ) then
	phys1:Sleep()
	phys1:SetMass(100)
	end
	self:EmitSound("SteamLoop2.Play")
	self.steam = ents.Create("env_steam")
	self.steam:SetPos( self:GetPos())
	self.steam:SetAngles( self:GetAngles() )
	self.steam:SetKeyValue( "InitialState", "1" )
	self.steam:SetKeyValue( "SpreadSpeed", 15)
	self.steam:SetKeyValue( "Speed", 120 )
	self.steam:SetKeyValue( "StartSize", 10 )
	self.steam:SetKeyValue( "EndSize", 35 )
	self.steam:SetKeyValue( "Rate", 26 )
	self.steam:SetKeyValue( "JetLength", 20 )
	self.steam:SetKeyValue( "renderamt", 255 )
	self.steam:SetKeyValue( "type", 0 )
	self.steam:SetKeyValue("spawnflags", "16" + "32")
	self.steam:SetOwner( self.Owner )
	self.steam:SetParent(self)
	self.steam:Spawn()
	self.steam:Activate()
	local steam_name = "steam" .. self.steam:EntIndex()
	self.steam:SetName( steam_name )

end

function ENT:OnRemove()
	self:StopSound("SteamLoop1.Play")
	self:StopSound("SteamLoop2.Play")
end

	function ENT:Use(user)
		local item = user:GetCharacter():GetInventory():HasItem("tool_toolkit")
		if self:GetNetVar("destroyed", false) == true and !item then
			user:Notify("The pipe is broken! You need a toolkit to fix it.") -- message when dont work and you dont have item
			return false
		else
			if item and self:GetNetVar("destroyed", false) == true then
				user:Freeze(true)
				user:SetAction("Repairing...", 12, function() -- line with text when you repair it
					item = user:GetCharacter():GetInventory():HasItem("tool_toolkit")

					if (item) then
						if (item.isTool) then
							item:DamageDurability(1)
						end

						self:SetNetVar("destroyed", false)
						user:Freeze(false)
						self.health = 200
						self:EmitSound("physics/cardboard/cardboard_box_impact_hard7.wav", 100, 75)
						self:Remove()
						user:Notify("You've fixed the pipe.") -- message when you finish the job
					end
				end)
			end
		end
	end
end
