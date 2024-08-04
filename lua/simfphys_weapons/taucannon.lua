--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local function GaussFire(ply,vehicle,shootOrigin,Attachment,damage)
	vehicle:EmitSound("taucannon_fire")
	
	local bullet = {}
		bullet.Num 			= 1
		bullet.Src 			= shootOrigin
		bullet.Dir 			= Attachment.Ang:Forward()
		bullet.Spread 		= Vector(0.01,0.01,0)
		bullet.Tracer		= 1
		bullet.TracerName 	= "simfphys_gausstracer"
		bullet.Force		= damage
		bullet.Damage		= damage * 1.5
		bullet.HullSize		= 1
		bullet.DisableOverride = true
		bullet.Callback = function(att, tr, dmginfo)
			local effect = ents.Create("env_spark")
				effect:SetKeyValue("targetname", "target")
				effect:SetPos( tr.HitPos + tr.HitNormal * 2 )
				effect:SetAngles( tr.HitNormal:Angle() )
				effect:Spawn()
				effect:SetKeyValue("spawnflags","128")
				effect:SetKeyValue("Magnitude",5)
				effect:SetKeyValue("TrailLength",3)
				effect:Fire( "SparkOnce" )
				effect:Fire("kill","",0.21)
				
			util.Decal("fadingscorch", tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal)
		end
		bullet.Attacker 	= ply
		
	vehicle:FireBullets( bullet )
	
	vehicle:GetPhysicsObject():ApplyForceOffset( -Attachment.Ang:Forward() * damage * 100, shootOrigin ) 
end

function simfphys.weapon:ValidClasses()
	
	local classes = {
		"sim_fphys_jeep_armed",
		"sim_fphys_v8elite_armed"
	}
	
	return classes
end

function simfphys.weapon:Initialize( vehicle )
	vehicle:SetBodygroup(1,1)
	
	local pod = vehicle:GetDriverSeat()
	
	simfphys.RegisterCrosshair( pod )
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
	
	local fire = false
	local alt_fire = false
	
	if IsValid( ply ) then 
		self:AimWeapon( ply, vehicle, pod )
		fire = ply:KeyDown( IN_ATTACK )
		alt_fire = ply:KeyDown( IN_ATTACK2 ) and self:CanPrimaryAttack( vehicle )
	else
		ply = NULL
	end
	
	local ID = vehicle:LookupAttachment( "muzzle" )
	local Attachment = vehicle:GetAttachment( ID )
	
	vehicle.wOldPos = vehicle.wOldPos or Vector(0,0,0)
	local deltapos = vehicle:GetPos() - vehicle.wOldPos
	vehicle.wOldPos = vehicle:GetPos()

	local shootOrigin = Attachment.Pos + deltapos * engine.TickInterval()
	
	vehicle.afire_pressed = vehicle.afire_pressed or false
	vehicle.gausscharge = vehicle.gausscharge and (vehicle.gausscharge + math.Clamp((alt_fire and 200 or 0) - vehicle.gausscharge,0, FrameTime() * 100)) or 0
	
	if vehicle.wpn_chr then
		vehicle.wpn_chr:ChangePitch(100 + vehicle.gausscharge * 0.75)
		
		vehicle.gaus_pp_spin = vehicle.gaus_pp_spin and (vehicle.gaus_pp_spin + vehicle.gausscharge / 4) or 0
		vehicle:SetPoseParameter("gun_spin", vehicle.gaus_pp_spin)
	end
	
	if fire and not alt_fire then
		self:PrimaryAttack( vehicle, ply, shootOrigin, Attachment )
	end
	
	if alt_fire ~= vehicle.afire_pressed then
		vehicle.afire_pressed = alt_fire
		if alt_fire then
			vehicle.wpn_chr = CreateSound( vehicle, "weapons/gauss/chargeloop.wav" )
			vehicle.wpn_chr:Play()
			vehicle:CallOnRemove( "stopmesounds", function( vehicle )
				if vehicle.wpn_chr then
					vehicle.wpn_chr:Stop()
				end
			end)
		else
			vehicle.wpn_chr:Stop()
			vehicle.wpn_chr = nil
			GaussFire(ply,vehicle,shootOrigin,Attachment,250 + vehicle.gausscharge * 3)
			vehicle.gausscharge = 0
			
			self:SetNextPrimaryFire( vehicle, CurTime() + 1 )
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

function simfphys.weapon:PrimaryAttack( vehicle, ply, shootOrigin, Attachment )
	if not self:CanPrimaryAttack( vehicle ) then return end
	
	GaussFire(ply,vehicle,shootOrigin,Attachment,12)
	
	self:SetNextPrimaryFire( vehicle, CurTime() + 0.2 )
end
