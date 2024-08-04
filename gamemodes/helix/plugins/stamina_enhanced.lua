--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix

PLUGIN.name = "Stamina Enhanced"
PLUGIN.author = "Chessnut, Gr4Ss"
PLUGIN.description = "Adds a stamina system to limit running. Edited for WN."

ix.plugin.SetUnloaded("stamina", true)

-- luacheck: push ignore 631
ix.config.Add("staminaDrain", 1, "How much stamina to drain per tick (every quarter second). This is calculated before attribute reduction.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaRegeneration", 1.75, "How much stamina to regain per tick (every quarter second).", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("staminaCrouchRegeneration", 2, "How much stamina to regain per tick (every quarter second) while crouching.", nil, {
	data = {min = 0, max = 10, decimals = 2},
	category = "characters"
})

ix.config.Add("punchStamina", 10, "How much stamina punches use up.", nil, {
	data = {min = 0, max = 100},
	category = "characters"
})

-- luacheck: pop
local function CalcStaminaChange(client)
	local character = client:GetCharacter()

	if (!character or client:GetMoveType() == MOVETYPE_NOCLIP) then
		return 0
	end

	local walkSpeed = ix.config.Get("walkSpeed")
	local offset
	local isBird = client:Team() == FACTION_BIRD
	local isBabyBird = client:GetCharacter():GetData("babyBird", 0) > os.time()

	if ((client:KeyDown(IN_SPEED) and client:GetVelocity():LengthSqr() >= (walkSpeed * walkSpeed)) or (isBird and client:KeyDown(IN_JUMP))) then
		-- characters could have attribute values greater than max if the config was changed
		offset = isBabyBird and -5 or isBird and -2.5 or -ix.config.Get("staminaDrain", 1)
	else
		offset = client:Crouching() and ix.config.Get("staminaCrouchRegeneration", 2) or ix.config.Get("staminaRegeneration", 1.75)
	end
	--offset = hook.Run("AdjustStaminaOffset", client, offset) or offset

	if (CLIENT) then
		return offset -- for the client we need to return the estimated stamina change
	else
		local current = client:GetLocalVar("stm", 0)
		local maxStamina = character:GetMaxStamina() or 100

		local value = math.Clamp(current + (offset * 2), 0, maxStamina)

		if (current != value) then
			client:SetLocalVar("stm", value)

			if (value > (client.ixSkillStamina or 0)) then
				client.ixSkillStamina = value
			elseif (value <= (client.ixSkillStamina or 0) - 5) then
				if (ix.action) then
					character:DoAction("speed_sprint")
				end
				client.ixSkillStamina = value
			end

			if (value == 0 and !client:GetNetVar("brth", false)) then
				client:SetRunSpeed(walkSpeed)
				client:SetNetVar("brth", true)

				--hook.Run("PlayerStaminaLost", client)
			elseif (value >= (maxStamina >= 50 and 50 or maxStamina) and client:GetNetVar("brth", false)) then
				local runSpeed = ix.config.Get("runSpeed") + character:GetSkillScale("run_speed")

				if (client:WaterLevel() > 1) then
					runSpeed = runSpeed * 0.775
				end

				client:SetRunSpeed(runSpeed)
				client:SetNetVar("brth", nil)

				--hook.Run("PlayerStaminaGained", client)
			end
		end
	end
end

local CHAR = ix.meta.character

function CHAR:GetMaxStamina()
	local hunger, thirst, health, maxHealth = self:GetHunger(), self:GetThirst(), self:GetPlayer():Health(), self:GetPlayer():GetMaxHealth()
	local stamina = 100

	if (hunger > 50) then
		stamina = stamina * (1 - math.Remap(math.min(hunger, 100), 50, 100, 0, 0.4))
	end

	if (thirst > 50) then
		stamina = stamina * (1 - math.Remap(math.min(thirst, 100), 50, 100, 0, 0.4))
	end

	if (health < maxHealth / 2) then
		stamina = stamina * (1 + math.Remap(math.min(health, maxHealth), 50, 100, 0, 0.4))
	end

	return stamina
end

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
		local uniqueID = "ixStam" .. client:SteamID()

		timer.Create(uniqueID, 0.5, 0, function()
			if (!IsValid(client)) then
				timer.Remove(uniqueID)
				return
			end

			CalcStaminaChange(client)
		end)
	end

	function PLUGIN:CharacterPreSave(character)
		local client = character:GetPlayer()

		if (IsValid(client)) then
			character:SetData("stamina", client:GetLocalVar("stm", 0))
		end
	end

	function PLUGIN:PlayerLoadedCharacter(client, character)
		local maxStamina = character:GetMaxStamina() or 100
		timer.Simple(0.25, function()
			client:SetLocalVar("stm", character:GetData("stamina", maxStamina))
			client.ixSkillStamina = client:GetLocalVar("stm")
		end)
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:RestoreStamina(amount)
		local current = self:GetLocalVar("stm", 0)
		local maxStamina = self:GetCharacter() and self:GetCharacter():GetMaxStamina() or 100
		local value = math.Clamp(current + amount, 0, maxStamina)

		self:SetLocalVar("stm", value)
	end

	function playerMeta:ConsumeStamina(amount)
		local current = self:GetLocalVar("stm", 0)
		local maxStamina = self:GetCharacter() and self:GetCharacter():GetMaxStamina() or 100
		local value = math.Clamp(current - amount, 0, maxStamina)

		self:SetLocalVar("stm", value)
	end

else

	local predictedStamina = 100

	function PLUGIN:Think()
		local client = LocalPlayer()
		local maxStamina = client:GetCharacter() and client:GetCharacter():GetMaxStamina() or 100
		local offset = CalcStaminaChange(client)
		-- the server check it every 0.25 sec, here we check it every [FrameTime()] seconds
		offset = math.Remap(FrameTime(), 0, 0.25, 0, offset)

		if (offset != 0) then
			predictedStamina = math.Clamp(predictedStamina + offset, 0, maxStamina)
		end
	end

	function PLUGIN:OnLocalVarSet(key, var)
		if (key != "stm") then return end
		if (math.abs(predictedStamina - var) > 5) then
			predictedStamina = var
		end
	end

	ix.bar.Add(function()
		local client = LocalPlayer()
		local maxStamina = client:GetCharacter() and client:GetCharacter():GetMaxStamina() or 100
		return predictedStamina / maxStamina
	end, Color(200, 200, 40), nil, "stm")
end
