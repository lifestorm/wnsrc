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
PLUGIN.name = "Show Genetic Description"
PLUGIN.author = "M!NT"
PLUGIN.description = "Adds /showgendesc command that will show the genetic description of the targeted character"

ix.command.Add("ShowGenDesc", {
    description = "Show the genetic description of the player you are looking at",
	OnRun = function(self, client)
        local target = client:GetEyeTraceNoCursor().Entity
        if (!IsValid(target) or !target:IsPlayer()) then
            client:NotifyLocalized("You're not looking at a valid player :(")
        else
	        local targetchar = target:GetCharacter()
            local text =
            "AGE: "..string.lower(targetchar:GetAge())..
            " HEIGHT: "..string.lower(targetchar:GetHeight())..
            " EYES: "..string.lower(targetchar:GetEyeColor())
            net.Start("OnShowGeneticDescription")
                net.WriteString(text)
            net.Send(client)
        end
	end,
    bNoIndicator = true
})

if (CLIENT) then
    net.Receive("OnShowGeneticDescription", function()
        local text = net.ReadString()
        chat.AddText(Color(255,255,255), text)
    end)
else
    util.AddNetworkString("OnShowGeneticDescription")
end