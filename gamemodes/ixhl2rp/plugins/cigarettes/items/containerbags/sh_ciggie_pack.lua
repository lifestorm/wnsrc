--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Cigarette Pack"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_1.mdl")
ITEM.description = "A cigarette pack capable of holding precisely 8 cigarettes."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette", "lighter"}
ITEM.noEquip = true

function ITEM:GetName()
	return self:GetData("relabeled", false) and "Relabelled Cigarette Pack" or "Benefactor Edition Cigarette Pack"
end

function ITEM:GetDescription()
	return self:GetData("relabeled", false) and "A relabelled cigarette pack capable of holding precisely 8 cigarettes." or "A Combine-issued cigarette pack capable of holding precisely 8 cigarettes."
end

function ITEM:GetModel()
	return self:GetData("relabeled", false) and "models/willardnetworks/cigarettes/cigarette_pack_1.mdl" or "models/willardnetworks/cigarettes/cigarette_pack.mdl"
end

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
