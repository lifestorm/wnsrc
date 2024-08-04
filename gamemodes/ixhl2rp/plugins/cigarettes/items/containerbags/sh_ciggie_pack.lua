--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Paczka papierosów"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_1.mdl")
ITEM.description = "Paczka papierosów, w której mieści się 8 papierosów."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette", "lighter"}
ITEM.noEquip = true

function ITEM:GetName()
	return self:GetData("relabeled", false) and "Paczka papierosów ze zmienioną etykietą" or "Paczka papiersów - Edycja Benefaktor"
end

function ITEM:GetDescription()
	return self:GetData("relabeled", false) and "Paczka papierosów ze zmienioną etykietą, w której mieści się 8 papierosów." or "Paczka papierosów wydana przez Kombinat, w której mieści się 8 papierosów."
end

function ITEM:GetModel()
	return self:GetData("relabeled", false) and "models/willardnetworks/cigarettes/cigarette_pack_1.mdl" or "models/willardnetworks/cigarettes/cigarette_pack.mdl"
end

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
