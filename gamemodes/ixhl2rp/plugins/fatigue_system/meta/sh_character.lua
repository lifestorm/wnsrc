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
local charMeta = ix.meta.character

function charMeta:IsAffectedByFatigue()
	return PLUGIN.noFatigueFactions[self:GetFaction()] != true
end

function charMeta:GetActionTimeInfluencedByEnergyLevel(time)
	if (!self:IsAffectedByFatigue()) then
		return time
	end

	local charEnergy = self:GetEnergy()
	local energyLevelToApplyDebuffs = ix.config.Get("energyLevelToApplyDebuffs", 50)

	if (charEnergy < energyLevelToApplyDebuffs) then
		local energyMaxActionSpeedDebuff = ix.config.Get("energyMaxActionSpeedDebuff", 50) / 100

		return math.ceil(time + (energyMaxActionSpeedDebuff * (1 - charEnergy / energyLevelToApplyDebuffs)))
	elseif (charEnergy > 100) then
		local energyMaxActionSpeedBuff = ix.config.Get("energyMaxActionSpeedBuff", 50) / 100

		return math.floor(time - (time * energyMaxActionSpeedBuff))
	end

	return time
end
