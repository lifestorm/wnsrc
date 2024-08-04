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
PLUGIN.name = "Automatic Language"
PLUGIN.author = "Naast"
PLUGIN.description = "Ability to set your default language in options."

ix.char.RegisterVar("defaultLanguage", {
	field = "defaultLanguage",
	default = false,
	isLocal = true,
	bNoDisplay = true
})

ix.command.Add("CharSetDefaultLanguage", {
    description = "Définissez une langue par défaut pour votre personnage ! Entrez une valeur erronée dans le champ pour la supprimer.",
    arguments = ix.type.string,
    OnRun = function(self, client, lang)
		local char = client:GetCharacter()
		for _, v in ipairs(char:GetLanguages()) do
			if v == lang then char:SetDefaultLanguage(lang) return client:NotifyLocalized("Vous avez réglé votre langue par défaut sur" .. lang) end
		end
		client:NotifyLocalized("Votre langue par défaut est réinitialisée. Maintenant vous parlez Français. (Ou vous avez entré une valeur incorrecte)")
		char:SetDefaultLanguage(false)

    end
})

if SERVER then
	local sub = string.sub
	function PLUGIN:PlayerSay(client, text)
		local pref = sub(text, 1, 1)
		if pref != "!" and pref != "@" then
			local chatType, message, anonymous = ix.chat.Parse(client, text, true)
			local char = client:GetCharacter()

			if (chatType == "ic") then
				if (ix.command.Parse(client, message)) then
					return ""
				end
			end

			if chatType == "ic" and char:GetDefaultLanguage() then chatType = char:GetDefaultLanguage() end
			text = ix.chat.Send(client, chatType, message, anonymous)

			if (isstring(text)) then
				ix.log.Add(client, "chat", chatType and chatType:utf8upper() or "??", text)
			end

			hook.Run("PostPlayerSay", client, chatType, message, anonymous)
			return ""
		end
	end
end