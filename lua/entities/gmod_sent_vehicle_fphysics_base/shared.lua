--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Base = "lvs_base"

ENT.PrintName = "Comedy Effect"
ENT.Author = "Blu"
ENT.Information = ""
ENT.Category = "Fun + Games"

ENT.Spawnable       = false
ENT.AdminSpawnable  = false

ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_BOTH 

ENT.Editable = true

-- this needs to be here for some addons
ENT.IsSimfphyscar = true

ENT.LVSsimfphys = true

ENT.MaxHealth = -1

ENT.MouseSteerAngle = 20
ENT.MouseSteerExponent = 2

ENT.lvsDisableZoom = false

ENT.DoNotDuplicate = true

function ENT:SetupDataTables()

	self:AddDT( "Int", "AITEAM", { KeyName = "aiteam", Edit = { type = "Int", order = 0,min = 0, max = 3, category = "AI"} } )

	self:AddDT( "Float", "SteerSpeed",				{ KeyName = "steerspeed",			Edit = { type = "Float",		order = 1,min = 1, max = 16,		category = "Steering"} } )
	self:AddDT( "Float", "FastSteerConeFadeSpeed",	{ KeyName = "faststeerconefadespeed",	Edit = { type = "Float",		order = 2,min = 1, max = 5000,		category = "Steering"} } )
	self:AddDT( "Float", "FastSteerAngle",			{ KeyName = "faststeerangle",			Edit = { type = "Float",		order = 3,min = 0, max = 1,		category = "Steering"} } )
	
	self:AddDT( "Float", "FrontSuspensionHeight",		{ KeyName = "frontsuspensionheight",	Edit = { type = "Float",		order = 4,min = -1, max = 1,		category = "Suspension" } } )
	self:AddDT( "Float", "RearSuspensionHeight",		{ KeyName = "rearsuspensionheight",		Edit = { type = "Float",		order = 5,min = -1, max = 1,		category = "Suspension" } } )
	
	self:AddDT( "Int", "EngineSoundPreset",			{ KeyName = "enginesoundpreset",		Edit = { type = "Int",			order = 6,min = -1, max = 23,		category = "Engine"} } )
	self:AddDT( "Int", "IdleRPM", 					{ KeyName = "idlerpm",				Edit = { type = "Int",			order = 7,min = 1, max = 25000,	category = "Engine"} } )
	self:AddDT( "Int", "LimitRPM", 					{ KeyName = "limitrpm",				Edit = { type = "Int",			order = 8,min = 4, max = 25000,	category = "Engine"} } )
	self:AddDT( "Int", "PowerBandStart", 			{ KeyName = "powerbandstart",			Edit = { type = "Int",			order = 9,min = 2, max = 25000,	category = "Engine"} } )
	self:AddDT( "Int", "PowerBandEnd", 				{ KeyName = "powerbandend",			Edit = { type = "Int",			order = 10,min = 3, max = 25000,	category = "Engine"} } )
	self:AddDT( "Float", "MaxTorque",				{ KeyName = "maxtorque",			Edit = { type = "Float",		order = 11,min = 20, max = 1000,	category = "Engine"} } )
	self:AddDT( "Bool", "Revlimiter",				{ KeyName = "revlimiter",				Edit = { type = "Boolean",		order = 12,					category = "Engine"} } )
	self:AddDT( "Bool", "TurboCharged",				{ KeyName = "turbocharged",			Edit = { type = "Boolean",		order = 13,					category = "Engine"} } )
	self:AddDT( "Bool", "SuperCharged",				{ KeyName = "supercharged",			Edit = { type = "Boolean",		order = 14,					category = "Engine"} } )
	self:AddDT( "Bool", "BackFire",				{ KeyName = "backfire",				Edit = { type = "Boolean",		order = 15,					category = "Engine"} } )
	self:AddDT( "Bool", "DoNotStall",				{ KeyName = "donotstall",				Edit = { type = "Boolean",		order = 16,					category = "Engine"} } )
	
	self:AddDT( "Float", "DifferentialGear",			{ KeyName = "differentialgear",			Edit = { type = "Float",		order = 17,min = 0.2, max = 6,		category = "Transmission"} } )
	
	self:AddDT( "Float", "BrakePower",				{ KeyName = "brakepower",			Edit = { type = "Float",		order = 18,min = 0.1, max = 500,	category = "Wheels"} } )
	self:AddDT( "Float", "PowerDistribution",			{ KeyName = "powerdistribution",		Edit = { type = "Float",		order = 19,min = -1, max = 1,		category = "Wheels"} } )
	self:AddDT( "Float", "Efficiency",				{ KeyName = "efficiency",				Edit = { type = "Float",		order = 20,min = 0.2, max = 4,		category = "Wheels"} } )
	self:AddDT( "Float", "MaxTraction",				{ KeyName = "maxtraction",			Edit = { type = "Float",		order = 21,min = 5, max = 1000,	category = "Wheels"} } )
	self:AddDT( "Float", "TractionBias",				{ KeyName = "tractionbias",			Edit = { type = "Float",		order = 22,min = -0.99, max = 0.99,	category = "Wheels"} } )
	self:AddDT( "Bool", "BulletProofTires",			{ KeyName = "bulletprooftires",			Edit = { type = "Boolean",		order = 23,					category = "Wheels"} } )
	self:AddDT( "Vector", "TireSmokeColor",			{ KeyName = "tiresmokecolor",			Edit = { type = "VectorColor",	order = 24,					category = "Wheels"} } )
	
	self:AddDT( "Float", "FlyWheelRPM" )
	self:AddDT( "Float", "Throttle" )
	self:AddDT( "Float", "WheelVelocity" )
	self:AddDT( "Int", "Gear" )
	self:AddDT( "Int", "Clutch" )
	self:AddDT( "Bool", "IsCruiseModeOn" )
	self:AddDT( "Bool", "IsBraking" )
	self:AddDT( "Bool", "LightsEnabled" )
	self:AddDT( "Bool", "LampsEnabled" )
	self:AddDT( "Bool", "EMSEnabled" )
	self:AddDT( "Bool", "FogLightsEnabled" )
	self:AddDT( "Bool", "HandBrakeEnabled" )

	self:AddDT( "Bool", "lvsLockedStatus" )
	self:AddDT( "Bool", "lvsReady" )

	self:AddDT( "Float", "VehicleSteer" )

	self:AddDT( "Float", "CurHealth" )

	self:AddDT( "Entity", "Driver" )
	self:AddDT( "Entity", "DriverSeat" )
	self:AddDT( "Entity", "FuelTank" )
	self:AddDT( "Bool", "Active" )

	self:AddDT( "String", "Spawn_List")
	self:AddDT( "String", "Lights_List")
	self:AddDT( "String", "Soundoverride")
	
	self:AddDT( "Vector", "FuelPortPosition" )

	if SERVER then
		self:SetCurHealth( 1 )

		self:NetworkVarNotify( "FrontSuspensionHeight", self.OnFrontSuspensionHeightChanged )
		self:NetworkVarNotify( "RearSuspensionHeight", self.OnRearSuspensionHeightChanged )
		self:NetworkVarNotify( "TurboCharged", self.OnTurboCharged )
		self:NetworkVarNotify( "SuperCharged", self.OnSuperCharged )
		self:NetworkVarNotify( "Active", self.OnActiveChanged )
		self:NetworkVarNotify( "Throttle", self.OnThrottleChanged )
		self:NetworkVarNotify( "CurHealth", self.OnHealthChanged )
	end
	
	self:AddDataTables()
end

function ENT:AddDataTables()
end

local VehicleMeta = FindMetaTable("Entity")
local OldIsVehicle = VehicleMeta.IsVehicle
function VehicleMeta:IsVehicle()

	if self.LVSsimfphys then
		return true
	end

	return OldIsVehicle( self )
end

function ENT:GetSelectedWeapon()
	return 0
end

function ENT:GetAI()
	return false
end

function ENT:SetHP( nHealth )
	self:SetCurHealth( nHealth )
end

function ENT:GetShield()
	return 0
end

function ENT:SetShield()
end

function ENT:GetHP()
	return self:GetCurHealth()
end

function ENT:GetMaxHP()
	return self:GetMaxHealth()
end

function ENT:GetMaxHealth()
	return self:GetNWFloat( "MaxHealth", 2000 )
end

function ENT:GetMaxFuel()
	return self:GetNWFloat( "MaxFuel", 60 )
end

function ENT:GetFuel()
	return self:GetNWFloat( "Fuel", self:GetMaxFuel() )
end

function ENT:GetFuelUse()
	return self:GetNWFloat( "FuelUse", 0 )
end

function ENT:GetFuelType()
	return self:GetNWInt( "FuelType", 1 )
end

function ENT:GetFuelPos()
	return self:LocalToWorld( self:GetFuelPortPosition() )
end

function ENT:OnSmoke()
	return self:GetNWBool( "OnSmoke", false )
end

function ENT:OnFire()
	return self:GetNWBool( "OnFire", false )
end

function ENT:GetIsVehicleLocked()
	return self:GetlvsLockedStatus()
end

function ENT:SetIsVehicleLocked( lock )
	self:SetlvsLockedStatus( lock )
end

function ENT:GetBackfireSound()
	return self:GetNWString( "backfiresound" )
end

function ENT:SetBackfireSound( the_sound )
	self:SetNWString( "backfiresound", the_sound ) 
end

function ENT:BodyGroupIsValid( bodygroups )
	for index, groups in pairs( bodygroups ) do
		local mygroup = self:GetBodygroup( index )
		for g_index = 1, table.Count( groups ) do
			if mygroup == groups[g_index] then return true end
		end
	end
	return false
end

function ENT:GetVehicleClass()
	return self:GetSpawn_List()
end

function ENT:CalcMainActivityPassenger( ply )
	if not istable( self.PassengerSeats ) then

		if not self.HasCheckedpSeats then
			self.HasCheckedpSeats = true

			self.PassengerSeats = list.Get( "simfphys_vehicles" )[ self:GetSpawn_List() ].Members.PassengerSeats
		end

		return
	end

	local Pod = ply:GetVehicle()

	local pSeatTBL = self.PassengerSeats[ Pod:GetNWInt( "pPodIndex", -1 ) - 1 ]

	if not istable( pSeatTBL ) then return end

	local seq = pSeatTBL.anim

	if not isstring( seq ) then return end

	if ply.m_bWasNoclipping then 
		ply.m_bWasNoclipping = nil 
		ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM ) 
		
		if CLIENT then 
			ply:SetIK( true )
		end 
	end 

	ply.CalcIdeal = ACT_STAND
	ply.CalcSeqOverride = ply:LookupSequence( seq )

	return ply.CalcIdeal, ply.CalcSeqOverride
end

function ENT:CalcMainActivity( ply )
	if ply ~= self:GetDriver() then return self:CalcMainActivityPassenger( ply ) end

	if ply.m_bWasNoclipping then 
		ply.m_bWasNoclipping = nil 
		ply:AnimResetGestureSlot( GESTURE_SLOT_CUSTOM ) 
		
		if CLIENT then 
			ply:SetIK( true )
		end 
	end 

	ply.CalcIdeal = ACT_STAND

	if isstring( self.SeatAnim ) then
		ply.CalcSeqOverride = ply:LookupSequence( self.SeatAnim )
	else
		if not self.HasCheckedSeat then
			self.HasCheckedSeat = true

			self.SeatAnim = list.Get( "simfphys_vehicles" )[ self:GetSpawn_List() ].Members.SeatAnim
		end

		ply.CalcSeqOverride = ply:LookupSequence( "drive_jeep" )
	end

	return ply.CalcIdeal, ply.CalcSeqOverride
end

function ENT:UpdateAnimation( ply, velocity, maxseqgroundspeed )
	ply:SetPlaybackRate( 1 )

	if CLIENT then
		if ply == self:GetDriver() then
			ply:SetPoseParameter( "vehicle_steer", self:GetVehicleSteer() )
			ply:InvalidateBoneCache()
		end

		GAMEMODE:GrabEarAnimation( ply )
		GAMEMODE:MouthMoveAnimation( ply )
	end

	return false
end

function ENT:StartCommand( ply, cmd )
	if self:GetDriver() ~= ply then return end

	if SERVER then
		self:SetRoadkillAttacker( ply )
	end
end

function ENT:GetVehicleType()
	return "car"
end
