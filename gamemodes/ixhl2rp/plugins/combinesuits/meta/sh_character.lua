--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local characterMeta = ix.meta.character

function characterMeta:IsCombine()
	local faction = ix.faction.Get(self:GetFaction())
	local client = self:GetPlayer()

	if (faction and faction.isCombineFaction) then
		return true
	else
		local suit = client:GetActiveCombineSuit()
		
		if (suit and (suit:GetData("ownerID") == self:GetID() or !suit:GetData("trackingActive"))) then
			return true
		end
	end
end
