--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local function hmgfire(ply,vehicle,shootOrigin,shootDirection)
	local projectile = {}
		projectile.filter = vehicle.VehicleData["filter"]
		projectile.shootOrigin = shootOrigin
		projectile.shootDirection = shootDirection
		projectile.attacker = ply
		projectile.Tracer	= 1
		projectile.Spread = Vector(0.015,0.015,0.015)
		projectile.HullSize = 5
		projectile.attackingent = vehicle
		projectile.Damage = 30
		projectile.Force = 12
	simfphys.FireHitScan( projectile )
end

local function minigunfire(ply,vehicle,shootOrigin,shootDirection)
	local projectile = {}
		projectile.filter = vehicle.VehicleData["filter"]
		projectile.shootOrigin = shootOrigin
		projectile.shootDirection = shootDirection
		projectile.attacker = ply
		projectile.Tracer	= 1
		projectile.Spread = Vector(0.015,0.015,0.015)
		projectile.HullSize = 5
		projectile.attackingent = vehicle
		projectile.Damage = 40
		projectile.Force = 12
	simfphys.FireHitScan( projectile )
end

function simfphys.weapon:ValidClasses()
	
	local classes = {
		"sim_fphys_ratmobile",
		"sim_fphys_hedgehog",
		"sim_fphys_chaos126p"
	}
	
	return classes
end

function simfphys.weapon:Initialize( vehicle )
	local class = vehicle:GetSpawn_List()
	vehicle.neg = class == "sim_fphys_ratmobile" and 1 or -1

	local data = {}
	data.Attachment = "machinegun_ref"
	data.Direction = Vector(1,0,0)
	data.Attach_Start_Left = "machinegun_barell_right"
	data.Attach_Start_Right = "machinegun_barell_left"

	simfphys.RegisterCrosshair( vehicle:GetDriverSeat(), data )
	
	vehicle:SetNWString( "WeaponMode", "Machine Gun Turret" )
end

function simfphys.weapon:Think( vehicle )
	vehicle.VehicleData["steerangle"] = 45
	
	local curtime = CurTime()
	
	local DriverSeat = vehicle:GetDriverSeat()
	
	if not IsValid( DriverSeat ) then return end
	
	local ply = DriverSeat:GetDriver()
	
	if not IsValid(ply) then
		if vehicle.wpn then
			vehicle.wpn:Stop()
			vehicle.wpn = nil
		end
		
		if vehicle.wpn2 then
			vehicle.wpn2:Stop()
			vehicle.wpn2 = nil
		end
		return
	end
	
	vehicle.wOldPos = vehicle.wOldPos or vehicle:GetPos()
	local deltapos = vehicle:GetPos() - vehicle.wOldPos
	vehicle.wOldPos = vehicle:GetPos()
	
	local ID = vehicle:LookupAttachment( "machinegun_ref" )
	local Attachment = vehicle:GetAttachment( ID )
	
	local Angles = angle_zero

	if ply:lvsMouseAim() then
		local TargetAngle = ply:EyeAngles()

		local ang = vehicle:GetAngles()
		ang.y = DriverSeat:GetAngles().y + 90

		local Forward = ang:Right()
		local View = DriverSeat:WorldToLocalAngles( TargetAngle )

		local Pitch = (vehicle:AngleBetweenNormal( View:Up(), ang:Forward() ) - 90)
		local Yaw = (vehicle:AngleBetweenNormal( View:Forward(), ang:Right() ) - 90)

		Angles = Angle(-Pitch,Yaw,0)
	else
		Angles = vehicle:WorldToLocalAngles( ply:EyeAngles() )
		Angles:Normalize()
	end

	vehicle.sm_pp_yaw = vehicle.sm_pp_yaw and (vehicle.sm_pp_yaw + (Angles.y - vehicle.sm_pp_yaw) * 0.2) or 0
	vehicle.sm_pp_pitch = vehicle.sm_pp_pitch and (vehicle.sm_pp_pitch + (Angles.p - vehicle.sm_pp_pitch) * 0.2) or 0

	vehicle:SetPoseParameter("vehicle_weapon_yaw", vehicle.sm_pp_yaw )
	vehicle:SetPoseParameter("vehicle_weapon_pitch", -vehicle.sm_pp_pitch )
	
	local tr = util.TraceLine( {
		start = Attachment.Pos,
		endpos = Attachment.Pos + Attachment.Ang:Forward() * 50000,
		filter = {vehicle}
	} )
	local Aimpos = tr.HitPos
	
	local AttachmentID_Left = vehicle:LookupAttachment( "machinegun_barell_left" )
	local AttachmentID_Right = vehicle:LookupAttachment( "machinegun_barell_right" )
	
	local Attachment_Left = vehicle:GetAttachment( AttachmentID_Left )
	local Attachment_Right = vehicle:GetAttachment( AttachmentID_Right )
	
	local pos1 = Attachment_Left.Pos
	local pos2 = Attachment_Right.Pos
	
	local Aimang = (Aimpos - (pos1 + pos2) * 0.5):Angle()
	local Angles = vehicle:WorldToLocalAngles( Aimang )
	Angles:Normalize()
	
	vehicle:SetPoseParameter("vehicle_minigun_yaw", Angles.y )

	vehicle:SetPoseParameter("vehicle_minigun_pitch", Angles.p * vehicle.neg )
	
	local keyattack = ply:KeyDown( IN_ATTACK ) and not vehicle.lockweapons and (vehicle:GetNWInt( "CurWPNAmmo", -1 ) > 0)
	local alt_fire = ply:KeyDown( IN_ATTACK2 )
	local reload = ply:KeyDown( IN_RELOAD )
	
	vehicle.FireMode = vehicle.FireMode or 0
	
	vehicle.missle_ammo = vehicle.missle_ammo or 6
	vehicle.mg_ammo = vehicle.mg_ammo or 1500
	vehicle.rac_ammo = vehicle.rac_ammo or 300
	
	if vehicle.FireMode == 0 then
		vehicle:SetNWInt( "CurWPNAmmo", vehicle.mg_ammo )
		
	elseif vehicle.FireMode == 1 then
		vehicle:SetNWInt( "CurWPNAmmo", vehicle.rac_ammo )
		
	else
		vehicle:SetNWInt( "CurWPNAmmo", vehicle.missle_ammo )
	end
	
	if reload and (vehicle.missle_ammo ~= 6 or vehicle.mg_ammo ~= 1500 or vehicle.rac_ammo ~= 300)  then
		vehicle:EmitSound("simulated_vehicles/weapons/apc_reload.wav")
		
		vehicle.missle_ammo = 6
		vehicle.mg_ammo = 1500
		vehicle.rac_ammo = 300
	
		vehicle.lockweapons = true
		
		vehicle:SetIsCruiseModeOn( false )
		
		timer.Simple( 3, function()
			if not IsValid( vehicle ) then return end
			vehicle.lockweapons = false
			vehicle:SetIsCruiseModeOn( false )
			
			vehicle:EmitSound("simulated_vehicles/weapons/leopard_ready.wav")
		end)
	end
	
	if alt_fire ~= vehicle.afire_pressed then
		vehicle.afire_pressed = alt_fire
		if alt_fire then
			vehicle.FireMode = vehicle.FireMode + 1
			if vehicle.FireMode >= 3 then
				vehicle.FireMode = 0
			end
			
			if vehicle.FireMode == 0 then
				vehicle:EmitSound("weapons/smg1/switch_burst.wav")
				vehicle:SetNWString( "WeaponMode", "Machine Gun Turret" )
				
			elseif vehicle.FireMode == 1 then
				vehicle:EmitSound("weapons/357/357_spin1.wav")
				vehicle:SetNWString( "WeaponMode", "Minigun" )
				
			else
				vehicle:EmitSound("weapons/shotgun/shotgun_cock.wav")
				vehicle:SetNWString( "WeaponMode", "Missiles" )
			end
		end
	end
	
	local fire = vehicle.FireMode == 0 and keyattack
	local fire2 = vehicle.FireMode == 1 and keyattack
	local fire3 = vehicle.FireMode == 2 and keyattack
	
	vehicle.smoothaltfire = vehicle.smoothaltfire and (vehicle.smoothaltfire + ((fire2 and 20 or 0) - vehicle.smoothaltfire) * 0.1) or 0
	vehicle.minigunspin = vehicle.minigunspin and (vehicle.minigunspin + vehicle.smoothaltfire) or 0
	vehicle:SetPoseParameter("vehicle_minigun_spin", vehicle.minigunspin )
	
	vehicle.NextShoot = vehicle.NextShoot or 0
	
	if fire then
		if vehicle.NextShoot < curtime then
			
			vehicle.mg_ammo = vehicle.mg_ammo - 1
			
			if vehicle.swapMuzzle then
				vehicle.swapMuzzle = false
			else
				vehicle.swapMuzzle = true
			end
		
			local offset = deltapos * engine.TickInterval()
		
			local AttachmentID = vehicle.swapMuzzle and AttachmentID_Left or AttachmentID_Right
			local Attachment = vehicle:GetAttachment( AttachmentID )
			
			local shootOrigin = Attachment.Pos + offset
			local shootDirection = Attachment.Ang:Forward()
			
			hmgfire( ply, vehicle, shootOrigin, Attachment.Ang:Forward() )
			
			vehicle.NextShoot = curtime + 0.08
		end
	end
	
	if fire2 then
		if vehicle.NextShoot < curtime then
		
			vehicle.rac_ammo = vehicle.rac_ammo - 1
			
			local offset = deltapos * engine.TickInterval()
			
			local muzzle_1 = vehicle:LookupAttachment( "minigun_barell_right" )
			local muzzle_2 = vehicle:LookupAttachment( "minigun_barell_left" )
			local muzzles = {muzzle_1,muzzle_2}
			
			for k, v in pairs( muzzles ) do
				local AttachmentID = v
				local Attachment = vehicle:GetAttachment( AttachmentID )
				
				local shootOrigin = Attachment.Pos + offset
				local shootDirection = Attachment.Ang:Forward()
				
				minigunfire( ply, vehicle, shootOrigin, shootDirection )
			end
			
			vehicle.NextShoot = curtime + 0.03
		end
	end
	
	vehicle.OldFire = vehicle.OldFire or false
	vehicle.OldFire2 = vehicle.OldFire2 or false
	vehicle.OldFire3 = vehicle.OldFire3 or false
	
	if vehicle.OldFire ~= fire then
		vehicle.OldFire = fire
		if fire then
			vehicle.wpn = CreateSound( vehicle, "simulated_vehicles/weapons/diprip/machinegun_loop.wav" )
			vehicle.wpn:Play()
			vehicle:CallOnRemove( "stop_fire1_sounds", function( vehicle )
				if vehicle.wpn then
					vehicle.wpn:Stop()
				end
			end)
		else
			if vehicle.wpn then
				vehicle.wpn:Stop()
				vehicle.wpn = nil
			end
		end
	end
	
	if vehicle.OldFire2 ~= fire2 then
		vehicle.OldFire2 = fire2
		if fire2 then
			vehicle.wpn2 = CreateSound( vehicle, "simulated_vehicles/weapons/diprip/minigun_loop.wav" )
			vehicle.wpn2:Play()
			vehicle:CallOnRemove( "stop_fire2_sounds", function( vehicle )
				if vehicle.wpn2 then
					vehicle.wpn2:Stop()
				end
			end)
		else
			if vehicle.wpn2 then
				vehicle.wpn2:Stop()
				vehicle.wpn2 = nil
			end
		end
	end
	
	
	if vehicle.OldFire3 ~= fire3 then
		vehicle.OldFire3 = fire3
		if fire3 then
			if vehicle.NextShoot < curtime then
				if not IsValid(vehicle.missle) then
					vehicle:EmitSound("simulated_vehicles/weapons/diprip/rocket.wav")
					
					vehicle.missle_ammo = vehicle.missle_ammo - 1
					
					if vehicle.swapMuzzle then
						vehicle.swapMuzzle = false
					else
						vehicle.swapMuzzle = true
					end
					
					local attach = vehicle.swapMuzzle and vehicle:GetAttachment( vehicle:LookupAttachment( "rocket_barell_right" ) ) or vehicle:GetAttachment( vehicle:LookupAttachment( "rocket_barell_left" ) )
					
					vehicle.missle = ents.Create( "rpg_missile" )
					vehicle.missle:SetPos( attach.Pos + attach.Ang:Up() * 25 )
					vehicle.missle:SetAngles( attach.Ang - Angle(10,0,0) )
					vehicle.missle:SetOwner( vehicle )
					vehicle.missle:SetSaveValue( "m_flDamage", 120 )
					vehicle.missle:Spawn()
					vehicle.missle:Activate()
					
					vehicle.missle.DirVector = vehicle.missle:GetAngles():Forward()
					
					vehicle.NextShoot = curtime + 0.5
					vehicle.UnlockMissle = curtime + 0.5
				end
			end
		end
	end
	
	if IsValid(vehicle.missle) then
		if vehicle.UnlockMissle < curtime then
			local targetdir = Aimpos - vehicle.missle:GetPos()
			targetdir:Normalize()
			
			vehicle.missle.DirVector = vehicle.missle.DirVector + (targetdir - vehicle.missle.DirVector) * 0.1
			
			local vel = -vehicle.missle:GetVelocity() + vehicle.missle.DirVector * 2500 + vehicle:GetVelocity()
			
			vehicle.missle:SetVelocity( vel )
			vehicle.missle:SetAngles( vehicle.missle.DirVector:Angle() )
		end
	end
end
