--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


INFESTATION.name = "Xipe-Class Strain"
INFESTATION.color = Color(256, 128, 4)
INFESTATION.reading = {25, 50}
INFESTATION.chemical = "ic_cryogenic_liquid"

INFESTATION.OnHarvested = function(self, client, damageType)
	if (math.random(0, 10) > 5) then
		if (!client:GetCharacter():GetInventory():Add("ic_cluster_hive")) then
			ix.item.Spawn("ic_cluster_hive", client)
		end

		client:NotifyLocalized("xipeCollectSuccess")
	else
		client:NotifyLocalized("xipeCollectFailureLuck")
	end

	return true
end
