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
	getPlayerInfo = "Oyuncu Bilgisi Al",
	optStaffChat = "Tüm karakterlerde Yetkili Sohbetini göster",
	optdStaffChat = "Tüm karakterlerde yetkili sohbetini açar/kapatır. Kapalıyken, yalnızca gözlemci modunda ya da bir admin karakterindeyken yetkili sohbeti gösterir.",
	optPgi = "'PGI'/'Oyuncuyu Görüntüle' komutunda Steam ID'yi panoya kopyala",
	optdPgi = "PGI komutunu veya 'Oyuncuyu Görüntüle' bağlam menü seçeneğini kullanırken bir oyuncunun SteamID'sini otomatik olarak panoya kopyalamayı açar/kapatır.",
	cmdStaffHelp = "Tüm yetkililerden yardım isteyin.\n",
	cmdAnnounce = "Tüm sunucuya OOC bir admin duyurusu yapın.",
	cmdLocalEvent = "Verilen bir yarıçap içinde sadece duyulabilen bir IC admin etkinliği yapın.",
	bastionPGIInvalidTarget = "Geçerli bir hedefe bakmalı veya girmelisiniz.",
	bastionTakingItemsTooQuickly = "Eşyaları çok hızlı alıyorsunuz! Lütfen yavaşlayın.",
	bastionItemDropSpamKick = "%s eşya bırakma istismarı için atıldı.",
	bastionItemDropSpamWarn = "%s eşya bırakma istismarı için uyarıldı.",
	bastionItemDropTooQuick = "Eşyaları çok hızlı bırakıyorsunuz! Lütfen yavaşlayın.",
	bastionItemTakeWarn = "%s eşyaları çok hızlı aldığı için uyarıldı.",
	bastionItemTakeKick = "%s eşyaları çok hızlı bıraktığı için atıldı.",
	charCreateTooFast = "Karakterleri çok hızlı oluşturuyorsunuz. Lütfen denemeler arasında en az %d dakika bekleyin.",
	bastionCopiedCharName = "Karakter adı kopyalandı",
	bastionCopiedSteamName = "Steam adı kopyalandı",
	bastionCopiedSteamID = "Steam ID kopyalandı",
	bastionGoto = "Oyuncuya git",
	bastionCopyCharName = "Karakter adını kopyala",
	bastionCopySteamName = "Steam adını kopyala",
	bastionNoRecordFound = "%s için herhangi bir kayıt bulunamadı.",
	bastionResultsPrinted = "Sonuçlar konsolda yazdırıldı.",
	bastionProxyNotify = "%s bir VPN/Proxy kullanarak yeni oyuncu olarak bağlandı.",
	bastionPropOwnerInformation = "Bu prop'un sahibi %s (%s - %s).",
	bastionPropOwnerUnknown = "Bu prop'un sahibi kayıtlara geçmemiş!",
	whitelistDone = "Oyuncu beyaz listeye eklendi.",
	whitelistError = "Oyuncuyu beyaz listeye eklerken bir şeyler ters gitti. Bir geliştiriciye sorun.",
	cmdTimeScale = "Zaman ölçeğini değiştir (min 0.001, max 5).",
	bastionTimeScale = "%s zaman ölçeğini %d olarak ayarladı.",
	cmdGravity = "Yer çekimini değiştir.",
	bastionGravity = "%s yer çekimini %d olarak ayarladı.",
	edictWarning = "Yalnızca %d edict kaldı! Toplam edict sayısı şu anda: %d/8192!",
	edictCritical = "Yalnızca %d edict kaldı! Toplam edict sayısı şu anda: %d/8192! Acil Temizlik Gereklidir!",
	entsPrintedInConsole = "Entity listesi konsolda yazdırıldı.",
	entityRemoved = "Entity %d (%s) kaldırıldı!",
	entityNotFound = "Entity %d bulunamadı/geçerli değil.",
	optPlayerDeathNotification = "Oyuncu Ölüm Bildirimi",
	optdPlayerDeathNotification = "Bir oyuncu öldüğünde bir sohbet mesajı gönderilip gönderilmeyeceği.",
	cmdRemovePersistedProps = "Çevrenizdeki belirli bir alanda kalıcı olan tüm nesneleri kaldırın."
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
