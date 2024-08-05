--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Vortigaunt Hooks"
ITEM.description = "The base component of both shackles and collars. They fit very tight around the legs. Locked in place, they cannot be removed once applied."
ITEM.category = "Vortigaunt"
ITEM.model = "models/willardnetworks/clothingitems/vortigaunt_hooks.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "Shoes"
ITEM.factionList = {FACTION_VORT}
ITEM.KeepOnDeath = true

ITEM.bodyGroups = {
    ["hooks"] = 1 -- The actual name of the bodypart, then number in that bodypart (model-wise)
}

function ITEM:OnInstanced()
	self:SetData("Locked", false)
end

function ITEM:OnEquip(client)
	self:SetData("Locked", true)
end

function ITEM:OnUnEquip()
	self:SetData("Locked", false)
end

ITEM:Hook("drop", function(item)
	if item:GetData("Locked") == true then
		item.player:NotifyLocalized("Your collar is locked so you cannot drop it!")
		return false
	end

	if (item:GetData("equip")) then
		item:RemoveOutfit(item:GetOwner())
	end
end)
