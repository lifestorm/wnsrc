--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

util.AddNetworkString("ixVoiceMenu")

function PLUGIN:InitializedPlugins()
    RunConsoleCommand("mp_show_voice_icons", "0")
end

function PLUGIN:PlayerSpawn(client)
    client:SetNetVar("voiceRange", 2)
end

/*
function PLUGIN:ShowSpare1(client)
    if (client:GetCharacter()) then
        netstream.Start(client, "ixVoiceMenu")
    end
end
*/