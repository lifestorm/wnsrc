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

local IsValid = IsValid
local ix = ix
local math = math

util.AddNetworkString("ixHealingData")

ix.log.AddType("medicalBleedoutKO", function(client)
	return string.format("%s was knocked unconscious and is bleeding out.", client:GetName())
end, FLAG_DANGER)
ix.log.AddType("medicalBleedoutKilled", function(client)
	return string.format("%s was killed while bleeding out.", client:GetName())
end, FLAG_DANGER)
ix.log.AddType("medicalBleedoutStop", function(client)
	return string.format("%s is no longer unconscious from critical wounds.", client:GetName())
end)
ix.log.AddType("medicalBleedout", function(client)
	return string.format("%s bled out.", client:GetName())
end, FLAG_DANGER)
ix.log.AddType("medicalFullyHealed", function(client)
	return string.format("%s is fully healed.", client:GetName())
end)
ix.log.AddType("medicalPainkillersNoHP", function(client)
	return string.format("%s ran out of health.", client:GetName())
end, FLAG_DANGER)
ix.log.AddType("medicalPainkillersTooMany", function(client)
	return string.format("%s took too many painkillers.", client:GetName())
end, FLAG_DANGER)
ix.log.AddType("medicalBleedoutStoppedBy", function(client, givenBy)
	return string.format("%s's bleeding was stopped by %s.", client:Name(), givenBy:GetPlayer():Name())
end)
ix.log.AddType("medicalBandagedBy", function(client, givenBy, amount)
	return string.format("%s was bandaged by %s for %d HP.", client:Name(), givenBy:GetPlayer():Name(), amount)
end)
ix.log.AddType("medicalDisinfectedBy", function(client, givenBy, amount)
	if (amount) then
		return string.format("%s was disinfected by %s for %d seconds.", client:Name(), givenBy:GetPlayer():Name(), amount)
	else
		return string.format("%s tried to disinfect %s but the wound was already clean.", givenBy:GetPlayer():Name(), client:Name())
	end
end)

function PLUGIN:MedicalPlayerTick(client, ticks)
	local character = client:GetCharacter()
	if (!character) then return end

	if (!client:Alive()) then
		return
	end

	local health = client:Health()
	local maxHealth = client:GetMaxHealth()
	local bMaxHealth = health >= maxHealth

	if (!bMaxHealth or character:GetHealing("fakeHealth") > 0) then
		local factor = 1
		if (character:GetHealing("disinfectant") > 0) then
			factor = ix.config.Get("HealingRegenBoostFactor") * 5
		end
		local passiveHealAmount = ticks * factor * maxHealth / (ix.config.Get("HealthRegenTime") * 3600)
		if character:GetConterminous() then
			passiveHealAmount = passiveHealAmount * ix.config.Get("ConterminusHealingIncrease", 1)
		end
		character:SetHealing("passive", passiveHealAmount)
	end

	if (IsValid(client.ixRagdoll) and client:Alive() and client.ixRagdoll.bleedoutGetup and
		(health * 100 / maxHealth) >= ix.config.Get("WakeupTreshold")) then
		client:SetRagdolled(false)
		netstream.Start("BleedoutScreen", false)
		ix.log.Add(client, "medicalBleedoutStop")

		client:RemoveFlags(FL_NOTARGET)
	end

	-- Do bleedout stuff
	local bleedout = character:GetBleedout()
	if (bleedout > 0) then
		bleedout = bleedout - ticks
		if (bleedout <= 0) then
			if (IsValid(client.ixRagdoll)) then
				client.ixRagdoll.ixNoReset = true
			end

			character:SetBleedout(-1)
			client:SetNetVar("deathTime", nil)
			client:Kill()
			ix.log.Add(client, "medicalBleedout")
			return
		else
			self:BleedoutPainSound(client)
			character:SetBleedout(bleedout)
		end
	end

	local healingData = character:GetHealing()
	if (!healingData) then
		return
	end

	-- Apply healing from bandages
	if (healingData.bandage > 0) then
		local healingAmount = ticks * ix.config.Get("HealingRegenRate") / 60
		if (healingData.disinfectant > 0) then -- Boost if disinfected
			healingAmount = healingAmount * ix.config.Get("HealingRegenBoostFactor")
			healingData.disinfectant = math.max(healingData.disinfectant - ticks, 0)
		end

		-- Give healRate or whatever is left
		if (healingData.bandage > healingAmount) then
			healingData.healingAmount = math.Round(healingData.healingAmount + healingAmount, self.HEALING_PRECISION)
			healingData.bandage = math.Round(healingData.bandage - healingAmount, self.HEALING_PRECISION)
		else
			healingData.healingAmount = math.Round(healingData.healingAmount + healingData.bandage, self.HEALING_PRECISION)
			healingData.bandage = 0
		end
	elseif (healingData.disinfectant and healingData.disinfectant > 0) then
		healingData.disinfectant = math.max(healingData.disinfectant - ticks * 2, 0)
	end

	-- Apply fake healing from painkillers
	if (healingData.painkillers > 0) then
		local fakeAmount = ticks * ix.config.Get("HealingPainkillerRate") / 60

		if (healingData.painkillers > fakeAmount) then
			if (!bMaxHealth) then -- Only actually kill pain if not at max health
				healingData.fakeHealth = math.Round(healingData.fakeHealth + fakeAmount, self.HEALING_PRECISION)
				healingData.healingAmount = math.Round(healingData.healingAmount + fakeAmount, self.HEALING_PRECISION)
			end
			healingData.painkillers = math.Round(healingData.painkillers - fakeAmount, self.HEALING_PRECISION)
		else
			if (!bMaxHealth) then -- Only actually kill pain if not at max health
				healingData.healingAmount = math.Round(healingData.healingAmount + healingData.painkillers, self.HEALING_PRECISION)
				healingData.fakeHealth = math.Round(healingData.fakeHealth + healingData.painkillers, self.HEALING_PRECISION)
			end
			healingData.painkillers = 0
		end
	end

	-- Check if painkillers are still working
	if (healingData.painkillersDuration > 0) then
		-- Reduce duration
		healingData.painkillersDuration = math.max(healingData.painkillersDuration - ticks, 0)
	end

	-- At max health?
	if (bMaxHealth) then
		-- Check if there is any fake health we can heal
		if (healingData.fakeHealth > 0 and healingData.healingAmount > 0) then
			if (healingData.fakeHealth > healingData.healingAmount) then
				healingData.fakeHealth = healingData.fakeHealth - healingData.healingAmount
				healingData.healingAmount = 0
			else
				healingData.healingAmount = healingData.healingAmount - healingData.fakeHealth
				healingData.fakeHealth = 0
			end
		end

		-- At max health and no full health point of fake healing left
		if (healingData.fakeHealth - healingData.healingAmount < 1) then
			character:SetHealing("table", nil) -- Stop healing!
			ix.log.Add(client, "medicalFullyHealed")
			return
		end
	end

	-- Uh oh, the painkillers ran out... time to bring back the pain
	if (healingData.painkillersDuration == 0 and healingData.fakeHealth > 0) then
		local fakeAmount = ticks * ix.config.Get("HealingPainkillerDecayRate") / 60
		if (healingData.fakeHealth > fakeAmount) then
			healingData.healingAmount = math.Round(healingData.healingAmount - fakeAmount, self.HEALING_PRECISION)
			healingData.fakeHealth = math.Round(healingData.fakeHealth - fakeAmount, self.HEALING_PRECISION)
		else
			healingData.healingAmount = math.Round(healingData.healingAmount - healingData.fakeHealth, self.HEALING_PRECISION)
			healingData.fakeHealth = 0
		end
	end

	-- Check if we can heal/damage for at least one point of HP
	if ((!bMaxHealth and healingData.healingAmount >= 1) or healingData.healingAmount <= -1) then
		if (healingData.healingAmount >= 1 or healingData.healingAmount <= -1) then
			-- Source engine can only handle integer values for HP so...
			-- Heal as many integer points of HP as we can and save the fraction left for the future
			local totalHealing = math.min(math.Truncate(healingData.healingAmount), maxHealth - health)
			healingData.healingAmount = healingData.healingAmount - totalHealing
			client:SetHealth(math.min(health + totalHealing, maxHealth))

			if (client:Health() <= 0) then
				client:Kill()
				ix.log.Add(client, "medicalPainkillersNoHP")
				character:SetHealing("table", nil)
				return
			end
		end
	end

	if (healingData.fakeHealth - client:Health() > maxHealth * 1.1) then
		client:Kill()
		ix.log.Add(client, "medicalPainkillersTooMany")
		character:SetHealing("table", nil)
		return
	end

	character:SetHealing("table", healingData)
end

function PLUGIN.OnSetHealing(character, healType, value, givenBy)
	if (!healType) then
		ErrorNoHalt("Attempted to set healing but no type was provided!")
		return
	end

	if (healType == "table") then
		character.vars.healing = value

		net.Start("ixHealingData")
			net.WriteUInt(character:GetID(), 32)
			if (character.vars.healing) then
				net.WriteUInt(0, 2)
				net.WriteUInt(value.bandage, 16)
				net.WriteUInt(value.disinfectant, 16)
				net.WriteUInt(value.painkillers, 16)
				net.WriteUInt(value.painkillersDuration, 16)
				net.WriteFloat(value.healingAmount)
				net.WriteFloat(value.fakeHealth)
			end
		net.Broadcast()
	else
		if (!value or value <= 0) then
			ErrorNoHalt("Attempted to give '"..healType.."' healing with invalid value ("..(value or "nil")..")!")
			return
		end

		local healingData = character:GetHealing()
		if (!healingData or !healingData.bandage) then
			healingData = {
				bandage = 0,
				disinfectant = 0,
				painkillers = 0,
				painkillersDuration = 0,
				healingAmount = 0,
				fakeHealth = 0
			}
		end

		if (healType == "bandage") then
			value = value * (givenBy and (1 + givenBy:GetSkillScale("bandage_skill")) or 1)
			healingData.bandage = healingData.bandage + value
			net.Start("ixHealingData")
				net.WriteUInt(character:GetID(), 32)
				net.WriteUInt(1, 2)
				net.WriteUInt(healingData.bandage, 16)
			net.Broadcast()

			if (character:GetBleedout() > 0) then
				character:SetBleedout(-1)

				ix.log.Add(character:GetPlayer(), "medicalBleedoutStoppedBy", givenBy)
			end

			if (givenBy) then
				ix.log.Add(character:GetPlayer(), "medicalBandagedBy", givenBy, value)
			end
		elseif (healType == "bandage_damage") then
				healingData.bandage = math.max(healingData.bandage - value, 0)
				healingData.painkillers = 0
				net.Start("ixHealingData")
					net.WriteUInt(character:GetID(), 32)
					net.WriteUInt(1, 2)
					net.WriteUInt(healingData.bandage, 16)
				net.Broadcast()
				net.Start("ixHealingData")
					net.WriteUInt(character:GetID(), 32)
					net.WriteUInt(3, 2)
					net.WriteUInt(healingData.painkillers, 16)
				net.Broadcast()
		elseif (healType == "disinfectant") then
			value = value * (1 + givenBy:GetSkillScale("disinfectant_skill")) * 60 /
				(ix.config.Get("HealingRegenRate") * ix.config.Get("HealingRegenBoostFactor"))
			healingData.disinfectant = math.max(healingData.disinfectant, value)
			net.Start("ixHealingData")
				net.WriteUInt(character:GetID(), 32)
				net.WriteUInt(2, 2)
				net.WriteUInt(healingData.disinfectant, 16)
			net.Broadcast()

			if (givenBy) then
				ix.log.Add(character:GetPlayer(), "medicalDisinfectedBy", givenBy, healingData.disinfectant == value and value)
			end
		elseif (healType == "painkillers") then
			healingData.painkillers = healingData.painkillers + value
			healingData.painkillersDuration = ix.config.Get("HealingPainkillerDuration") * 60
			net.Start("ixHealingData")
				net.WriteUInt(character:GetID(), 32)
				net.WriteUInt(3, 2)
				net.WriteUInt(healingData.painkillers, 16)
			net.Broadcast()
		elseif (healType == "passive") then
			healingData.healingAmount = math.Round(healingData.healingAmount + value, PLUGIN.HEALING_PRECISION)
		end
		character.vars.healing = healingData
	end
end

local painSounds = {
	Sound("vo/npc/male01/pain01.wav"),
	Sound("vo/npc/male01/pain02.wav"),
	Sound("vo/npc/male01/pain03.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/male01/pain05.wav"),
	Sound("vo/npc/male01/pain06.wav")
}

function PLUGIN:BleedoutPainSound(client)
	if ((client.ixNextPain or 0) < CurTime() and math.random() < 0.1) then
		local painSound = hook.Run("GetPlayerPainSound", client) or painSounds[math.random(1, #painSounds)]

		if (client:IsFemale() and !painSound:find("female")) then
			painSound = painSound:gsub("male", "female")
		end

		client:EmitSound(painSound)
		client.ixNextPain = CurTime() + 5
	end
end


netstream.Hook("ixConfirmRespawn", function(client)
	client.confirmRespawn = true
end)

netstream.Hook("ixAcceptDeath", function(client)
	if (IsValid(client.ixRagdoll)) then
		client.ixRagdoll.ixNoReset = true
	end

	if (!client:GetCharacter()) then return end

	client:GetCharacter():SetBleedout(-1)
	client:SetNetVar("deathTime", nil)
	client:Kill()

	ix.log.Add(client, "qolDeathLog", "accepting their death")
end)
