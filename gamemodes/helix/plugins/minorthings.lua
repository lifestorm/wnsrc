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

ix.config.Add("DeleteNPCWeaponOnDeath", true, "Si oui ou non les armes des PNJ doivent être supprimées à la mort (au lieu d'être jetées au sol).", nil, {category = "Autres"})
ix.config.Add("StrictLocation", false, "Indique si un joueur doit se trouver dans la zone de localisation pour s'afficher comme se trouvant à cet emplacement. Si c'est vrai, les joueurs à l'extérieur d'une boîte seront affichés dans 'lieu inconnu'. Si false, le joueur s'affichera comme s'il était à son dernier emplacement.", nil, {category = "Autres"})

do
	local ITEM = ix.item.Register("flashlight", nil, false, nil, true)
	ITEM.name = "Lampe Torche"
	ITEM.category = "Outils"
	ITEM.model = Model("models/willardnetworks/skills/flashlight.mdl")
	ITEM.description = "Une simple lampe de poche noire. Elle possède qu'un seul bouton, qui permet de l'éteindre ou de la rallumer."
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
			return "une location inconnue"
		end

		local areaInfo = ix.area.stored[self.ixArea]
		if (!areaInfo) then
			return "une location inconnue"
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

ix.flag.Add("Q", "Accès pour voir tous les personnages.")
