--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local function AirboatFire(ply,vehicle,shootOrigin,Attachment,damage)
	local bullet = {}
	bullet.Src 	= shootOrigin
	bullet.Dir 	= Attachment.Ang:Forward()
	bullet.Spread 	= Vector(0.04,0.04,0.04)
	bullet.TracerName = "lvs_ar2_tracer"
	bullet.Force	= damage
	bullet.HullSize 	= 1
	bullet.Damage	= damage
	bullet.Velocity = 12000
	bullet.Attacker 	= ply
	bullet.Callback = function(att, tr, dmginfo)
		local effectdata = EffectData()
		effectdata:SetOrigin( tr.HitPos + tr.HitNormal )
		effectdata:SetNormal( tr.HitNormal * 2 )
		effectdata:SetRadius( 10 )
		util.Effect( "cball_bounce", effectdata, true, true )
	end
	vehicle:LVSFireBullet( bullet )
end

function simfphys.weapon:ValidClasses()
	
	local classes = {
		"sim_fphys_jeep_armed2",
		"sim_fphys_v8elite_armed2"
	}
	
	return classes
end

function simfphys.weapon:Initialize( vehicle )
	--vehicle:SetBodygroup(1,1)

	local ID = vehicle:LookupAttachment( "gun_ref" )
	local attachmentdata = vehicle:GetAttachment( ID )

	local prop = ents.Create( "gmod_sent_vehicle_fphysics_attachment" )
	prop:SetModel( "models/airboatgun.mdl" )			
	prop:SetPos( attachmentdata.Pos )
	prop:SetAngles( attachmentdata.Ang )
	prop:SetModelScale( 0.5 ) 
	prop:Spawn()
	prop:Activate()
	prop:SetNotSolid( true )
	prop:SetParent( vehicle, ID )
	prop.DoNotDuplicate = true

	simfphys.RegisterCrosshair( vehicle:GetDriverSeat() )
	
	simfphys.SetOwner( vehicle.EntityOwner, prop )
end

function simfphys.weapon:AimWeapon( ply, vehicle, pod )	
	local Aimang = ply:EyeAngles()
	local AimRate = 250
	
	local Angles = angle_zero
	if ply:lvsMouseAim() then
		local ang = vehicle:GetAngles()
		ang.y = pod:GetAngles().y + 90

		local Forward = ang:Right()
		local View = pod:WorldToLocalAngles( Aimang )

		local Pitch = (vehicle:AngleBetweenNormal( View:Up(), ang:Forward() ) - 90)
		local Yaw = (vehicle:AngleBetweenNormal( View:Forward(), ang:Right() ) - 90)

		Angles = Angle(-Pitch,Yaw,0)
	else
		Angles = vehicle:WorldToLocalAngles( Aimang ) - Angle(0,90,0)
		Angles:Normalize()
	end

	vehicle.sm_pp_yaw = vehicle.sm_pp_yaw and math.ApproachAngle( vehicle.sm_pp_yaw, Angles.y, AimRate * FrameTime() ) or 0
	vehicle.sm_pp_pitch = vehicle.sm_pp_pitch and math.ApproachAngle( vehicle.sm_pp_pitch, Angles.p, AimRate * FrameTime() ) or 0
	
	local TargetAng = Angle(vehicle.sm_pp_pitch,vehicle.sm_pp_yaw,0)
	TargetAng:Normalize() 
	
	vehicle:SetPoseParameter("vehicle_weapon_yaw", -TargetAng.y )
	vehicle:SetPoseParameter("vehicle_weapon_pitch", -TargetAng.p )
	
	return Aimang
end

function simfphys.weapon:Think( vehicle )
	local pod = vehicle:GetDriverSeat()
	if not IsValid( pod ) then return end
	
	local ply = pod:GetDriver()
	
	local curtime = CurTime()
	
	if not IsValid( ply ) then 
		if vehicle.wpn then
			vehicle.wpn:Stop()
			vehicle.wpn = nil
		end
		
		return
	end
	
	local ID = vehicle:LookupAttachment( "muzzle" )
	local Attachment = vehicle:GetAttachment( ID )
	
	self:AimWeapon( ply, vehicle, pod )
	
	vehicle.wOldPos = vehicle.wOldPos or Vector(0,0,0)
	local deltapos = vehicle:GetPos() - vehicle.wOldPos
	vehicle.wOldPos = vehicle:GetPos()

	local shootOrigin = Attachment.Pos + deltapos * engine.TickInterval()
	
	vehicle.charge = vehicle.charge or 100
	
	local fire = ply:KeyDown( IN_ATTACK ) and vehicle.charge > 0
	
	if fire then
		self:PrimaryAttack( vehicle, ply, shootOrigin, Attachment, ID )
	else
		vehicle.charge = math.min(vehicle.charge + 0.3,100)
	end
	
	vehicle.OldFire = vehicle.OldFire or false
	if vehicle.OldFire ~= fire then
		vehicle.OldFire = fire
		if fire then
			vehicle.wpn = CreateSound( vehicle, "weapons/airboat/airboat_gun_loop2.wav" )
			vehicle.wpn:Play()
			vehicle:CallOnRemove( "stopmesounds", function( vehicle )
				if vehicle.wpn then
					vehicle.wpn:Stop()
				end
			end)
		else
			if vehicle.wpn then
				vehicle.wpn:Stop()
				vehicle.wpn = nil
			end

			vehicle:EmitSound("weapons/airboat/airboat_gun_lastshot"..math.random(1,2)..".wav")
		end
	end
end

function simfphys.weapon:CanPrimaryAttack( vehicle )
	vehicle.NextShoot = vehicle.NextShoot or 0
	return vehicle.NextShoot < CurTime()
end

function simfphys.weapon:SetNextPrimaryFire( vehicle, time )
	vehicle.NextShoot = time
end

function simfphys.weapon:PrimaryAttack( vehicle, ply, shootOrigin, Attachment, ID )
	if not self:CanPrimaryAttack( vehicle ) then return end
	
	local effectdata = EffectData()
		effectdata:SetOrigin( shootOrigin )
		effectdata:SetAngles( Attachment.Ang )
		effectdata:SetEntity( vehicle )
		effectdata:SetAttachment( ID )
		effectdata:SetScale( 1 )
	util.Effect( "AirboatMuzzleFlash", effectdata, true, true )
	
	AirboatFire(ply,vehicle,shootOrigin,Attachment,(vehicle.charge / 5))
	
	vehicle.charge = vehicle.charge - 0.5
	
	if vehicle.charge <= 0 then
		if vehicle.charge > -1 then
			vehicle:EmitSound("weapons/airboat/airboat_gun_energy"..math.Round(math.random(1,2),0)..".wav")
		end
		vehicle.charge = -50
	end
	
	self:SetNextPrimaryFire( vehicle, CurTime() + 0.05 )
end
