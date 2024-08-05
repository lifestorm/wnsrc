--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

TFA.AddStatus( "NMRIH_MELEE_SWING" )
TFA.AddStatus( "NMRIH_MELEE_CHARGE_START" )
TFA.AddStatus( "NMRIH_MELEE_CHARGE_LOOP" )
TFA.AddStatus( "NMRIH_MELEE_CHARGE_END" )
TFA.AddStatus( "NMRIH_MELEE_MOTOR_START" )
TFA.AddStatus( "NMRIH_MELEE_MOTOR_LOOP" )
TFA.AddStatus( "NMRIH_MELEE_MOTOR_ATTACK" )
TFA.AddStatus( "NMRIH_MELEE_MOTOR_END" )

local function M_PRESS(plyv, key)
end

local swing_threshold = 0.3

hook.Add("KeyPress","TFANMRIH_M",M_PRESS)

local function M_RELEASE(plyv, key)
	wep = plyv:GetActiveWeapon()
	if not ( IsValid(wep) and wep.TFA_NMRIH_MELEE  ) then return end
	if wep:GetStatus() == TFA.Enum.STATUS_IDLE then
		if key == IN_ATTACK and CurTime() <= ( plyv.LastNMRIMSwing or CurTime() ) + swing_threshold then
			plyv.LastNMRIMSwing = nil
			plyv.HasTFANMRIMSwing = false
			plyv:GetActiveWeapon():PrimaryAttack( true, false )
		end
	elseif wep:GetStatus() == TFA.Enum.STATUS_NMRIH_MELEE_CHARGING then
		--wep:SwingHard()
	end
end

hook.Add("KeyRelease","TFANMRIH_M",M_RELEASE)

local function M_TIME(plyv)
	wep = plyv:GetActiveWeapon()
	if not ( IsValid(wep) and wep.TFA_NMRIH_MELEE and wep:GetStatus() == TFA.Enum.STATUS_IDLE ) then return end
	if plyv.HasTFANMRIMSwing then return end
	if plyv:KeyDown(IN_ATTACK) then
		if plyv.LastNMRIMSwing == nil then
			plyv.HasTFANMRIMSwing = false
			plyv.LastNMRIMSwing = CurTime()
		elseif CurTime() > ( plyv.LastNMRIMSwing or CurTime() ) + swing_threshold and IsValid(wep) and wep.IsTFAWeapon then
			plyv.HasTFANMRIMSwing = true
			plyv:GetActiveWeapon():PrimaryAttack( true, true )
			plyv.LastNMRIMSwing = CurTime()
		end
	end
end

hook.Add("PlayerTick","TFANMRIH_M",M_TIME)

local function M_SPAWN(plyv)
	plyv.LastNMRIMSwing = nil
	plyv.HasTFANMRIMSwing = false
end

hook.Add("PlayerSpawn","TFANMRIH_M",M_SPAWN)