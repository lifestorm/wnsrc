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
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Damage = 1

function ENT:Draw()
end

function ENT:Initialize()
	self.Damage = 1
	self:SetNWBool("extinguished",false)
	
	if SERVER then
		self:SetModel( "models/weapons/tfa_csgo/w_eq_incendiarygrenade_thrown.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_NONE )
		self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
		self:DrawShadow( false )

		self:CreateFires()
	end
	self:NextThink( CurTime() )
end

function ENT:CreateFires()
	for i = 1, 20 do
		local fire = ents.Create("info_particle_system")
		if (i < 2) then
			fire:SetKeyValue("effect_name","molotov_fire_main_gm")
		else
			fire:SetKeyValue("effect_name","molotov_fire_child_gm")
		end
		local pos = self:GetPos()
		//fire:SetPos( Vector( pos.x + 100 * math.sin( math.rad( i * 20 ) ), pos.y + 100 * math.cos( math.rad( i * 20 ) ), pos.z ) )
		fire:SetPos( Vector( pos.x + math.Rand(0, 144) * math.sin( math.rad( i * math.Rand( 0, 180 ) ) ), pos.y + math.Rand(0, 144) * math.cos( math.rad( i * math.Rand( 0, 180 ) ) ), pos.z ) )
		fire:SetAngles( self:GetAngles() )
		fire:SetParent( self )
		fire:Spawn()
		fire:Activate()
		fire:Fire("Start","",0)
		fire:Fire("Kill", "",8)
	end

	self.nextFires = CurTime() + 6
end

function ENT:Think()
	if SERVER then
		for k, v in pairs( ents.FindInSphere( self:GetPos(), 150 ) ) do
			if v:IsPlayer() or v:IsNPC() then
				-- If player did not take the damage in TBC then deal it for 1 second and then stop
				if (!self.damageReceivers or self.damageReceivers and !self.damageReceivers[v]) then
					damage = DamageInfo()
					damage:SetDamage( math.random( 3, 7 ) )
					damage:SetAttacker( self:GetOwner() )
					damage:SetInflictor( self:GetCreator() )
					damage:SetDamageType( DMG_BURN )
					v:TakeDamageInfo( damage )

					if (self.damageReceivers and self.damageReceivers[v] == nil) then
						self.damageReceivers[v] = false

						timer.Simple(1, function()
							if (IsValid(self) and IsValid(v)) then
								self.damageReceivers[v] = true
							end
						end)
					end
				end
			end
		end

		if (self.nextFires and CurTime() > self.nextFires) then
			self:CreateFires()
		end
	end
	if self:GetNWBool("extinguished",true) then
		if not self.PlayedSound then
			self:EmitSound("TFA_CSGO_Molotov.Extinguish")
			self.PlayedSound = true
		end
		if SERVER then
			SafeRemoveEntity( self )
		end
	end
	self:NextThink( CurTime() + math.Rand( 0.2, 0.7 ) )
end
