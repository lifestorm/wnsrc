--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

game.AddParticles("particles/fire_01.pcf")
PrecacheParticleSystem("fire_jet_01_flame")

util.PrecacheSound("ambient/explosions/explode_8.wav")

function PLUGIN:PostPlayerLoadout(client)
    if (client:Team() == FACTION_CREMATOR and client:GetCharacter()) then
		client:SetWalkSpeed(50)
		client:SetRunSpeed(70)
		client:SetHealth(300)
		client:SetMaxHealth(300)

		client:StripWeapon("ix_keys")
		
		client:Give("immolator")
		client:SelectWeapon("immolator")

		client:SetNetVar("fuelTankHealth", 1)
		client:SetNetVar("fuelTankWasExploded", nil)
	end
end

function PLUGIN:GetPlayerPainSound(client)
	if (client:Team() == FACTION_CREMATOR) then
		return "npc/cremator/alert_object.wav"
	end
end

function PLUGIN:GetPlayerDeathSound(client)
	if (client:Team() == FACTION_CREMATOR) then
		return "npc/cremator/crem_die.wav"
	end
end

local walkSounds = {"npc/cremator/foot1.wav", "npc/cremator/foot2.wav", "npc/cremator/foot3.wav"}

function PLUGIN:PlayerFootstep(client, position, foot, soundName, volume)
	if (client:Team() == FACTION_CREMATOR) then
		client:EmitSound(walkSounds[math.random(1, #walkSounds)])

		return true
	end
end

local fuelTankBone = "Bip01 Spine2"

local radius = 200
local magnitude = 10

local fireTrailSeconds = 5

function PLUGIN:PlayerTraceAttack(client, damageInfo, vector, trace)
	if (client:Team() == FACTION_CREMATOR) then
		local fuelTankHealth = client:GetNetVar("fuelTankHealth", 0)

		local bone = trace.HitBoxBone
		
		if (client:GetBoneName(bone) == fuelTankBone) then
			if (client:GetNetVar("fuelTankWasExploded")) then return end

			if (fuelTankHealth > 0) then
				client:SetNetVar("fuelTankHealth", fuelTankHealth - damageInfo:GetDamage())

				return
			end

			local timerId = "ixCrematorTankExplodeTimer_" .. client:EntIndex()

			if (timer.Exists(timerId)) then return end

			local matrix = client:GetBoneMatrix(bone)
			local position = matrix:GetTranslation()
			local angles = matrix:GetAngles()

			local fireTrail = ents.Create( "info_particle_system" )
			fireTrail:SetKeyValue("effect_name", "fire_jet_01_flame")
			fireTrail:SetKeyValue("start_active", "1")
			fireTrail:SetPos(position)
			fireTrail:SetAngles(angles)
			fireTrail:SetParent(client)
			fireTrail:Spawn()
			fireTrail:Activate()
			fireTrail:Fire("Kill", nil, fireTrailSeconds)

			client:SetNetVar("fuelTankWasExploded", true)

			timer.Create(timerId, fireTrailSeconds, 1, function()
				if (!IsValid(client)) then return end

				local playerPosition = client:GetPos()

				local effect = EffectData()
				effect:SetStart(playerPosition)
				effect:SetOrigin(playerPosition)
				effect:SetScale(2)
				effect:SetRadius(radius)
				effect:SetMagnitude(magnitude)
		
				util.Effect("Explosion", effect, true, true)
				util.Effect("HelicopterMegaBomb", effect, true, true)

				local explode = ents.Create("info_particle_system")
				explode:SetKeyValue("effect_name", "hl2r_explosion_rpg")
				explode:SetOwner(client)
				explode:SetPos(playerPosition)
				explode:Spawn()
				explode:Activate()
				explode:Fire("start", "", 0)
				explode:Fire("kill", "", 30)

				local blastDamage = DamageInfo()
				blastDamage:SetInflictor(client)
				blastDamage:SetAttacker(client)
				blastDamage:SetDamage(80)
				blastDamage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

				util.BlastDamageInfo(blastDamage, playerPosition, radius)

				local explosion = ents.Create("env_physexplosion")
				explosion:SetPos(playerPosition)
				explosion:SetKeyValue("magnitude", magnitude)
				explosion:SetKeyValue("radius", radius)
				explosion:SetKeyValue("spawnflags", "19")
				explosion:Spawn()
				explosion:Fire("Explode", "", 0)

				client:ForceSequence("Flich01")
			end)
		end
	end
end
