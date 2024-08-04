--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

hook.Add("eP:PostHTTP", "eP:HTTPLoggingHandeler", function(url, type)
    eProtect.logHTTP(url, type)
end)