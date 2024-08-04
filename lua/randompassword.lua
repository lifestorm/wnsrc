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

local randomPassword = "wnt" .. tostring(math.random(1000, 9999))

RunConsoleCommand("sv_password", randomPassword)

sendMessage = "Sunucu şifresi güncellendi: **" .. randomPassword .. "**"

local discordWebhookUrl = "https://discord.com/api/webhooks/1178148118580166656/WLRygtgaBvY7itZWKUC2ucbsr03bjE2owsyVYPB3wLehMPAxxy5LPe2jQvID5288sWaN"
local messageData = {
    content = sendMessage
    -- If you want to send embeds or other complex data, add them here
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