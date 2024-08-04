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

PLUGIN.name = "Combine Utilities"
PLUGIN.author = "Fruity, wowm0d"
PLUGIN.description = "Adds combine entities and visual stuff."

ix.util.IncludeDir("darkrp/plugins/combineutilities/pda", true)
ix.util.IncludeDir("darkrp/plugins/combineutilities/teams", true)
ix.util.IncludeDir("darkrp/plugins/combineutilities/consoles", true)
ix.util.IncludeDir("darkrp/plugins/combineutilities/workshifts", true)
ix.plugin.LoadEntities("darkrp/plugins/combineutilities/workshifts/entities")
ix.util.Include("sv_groupmessaging.lua")
ix.util.Include("sv_plugin.lua")

ix.flag.Add("L", "Effacer les logs du DATAPAD.")

ix.lang.AddTable("english", {
	cmdCharTogglePermit = "Gives or removes a character's permit, (dis)allowing them to use the bartering menu.",
	togglePermit = "You have %s %s's bartering permit.",
	togglePermitTarget = "%s has %s your bartering permit.",
	cmdMassReward = "Give SC to multiple CP units at once. Use 'all' to give to all CP's.\nEnter a space-separated list of (partial) names to give to specific units.",
	cmdAmputate = "Boosts your damage against the person you are looking at.\nBoost is only valid for 60 seconds. Target must be tied or KO.\nIf the target dies, the admins are alerted to PK the target.",
	identityInspection = "%s %s performing identity inspection on %s, #%s",
})

ix.lang.AddTable("french", {
	cmdCharTogglePermit = "Donne ou retire le permis d'un personnage, lui (dés)autorisant à utiliser le menu de commerce.",
	togglePermit = "Vous avez le permis de commerce de %s %s.",
	togglePermitTarget = "%s a %s votre permis de commerce.",
	cmdMassReward = "Donnez CS à plusieurs unités PC à la fois. Utilisez 'tous' pour donner à tous les PC.\nEntrez une liste séparée par des espaces de noms (partiels) à donner à des unités spécifiques.",
	cmdAmputate = "Augmente vos dégâts contre la personne que vous regardez.\nLe boost n'est valable que pendant 60 secondes. La cible doit être attaché ou KO.\nSi la cible meurt, les admins sont alertés pour PK la cible.",
	identityInspection = "%s %s effectue une inspection d'identité sur %s, #%s",
})

ix.lang.AddTable("spanish", {
	cmdAmputate = "Aumenta tu daño contra la persona a la que estás mirando.\nEl aumento sólo es válido durante 60 segundos. El objetivo debe estar atado o inconsciente.\nSi el objetivo muere, se avisa a los administradores para que hagan PK al objetivo.",
	cmdCharTogglePermit = "Da o quita el permiso de un personaje, (des)permitiéndole usar el menú de comercio.",
	identityInspection = "%s %s realizando inspección de identidad en %s, #%s",
	togglePermitTarget = "%s ha %s tu permiso de comercio.",
	togglePermit = "Tienes %s permisos de comercio de tipo %s.",
	cmdMassReward = "Dar CE a múltiples CPCs a la vez. Usa \"all\" para dar a todas las unidades de Protección Civil.\nIntroduce una lista separada por espacios de nombres (parciales) para dar a unidades específicas."
})

ix.char.RegisterVar("hasDatafile", {
	default = false,
	field = "hasDatafile",
	fieldType = ix.type.bool,
	bNoDisplay = true,
	bNoNetworking = true,
})

ix.config.Add("communionSCRequirement", 150, "Quantité de CS nécessaire pour utiliser le terminal communion.", nil, {
	data = {min = 101, max = 720},
	catégorie = "Terminal Citoyen"
})

ix.config.Add("maxWorkshiftSocialCredits", 15, "Le montant maximum de crédits sociaux donnés à l'atelier.", nil, {
	data = {min = 1, max = 20},
	category = "Poste de Travail"
})

ix.config.Add("datafileNoConnection", false, "Disable the datafile's connection to the OCIN network", nil, {
	category = "Datafile"
})

ix.config.Add("crimeReportArchiveTime", 1, "The amount of weeks that crime reports must be older than to be automatically cleared via 'clear' button.", nil, {
	data = {min = 1, max = 12},
	category = "Datafile"
})

local classes = {
	[CLASS_CP_CMD] = true,
	[CLASS_CP_CPT] = true,
	[CLASS_CP_RL] = true,
	[CLASS_OVERSEER] = true,
	[FACTION_MCP] = true
}

ix.command.Add("MassReward", {
	description = "@cmdMassReward",
	arguments = {
		ix.type.number,
		ix.type.text
	},
	OnCheckAccess = function(self, client)
		local character = client:GetCharacter()
		local name = client:Name()

		if (client:Team() != FACTION_OVERWATCH and !classes[character:GetClass()] and !Schema:IsCombineRank(name, "i2") and !Schema:IsCombineRank(name, "i1")) then
			return false
		end

		return true
	end,
	OnRun = function(self, client, sc, targets)
		if (sc == 0) then
			client:Notify("Entrez un montant valide de CS !")
			return false
		end

		local given = {}

		if (targets == "*" or targets == "all") then
			for _, v in ipairs(player.GetAll()) do
				if (v:Team() != FACTION_CP or v == client) then continue end

				local char = v:GetCharacter()
				if (!char) then continue end

				given[#given + 1] = v:Name()

				local genericdata = char:GetGenericdata()
				if (genericdata) then
					genericdata.socialCredits = (genericdata.socialCredits or 0) + sc

					char:SetGenericdata(genericdata)
					char:Save()
				end

				if (sc > 0) then
					v:Notify("Vous avez reçu "..sc.." crédits stérilisés.")
				else
					v:Notify("Vous avez perdu "..math.abs(sc).." crédits stérilisés.")
				end
			end
		else
			targets = string.Explode(" ", targets)
			for _, v in ipairs(player.GetAll()) do
				if (v:Team() != FACTION_CP) then continue end


				local name = string.utf8lower(v:Name())
				for _, target in ipairs(targets) do
					if (string.find(name, string.utf8lower(target), 1, true)) then
						local char = v:GetCharacter()
						given[#given + 1] = v:Name()

						local genericdata = char:GetGenericdata()
						if (genericdata) then
							genericdata.socialCredits = (genericdata.socialCredits or 0) + sc

							char:SetGenericdata(genericdata)
							char:Save()
						end

						if (sc > 0) then
							v:Notify("Vous avez reçu "..sc.." crédits stérilisés.")
						else
							v:Notify("Vous avez perdu "..math.abs(sc).." crédits stérilisés.")
						end

						break
					end
				end
			end
		end

		if (sc > 0) then
			client:ChatNotify("Vous avez donné "..sc.." scrédits stérilisés à : "..table.concat(given, ", "))
		else
			client:ChatNotify("Vous avez retiré "..sc.." scrédits stérilisés à : "..table.concat(given, ", "))
		end
    end
})

ix.command.Add("Amputate", {
	description = "@cmdAmputate",
	arguments = {
		bit.bor(ix.type.text, ix.type.optional)
	},
	OnCheckAccess = function(self, client)
		return ix.faction.Get(client:Team()).isCombineFaction
	end,
	OnRun = function(self, client, reason)
		local target = client:GetEyeTraceNoCursor().Entity
		if (!IsValid(target) or !(target:IsPlayer() or target:GetClass() == "prop_ragdoll")) then
			client:Notify("Vous devez regarder une cible valable !")
			return
		end
		local bIsRagdoll = target:GetClass() == "prop_ragdoll"

		if (target:GetPos():DistToSqr(client:GetPos()) > 400 * 400) then
			client:Notify("Votre cible est trop éloignée !")
			return
		end

		if ((bIsRagdoll and !IsValid(target.ixPlayer)) or (!bIsRagdoll and !target:IsRestricted())) then
			client:Notify("Votre cible doit être inconsciente ou attachée !")
			return
		end

		if (bIsRagdoll) then
			target = target.ixPlayer
		end

		target.beingAmputated = client
		target.beingAmputatedEnd = CurTime() + 60
		target.beingAmputatedReason = reason

		client:Notify("Cible pour amputation ! Appliquez le verdict !")
    end
})

ix.command.Add("SetCombineDoor", {
	description = "Mettre une porte comme Combine.",
	privilege = "Manage Doors",
	adminOnly = true,
	arguments = ix.type.text,
	OnRun = function(self, client, name)
		-- Get the door the player is looking at.
		local entity = client:GetEyeTrace().Entity

		-- Validate it is a door.
		if (IsValid(entity) and entity:IsDoor() and !entity:GetNetVar("disabled")) then
			entity:SetNetVar("combineDoor", name)
			entity.ixCombineDoor = name
			client:NotifyLocalized("Définissez cette porte comme une porte de Combine.")

			hook.Run("SaveDoorData")
		end
	end
})

function PLUGIN:CreateDiskNameRequest(currentName, itemID, password)
	Derma_StringRequest("Définir le nom de la disquette", "Définissez le nom du disque.", currentName or "Disquette", function(text)
		if (text == "") then return end

		netstream.Start("SetFloppyDiskName", text, itemID, password)
	end)
end

if (CLIENT) then
	netstream.Hook("SetFloppyDiskName", function(currentName, itemID, password)
		if password then
			Derma_StringRequest("Ce disque est protégé par un mot de passe.", "Entrez-le.", "", function(password2)
				if (password2 == "") then return end

				PLUGIN:CreateDiskNameRequest(currentName, itemID, password2)
			end)

			return
		end

		PLUGIN:CreateDiskNameRequest(currentName, itemID, false)
	end)
end
