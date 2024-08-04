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
local math = math
local ix = ix

local PLUGIN = PLUGIN

PLUGIN.name = "Better Gas"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "An improved gas zone system, aiming to facilitate roleplay both in and out of gas zones."

PLUGIN.TIMER_INTERVAL = 10
PLUGIN.LETHAL_GAS = 120
PLUGIN.GAS_DEATH = 180
PLUGIN.GAS_COOLDOWN_DELAY = 30
PLUGIN.GAS_DECREASE_DELAY = 2

ix.config.Add("gasPermakill", false, "Que le permakill du gaz soit activé ou non.", nil, {
	category = "Permakill"
})
ix.config.Add("gasPointGainScale", 1, "Combien de gaz supplémentaire tous les personnages gagnent lorsqu'ils se trouvent à l'intérieur d'une zone de gaz. Cela n'a pas d'incidence sur les filtres. 1 => 1 minute = 1 point gaz, 2 => 1 minute = 2 points gaz, 0,5 => 1 minute = 0,5 points gaz", nil, {
	data = {min = 0, max = 5, decimals = 2},
	category = "Zones"
})
ix.config.Add("gasPointRecoveryPenalty", 1, "Combien de temps tous les personnages doivent récupérer du gaz. 1 = même vitesse, 2 = deux fois plus lent, 0,5 = deux fois plus long", nil, {
	data = {min = 0, max = 5, decimals = 2},
	category = "Zones"
})

ix.config.Add("gasPointInjuryScale", 1, "Combien les personnages blessés par le gaz supplémentaires gagnent lorsqu'ils se trouvent dans une zone de gaz. L'effet est appliqué progressivement. Le nombre indiqué est le «but» à 1 ch. 1 = même vitesse que 100 ch, 2 = deux fois plus rapide, 0,5 = moitié moins longtemps", nil, {
	data = {min = 0, max = 5, decimals = 2},
	category = "Zones"
})

ix.config.Add("gasPointInjuryRecoveryPenalty", 1, "Combien de temps les personnages blessés doivent récupérer du gaz. L'effet est appliqué progressivement. Le nombre indiqué est le «but» à 1 ch. 1 = même vitesse que 100 ch, 2 = deux fois plus lent, 0,5 = deux fois plus long", nil, {
	data = {min = 0, max = 5, decimals = 2},
	category = "Zones"
})
ix.config.Add("gasReverseZones", false, "Make the gas active everywhere on the map, except within gas areas.", nil, {
	category = "Areas"
})

ix.lang.AddTable("english", {
	gasDeathNotif = "%s was killed by gas.",
	gasLethal = "LETHAL POISON LEVELS",
	gasHigh = "HIGH POISON LEVELS",
	optGasNotificationWarnings = "Gas Notification Warnings",
	optdGasNotificationWarnings = "Get warning notifications when entering gas and when reaching high levels of gas.",
	gasCDStart = "You have been out of the sewers long enough for your poison levels to keep slowly decreasing while you are offline or on another character.",
	gasEntered = "The air smells bad here, it makes you sick. It is better if you do not stay for too long.",
	gasHighNotif = "The air is starting to weigh heavy on you and your body tingles strangely. How much longer can you keep this up?",
	gasNearLethalNotif = "Breathing becomes hard, you feel confused, and you are so tired. Leave while you still can, death is around the corner.",
	gasLethalNotif = "As every step becomes a challenge, somewhere deep down you can feel it: you stayed too long and pushed your body too far. There is no coming back anymore, only death awaits you.",
	gasLethalNotifOOC = "OOC Note: you have reached lethal amounts of poison. There is no cure or fix for this. You are allowed some time to roleplay your character's death as you enter septic shock.",
	filterOut = "Your filter has run out.",
	filterDecay = "Your filter is starting to decay, it will run out soon."
})

ix.lang.AddTable("french", {
	gasDeathNotif = "%s a été tué par du gaz.",
	gasLethal = "NIVEAUX DE POISON MORTEL",
	gasHigh = "NIVEAUX ÉLEVÉS DE POISON",
	optGasNotificationWarnings = "Avertissements de notification de gaz",
	optdGasNotificationWarnings = "Recevez des notifications d'avertissement lorsque vous entrez dans le gaz et lorsque vous atteignez des niveaux élevés de gaz.",
	gasCDStart = "Vous êtes sorti des égouts assez longtemps pour que vos niveaux de poison continuent de diminuer lentement lorsque vous êtes hors ligne ou sur un autre personnage.",
	gasEntered = "L'air sent mauvais ici, ça rend malade. C'est mieux si vous ne restez pas trop longtemps.",
	gasHighNotif = "L'air commence à peser lourd sur vous et votre corps picote étrangement. Combien de temps pouvez-vous continuer ainsi ?",
	gasNearLethalNotif = "La respiration devient difficile, vous vous sentez confus et vous êtes tellement fatigué. Partez pendant que vous le pouvez encore, la mort est au coin de la rue.",
	gasLethalNotif = "Comme chaque pas devient un défi, quelque part au fond de vous, vous pouvez le sentir : vous êtes resté trop longtemps et avez poussé votre corps trop loin. Il n'y a plus de retour, seule la mort vous attend.",
	gasLethalNotifOOC = "Remarque OOC : Vous avez atteint des quantités mortelles de poison. Il n'y a pas de remède ou de solution pour cela. Vous disposez d'un certain temps pour interpréter la mort de votre personnage lorsque vous entrerez dans un choc sceptique.",
	filterOut = "Votre filtre est épuisé.",
	filterDecay = "Votre filtre commence à se détériorer, il va bientôt s'épuiser."
})

ix.lang.AddTable("spanish", {
	gasLethal = "NIVELES DE VENENO LETAL",
	optdGasNotificationWarnings = "Obtenga notificaciones de advertencia cuando entre gas y cuando alcance niveles altos de gas.",
	optGasNotificationWarnings = "Avisos de peligro gas",
	gasDeathNotif = "%s fue asesinado por el gas.",
	gasHigh = "ALTOS NIVELES DE VENENO",
	gasLethalNotifOOC = "Nota OOC: has alcanzado cantidades letales de veneno. No hay cura o arreglo para ello. Se te permite un tiempo para rolear la muerte de tu personaje mientras entras en shock séptico.",
	gasCDStart = "Has estado fuera de las alcantarillas el tiempo suficiente para que tus niveles de veneno sigan disminuyendo lentamente mientras estás desconectado o con otro personaje.",
	gasLethalNotif = "A medida que cada paso se convierte en un desafío, en algún lugar de tu interior puedes sentirlo: Te has quedado mucho tiempo y has forzado tu cuerpo demasiado lejos. Ya no hay vuelta atrás, sólo te espera la muerte.",
	gasNearLethalNotif = "Respiras con dificultad, te sientes confuso y estás muy cansado. Vete mientras puedas, la muerte está a la vuelta de la esquina.",
	gasEntered = "El aire huele mal aquí, te pone enfermo. Es mejor no quedarse mucho tiempo.",
	gasHighNotif = "El aire empieza a pesarte y tu cuerpo siente un extraño cosquilleo. ¿Cuánto tiempo más podrás seguir así?",
	filterOut = "Tu filtro se ha agotado.",
	filterDecay = "Tu filtro está empezando a deteriorarse, se agotará pronto."
})

ix.option.Add("gasNotificationWarnings", ix.type.bool, true, {
	bNetworked = true,
	category = "Notices"
})


CAMI.RegisterPrivilege({
	Name = "Helix - Manage Gas",
	MinAccess = "admin"
})

do
	local a, b, c = 50, 1.04, 49
	local gasToCooldown = {b}
	PLUGIN.gasToCooldown = gasToCooldown

	for i = 2, PLUGIN.LETHAL_GAS do
		gasToCooldown[i] = gasToCooldown[i - 1] * b
		gasToCooldown[i - 1] = (gasToCooldown[i - 1] * a) - c
	end
	gasToCooldown[0] = a - c
	gasToCooldown[PLUGIN.LETHAL_GAS] = (gasToCooldown[PLUGIN.LETHAL_GAS] * a) - c
end

ix.util.Include("meta/sh_player.lua")
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")

-- Accumalated gas points
ix.char.RegisterVar("gasPoints", {
	field = "gas_points",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
})

-- Detection for when the player left a gas area
ix.char.RegisterVar("gasCooldownPoints", {
	field = "gas_cd_points",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
    bNoNetworking = true
})

-- Time when player left character with enough points for gas cooldown
ix.char.RegisterVar("gasCooldownStart", {
	field = "gas_cd_start",
	fieldType = ix.type.number,
	default = 0,
	bNoDisplay = true,
    bNoNetworking = true
})

ix.char.RegisterVar("filterItem", {
	default = 0,
	bNoDisplay = true,
	isLocal = true,
})

ix.command.Add("CharSetGasPoints", {
	description = "Set character's gas points (1 point = 1 minute in gas; more than "..PLUGIN.LETHAL_GAS.." = lethal; between 0 and "..PLUGIN.GAS_DEATH..")",
	arguments = {
		ix.type.character,
		ix.type.number
	},
	privilege = "Manage Gas",
	OnRun = function(self, client, character, amount)
		character:SetGasPoints(math.Clamp(amount, 0, PLUGIN.GAS_DEATH))
		client:Notify(character:GetName().."'s gas points were set to "..math.Clamp(amount, 0, PLUGIN.GAS_DEATH))
	end
})