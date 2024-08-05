--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN or {}

PLUGIN.name = "Minor Things"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Small Changes and Additions."

ix.config.Add("DeleteNPCWeaponOnDeath", true, "Whether or not NPC weapons should be deleted on death (instead of dropped on the ground).", nil, {category = "Minor Things"})
ix.config.Add("StrictLocation", false, "Whether a player must be in the location box to show as in that location. If true, players outside a box will shown in 'unknown location'. If false, player will show as if in their last location.", nil, {category = "Minor Things"})

do
	local ITEM = ix.item.Register("flashlight", nil, false, nil, true)
	ITEM.name = "Flashlight"
	ITEM.category = "Tools"
	ITEM.model = Model("models/willardnetworks/skills/flashlight.mdl")
	ITEM.description = "A simple black flashlight with a singular button to turn it off and on again."
	ITEM.postHooks.drop = function(item, result, data)
		if (result == false and item.player:FlashlightIsOn() and !item.player:GetCharacter():GetInventory():HasItem("flashlight")) then
			item.player:Flashlight(false)
		end
	end
end

function PLUGIN:PostSetupActs()
	ix.act.Remove("Arrest")

	local actPlugin = ix.plugin.Get("act")


end

do
	local PLAYER = FindMetaTable("Player")

	-- returns the current area the player is in, or the last valid one if the player is not in an area
	function PLAYER:GetLocation(bCombine)
		if (!self.ixInArea and ix.config.Get("StrictLocation")) then
			return "unknown location"
		end

		local areaInfo = ix.area.stored[self.ixArea]
		if (!areaInfo) then
			return "unknown location"
		end

		if (areaInfo.type != "area" and areaInfo.type != "rpArea" or !areaInfo.properties.display) then
			return "unknown location"
		end

		return string.Trim(bCombine and areaInfo.properties.combineText or self.ixArea)
	end
end

if (CLIENT) then
	function PLUGIN:ShouldShowPlayerOnScoreboard(client)
		local localFaction = ix.faction.Get(LocalPlayer():GetCharacter():GetFaction())
		if (localFaction.seeAll or LocalPlayer():GetCharacter():HasFlags("Q")) then
			return true
		else
			local clientFaction = ix.faction.Get(client:GetCharacter():GetFaction())
			if (clientFaction and clientFaction.hidden and localFaction != clientFaction) then
				return false
			end
		end
	end

	function PLUGIN:IsCharacterRecognized(char, id)
		local faction = ix.faction.indices[LocalPlayer():GetCharacter():GetFaction()]

		if ((faction and faction.recogniseAll) or LocalPlayer():GetCharacter():HasFlags("Q")) then
			return true
		end
	end
else
	ix.allowedHoldableClasses["ix_container"] = true

	function PLUGIN:OnNPCKilled(npc, attacker, inflictor)
		if (!ix.config.Get("DeleteNPCWeaponOnDeath")) then return end

		if (!npc.GetActiveWeapon) then return end

		local weapon = npc:GetActiveWeapon()
		if (IsValid(weapon)) then
			weapon:Remove();
		end
	end

	-- A function to get whether a player has a flashlight.
	function PLUGIN:PlayerSwitchFlashlight(client, enabled)
		if (client:GetFactionVar(alwaysFlashlight)) then
			return true
		end

		if (!enabled or (client:GetCharacter() and client:GetCharacter():GetInventory():HasItem("flashlight"))) then
			return true
		end

		return false
	end

	local adminEntities = {
		["prop_physics"] = true,
		["ix_grouplock"] = true,
		["ix_combinelock"] = true,
		["ix_combinelock_cmru"] = true,
		["ix_combinelock_cmu"] = true,
		["ix_combinelock_cwu"] = true,
		["ix_combinelock_dob"] = true,
		["ix_combinelock_moe"] = true
	}

	-- Anti-Exploit measures.
	function PLUGIN:EntityTakeDamage(entity, damageInfo)
		local attacker = damageInfo:GetAttacker()
		if (!attacker or !attacker:IsPlayer()) then return end

		if (entity:GetClass() == "ix_item" and entity:GetData("pin") and entity:GetData("owner") != attacker:GetCharacter():GetID() and !attacker:IsCombine()) then return true end
		if (!adminEntities[entity:GetClass()]) then return end

		for _, v in ipairs(player.GetAll()) do
			if (v:IsAdmin()) then return end
		end

		return true
	end

	ix.log.AddType("containerSpawned", function(client, name)
		return string.format("%s created a '%s' container.", client:Name(), name)
	end, FLAG_NORMAL)
end

ix.flag.Add("Q", "Access to see all characters.")
