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
local RealTime = RealTime
local ix = ix
local timer = timer

PLUGIN.minHealthLeft = 2

--[[
function PLUGIN:CanPlayerHoldObject(client, entity)
	if (entity:GetClass() == "prop_ragdoll" and IsValid(entity.ixPlayer) and entity.bleedoutGetup) then
		return entity.ixPlayer:GetCharacter():GetBleedout() <= 0 or !ix.faction.Get(client:Team()).isDefault
	end
end
--]]

function PLUGIN:CanPlayerUseCharacter(client, character)
	if (IsValid(client.ixRagdoll) and client.ixRagdoll.bleedoutGetup == true) then
		return false, "@cannotChangeCharBleedout"
	end
end

function PLUGIN:CalculatePlayerDamage(victim, damage)
	-- Damage grace for people who just got downed
	if (victim.bleedoutDamageGrace and victim.bleedoutDamageGrace > RealTime()) then
		damage:SetDamage(0)
		return true
	end

	if (ix.config.Get("bleedoutGodmode") and victim:GetCharacter() and victim:GetCharacter():GetBleedout() != -1 and victim.ixRagdoll and victim.ixRagdoll.bleedoutGetup) then
		damage:SetDamage(0)
		return true
	end
end

function PLUGIN:PlayerHurt(client, attacker, healthRemaining, damageTaken)
	if (damageTaken <= 0) then return end
	if (IsValid(client.ixScn)) then return end
	if (IsValid(attacker) and attacker:GetClass() == "npc_headcrab_black") then return end

	local character = client:GetCharacter()
	if (!character) then return end

	local targetMaxBandage = client:GetMaxHealth() - client:Health() - damageTaken
	character:SetHealing("bandage_damage", math.max(damageTaken, character:GetHealing("bandage") - targetMaxBandage))
end

function PLUGIN:HandlePlayerDeath(client, damage)
	if (IsValid(client) and client:IsPlayer()) then
		local character = client:GetCharacter()
		if (!character) then
			return
		end


		hook.Run("PrePlayerBleedout", client)
		client:AddFlags(FL_NOTARGET)

		local fight = ix.fights and character:GetFight()
		if (fight) then
			character:SetFight()
		end

		if (character:GetBleedout() == -1) then
			local bleedoutTime = ix.config.Get("BleedoutTime") * 60

			client.bleedoutDamageGrace = RealTime() + 0.5 + ix.config.Get("AdditionalBleedoutGrace", 0)
			character:SetBleedout(bleedoutTime)
			netstream.Start(client, "BleedoutScreen", true)

			client:SetHealth(self.minHealthLeft)

			if (!IsValid(client.ixRagdoll)) then
				client:SetRagdolled(true, nil, bleedoutTime + 60)
			elseif (client.ixRagdoll.ixStart) then
				client.ixRagdoll.ixStart = nil
				client.ixRagdoll.ixFinish = nil
				timer.Remove("ixUnRagdoll" .. client:SteamID())
				client:SetAction()
			end

			if (client.ixRagdoll) then
				client.ixRagdoll.ixGrace = nil
				client.ixRagdoll.bleedoutGetup = true
			end

			if (client:HasActiveTracker()) then
				ix.combineNotify:AddImportantNotification("WRN:// Unit " .. client:GetCombineTag() .. " vital signs critical", nil, client, client:GetPos(), nil, client:GetCombineTag())
			end

			if ix.plugin.Get("vortigaunts") then
				if damage:GetAttacker():IsPlayer() and damage:GetAttacker():IsVortigaunt() then
					ix.plugin.Get("vortigaunts"):HandlePlayerKill(client, damage:GetAttacker())
				end
			end
			netstream.Start(client, "ixBleedoutScreen", bleedoutTime)

			ix.log.Add(client, "medicalBleedoutKO")
			return false
		else
			if (IsValid(client.ixRagdoll)) then
				client.ixRagdoll.ixNoReset = true
			end
			ix.log.Add(client, "medicalBleedoutKilled")
		end
	end
end

function PLUGIN:PrePlayerLoadedCharacter(client)
	client.ixLoadingChar = true
end

function PLUGIN:PlayerSpawn(client)
	if (client.ixLoadingChar == true) then
		client.ixLoadingChar = nil
		return
	end

	local character = client:GetCharacter()
	if (character) then
		character:SetBleedout(-1)
		netstream.Start(client, "BleedoutScreen", false)
	end
end

local errorFunc = function(msg)
	ErrorNoHaltWithStack("[MEDICAL]"..msg.."\n")
end

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	local uniqueID = "ixHealing" .. client:SteamID64()
	local ticks = self.TIMER_DELAY
	timer.Create(uniqueID, ticks, 0, function()
		if (IsValid(client)) then
			if (ix.fights and client:GetFight() and !client:GetFight().s2kActive) then
				return
			end
			xpcall(PLUGIN.MedicalPlayerTick, errorFunc, PLUGIN, client, ticks)
		else
			timer.Remove(uniqueID)
		end
	end)

	if (character:GetHealing() and table.IsEmpty(character:GetHealing())) then
		character:SetHealing("table", nil)
	end
end

function PLUGIN:FirefightTurnEnd(fight, fightInfo, character)
	if (!fightInfo.lastMedicalTick or fightInfo.lastMedicalTick < CurTime()) then
		self:MedicalPlayerTick(character:GetPlayer(), 5)
		fightInfo.lastMedicalTick = CurTime() + 5
	end
end

function PLUGIN:PlayerDeath(client, attacker, damageinfo)
	local character = client:GetCharacter()

	if (character) then
		character:SetHealing("table", nil)
		character:SetBleedout(-1)

		client.lastMeExpended = false

		netstream.Start(client, "BleedoutScreen", false)
		netstream.Start(client, "ixDeathScreen")
	end
end

function PLUGIN:PlayerDeathThink(client)
	if (client.confirmRespawn) then
		client.confirmRespawn = nil
		client:Spawn()
	else
		return false
	end
end

function PLUGIN:PlayerMessageSend(speaker, chatType)
	if (chatType == "me" or chatType == "mel" or chatType == "mec" and !speaker:Alive()) then
		speaker.lastMeExpended = true
	end
end
