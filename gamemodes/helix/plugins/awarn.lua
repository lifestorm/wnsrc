--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "AWarn3 Compat"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Adds AWarn 3 integration."

if (!AWarn) then return end

if (SERVER) then
    function PLUGIN:PlayerLoadedCharacter(client, character, lastChar)
        client:SetNetVar("AWarnWarnings", client:GetActiveWarnings())
    end

    function PLUGIN:AWarnPlayerWarned(client, aID, reason)
        client:SetNetVar("AWarnWarnings", client:GetActiveWarnings())
    end
    function PLUGIN:AWarnPlayerIDWarn(clientID, aID, reason)
        for _, v in ipairs(player.GetAll()) do
            if (v:SteamID64() == clientID) then
                return self:AwarnPlayerWarned(v, aID, reason)
            end
        end
    end
else
    function PLUGIN:GetPlayerESPText(client, toDraw, distance, alphaFar, alphaMid, alphaClose)
        if (client:GetNetVar("AWarnWarnings", 0) > 0) then
            toDraw[#toDraw + 1] = {alpha = alphaClose, priority = 29.5, text = "Warnings: "..client:GetNetVar("AWarnWarnings", 0)}
        end
    end
end