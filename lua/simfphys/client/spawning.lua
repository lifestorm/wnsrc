--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local function TableMerge( ent, class )
	local vehiclelist = list.Get( "simfphys_vehicles" )[ class ]

	if not vehiclelist then return end

	local data = vehiclelist.Members

	if not data then return end

	ent.customview = data.FirstPersonViewPos or Vector(0,-9,5)

	ent.EnginePos = data.EnginePos

	ent.ExhaustPositions = data.ExhaustPositions

	ent.snd_idle = data.snd_idle
	ent.snd_low = data.snd_low
	ent.snd_mid = data.snd_mid
	ent.snd_low_revdown = data.snd_low_revdown
	ent.snd_mid_gearup = data.snd_mid_gearup
	ent.snd_mid_geardown = data.snd_mid_geardown

	ent.snd_low_pitch = data.snd_low_pitch
	ent.snd_mid_pitch = data.snd_mid_pitch
	ent.snd_pitch = data.snd_pitch

	ent.Sound_Idle = data.Sound_Idle
	ent.Sound_IdlePitch = data.Sound_IdlePitch

	ent.Sound_Mid = data.Sound_Mid
	ent.Sound_MidPitch = data.Sound_MidPitch
	ent.Sound_MidVolume = data.Sound_MidVolume
	ent.Sound_MidFadeOutRPMpercent = data.Sound_MidFadeOutRPMpercent
	ent.Sound_MidFadeOutRate = data.Sound_MidFadeOutRate

	ent.Sound_High = data.Sound_High
	ent.Sound_HighPitch = data.Sound_HighPitch
	ent.Sound_HighVolume = data.Sound_HighVolume
	ent.Sound_HighFadeInRPMpercent = data.Sound_HighFadeInRPMpercent
	ent.Sound_HighFadeInRate = data.Sound_HighFadeInRate

	ent.Sound_Throttle = data.Sound_Throttle
	ent.Sound_ThrottlePitch = data.Sound_ThrottlePitch
	ent.Sound_ThrottleVolume = data.Sound_ThrottleVolume 
end

local function Loop( ent, delay )
	delay = delay or 0

	if not IsValid( ent ) then return end

	timer.Simple( delay , function()
		if not IsValid( ent ) then return end

		if ent.GetSpawn_List then
			TableMerge( ent, ent:GetSpawn_List() )
		else
			Loop( ent, 0.1 )
		end
	end)
end

hook.Add( "OnEntityCreated", "!!!!lvs_just_in_time_table_merge", function( ent )
	if not IsValid( ent ) then return end

	if ent:GetClass() ~= "gmod_sent_vehicle_fphysics_base" then return end


	Loop( ent )
end )