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

PLUGIN.name = "Xenforo Link"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Links the in-game ranks and factions to the forums."

if (!sam) then return end

if (SERVER and !CHTTP) then
	pcall(require, "chttp")
end

PLUGIN.TOKEN_VALID = 60
PLUGIN.NEW_ATTEMPT_WAIT = 1

PLUGIN.tiers = {
    "A True Citizen",
    "Protector",
    "Galunga Prince"
}

CAMI.RegisterPrivilege({
	Name = "Helix - Manage Temp Admin",
	MinAccess = "superadmin"
})

ix.config.Add("whitelistForumLink", true, "Whether or not some whitelists should be linked to forum groups.", nil, {
	category = "server"
})

ix.util.Include("sh_commands.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_link.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
    xenforoFailsPause = "You entered the wrong code too many times. Please try again in %d minutes.",
    xenforoStartWait = "Please wait 1 minute before starting a new linking attempt.",
    xenforoFailedFindUser = "Something went wrong trying to find the user '%s'.",
    xenforoFindUserNoExactMatch = "We did not manage to find an exact match for the user '%s'.",
    xenforoFailedCreatePM = "Something went wrong trying to send the private message with the token.",
    xenforoFailedCreatePMError = "Received an error when trying to send the private message with the token.",
    xenforoCodeSend = "Private message with link token was successfully send. Please check your PM's on the forums. Do not disconnect from the server: your token will become invalid.",
    xenoforoNoLinkActive = "Cannot finishing linking as no link attempt is active. Please use /LinkAccount first.",
    xenoforoLinkNotValid = "Token is no longer valid. Please start again with /LinkAccount.",
    xenforoLinkSuccess = "Your account was successfully linked with your forum account!",
    xenforoFailsPauseStart = "You entered a wrong token too many times. Please wait 1 hour before making a new attempt.",
    xenforoWrongCode = "You entered a wrong token. You have %d attempts left.",
    xenforoNotLinked = "%s does not have their forum account linked.",
    xenforoGroupsUpdateSelf = "Your forum groups have been updated. %d valid groups were found.",
	xenforoGroupsUpdate = "%s their forum groups have been updated. %d valid groups were found.",
	xenforoLinkRemoved = "Your link to your forum has been removed.",
	xenforoNoGroupFound = "Couldn't find the target group '%s'.",
	xenforoTempGroup = "%s was temporarily given '%s' for '%d' minutes.",
	xenforoTempGroupRemove = "%s was removed from the temporary group '%s'.",
	xenforoTempGroupClear = "%s their temporary groups were cleared.",
	xenforoWhitelistForumLink = "This faction whitelist is managed via the forums. Use /LinkAccount instead!",
	xenforoTargetForumID = "%s is linked to forum account ID '%d'.",
	xenforoTargetNoForumID = "%s does not have a forum account linked!",
	xenforoTargetGroups = "Forum groups: %s",
	xenforoTargetNoGroups = "%s has no Xenforo groups!",
	xenforoTargetDynGroups = "Dynamic groups: %s",
	xenforoTargetDynNoGroups = "%s has no dynamic groups!",
	xenforoRanks = "SAM ranks: %s",
	xenforoNoRanks = "%s has no ranks!",
	xenforoFlags = "Flags: %s",
	xenforoNoFlags = "%s has no forum-group flags!",
	xenforoPremium = "Premium tier: %d",
	xenforoNoPremium = "%s has no premium subscription!",
	gamemasterToggle = "%s has toggled their gamemaster admin-powers %s!",
	mentorToggle = "%s has toggled their mentor admin-powers %s!",
})

ix.lang.AddTable("spanish", {
	xenoforoNoLinkActive = "No se puede linkear al no haber intento de link activo. Por favor, usa /LinkAccount primero.",
	xenforoNoGroupFound = "No se pudo encontrar el grupo objetivo \"%s\".",
	xenforoNotLinked = "%s no tiene su cuenta del foro linkeada.",
	xenforoTempGroupClear = "Grupos temporales de %s removidos.",
	xenoforoLinkNotValid = "El token ya no es válido. Por favor, empieza de nuevo con /LinkAccount.",
	xenforoLinkRemoved = "Tu link a tu foro han sido removidos.",
	xenforoGroupsUpdateSelf = "Tus grupos del foro han sido actualizados. %d grupos válidos fueron encontrados.",
	xenforoLinkSuccess = "¡Tu cuenta ha sido linkeada exitosamente con tu cuenta del foro!",
	xenforoCodeSend = "Mensaje privado con el token linkeado fue enviado con éxito. Por favor, revisa tus MPs en el foro. No te desconectes del servidor: Tu token se volverá inválido.",
	xenforoGroupsUpdate = "%s sus grupos han sido actualizados. %d grupos válidos encontrados.",
	xenforoFailedCreatePMError = "Error recibido al intentar enviar el mensaje con el token.",
	xenforoTempGroupRemove = "%s ha sido echado del grupo temporal \"%s\".",
	xenforoWrongCode = "Introdujiste un token erróneo. Tienes %d intentos más.",
	xenforoTempGroup = "A %s se le dio temporalmente \"%s\" por \"%d\" minutos.",
	xenforoFailsPauseStart = "Has introducido un token erróneo demasiadas veces. Por favor, espera 1 hora antes de hacer otro intento.",
	xenforoWhitelistForumLink = "La whitelist de esta facción es manejada a través del foro ¡Usa /LinkAccount en lugar de eso!",
	xenforoFindUserNoExactMatch = "No conseguimos encontrar una coincidencia exacta para el usuario '%s'.",
	xenforoFailedFindUser = "Algo fue mal al intentar buscar al usuario '%s'.",
	xenforoFailsPause = "Has introducido el código erróneo demasiadas veces. Por favor prueba otra vez en %d minutos.",
	xenforoFailedCreatePM = "Algo fue mal al intentar enviar el mensaje privado con el token.",
	xenforoStartWait = "Por favor espera 1 minuto antes de intentar otro intento de enlace.",
})

function PLUGIN:RegisterForumGroup(name, id, data)
	id = isstring(id) and id or tostring(id)
	if (!id or id == "") then return end

	if (data.camiGroup) then
		CAMI.RegisterUsergroup({Name = data.camiGroup, Inherits = data.inherits or "user"}, "helix")
	end

	if (SERVER) then
		ix.xenforo:RegisterForumGroup(name, id, data)
	end
end