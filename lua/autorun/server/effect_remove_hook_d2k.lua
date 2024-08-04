--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

//Global variable to inform Export To Lua addon that the core addon is installed
SpecialEffectsD2KIsInstalled = true


//Find effects and cut the sound they're making
local function OnEffectRemove_D2K(effect_d2k)

	//Stop sounds
	if effect_d2k.SFX_Sound then
	effect_d2k.SFX_Sound:Stop()
	end

end

//Add hook
hook.Add("EntityRemoved", "EffectRemoveHook_D2K", OnEffectRemove_D2K)