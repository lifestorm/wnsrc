--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Allows to reset
if _STORMFOX_POSTENTITY then
	timer.Simple(2, function()
		hook.Run("StormFox2.InitPostEntity")
	end)
end

hook.Add("InitPostEntity", "SF_PostEntity", function()
	hook.Run("StormFox2.InitPostEntity")
	_STORMFOX_POSTENTITY = true
end)