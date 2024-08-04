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

local COMMAND = {}

COMMAND.description = "Définissez l'humeur de votre personnage."
COMMAND.arguments = {
	ix.type.string
}
COMMAND.argumentNames = {
	"Humeur [DEFAUT | DETENDU | TETU | EFFRAYE | FRUSTRE]"
}

function COMMAND:OnRun(client, mood)
	if (string.lower(mood) == "default") then
		client:SetNetVar("characterMood", nil)

		return "Yous avez réglé l'humeur de votre personnage sur 'Par défaut'."
	end

	if (!PLUGIN.personaTypes[string.upper(mood)]) then
		return "Vous devez spécifier une humeur valide !"
	end

	if (client:IsFemale()) then
		client:SetNetVar("characterMood", string.upper(mood) .. "F")
	else
		client:SetNetVar("characterMood", string.upper(mood))
	end

	local formattedString = string.upper(string.sub(mood, 1, 1)) .. string.lower(string.sub(mood, 2))

	return "Vous avez défini l'humeur de votre personnage sur '" .. formattedString .. "'." 
end

ix.command.Add("SetMood", COMMAND)
