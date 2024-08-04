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
local ix = ix
local math = math

function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
	local uniqueID = "ixNeeds" .. client:SteamID64()

	if (timer.Exists(uniqueID)) then
		timer.Remove(uniqueID)
	end

	timer.Create(uniqueID, ix.config.Get("needsTickTime", 300), 0, function()
		if (!IsValid(client)) then
			return
		end

		if (!client:Alive()) then return end

		if (hook.Run("ShouldCalculatePlayerNeeds", client, character) == false) then
			return
		end

		local scale = 1
		local count = math.max(character:GetInventory():GetFilledSlotCount(), 0) / 30
		local vcsqr = client:GetVelocity():LengthSqr()
		local walkSpeed = ix.config.Get("walkSpeed")

		if ( client:KeyDown(IN_SPEED) and !client:InVehicle() and (vcsqr >= (walkSpeed * walkSpeed))) then
			scale = scale + count
		elseif (vcsqr > 0) then
			scale = scale + count * 0.3
		else
			scale = scale + count * 0.1
		end

		if (client:Health() < client:GetMaxHealth()) then
			scale = scale + math.Remap(client:Health() / client:GetMaxHealth(), 1, 0, 0, 0.4)
		end

		local tickTime = ix.config.Get("needsTickTime", 300)

		local hunger = math.Clamp(character:GetHunger() + 60 * scale * tickTime / (3600 * ix.config.Get("hungerHours", 6)), 0, 100)
		local thirst = math.Clamp(character:GetThirst() + 60 * scale * tickTime / (3600 * ix.config.Get("thirstHours", 4)), 0, 100)

		character:SetHunger(hunger)
		character:SetThirst(thirst)

		if (ix.config.Get("killOnMaxNeeds", false)) then
			local damage = 0
			if (hunger >= 100 and thirst >= 100) then
				damage = ix.config.Get("needsDeathDamage") * 1.5
			elseif (hunger >= 100 or thirst >= 100) then
				damage = ix.config.Get("needsDeathDamage")
			end

			if (damage > 0) then
				character.ixNeedsDamageScale = (character.ixNeedsDamageScale or 0.9) + 0.1
				damage = damage * character.ixNeedsDamageScale

				if (!character.ixNeedsWarningGiven) then
					character.ixNeedsWarningGiven = true
					client:Notify("You are slowly dying from starvation and/or dehydration! Make sure to eat and/or drink something!")
				end

				local newHP = client:Health() - damage
				if (newHP > 0) then
					client:SetHealth(newHP)
					return
				end

				local permakill = ix.config.Get("needsPermaKill")
				if (permakill) then
					character:SetHunger(0)
					character:SetThirst(0)
					character:SetData("needsPermaKill", true)
				else
					character:SetHunger(70)
					character:SetThirst(70)
				end

				character.ixNeedsWarningGiven = nil
				character.ixNeedsDamageScale = nil

				client:Kill()
				ix.log.Add(client, "qolDeathLog", "starvation/dehydration")
			else
				character.ixNeedsWarningGiven = nil
				character.ixNeedsDamageScale = nil
			end
		end
	end)
end

function PLUGIN:ShouldCalculatePlayerNeeds(client, character)
	if (character and client and
		((client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) or client:IsAFK())) then
		return false
	end
end

function PLUGIN:PlayerSpawn(client)
	local character = client:GetCharacter()
	if (!character) then return end
	if (ix.config.Get("needsPermaKill") and character:GetData("needsPermaKill")) then
        character:SetData("needsPermaKill", nil)
		character:Ban()
	else
		character:SetData("needsPermaKill", nil)
	end
end