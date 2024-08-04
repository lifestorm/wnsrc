--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

//Find effects and stop their sounds
local function OnEffectRemove(effect)

	//Stop sounds
	if effect.Sound then
	effect.Sound:Stop()
	end

end

//Add hook
hook.Add("EntityRemoved", "EffectRemoveHook", OnEffectRemove)