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

ix.flag.Add("L", "Access to delete Datafile Logs.")

ix.lang.AddTable("english", {
	cmdCharTogglePermit = "Bir karakterin pazarlık menüsünü kullanabilmesi için izin verir veya kaldırır.",
	togglePermit = "%s'nin pazarlık iznini %s oldunuz.",
	togglePermitTarget = "%s pazarlık iznini %s.",
	cmdMassReward = "Birden fazla CP birimine aynı anda SC verin. Tüm CP'lere vermek için 'all' kullanın.\nBelirli birimlere vermek için boşlukla ayrılmış (kısmi) isimlerin bir listesini girin.",
	cmdAmputate = "Baktığınız kişiye karşı hasarınızı artırır.\nArtış yalnızca 60 saniye için geçerlidir. Hedef bağlanmış veya KO olmalıdır.\nEğer hedef ölürse, yöneticiler PK yapmaları için uyarılır.",
	identityInspection = "%s, %s üzerinde kimlik denetimi gerçekleştiriyor, #%s",
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

ix.config.Add("communionSCRequirement", 150, "Amount of SC needed to use the terminal communion.", nil, {
	data = {min = 101, max = 720},
	category = "Datafile"
})

ix.config.Add("maxWorkshiftSocialCredits", 15, "The max amount of social credits given at workshift.", nil, {
	data = {min = 1, max = 20},
	category = "Workshift"
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
			client:Notify("Geçerli miktarda SC giriniz!")
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
					v:Notify(sc.." adet sterilize kredi edindiniz.")
				else
					v:Notify(math.abs(sc).." adet sterilize kredi kaybettiniz.")
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
							v:Notify(sc.." adet sterilize kredi edindiniz.")
						else
							v:Notify(math.abs(sc).." adet sterilize kredi kaybettiniz.")
						end

						break
					end
				end
			end
		end

		if (sc > 0) then
			client:ChatNotify(sc.." adet sterilize krediyi şu kişiye gönderdiniz: "..table.concat(given, ", "))
		else
			client:ChatNotify(sc.." adet sterilize krediyi şu kişiden aldınız: "..table.concat(given, ", "))
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
			client:Notify("Geçerli bir hedefe bakmıyorsunuz!")
			return
		end
		local bIsRagdoll = target:GetClass() == "prop_ragdoll"

		if (target:GetPos():DistToSqr(client:GetPos()) > 400 * 400) then
			client:Notify("Hedefiniz çok uzak!")
			return
		end

		if ((bIsRagdoll and !IsValid(target.ixPlayer)) or (!bIsRagdoll and !target:IsRestricted())) then
			client:Notify("Hedefiniz baygın veya eli bağlı olmalı!")
			return
		end

		if (bIsRagdoll) then
			target = target.ixPlayer
		end

		target.beingAmputated = client
		target.beingAmputatedEnd = CurTime() + 60
		target.beingAmputatedReason = reason

		client:Notify("Hedef amputasyon için belirlendi. Kararı uygulayın!")
    end
})

ix.command.Add("SetCombineDoor", {
	description = "Set a door to combine and its' name to show up on the CA PDA.",
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
			client:NotifyLocalized("Set this door to a combine door.")

			hook.Run("SaveDoorData")
		end
	end
})

function PLUGIN:CreateDiskNameRequest(currentName, itemID, password)
	Derma_StringRequest("Set Floppy Disk Name", "Set the name of the disk.", currentName or "Floppy Disk", function(text)
		if (text == "") then return end

		netstream.Start("SetFloppyDiskName", text, itemID, password)
	end)
end

if (CLIENT) then
	netstream.Hook("SetFloppyDiskName", function(currentName, itemID, password)
		if password then
			Derma_StringRequest("This disk is password protected.", "Enter it.", "", function(password2)
				if (password2 == "") then return end

				PLUGIN:CreateDiskNameRequest(currentName, itemID, password2)
			end)

			return
		end

		PLUGIN:CreateDiskNameRequest(currentName, itemID, false)
	end)
end
