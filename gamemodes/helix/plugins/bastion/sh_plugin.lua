--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local IsValid = IsValid
local ix = ix

PLUGIN.name = "Bastion"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Some admin extensions for Helix."

local CAMI = CAMI

CAMI.RegisterPrivilege({
	Name = "Helix - Hear Staff Chat",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Hear GM Chat",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Hear Mentor Chat",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Fun Stuff",
	MinAccess = "superadmin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Basic Commands",
	MinAccess = "user"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Basic Admin Commands",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Full Remover Tool",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - HL2 Tools",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Bastion Whitelist",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - View Inventory",
	MinAccess = "superadmin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Increase Character Limit",
	MinAccess = "admin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Bastion Lookup",
	MinAccess = "superadmin"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Container Password",
	MinAccess = "superadmin"
})
CAMI.RegisterPrivilege({
	Name = "Helix - Proxy Notify",
	MinAccess = "superadmin"
})

ix.option.Add("pgi", ix.type.bool, true, {category = "administration"})

ix.option.Add("playerDeathNotification", ix.type.bool, true, {category = "administration", bNetworked = true})

ix.config.Add("netLoggingEnabled", false, "Enable or disable net logging into the database (WARNING: PERFORMANCE IMPACT)", nil, {
	category = "Bastion"
})
ix.config.Add("netAntiSpam", true, "Enable or disable net anti-spam (WARNING: PERFORMANCE IMPACT)", nil, {
	category = "Bastion"
})
ix.config.Add("suppressOnPlayerChat", true, "Suppress the default OnPlayerChat hook (should not be used by helix)", nil, {
	category = "Bastion"
})
ix.config.Add("maxCharactersIncreased", 5, "The maximum number of characters a player can have if they have the increased character limit permission.", nil, {
	data = {min = 1, max = 50},
	category = "characters"
})
ix.config.Add("charCreateInterval", 5, "How many minutes there should be between 2 successful character creations of one player (to avoid character spam).", nil, {
	data = {min = 1, max = 50},
	category = "characters"
})
ix.config.Add("AllowContainerSpawn", false, "Allow anyone to directly spawn containers by spawning in their prop. Disallowing this will require admins to create containers from a prop using the context menu.", nil, {
	category = "containers"
})
ix.config.Add("VPNKick", false, "Kick new users if they use a VPN.", nil, {
	category = "Bastion"
})
ix.config.Add("ProxyAlwaysAlert", true, "Always Discord Alert for new joiners with a VPN.", nil, {
	category = "Bastion"
})
ix.config.Add("showConnectMessages", true, "Whether or not to show notifications when players connect to the server. When off, only Staff will be notified.", nil, {
	category = "server"
})
ix.config.Add("showDisconnectMessages", true, "Whether or not to show notifications when players disconnect from the server. When off, only Staff will be notified.", nil, {
	category = "server"
})
ix.config.Add("DiscordLink", "https://discord.gg/HbDjUQd", "Invite link to the discord.", nil, {
	category = "Bastion"
})
ix.config.Add("ContentLink", "https://steamcommunity.com/sharedfiles/filedetails/?id=2145501003", "Link to the workshop collection.", nil, {
	category = "Bastion"
})
ix.config.Add("ForumLink", "https://willard.network", "Link to the forums", nil, {
	category = "Bastion"
})
ix.config.Add("EdictWarningLimit", 1024, "How many edicts can be left before warning messages start to appear.", nil, {
	data = {min = 100, max = 1024},
	category = "Bastion"
})

ix.flag.Add("a", "Access to the advanced duplicator.")

ix.lang.AddTable("english", {
	getPlayerInfo = "Get Player Info",
	optStaffChat = "Show Staff Chat on all characters",
	optdStaffChat = "Turns on/off staff chat on all characters. When off, will only show staff chat while in observer or on an admin character.",
	optPgi = "Copy Steam ID to clipboard on 'PGI'/'View Player'",
	optdPgi = "Allows you to turn on/off the automatic copy-to-clipboard of a player's SteamID when using the PGI command or 'View Player' context menu option.",
	cmdStaffHelp = "Call for help from all the staff.\n",
	cmdAnnounce = "Make an OOC admin announcement to the entire server.",
	cmdLocalEvent = "Make an IC admin event that can only be heard within a given radius.",
	bastionPGIInvalidTarget = "You must enter or be looking at a valid target.",
	bastionTakingItemsTooQuickly = "You are taking items too quickly! Please slow down.",
	bastionItemDropSpamKick = "%s was kicked for item drop exploiting.",
	bastionItemDropSpamWarn = "%s was warned for item drop exploiting.",
	bastionItemDropTooQuick = "You are dropping items too quickly! Please slow down.",
	bastionItemTakeWarn = "%s was warned for taking items too quickly.",
	bastionItemTakeKick = "%s was kicked for dropping items too quickly.",
	charCreateTooFast = "You are creating characters too fast. Please wait at least %d minutes between attempts.",
	bastionCopiedCharName = "Character name copied",
	bastionCopiedSteamName = "Steam name copied",
	bastionCopiedSteamID = "Steam ID copied",
	bastionGoto = "Go to player",
	bastionCopyCharName = "Copy character name",
	bastionCopySteamName = "Copy steam name",
	bastionNoRecordFound = "Could not find any records for %s.",
	bastionResultsPrinted = "Results were printed in console.",
	bastionProxyNotify = "%s connected as new player while using a VPN/Proxy.",
	bastionPropOwnerInformation = "The owner of this prop is %s (%s - %s).",
	bastionPropOwnerUnknown = "The owner of this prop has not been registered!",
	whitelistDone = "Player was whitelisted.",
	whitelistError = "Something went wrong whitelisting the player. Ask a dev.",
	cmdTimeScale = "Change the timescale (min 0.001, max 5).",
	bastionTimeScale = "%s has set the timescale to %d.",
	cmdGravity = "Change the gravity.",
	bastionGravity = "%s has set the gravity to %d.",
	edictWarning = "Only %d edicts are left! Total edict count is currently: %d/8192!",
	edictCritical = "Only %d edicts are left! Total edict count is currently: %d/8192! Emergency Cleanup Required!",
	entsPrintedInConsole = "Entity list has been printed in console.",
	entityRemoved = "Entity %d (%s) was removed!",
	entityNotFound = "Entity %d was not found/is not valid.",
	optPlayerDeathNotification = "Player Death Notification",
	optdPlayerDeathNotification = "Whether to send a chat message when a player dies.",
	cmdRemovePersistedProps = "Remove all persisted props in a radius around you."
})

ix.lang.AddTable("spanish", {
	bastionCopySteamName = "Copiar nombre de Steam",
	bastionPGIInvalidTarget = "Debes especificar o estar mirando a un objetivo válido.",
	cmdLocalEvent = "Haz un evento IC de administrador que sólo pueda ser escuchado dentro de un radio determinado.",
	bastionNoRecordFound = "No se ha podido encontrar ningún registro para %s.",
	cmdAnnounce = "Haz un anuncio OOC de administrador a todo el servidor.",
	cmdGravity = "Cambia la gravedad.",
	bastionCopiedSteamID = "Steam ID copiada",
	bastionProxyNotify = "%s se ha conectado como nuevo jugador mientras usa una VPN/Proxy.",
	bastionTakingItemsTooQuickly = "¡Estás agarrando objetos demasiado rápido! Por favor, reduce la velocidad.",
	optdStaffChat = "Activa/desactiva el Chat de Staff en todos los personajes. Cuando está desactivado, sólo se mostrará el Chat de Staff mientras se esté en observer o en un personaje administrativo.",
	entityNotFound = "La entidad %d no fue encontrada/no es válida.",
	whitelistDone = "El jugador estaba en la Whitelist.",
	bastionCopiedCharName = "Nombre del personaje copiado",
	getPlayerInfo = "Obtener información del jugador",
	bastionCopyCharName = "Copiar el nombre del personaje",
	charCreateTooFast = "Estás creando personajes demasiado rápido. Por favor, espera al menos %d minutos entre intentos.",
	entsPrintedInConsole = "La lista de entidades se ha impreso en la consola.",
	bastionItemDropTooQuick = "¡Estás soltando objetos demasiado rápido! Por favor, baja la velocidad.",
	bastionGravity = "%s ha fijado la gravedad en %d.",
	entityRemoved = "¡La entidad %d (%s) ha sido eliminada!",
	cmdStaffHelp = "Pide ayuda a todo el Staff.\n",
	bastionCopiedSteamName = "Nombre de Steam copiado",
	bastionItemTakeWarn = "%s fue advertido por agarrar objetos demasiado rápido.",
	bastionResultsPrinted = "Los resultados se imprimieron en la consola.",
	optStaffChat = "Mostrar el Chat de Staff en todos los personajes",
	bastionGoto = "Ir al jugador",
	cmdTimeScale = "Cambie la escala de tiempo (mínimo 0,001, máximo 5).",
	whitelistError = "Algo fue mal cuando se intentó meter al jugador en la whitelist. Contacta con un desarrollador.",
	bastionTimeScale = "%s ha fijado la escala de tiempo en %d.",
	bastionItemDropSpamKick = "%s ha sido expulsado por exploits relacionados con item-dropping.",
	optdPgi = "Te permite activar/desactivar la copia automática al portapapeles del SteamID de un jugador cuando usa el comando PGI o la opción del menú contextual 'Ver Jugador'.",
	bastionItemDropSpamWarn = "%s ha sido advertido del uso de exploits relacionados con item-dropping.",
	bastionItemTakeKick = "%s ha sido expulsado por soltar objetos demasiado rápido.",
	optPgi = "Copiar Steam ID al portapapeles en el 'PGI'/'Ver Jugador'",
	edictWarning = "¡Solamente quedan disponibles %d edictos! ¡El conteo total de edictos es de: %d/8192!"
})

PLUGIN.soundAlias = {
	["restricted_block_deploy"] = "voices/dispatch/restrictedblock_deployment.wav",
	["restricted_block"] = "voices/dispatch/restrictedblock_warning.wav",
	["access_restricted"] = "voices/dispatch/access_restricted.wav",
	["anticivil_evading"] = "voices/dispatch/anticivil_evading.wav",
	["civil_insurrection"] = "voices/dispatch/civil_insurrection.wav",
	["victory_music"] = "music/scary_tense/victory_music.mp3",
}

ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_classes.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sh_context.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.util.Include("modules/sh_bindchecker.lua")

function PLUGIN:GetMaxPlayerCharacter(client)
    if (CAMI.PlayerHasAccess(client, "Helix - Increase Character Limit")) then
        return ix.config.Get("maxCharactersIncreased", 8)
    end
end

function PLUGIN:CanProperty(client, property, entity)
    if (property == "container_setpassword" and !CAMI.PlayerHasAccess(client, "Helix - Container Password")) then
        return false
    end
end

function PLUGIN:CanPlayerSpawnContainer()
	if (!ix.config.Get("AllowContainerSpawn")) then
		return false
	end
end

function PLUGIN:CanPlayerAccessDoor(client)
	if (client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle()) then return true end

	if (ix.faction.Get(client:Team()).lockAllDoors) then return true end
end

PLUGIN.removeWhitelist = {
    ["prop_physics"] = true,
    ["prop_ragdoll"] = true
}

local hl2Tools = {
	["env_headcrabcanister"] = true,
	["item_ammo_crate"] = true,
	["item_item_crate"] = true,
	["prop_door"] = true,
	["prop_thumper"] = true
}

function PLUGIN:CanTool(client, trace, tool)
    if (tool == "remover" and !CAMI.PlayerHasAccess(client, "Helix - Full Remover Tool")) then
        if (IsValid(trace.Entity) and !self.removeWhitelist[trace.Entity:GetClass()]) then
            return false
        end
    elseif (tool == "advdupe2" and !client:GetCharacter():HasFlags("a")) then
        return false
	elseif (hl2Tools[tool] and !CAMI.PlayerHasAccess(client, "Helix - HL2 Tools")) then
		return false
	end
end
