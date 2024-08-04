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

PLUGIN.name = "Ammo Limit"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = "Limit how much ammo can be loaded from ammo boxes."

ix.lang.AddTable("english", {
	ammoLimitReached = "You have reached the equipped ammo limit!"
})

ix.config.Add("ammoBoxLimit", 4, "The maximum amount of ammo boxes someone is allowed to equip", nil, {
	data = {min = 0, max = 10, decimals = 1},
	category = "Other"
})

function PLUGIN:CanPlayerInteractItem(client, action, item, data)
	if (isentity(item)) then
		if (IsValid(item)) then
			item = ix.item.instances[item.ixItemID]
		else
			return
		end
	elseif (isnumber(item)) then
		item = ix.item.instances[item]
	end

	if (!item) then return end
	if (action == "use" and item.ammo and item.ammoAmount and client:GetAmmoCount(item.ammo) >= item.ammoAmount * ix.config.Get("ammoBoxLimit")) then
		client:NotifyLocalized("ammoLimitReached")
		return false
	end
end