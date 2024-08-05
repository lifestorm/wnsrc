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
local CAMI = CAMI
local player_manager = player_manager
local LocalPlayer = LocalPlayer
local bit = bit
local string = string
local SetNetVar = SetNetVar
local net = net
local pairs = pairs

local PLUGIN = PLUGIN

PLUGIN.name = "Combine Suits"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Adds combine suits and visual stuff."

ix.util.Include("meta/sh_player.lua")
ix.util.Include("meta/sh_character.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

ix.char.RegisterVar("passiveSCProgress", {
	field = "passiveSCProgress",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true
})

ix.config.Add("passiveStcTimer", 60, "How often, in minutes, CPs should receive STC. Set to 0 to disable.", nil, {
	data = {min = 0, max = 300}
})

ix.config.Add("suitsNoConnection", false, "Disable some features on Combine suits that require connection to OCIN.", function(oldVal, newVal)
		if (!SERVER) then return end
		if (newVal) then
			SetNetVar("visorStatus", "OFFLINE")
			SetNetVar("visorColor", "red")
			SetNetVar("visorText", PLUGIN.visorStatus.offline[1])
		else
			SetNetVar("visorStatus", "blue")
			SetNetVar("visorColor", "blue")
			SetNetVar("visorText", PLUGIN.visorStatus.blue[1])
		end
	end, {
	category = "Miscellaneous"
})

CAMI.RegisterPrivilege({
	Name = "Helix - Combine Suit Admin Control",
	MinAccess = "superadmin"
})

ix.lang.AddTable("english", {
    optNewCPOverlayEnabled = "Enable New CP Overlay",
    optdNewCPOverlayEnabled = "Allows you to chose between the legacy CP overlay, or the new WN CP overlay.",
    optCPGUIEnabled = "Enable CP GUI",
    optdCPGUIEnabled = "Allows you to enable or disable the CP GUI",
    optCPGUIAlpha = "CP GUI Alpha",
    optdCPGUIAlpha = "Set the alpha (transparancy) of the CP GUI.",
	optChatterEnabled = "Chatter Enable",
	optChatterInterval = "Chatter Interval",
	optdChatterEnabled = "Turn on and off your CP character emitting radio chatter at a given interval",
	optdChatterInterval = "How often your character should emit chatter",
	optVoiceToggle = "Game Voice Toggle",
	optdVoiceToggle = "Switch between HL2 or HLA voices",
	optOTAESP = "OTA ESP Enable",
	optdOTAESP = "Enable or disable the OTA ESP highlighting friendly units",
	unitOnDuty = "Unit %s on duty",
	unitOffDuty = "Unit %s off duty",
	unitPromotedPTLead = "Unit %s promoted to lead of PT-%d",
	ptEnteredArea = "PT-%d relocated to vector '%s'",
	unitEnteredArea = "Unit %s entering vector '%s'",
	unitCompromised = "WARNING! UNIT %s ANONIMITY COMPROMISED",
	nexus = "Nexus",
	suitBiosignalMistmach = "%s SUIT BIOSIGNAL MISMATCH",
	suitDeactivated = "%s their suit is now deactivated.",
	suitNoValidFound = "No suit found to deactivate.",
	suitDeactivateNotif = "SUIT DEACTIVATED FOR %s",
	suitDisableTracker = "This suit's tracker is still active! If not disabled, CP's WILL get alerted everytime this suit is equipped.",
	visorInvalidColor = "That is not a valid visor color!",
	visorInvalidCode = "That is not a valid visor code!",
	optCombineHud = "Enable Combine HUD",
	optdCombineHud = "Whether the Combine Heads-Up-Display should be enabled."
})

ix.lang.AddTable("spanish", {
	optNewCPOverlayEnabled = "Habilitar la nueva interfaz de PC",
	unitPromotedPTLead = "Unidad %s ascendida a líder de escuadron-%d",
	unitOnDuty = "Unidad %s de servicio",
	nexus = "Nexo",
	suitDeactivateNotif = "TRAJE DESACTIVADO PARA %s",
	suitDeactivated = "%s su traje está ahora desactivado.",
	suitNoValidFound = "No se ha encontrado ningún traje para desactivar.",
	optdNewCPOverlayEnabled = "Le permite elegir entre la interfaz de CPC clásica o la nueva interfaz de CPC de Willard Networks.",
	unitOffDuty = "Unidad %s fuera de servicio",
	unitCompromised = "¡ADVERTENCIA! UNIDAD %s ANONIMIDAD COMPROMETIDA",
	suitDisableTracker = "El rastreador de este traje sigue activo. Si no se desactiva, la CPC recibirá una alerta cada vez que se equipe este traje.",
	optCPGUIEnabled = "Habilitar la GUI de CPC",
	optdCPGUIEnabled = "Permite activar o desactivar la UI del CPC",
	optdChatterInterval = "Frecuencia con la que tu personaje emite sonidos de radio",
	suitBiosignalMistmach = "DISCORDANCIA EN LA BIOSEÑAL %s",
	optdChatterEnabled = "Activa o desactiva que tu Unidad de Protección Civil emita transmisiones de radio en un intervalo establecido",
	optVoiceToggle = "Alternar voz del juego",
	optdVoiceToggle = "Cambiar entre voces HL2 o HLA",
	optCPGUIAlpha = "Canal Alpha del IU de PC",
	optdOTAESP = "Activa o desactiva el ESP de la OTA destacando a las unidades aliadas",
	optOTAESP = "Activar ESP de la OTA",
	optdCPGUIAlpha = "Establece el canal Alfa (Transparencia) de la IU de PC.",
	ptEnteredArea = "EP-%d relocalizado al vector '%s'",
	optChatterInterval = "Intervalos de Charla",
	optChatterEnabled = "Activar Charla",
	unitEnteredArea = "Unidad %s entrando en el vector '%s'"
})

-- Hand fixes by M!NT
for i = 1, 9 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice/male_0"..i..".mdl")
end
for i = 1, 7 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice/female_0"..i..".mdl")
end
for i = 1, 9 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice_c8/male_0"..i..".mdl")
end
for i = 1, 7 do
	player_manager.AddValidModel("CPModel", "models/wn7new/metropolice_c8/female_0"..i..".mdl")
end
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/ordinal.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/soldier.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/suppressor.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/charger.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_commander.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_elite.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_elite_summit.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_shotgunner.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_soldier.mdl")
player_manager.AddValidModel("CPModel", "models/combine_super_soldier.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ota_skylegion.mdl")
player_manager.AddValidModel("CPModel", "models/wn/ordinal.mdl")
player_manager.AddValidModel("CPModel", "models/willardnetworks/combine/antibody.mdl")

player_manager.AddValidHands("CPModel", "models/weapons/c_arms_combine.mdl", 0, "00000000")

PLUGIN.ranks = {
    [1] = "RCT",
    [2] = "i5",
	[3] = "i4",
	[4] = "i3",
	[5] = "i2",
	[6] = "i1",
	[7] = "RL",
	[8] = "CpT",
	[9] = "ChF",
    [10] = false,
    [11] = "OWS",
    [12] = "ORD",
    [13] = "EOW",
    [14] = false,
    [15] = "SCN",
    [16] = "Disp:AI",
    [17] = "OCIN:AI"
}

PLUGIN.visorStatus = {
	blue = {"SOCIO-STABILIZATION INTACT", "blue"},
	yellow = {"SOCIO-STABILIZATION MARGINAL", "yellow"},
	orange = {"SOCIO-STABILIZATION CRITICAL", "orange"},
	unrest = {"SOCIO-STABILIZATION CRITICAL. UNREST CODE IN EFFECT", "orange"},
	red = {"SOCIO-STABILIZATION FRACTURED.", "red"},
	jw = {"SOCIO-STABILIZATION FRACTURED. JUDGEMENT WAIVER IN EFFECT", "red"},
	black = {"SOCIO-STABILIZATION LOST. CODE SACRIFICE IN EFFECT. REGAIN CONTROL IMMEDIATELY.", "white"},
	ajw = {"SOCIO-STABILIZATION LOST. AUTONOMOUS JUDGEMENT IN EFFECT", "white"},
	totalr = {"TOTAL RENDITION. SYNTHETIC DEPLOYMENT AUTHORISED. EVACUATE", "white"},
	offline = {"FAILED TO ESTABLISH SECURE OCIN UPLINK", "red"}
}

ix.option.Add("CPGUIAlpha", ix.type.number, 60, {
    category = "civilprot",
    hidden = function()
        return !ix.faction.Get(LocalPlayer():Team()).isCombineFaction and !LocalPlayer():HasActiveCombineSuit()
    end,
    min = 0,
    max = 100
})

ix.option.Add("OTAESP", ix.type.bool, true, {
	bNetworked = true,
	hidden = function()
		return !ix.faction.Get(LocalPlayer():Team()).isCombineFaction and !LocalPlayer():HasActiveCombineSuit()
	end,
	category = "civilprot"
})

ix.option.Add("CombineHud", ix.type.bool, true, {
	bNetworked = true,
	hidden = function()
		return !ix.faction.Get(LocalPlayer():Team()).isCombineFaction and !LocalPlayer():HasActiveCombineSuit()
	end,
	category = "civilprot"
})

ix.option.Add("ChatterEnabled", ix.type.bool, true, {
	bNetworked = true,
	hidden = function()
		return !ix.faction.Get(LocalPlayer():Team()).isCombineFaction and !LocalPlayer():HasActiveCombineSuit()
	end,
	category = "civilprot"
})
ix.option.Add("ChatterInterval", ix.type.number, 120, {
	bNetworked = true,
	hidden = function()
		return !ix.faction.Get(LocalPlayer():Team()).isCombineFaction and !LocalPlayer():HasActiveCombineSuit()
	end,
	category = "civilprot",
	min = 120,
	max = 600
})
ix.option.Add("VoiceToggle", ix.type.bool, true, {
	bNetworked = true,
	hidden = function()
		return !ix.faction.Get(LocalPlayer():Team()).isCombineFaction and !LocalPlayer():HasActiveCombineSuit()
	end,
	category = "civilprot"
})

ix.char.RegisterVar("combineSuit", {
	default = 0,
	bNoDisplay = true,
})

ix.command.Add("VisorStatus", {
	description = "Notify all combine factions\nPreset: <string Code (blue, yellow, orange, unrest, red, jw, black, totalr)>\nCustom: <string Color (blue, yellow, orange, red, black)> <string CustomText>.",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.text, ix.type.optional)
	},
	OnCheckAccess = function(self, client)
		if (ix.config.Get("suitsNoConnection")) then return false end

		return (client:HasActiveCombineSuit() and client:IsCombineRankAbove("i1") and client:GetActiveCombineSuit().isCP) or client:IsDispatch()
	end,
	OnRun = function(self, client, color, text)
        color = string.utf8lower(color)

		if (text and text != "") then
			if (!Schema.colors[color]) then
				client:NotifyLocalized("visorInvalidColor", color)
				return
			end

			ix.combineNotify:AddImportantNotification("WRN:// Socio-Status updated to " .. string.utf8upper(text) .. " by " .. client:GetCombineTag(), Schema.colors[color])

			SetNetVar("visorStatus", color)
			SetNetVar("visorColor", color)
			SetNetVar("visorText", string.utf8upper(text))
		else
			if (!PLUGIN.visorStatus[color]) then
				client:NotifyLocalized("visorInvalidCode", color)
				return
			end

			ix.combineNotify:AddImportantNotification("WRN:// Socio-Status updated to " .. string.utf8upper(color) .. " by " .. client:GetCombineTag(), Schema.colors[PLUGIN.visorStatus[color][2]])

			SetNetVar("visorColor", PLUGIN.visorStatus[color][2])
			SetNetVar("visorText", PLUGIN.visorStatus[color][1])
			if color == "totalr" then
				color = "total rendition"
			elseif color == "jw" then
				color = "judgement waiver"
			end
			SetNetVar("visorStatus", color)
		end

		if (color == "blue") then
			net.Start("ixVisorNotify")
			net.Broadcast()
		end
	end
})

ix.command.Add("SuitDeactivate", {
	description = "Remotely deactivates someone's Combine Suit.",
	arguments = {
		ix.type.character,
	},
	OnCheckAccess = function(self, client)
		return (client:HasActiveCombineSuit() and client:IsCombineRankAbove("RL") and client:GetActiveCombineSuit().isCP) or client:IsDispatch()
	end,
	OnRun = function(self, client, character)
        local items = character:GetInventory():GetItems()
		local found = false

		for _, v in pairs(items) do
			if ((v.isCP or v.isOTA) and v:GetData("suitActive") and v:GetData("ownerID") == character:GetID()) then
				v:SetData("suitActive", false)
				found = v
			end
		end

		if (found) then
			client:NotifyLocalized("suitDeactivated", found:GetData("ownerName"))
			ix.combineNotify:AddImportantNotification("WRN:// Suit De-Activated for " .. found:GetData("ownerName", "UNKNOWN"), nil, found:GetData("trackingActive") and client, found:GetData("trackingActive") and client:GetPos(), nil)
		else
			client:NotifyLocalized("suitNoValidFound")
		end
	end
})
