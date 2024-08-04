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

COMMAND.description = "Set your character's mood."
COMMAND.arguments = {
	ix.type.string
}
COMMAND.argumentNames = {
	"Mood [Default | Relaxed | Headstrong | Scared | Frustrated]"
}

function COMMAND:OnRun(client, mood)
	if (string.lower(mood) == "default") then
		client:SetNetVar("characterMood", nil)

		return "You have set your character's mood to 'Default'."
	end

	if (!PLUGIN.personaTypes[string.upper(mood)]) then
		return "You must specify a valid mood!"
	end

	if (client:IsFemale()) then
		client:SetNetVar("characterMood", string.upper(mood) .. "F")
	else
		client:SetNetVar("characterMood", string.upper(mood))
	end

	local formattedString = string.upper(string.sub(mood, 1, 1)) .. string.lower(string.sub(mood, 2))

	return "You have set your character's mood to '" .. formattedString .. "'." 
end

ix.command.Add("SetMood", COMMAND)
