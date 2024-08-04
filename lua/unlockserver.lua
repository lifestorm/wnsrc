--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

require("chttp")

RunConsoleCommand("sv_password", "")

local discordWebhookUrl = "https://discord.com/api/webhooks/1178160382720876575/2H_nk_VxYHoz5B47MLVC_-VavAnqsBBOBF0HoN7vWzYnGALvZsbXfjkyUFfcTlct5Cny"
local messageData = {
    content = "@everyone",
    -- create a list
    embeds = {
        -- create a table
        {
            -- set the title
            title = "✅ Sunucu Aktif!",
            -- set the description
            description = "Rollere katılımınızı bekliyoruz!\n\n**Girmek için konsola yapıştırın:**\n`connect hl2rp.willard.network:27081`\n\n[Workshop Linki](https://steamcommunity.com/sharedfiles/filedetails/?id=3028452353)",
            -- set the color
            color = 65300
        }
    }
}

local jsonData = util.TableToJSON(messageData) -- Serialize the table to JSON

CHTTP( {
	failed = function( reason )
		print( "HTTP request failed", reason )
	end,
	success = function( code, body, headers )
		print( "HTTP request succeeded", code, body, headers )
	end,
	method = "POST",
	url = discordWebhookUrl,
    type = "application/json",
    body = jsonData
} )