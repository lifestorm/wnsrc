--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.DSArmorDamageReduction = 1
ENT.DSArmorDamageReductionType = DMG_GENERIC

ENT.DSArmorIgnoreDamageType = DMG_GENERIC

function ENT:ApplyDamage( damage, type )
	if type == DMG_BLAST then 
		damage = damage * 10
	end

	if type == DMG_BULLET then 
		damage = damage * 2
	end

	local MaxHealth = self:GetMaxHealth()
	local CurHealth = self:GetCurHealth()

	local NewHealth = math.max( math.Round(CurHealth - damage,0) , 0 )

	if NewHealth <= (MaxHealth * 0.6) then
		if NewHealth <= (MaxHealth * 0.3) then
			self:SetOnFire( true )
			self:SetOnSmoke( false )
		else
			self:SetOnSmoke( true )
		end
	end

	if MaxHealth > 30 and NewHealth <= 31 then
		if self:EngineActive() then
			self:DamagedStall()
		end
	end

	if NewHealth <= 0 then

		self:ExplodeVehicle()

		return
	end

	self:SetCurHealth( NewHealth )
end

function ENT:OnTakeDamage( dmginfo )
	if not self:IsInitialized() then return end

	if dmginfo:IsDamageType( self.DSArmorIgnoreDamageType ) then return end

	if dmginfo:IsDamageType( self.DSArmorDamageReductionType ) then
		if dmginfo:GetDamage() ~= 0 then
			dmginfo:ScaleDamage( self.DSArmorDamageReduction )

			dmginfo:SetDamage( math.max(dmginfo:GetDamage(),1) )
		end
	end

	if dmginfo:IsDamageType( DMG_BLAST ) then
		local Inflictor = dmginfo:GetInflictor()

		if IsValid( Inflictor ) and isfunction( Inflictor.GetEntityFilter ) then
			for ents, _ in pairs( Inflictor:GetEntityFilter() ) do
				if ents == self then return end
			end
		end
	end

	local dmgPartsTableOK = true

	if istable( self._dmgParts ) then
		for _, part in pairs( self._dmgParts ) do
			if isvector( part.mins ) and isvector( part.maxs ) and isvector( part.pos ) and isangle( part.ang ) then continue end

			dmgPartsTableOK = false

			break
		end
	else
		dmgPartsTableOK = false
	end

	local CriticalHit = false

	if dmgPartsTableOK then
		CriticalHit = self:CalcComponentDamage( dmginfo )
	else
		print("[LVS] - "..self:GetSpawn_List().." is doing something it shouldn't! DS part has been detected but was registered incorrectly!")
	end

	if hook.Run( "simfphysOnTakeDamage", self, dmginfo ) then return end

	local Damage = dmginfo:GetDamage() 
	local DamagePos = dmginfo:GetDamagePosition() 
	local Type = dmginfo:GetDamageType()
	local Driver = self:GetDriver()

	self.LastAttacker = dmginfo:GetAttacker() 
	self.LastInflictor = dmginfo:GetInflictor()

	if simfphys.DamageEnabled then
		net.Start( "simfphys_spritedamage" )
			net.WriteEntity( self )
			net.WriteVector( self:WorldToLocal( DamagePos ) ) 
			net.WriteBool( false ) 
		net.Broadcast()

		if Type == DMG_AIRBOAT then
			Type = DMG_DIRECT
			Damage = Damage * 6
		end

		local oldHP = self:GetCurHealth()

		self:ApplyDamage( Damage, Type )

		local newHP = self:GetCurHealth()

		if oldHP ~= newHP then
			local IsFireDamage = dmginfo:IsDamageType( DMG_BURN )

			if IsValid( self.LastAttacker ) and self.LastAttacker:IsPlayer() and not IsFireDamage then
				net.Start( "lvs_hitmarker" )
					net.WriteBool( CriticalHit )
				net.Send( self.LastAttacker )
			end

			if Damage > 1 and not IsFireDamage then
				net.Start( "lvs_hurtmarker" )
					net.WriteFloat( math.min( Damage / 50, 1 ) )
				net.Send( self:GetEveryone() )
			end
		end
	end
end

function ENT:ExplodeVehicle()
	if not IsValid( self ) then return end

	if self.destroyed then return end

	self.destroyed = true

	local Attacker = self.LastAttacker

	if IsValid( Attacker ) and Attacker:IsPlayer() then
		net.Start( "lvs_killmarker" )
		net.Send( Attacker )
	end

	local GibMDL = self.GibModels
	self.GibModels = nil

	self:OnFinishExplosion()

	self.GibModels = GibMDL
	GibMDL = nil

	local ply = self.EntityOwner
	local skin = self:GetSkin()
	local Col = self:GetColor()
	Col.r = Col.r * 0.8
	Col.g = Col.g * 0.8
	Col.b = Col.b * 0.8
	
	local Driver = self:GetDriver()
	if IsValid( Driver ) then
		if self.RemoteDriver ~= Driver then
			local dmginfo = DamageInfo()
			dmginfo:SetDamage( Driver:Health() + Driver:Armor() )
			dmginfo:SetAttacker( self.LastAttacker or game.GetWorld() )
			dmginfo:SetInflictor( self.LastInflictor or game.GetWorld() )
			dmginfo:SetDamageType( DMG_DIRECT )

			Driver:TakeDamageInfo( dmginfo )
		end
	end
	
	if self.PassengerSeats then
		for i = 1, table.Count( self.PassengerSeats ) do
			local Passenger = self.pSeat[i]:GetDriver()
			if IsValid( Passenger ) then
				local dmginfo = DamageInfo()
				dmginfo:SetDamage( Passenger:Health() + Passenger:Armor() )
				dmginfo:SetAttacker( self.LastAttacker or game.GetWorld() )
				dmginfo:SetInflictor( self.LastInflictor or game.GetWorld() )
				dmginfo:SetDamageType( DMG_DIRECT )

				Passenger:TakeDamageInfo( dmginfo )
			end
		end
	end

	if self.GibModels then
		local bprop = ents.Create( "gmod_sent_vehicle_fphysics_gib" )
		bprop:SetModel( self.GibModels[1] )
		bprop:SetPos( self:GetPos() )
		bprop:SetAngles( self:GetAngles() )
		bprop.MakeSound = true
		bprop:Spawn()
		bprop:Activate()
		bprop:GetPhysicsObject():SetVelocity( self:GetVelocity() + Vector(math.random(-5,5),math.random(-5,5),math.random(150,250)) ) 
		bprop:GetPhysicsObject():SetMass( self.Mass * 0.75 )
		bprop.DoNotDuplicate = true
		bprop:SetColor( Col )
		bprop:SetSkin( skin )
		
		self.Gib = bprop
		
		simfphys.SetOwner( ply , bprop )
		
		if IsValid( ply ) then
			undo.Create( "Gib" )
			undo.SetPlayer( ply )
			undo.AddEntity( bprop )
			undo.SetCustomUndoText( "Undone Gib" )
			undo.Finish( "Gib" )
			ply:AddCleanup( "Gibs", bprop )
		end
		
		bprop.Gibs = {}
		for i = 2, table.Count( self.GibModels ) do
			local prop = ents.Create( "gmod_sent_vehicle_fphysics_gib" )
			prop:SetModel( self.GibModels[i] )			
			prop:SetPos( self:GetPos() )
			prop:SetAngles( self:GetAngles() )
			prop:SetOwner( bprop )
			prop:Spawn()
			prop:Activate()
			prop.DoNotDuplicate = true
			bprop:DeleteOnRemove( prop )
			bprop.Gibs[i-1] = prop
			
			local PhysObj = prop:GetPhysicsObject()
			if IsValid( PhysObj ) then
				PhysObj:SetVelocityInstantaneous( VectorRand() * 500 + self:GetVelocity() + Vector(0,0,math.random(150,250)) )
				PhysObj:AddAngleVelocity( VectorRand() )
			end
			
			
			simfphys.SetOwner( ply , prop )
		end
	else
		
		local bprop = ents.Create( "gmod_sent_vehicle_fphysics_gib" )
		bprop:SetModel( self:GetModel() )			
		bprop:SetPos( self:GetPos() )
		bprop:SetAngles( self:GetAngles() )
		bprop.MakeSound = true
		bprop:Spawn()
		bprop:Activate()
		bprop:GetPhysicsObject():SetVelocity( self:GetVelocity() + Vector(math.random(-5,5),math.random(-5,5),math.random(150,250)) ) 
		bprop:GetPhysicsObject():SetMass( self.Mass * 0.75 )
		bprop.DoNotDuplicate = true
		bprop:SetColor( Col )
		bprop:SetSkin( skin )
		for i = 0, self:GetNumBodyGroups() do
			bprop:SetBodygroup(i, self:GetBodygroup(i))
		end
		
		self.Gib = bprop
		
		simfphys.SetOwner( ply , bprop )
		
		if IsValid( ply ) then
			undo.Create( "Gib" )
			undo.SetPlayer( ply )
			undo.AddEntity( bprop )
			undo.SetCustomUndoText( "Undone Gib" )
			undo.Finish( "Gib" )
			ply:AddCleanup( "Gibs", bprop )
		end
		
		if self.CustomWheels == true and not self.NoWheelGibs then
			bprop.Wheels = {}
			for i = 1, table.Count( self.GhostWheels ) do
				local Wheel = self.GhostWheels[i]
				if IsValid(Wheel) then
					local prop = ents.Create( "gmod_sent_vehicle_fphysics_gib" )
					prop:SetModel( Wheel:GetModel() )			
					prop:SetPos( Wheel:LocalToWorld( Vector(0,0,0) ) )
					prop:SetAngles( Wheel:LocalToWorldAngles( Angle(0,0,0) ) )
					prop:SetOwner( bprop )
					prop:Spawn()
					prop:Activate()
					prop:GetPhysicsObject():SetVelocity( self:GetVelocity() + Vector(math.random(-5,5),math.random(-5,5),math.random(0,25)) )
					prop:GetPhysicsObject():SetMass( 20 )
					prop.DoNotDuplicate = true
					bprop:DeleteOnRemove( prop )
					bprop.Wheels[i] = prop
					
					simfphys.SetOwner( ply , prop )
				end
			end
		end
	end

	self:Extinguish() 
	
	self:OnDestroyed()
	
	hook.Run( "simfphysOnDestroyed", self, self.Gib )
	
	self:Remove()
end
