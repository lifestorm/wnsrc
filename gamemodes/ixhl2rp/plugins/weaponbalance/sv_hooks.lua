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

function PLUGIN:GetHookCallPriority(hook)
	if (hook == "EntityTakeDamage") then
		return 0
	end
end

function PLUGIN:FirefightActionMove(client, character, fightInfo)
	local weapon = client:GetActiveWeapon()
	if (IsValid(weapon) and ix.weapons:IsMelee(weapon:GetClass())) then
		if (fightInfo.turn.actions == 1) then
			fightInfo.turn.weapon = weapon:GetClass()
			fightInfo.turn.attacksLeft = 1
		end
	end
end

function PLUGIN:FirefightTurnStart(fight, fightInfo, character)
	local client = character:GetPlayer()
	if (IsValid(client:GetActiveWeapon()) and ix.weapons:IsMelee(client:GetActiveWeapon():GetClass())) then
		fightInfo.turn.attacksLeft = 1
		fightInfo.turn.weapon = client:GetActiveWeapon():GetClass()
	end
end

function PLUGIN:ScaleNPCDamage(npc, hitgroup, damage)
	local attacker = damage:GetAttacker()
	if (!IsValid(attacker) or (!attacker:IsPlayer())) then
		return
    end

	local success, result, range, critChance, penalties, bonus = ix.weapons:BalanceDamage(npc, damage, attacker, hitgroup)

	if (success == false) then
		return
	end

	ix.weapons:QueueDamageMessage(attacker, {
		bCrit = result == "crit",
		target = npc,
		hitBox = PLUGIN.hitGroupName[hitgroup],
		range = math.Round(range),
		damage = damage:GetDamage(),
		calcCrit = critChance,
		penalties = penalties,
		bonus = bonus,
		messageType = ix.weapons.messageTypes.WEAPON_DAMAGE
	})
end

function PLUGIN:EntityTakeDamage(victim, damage)
	if (!IsValid(victim)) then return end

	-- Ensure we deal damage to the player if their ragdoll is hit
	local bIsRagdoll = false
	if (victim:GetClass() == "prop_ragdoll" and IsValid(victim.ixPlayer)) then
		if (IsValid(victim.ixHeldOwner)) then
			damage:SetDamage(0)
			return true
		end

		if (damage:IsDamageType(DMG_CRUSH)) then
			if ((victim.ixFallGrace or 0) < CurTime()) then
				if (damage:GetDamage() <= 10) then
					damage:SetDamage(0)
				end

				victim.ixFallGrace = CurTime() + 0.5
			else
				return
			end
		end

		bIsRagdoll = victim
		victim = victim.ixPlayer
	end
	-- Not attacking player
	if (!victim:IsPlayer()) then
		if (victim:IsNPC()) then return end -- gets handled by ScaleNPCDamage

		--local attacker = damage:GetAttacker()
		--if (!IsValid(attacker) or (!attacker:IsPlayer())) then
		--	return
		--end

		--return ix.weapons:BalanceDamage(victim, damage, attacker, 0)
		return --I dunno. All I know is that regular entities take damage again with the above commented out
	end
	if (!victim:Alive()) then return end

	-- Is attacking player
	local attacker = damage:GetAttacker()
	local hitgroup = !bIsRagdoll and victim:LastHitGroup() or self:CalculateRagdollHitGroup(victim, damage:GetDamagePosition())

	-- Do schema damage hook if it exists
	if (Schema.EntityTakeDamage and Schema:EntityTakeDamage(victim, damage)) then
		return true
	end
	-- Do GM & addon damage hooks
	if (hook.ixCall("EntityTakeDamage", Schema.GM, victim, damage)) then
		return true
	end

	-- Check if we are dealing invalid damage to a ragdoll
	if (bIsRagdoll and IsValid(attacker) and !attacker:IsPlayer() and (attacker:GetClass() == "prop_ragdoll" or attacker:IsDoor() or damage:GetDamage() < 5)) then
		damage:SetDamage(0)
		return true
	end

	-- Allow for schema damage overrides
	if (hook.Run("CalculatePlayerDamage", victim, damage, hitgroup)) then
		return true
	end
	-- Do gunbalance damage limitations
	local success, result, range, critChance, penalties, bonus
	if (IsValid(attacker) and attacker:IsPlayer()) then
		success, result, range, critChance, penalties, bonus = ix.weapons:BalanceDamage(victim, damage, attacker, hitgroup)
		if (success == false or !range or !tonumber(range)) then
			-- we don't know what to do with this damage
			return
		end
	end

	-- If still dealing damage
	if (damage:GetDamage() > 0) then
		local messageType
		local finalDamage
		local weaponItem

		if (IsValid(attacker) and attacker:IsPlayer()) then
			weaponItem = attacker:GetActiveWeapon().ixItem
		end

		local armorPen = weaponItem and weaponItem.armorPen or ix.config.Get("defaultArmorPenetration", 0.5)

		if (IsValid(attacker) and attacker:IsNPC()) then
			armorPen = ix.config.Get("npcArmorPen", 0.5)
		end
		
		if (victim:Armor() > 0) then
			if (damage:IsBulletDamage() or damage:IsDamageType(DMG_CLUB) or damage:IsDamageType(DMG_SLASH)) then
				local armor = victim:Armor() - (damage:GetDamage() * armorPen)

				if (armor < 0) then
					finalDamage = damage:GetDamage() * armorPen
					messageType = ix.weapons.messageTypes.ARMOR_BROKEN

					victim:SetHealth(math.max(victim:Health() - math.abs(armor), 1))
					victim:SetArmor(0)
				else
					finalDamage = damage:GetDamage() * armorPen
					messageType = ix.weapons.messageTypes.ARMOR_DAMAGE

					victim:SetArmor(armor)
				end

			elseif (damage:IsDamageType(DMG_SHOCK)) then
				finalDamage = damage:GetDamage()
				messageType = ix.weapons.messageTypes.ARMOR_HALF_DAMAGE

				victim:SetArmor(math.max(victim:Armor() - finalDamage / 2, 0))
				victim:SetHealth(math.max(victim:Health() - damage:GetDamage(), 1))
			else
				finalDamage = damage:GetDamage()
				messageType = ix.weapons.messageTypes.WEAPON_DAMAGE

				victim:SetHealth(math.max(victim:Health() - damage:GetDamage(), 1))
			end
		elseif victim:GetCharacter():GetFaction() == FACTION_VORT then
			finalDamage = damage:GetDamage() * armorPen
			messageType = ix.weapons.messageTypes.WEAPON_DAMAGE

			victim:SetHealth(math.max(victim:Health() - finalDamage, 1))
		else
			finalDamage = damage:GetDamage()
			messageType = ix.weapons.messageTypes.WEAPON_DAMAGE

			victim:SetHealth(math.max(victim:Health() - damage:GetDamage(), 1))
		end

		if (IsValid(attacker) and attacker:IsPlayer() and range) then
			ix.weapons:QueueDamageMessage(attacker, {
				bCrit = result == "crit",
				target = victim,
				hitBox = PLUGIN.hitGroupName[hitgroup],
				range = math.Round(range),
				damage = finalDamage,
				calcCrit = critChance,
				penalties = penalties,
				bonus = bonus,
				messageType = messageType
			})
		end
	else
		return true
	end

	-- If Victim is dying
	if (victim:Health() == 1) then
		if (hook.Run("HandlePlayerDeath", victim, damage) != false) then
			self:HandlePlayerDeathFallback(victim, damage)
		end
	else
		hook.Run("PlayerHurt", victim, attacker, victim:Health(), damage:GetDamage())
	end

	-- Stop further EntityTakeDamage stuff (we already called this!)
	damage:SetDamage(0)
	return true
end

function PLUGIN:TFA_PreCanPrimaryAttack(weapon)
	local client = weapon.Owner
	if (!IsValid(client) or !client:IsPlayer()) then return end

	client.ixCanDoDamage = weapon.Primary.NumShots
end

function PLUGIN:TFA_PostPrimaryAttack(weapon)
	local client = weapon.Owner
	if (client:IsNPC()) then return end

	local min, max = ix.weapons:GetWeaponSkillRequired(weapon:GetClass())
	local level = client:GetCharacter():GetSkill("guns")
	if (min <= level and level <= max) then
		client:GetCharacter():DoAction("guns_level_approp")
	else
		client:GetCharacter():DoAction("guns_level_unapprop")
	end
end

function PLUGIN:ShouldSpawnClientRagdoll(client)
	return false
end

function PLUGIN:PlayerSpawn(client)
	client:SetLocalVar("ragdoll", nil)
end

function PLUGIN:ShouldRemoveRagdollOnDeath(client)
	return false
end

function PLUGIN:PlayerInitialSpawn(client)
	self:CleanupCorpses()
end

function PLUGIN:DoPlayerDeath(client)
	-- remove old corpse if we've hit the limit
	local maxCorpses = ix.config.Get("corpseMax", 8)
	if (maxCorpses > 0) then
		local entity = IsValid(client.ixRagdoll) and client.ixRagdoll or client:CreateServerRagdoll()
		local decayTime = ix.config.Get("corpseDecayTime", 60)
		local uniqueID = "ixCorpseDecay" .. entity:EntIndex()

		entity:RemoveCallOnRemove("fixer")
		entity:CallOnRemove("ixPersistentCorpse", function(ragdoll)
			if (ragdoll.ixInventory) then
				ix.storage.Close(ragdoll.ixInventory)
			end

			if (IsValid(client) and !client:Alive()) then
				client:SetLocalVar("ragdoll", nil)
			end

			local index
			for k, v in ipairs(PLUGIN.corpses) do
				if (v == ragdoll) then
					index = k
					break
				end
			end

			if (index) then
				table.remove(PLUGIN.corpses, index)
			end

			if (timer.Exists(uniqueID)) then
				timer.Remove(uniqueID)
			end
		end)

		if (decayTime > 0) then
			timer.Create(uniqueID, decayTime, 1, function()
				if (IsValid(entity)) then
					entity:Remove()
				else
					timer.Remove(uniqueID)
				end
			end)
		end

		client.ixRagdoll = nil
		entity.ixPlayer = nil
		self.corpses[#self.corpses + 1] = entity

		if (#self.corpses >= maxCorpses) then
			self:CleanupCorpses(maxCorpses)
		end

		hook.Run("OnPlayerCorpseCreated", client, entity)
	end
end
