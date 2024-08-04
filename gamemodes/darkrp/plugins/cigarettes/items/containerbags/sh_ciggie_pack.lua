--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Sigara Paketi"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_1.mdl")
ITEM.description = "Tam olarak 8 sigarayı içerebilen bir sigara paketi."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette", "lighter"}
ITEM.noEquip = true

function ITEM:GetName()
	return self:GetData("relabeled", false) and "Etiketlenmiş Sigara Paketi" or "Benefactor Edition Sigara Paketi"
end

function ITEM:GetDescription()
	return self:GetData("relabeled", false) and "Tam olarak 8 sigara alabilen yeniden etiketlenmiş bir sigara paketi." or "Tam olarak 8 sigara alabilen, Combine tarafından verilen bir sigara paketi."
end

function ITEM:GetModel()
	return self:GetData("relabeled", false) and "models/willardnetworks/cigarettes/cigarette_pack_1.mdl" or "models/willardnetworks/cigarettes/cigarette_pack.mdl"
end

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
