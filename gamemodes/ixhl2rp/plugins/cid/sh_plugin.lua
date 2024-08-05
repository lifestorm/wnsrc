--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local CAMI = CAMI
local ix = ix
local IsValid = IsValid
local net = net
local tonumber = tonumber
local Color = Color
local chat = chat
local string = string

local PLUGIN = PLUGIN

PLUGIN.name = "CID"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Adds identification cards and credits as digital currency."

CAMI.RegisterPrivilege({
	Name = "Helix - Set Credits",
	MinAccess = "superadmin"
})

ix.config.Add("creditsNoConnection", false, "Disable the use of credits in some situations, simulating the connection to the Combine network being down.", nil, {
	category = "Miscellaneous"
})

ix.config.Add("requestDeviceAction", "just used request device.", "The action that should be sent after someone uses request device.", nil, {
	category = "Miscellaneous"
})

ix.char.RegisterVar("cid", {
	field = "cid",
	fieldType = ix.type.string,
	default = nil,
	bNoDisplay = true
})

ix.char.RegisterVar("idCardBackup", {
	field = "idCardBackup",
	default = {},
	bNoDisplay = true,
	bNoNetworking = true
})

ix.char.RegisterVar("idCard", {
	field = "idcard",
	fieldType = ix.type.number,
	default = nil,
	bNoDisplay = true,
	OnSet = function(self, value)
		local client = self:GetPlayer()

		if (IsValid(client)) then
			self.vars.idCard = value

			net.Start("ixCharacterVarChanged")
				net.WriteUInt(self:GetID(), 32)
				net.WriteString("idCard")
				net.WriteType(self.vars.idCard)
			net.Broadcast()
		end
	end,
	OnGet = function(self, default)
		local idCard = self.vars.idCard

		return tonumber(idCard) or 0
	end,
	OnAdjust = function(self, client, data, value, newData)
		newData.idCard = value
	end
})

ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_commands.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_net.lua")
ix.util.Include("sv_plugin.lua")

ix.lang.AddTable("english", {
	cmdCharSetCredits = "Set a character's Credits.",
	cmdCharGiveCredits = "Give a character Credits.",
	cmdRequest = "Make a request for assistance to Civil Protection. Will use a ID card-bound request device from your inventory.",

	setCredits = "You have set %s's credits to %s.",
	giveCredits = "You have given %s %s credits.",

	scanning = "Scanning...",
	idNotFound = "ERROR: Biological signature not found.",
	idNoBlank = "ERROR: No blank card inserted.",
	idCardAdded = "SUCCESS: ID Card created.",
	idCardRecreated = "SUCCESS: ID Card recreated.",
	idNotAllowed = "Device does not respond when you try to use it.",

	posBound = "SUCCESS: POS terminal bound to the specified ID Card.",
	posBoundInactiveCard = "ERROR: ID Card is no longer active. Please dispose of inactive card immediately.",

	posRequestSent = "INFO: Performing credit transaction...",
	posRequestExecuting = "INFO: Executing transaction... please wait...",
	posTransactionSuccess = "SUCCESS: Transaction complete.",
	posError = "ERROR: Unexpected error occurred. Transaction was terminated.",
	posBoundCardNotActive = "ERROR: Bound ID Card no longer active. Please dispose of inactive card immediately.",
	posCardNotActive = "ERROR: Used ID Card no longer active. Please dispose of inactive card immediately.",
	posTransOngoing = "%s tried to start a new transaction, but you are still finishing another transaction.",
	posTransExpired = "Your transaction has expired.",
	posTransactionRefused = "Your POS transaction was refused or timed out.",

	numNotValid = "You specified invalid amount of credits!",
	reasonNotValid = "You specified an invalid reason for the transaction!",
	transactionNoMoney = "ERROR: Insufficient credits.",
	transactionOwnChars = "ERROR: You cannot transfer credits between your own characters!",
	transactionSelf = "ERROR: You cannot transfer credits to yourself!",

	rdBound = "SUCCESS: Request Device successfully bound to the specified ID Card.",
	rdError = "ERROR: Unexpected error occurred. Please find a Civil Protection officer to file your request manually.",
	rdMoreThanOne = "You have more than one bound request device, please select in your inventory which one you want to use.",
	rdNoRD = "You do not have a request device, or it is not bound to an ID card!",
	rdFreqLimit = "Please wait at least 10 seconds between requests.",

	cwuBound = "SUCCESS: CWU Card successfully bound to the specified ID Card.",
	dobBound = "SUCCESS: DOB Card successfully bound to the specified ID Card.",
	cmruBound = "SUCCESS: CMRU Card successfully bound to the specified ID Card.",
	conBound = "SUCCESS: CCR Card successfully bound to the specified ID Card.",

	targetTransactionInProgress = "This person already has a transaction in progress!",

	idCardIssued = "New identity card issued for %s by %s",

	errorNoConnection = "ERROR: NO CONNECTION"
})

ix.lang.AddTable("spanish", {
	posBoundCardNotActive = "ERROR: La tarjeta ID vinculada ya no está activa. Por favor, deshágase de la tarjeta inactiva inmediatamente.",
	posTransExpired = "Tu transacción ha caducado.",
	posTransactionSuccess = "ÉXITO: Transacción completada.",
	posTransOngoing = "%s ha intentado iniciar una nueva transacción, pero todavía estás terminando otra transacción.",
	posRequestExecuting = "INFO: Ejecutando la transacción... por favor espere...",
	numNotValid = "¡Has especificado una cantidad de créditos inválida!",
	posError = "ERROR: Se ha producido un error inesperado. La transacción ha finalizado.",
	posCardNotActive = "ERROR: La tarjeta ID vinculada ya no está activa. Por favor, deshágase de la tarjeta inactiva inmediatamente.",
	reasonNotValid = "¡Has especificado un motivo no válido para la transacción!",
	transactionOwnChars = "ERROR: ¡No puedes transferir créditos entre tus propios personajes!",
	transactionNoMoney = "ERROR: Créditos insuficientes.",
	targetTransactionInProgress = "¡Esta persona ya tiene una transacción en curso!",
	transactionSelf = "ERROR: ¡No puedes transferirte créditos a ti mismo!",
	rdError = "ERROR: Se ha producido un error inesperado. Por favor, busque a un agente de Protección Civil para presentar tu solicitud manualmente.",
	giveCredits = "Has dado %s %s créditos.",
	scanning = "Escaneando...",
	cmdCharSetCredits = "Establecer los créditos de un personaje.",
	cmdCharGiveCredits = "Dar créditos a un personaje.",
	posTransactionRefused = "Su transacción en del datafono ha sido rechazada o ha expirado.",
	idNoBlank = "ERROR: No se ha insertado ninguna tarjeta en blanco.",
	posBoundInactiveCard = "ERROR: La tarjeta de identificación ya no está activa. Por favor, deshágase de la tarjeta inactiva inmediatamente.",
	rdNoRD = "¡No tiene un dispositivo de socorro, o no está vinculado a una tarjeta de identificación!",
	idCardAdded = "ÉXITO: Tarjeta de identificación creada.",
	posRequestSent = "INFO: Realizando una transacción de crédito...",
	idCardRecreated = "ÉXITO: Tarjeta de identificación recreada.",
	posBound = "ÉXITO: El datafono está vinculado a la tarjeta de identificación especificada.",
	idNotAllowed = "El dispositivo no responde cuando intentas utilizarlo.",
	idNotFound = "ERROR: Señal Biológica no encontrada.",
	rdMoreThanOne = "Tienes más de un dispositivo de socorro vinculado, por favor selecciona en tu inventario cuál quieres usar.",
	rdFreqLimit = "Por favor, espere al menos 10 segundos entre peticiones.",
	cmdRequest = "Realiza una solicitud de ayuda a Protección Civil. Utilizará un dispositivo de socorro vinculado a una tarjeta de identificación de tu inventario.",
	rdBound = "ÉXITO: El dispositivo de socorro se ha vinculado con éxito a la tarjeta de identificación especificada.",
	setCredits = "Los créditos de %s han sido establecidos a %s.",
	cwuBound = "ÉXITO: Tarjeta UTC vinculada con éxito a la tarjeta ID especificada.",
	idCardIssued = "Nuevo documento de identidad emitido para %s por %s"
})

do
	local CLASS = {}
	CLASS.color = Color(175, 125, 100)
	CLASS.format = "%s, #%s requests %s\"%s\""
	CLASS.formatCP = "%s requests %s\"%s\""

	function CLASS:CanHear(speaker, listener, data)
		if data.otherListeners and data.otherListeners[listener] then return true end
		return listener == speaker or listener:HasActiveCombineSuit() or ix.faction.Get(listener:Team()).canHearRequests == true
	end

	local requestTypes = {
		[REQUEST_CP] = "CP",
		[REQUEST_MED] = "CMRU",
		[REQUEST_WORK] = "CWU"
	}

	function CLASS:OnChatAdd(speaker, text, aonymous, data)
		local requestType = ""

		if (data.requestType) then
			requestType = requestTypes[data.requestType].." "
		end

		if (speaker:IsCombine()) then
			chat.AddText(self.color, string.format(self.formatCP, "Protection Unit", requestType, text))
		else
			chat.AddText(self.color, string.format(self.format, data.name, data.cid, requestType, text))
		end
	end

	ix.chat.Register("request", CLASS)
end
