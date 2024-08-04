--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- all increase and decrease variables represent the percentage (from 0 to 1).
-- "Increase" affects weapon behaviour when characters lacks the skill to use the gun
-- "Decrease" affects weapon behaviour when character exceeds minimum required skill to use the gun
--[[ Example:
	if you change "spreadMaxIncrease" to 1, then the spread of a gun will be 100% worse than the default one,
	and if you change "spreadMaxDecrease" to 1, then on the max skill level showed in guns range its spread will be 100% better than the default one
]]
PLUGIN.spreadMaxIncrease = 1
PLUGIN.spreadMaxDecrease = 0.5

PLUGIN.recoilMaxIncrease = 0.5
PLUGIN.recoilMaxDecrease = 0.5

if (CLIENT) then
	PLUGIN.swayDefault = 1 -- this variable changes guns default sway to the number at right, if gun has no sway by default. Changing this to 0 will result in no sway on guns, which doesn't have it

	PLUGIN.swayMaxIncrease = 1
	PLUGIN.swayMaxDecrease = 1
end
