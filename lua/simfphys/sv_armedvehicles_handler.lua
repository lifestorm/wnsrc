--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT
-- DO NOT EDIT OR REUPLOAD THIS SCRIPT

simfphys = istable( simfphys ) and simfphys or {}

simfphys.ManagedVehicles = istable( simfphys.ManagedVehicles ) and simfphys.ManagedVehicles or {}
simfphys.Weapons = {}
simfphys.weapon = {}

util.AddNetworkString( "simfphys_tank_do_effect" ) -- some people still use this so we have to keep it
util.AddNetworkString( "simfphys_update_tracks" )

--resource.AddSingleFile( "materials/effects/simfphys_armed/gauss_beam.vmt" )
--resource.AddSingleFile( "materials/effects/simfphys_armed/gauss_beam.vtf" )
--resource.AddSingleFile( "materials/effects/simfphys_armed/spark.vmt" )
--resource.AddSingleFile( "materials/effects/simfphys_armed/spark.vtf" )
--resource.AddSingleFile( "materials/effects/simfphys_armed/spark_brightness.vtf" )

local ImpactSounds = {
	"physics/metal/metal_sheet_impact_bullet2.wav",
	"physics/metal/metal_sheet_impact_hard2.wav",
	"physics/metal/metal_sheet_impact_hard6.wav",
}

sound.Add( {
	name = "apc_fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 110,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/apc_fire.wav"
} )

sound.Add( {
	name = "tiger_fire",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 140,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/tiger_cannon.wav"
} )

sound.Add( {
	name = "leopard_fire",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 140,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/leopard_cannon.wav"
} )

sound.Add( {
	name = "leopard_fire_mg",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 110,
	pitch = { 90, 100 },
	sound = {"^simulated_vehicles/weapons/leopard_mg1.wav","^simulated_vehicles/weapons/leopard_mg2.wav","^simulated_vehicles/weapons/leopard_mg3.wav"}
} )

sound.Add( {
	name = "t90ms_fire",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 140,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/t90ms_cannon.wav"
} )

sound.Add( {
	name = "tiger_fire_mg",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 110,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/tiger_mg.wav"
} )

sound.Add( {
	name = "tiger_fire_mg_new",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 110,
	pitch = { 90, 110 },
	sound = {"^simulated_vehicles/weapons/tiger_mg1.wav","^simulated_vehicles/weapons/tiger_mg2.wav","^simulated_vehicles/weapons/tiger_mg3.wav"}
} )

sound.Add( {
	name = "tiger_reload",
	channel = CHAN_STREAM,
	volume = 1.0,
	level = 70,
	pitch = { 90, 110 },
	sound = "simulated_vehicles/weapons/tiger_reload.wav"
} )

sound.Add( {
	name = "sherman_fire",
	channel = CHAN_ITEM,
	volume = 1.0,
	level = 140,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/sherman_cannon.wav"
} )

sound.Add( {
	name = "sherman_fire_mg",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 110,
	pitch = { 90, 110 },
	sound = "^simulated_vehicles/weapons/sherman_mg.wav"
} )

sound.Add( {
	name = "sherman_reload",
	channel = CHAN_STREAM,
	volume = 1.0,
	level = 70,
	pitch = { 90, 110 },
	sound = "simulated_vehicles/weapons/sherman_reload.wav"
} )

sound.Add( {
	name = "t90ms_reload",
	channel = CHAN_STREAM,
	volume = 1.0,
	level = 70,
	pitch = { 90, 110 },
	sound = "simulated_vehicles/weapons/t90ms_reload.wav"
} )

sound.Add( {
	name = "taucannon_fire",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 80,
	pitch = { 95, 105 },
	sound = "weapons/gauss/fire1.wav"
} )

-- seriously guys, you are not supposed to copy this script. I had to create this workaround because people keep stealing the entire code.
function simfphys.FireHitScan( data )
	simfphys.FireBullet( data )
end

function simfphys.FirePhysProjectile( data )
	simfphys.FirePhysBullet( data )
end

function simfphys.RegisterCrosshair( ent, data )
	simfphys.xhairRegister( ent, data )
end

function simfphys.RegisterCamera( ent, offset_firstperson, offset_thirdperson, bLocalAng, attachment )
	simfphys.CameraRegister( ent, offset_firstperson, offset_thirdperson, bLocalAng, attachment )
end

function simfphys.armedAutoRegister( vehicle )
	simfphys.WeaponSystemRegister( vehicle )
	
	return true
end

function simfphys.CameraRegister( ent, offset_firstperson, offset_thirdperson, bLocalAng, attachment )
	if not IsValid( ent ) then return end
	
	offset_firstperson = isvector( offset_firstperson ) and offset_firstperson or Vector(0,0,0)
	offset_thirdperson = isvector( offset_thirdperson ) and offset_thirdperson or Vector(0,0,0)
	
	ent:SetNWBool( "simfphys_SpecialCam", true )
	ent:SetNWBool( "SpecialCam_LocalAngles",  bLocalAng or false )
	ent:SetNWVector( "SpecialCam_Firstperson", offset_firstperson )
	ent:SetNWVector( "SpecialCam_Thirdperson", offset_thirdperson )
	
	if isstring( attachment ) then 
		ent:SetNWString( "SpecialCam_Attachment", attachment )
	end
end

function simfphys.FirePhysBullet( data )
	if not data then return end
	if not istable( data.filter ) then return end
	if not isvector( data.shootOrigin ) then return end
	if not isvector( data.shootDirection ) then return end
	if not IsValid( data.attacker ) then return end
	if not IsValid( data.attackingent ) then return end
	if not isnumber( data.DeflectAng ) then data.DeflectAng = 25 end
	
	local projectile = ents.Create( "simfphys_tankprojectile" )
	projectile:SetPos( data.shootOrigin )
	projectile:SetAngles( data.shootDirection:Angle() )
	projectile:SetOwner( data.attackingent )
	projectile.Attacker = data.attacker
	projectile.DeflectAng = data.DeflectAng
	projectile.AttackingEnt = data.attackingent 
	projectile.Force = data.Force and data.Force or 100
	projectile.Damage = data.Damage and data.Damage or 100
	projectile.BlastRadius = data.BlastRadius and data.BlastRadius or 200
	projectile.BlastDamage = data.BlastDamage and data.BlastDamage or 50
	projectile:SetBlastEffect( isstring( data.BlastEffect ) and data.BlastEffect or "simfphys_tankweapon_explosion" )
	projectile:SetSize( data.Size and data.Size or 1 )
	projectile.Filter = table.Copy( data.filter )
	projectile:Spawn()
	projectile:Activate()
end

function simfphys.FireBullet( data )
	if not data then return end
	if not istable( data.filter ) then return end
	if not isvector( data.shootOrigin ) then return end
	if not isvector( data.shootDirection ) then return end
	if not IsValid( data.attacker ) then return end
	if not IsValid( data.attackingent ) then return end

	local bullet = {}
	bullet.Num 			= 1
	bullet.Src 			= data.shootOrigin
	bullet.Dir 			= data.shootDirection
	bullet.Spread 		= data.Spread
	bullet.TracerName	= "lvs_tracer_white"
	bullet.Force		= (data.Force and data.Force or 1)
	bullet.Damage		= (data.Damage and data.Damage or 1)
	bullet.HullSize		= data.HullSize or 1
	bullet.Attacker 		= data.attacker
	bullet.Entity = data.attackingent
	bullet.Velocity = 30000
	bullet.SrcEntity = data.attackingent:WorldToLocal( data.shootOrigin )
	bullet.Callback = function(att, tr, dmginfo)
		dmginfo:SetDamageType( DMG_BULLET )
	end

	LVS:FireBullet( bullet )
end

function simfphys.xhairRegister( ent, data )
	if not IsValid( ent ) then return end
	
	local data = istable( data ) and data or {}
	
	local Base = data.Attachment or "muzzle"
	local Dir = data.Direction or Vector(1,0,0)
	local Type = data.Type and data.Type or 0
	
	ent:SetNWInt( "CrosshairType", Type )
	ent:SetNWBool( "HasCrosshair", true )
	ent:SetNWString( "Attachment", Base )
	ent:SetNWVector( "Direction", Dir )
	
	if data.Attach_Start_Left and data.Attach_Start_Right then
		ent:SetNWBool( "CalcCenterPos", true )
		ent:SetNWString( "Start_Left", data.Attach_Start_Left )
		ent:SetNWString( "Start_Right", data.Attach_Start_Right )
	end
end

function simfphys.WeaponSystemRegister( vehicle )
	if not IsValid( vehicle ) then return end
	
	simfphys.Weapons = istable( simfphys.Weapons ) and table.Empty( simfphys.Weapons ) or {}
	
	for k,v in pairs( file.Find("simfphys_weapons/*.lua", "LUA") ) do
		local name = string.Explode( ".", v )[1]
		
		table.Empty( simfphys.weapon )
		
		include("simfphys_weapons/"..v)
		
		simfphys.Weapons[ name ] = table.Copy( simfphys.weapon )
	end
	
	local class = vehicle:GetSpawn_List()

	for wpnname,tbldata in pairs( simfphys.Weapons ) do
		for _,v in pairs( tbldata.ValidClasses() ) do
			if class == v then
				local data = {}
				data.entity = vehicle
				data.func = tbldata

				table.insert(simfphys.ManagedVehicles, data)

				tbldata.Initialize( tbldata, vehicle )

				timer.Simple(0.3, function()
					if not IsValid( vehicle ) then return end

					if vehicle:GetAITEAM() == 0 then
						vehicle:SetAITEAM( 3 )
					end
				end)
			end
		end
	end
end

local DMG_PROPEXPLOSION = 134217792 -- should use CTakeDamageInfo:IsDamageType( number dmgType ) at some point
local DMG_LUABULLET = 8194

local DMGTypeException = {
	[DMG_LUABULLET] = true,
	[DMG_BULLET] = true,
}

local IsValidDMGType = {
	[DMG_PROPEXPLOSION] = true,
	[DMG_BLAST] = true,
	[DMG_BLAST_SURFACE] = true,
	[DMG_ENERGYBEAM] = true,
	[DMG_SHOCK] = true,
	[DMG_CRUSH] = true,
	[DMG_GENERIC] = true,
	[DMG_DIRECT] = true,
	[DMG_SLOWBURN] = true,
	[DMG_BURN] = true,
	[DMG_NEVERGIB] = true,
	[DMG_ALWAYSGIB] = true,
	[DMG_SNIPER] = true,
	[DMG_CLUB] = true,
	[DMG_MISSILEDEFENSE] = true,
}

function simfphys.TankApplyDamage(ent, Damage, Type)
	if not IsValid( ent ) or not isnumber( Damage ) or not isnumber( Type ) then return end
	
	if Type == DMG_PROPEXPLOSION then Damage = Damage * 10 end
	
	if IsValidDMGType[ Type ] or (DMGTypeException[ Type ] and Damage > 100) then
		if DMGTypeException[ Type ] then
			Damage = Damage - 100
		end

		local MaxHealth = ent:GetMaxHealth()
		local CurHealth = ent:GetCurHealth()
		
		local NewHealth = math.max( math.Round(CurHealth - Damage,0) , 0 )
		
		if NewHealth <= (MaxHealth * 0.6) then
			if NewHealth <= (MaxHealth * 0.3) then
				ent:SetOnFire( true )
				ent:SetOnSmoke( false )
			else
				ent:SetOnSmoke( true )
			end
		end
		
		if MaxHealth > 30 and NewHealth <= 31 then
			if ent:EngineActive() then
				ent:DamagedStall()
			end
		end
		
		if NewHealth <= 0 then
			if (Type ~= DMG_GENERIC and Type ~= DMG_CRUSH) or Damage > MaxHealth then
				
				ent:ExplodeVehicle()
				
				return
			end
			
			if ent:EngineActive() then
				ent:DamagedStall()
			end
			
			ent:SetCurHealth( 0 )
			
			return
		end
		
		ent:SetCurHealth( NewHealth )
	end
end

hook.Add("Think", "simfphys_weaponhandler", function()
	if simfphys.ManagedVehicles then
		for k, v in pairs( simfphys.ManagedVehicles ) do
			if IsValid( v.entity ) then
				if v.func then
					v.func.Think( v.func,v.entity )
				end
			else
				simfphys.ManagedVehicles[k] = nil
			end
		end
	end
end)
