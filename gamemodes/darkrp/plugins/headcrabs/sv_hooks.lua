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

local classAnim = {
	[CLASS_HEADCRAB] = "jumpattack_broadcast",
	[CLASS_FASTHEADCRAB] = "attack",
	[CLASS_POISONHEADCRAB] = "tele_attack_a"
}

function PLUGIN:KeyPress(client, key)
	if (client:Team() == FACTION_HEADCRAB) then
		if (key == IN_JUMP and client:IsOnGround() and client:Alive() and client:GetLocalVar("stm", 0) >= 30) then
			client:EmitSound("npc/headcrab/attack1.wav")
			client:SetVelocity(client:GetAimVector() * 300 + Vector(0, 0, 300))
			client:ConsumeStamina(30)
			client:ForceSequence(classAnim[client:GetCharacter():GetClass()], nil, nil, true)

			return true
		end
	end
end

function PLUGIN:PlayerStaminaGained(client)
	if (client:Team() == FACTION_HEADCRAB) then
		client:SetRunSpeed(70)
	end
end

function PLUGIN:GetFallDamage(client, speed)
	if (client:Team() == FACTION_HEADCRAB and client:GetCharacter():GetClass() == CLASS_FASTHEADCRAB) then
		return 0
	end
end

function PLUGIN:PlayerTick(client)
	if (!client:GetCharacter()) then return end

	if (client:Team() != FACTION_HEADCRAB and client:GetCharacter():GetClass() != CLASS_FASTHEADCRAB) then return end

	if (!client.nextChatter or (CurTime() >= client.nextChatter)) then
		client.nextChatter = CurTime() + math.random(60, 180)

		client:EmitSound("npc/headcrab/idle" .. math.random(1, 4) .. ".wav", 65)
	end
end

function PLUGIN:GetPlayerDeathSound(client)
	if (client:Team() == FACTION_HEADCRAB) then
		return "npc/headcrab/die" .. math.random(1, 2) .. ".wav"
	end
end

function PLUGIN:GetPlayerPainSound(client)
	if (client:Team() == FACTION_HEADCRAB) then
		return "npc/headcrab/pain" .. math.random(1, 3) .. ".wav"
	end
end
