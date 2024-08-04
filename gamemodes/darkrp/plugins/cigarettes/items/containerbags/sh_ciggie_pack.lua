--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Paquet de cigarettes"
ITEM.model = Model("models/willardnetworks/cigarettes/cigarette_pack_1.mdl")
ITEM.category = "Drogues"
ITEM.description = "Le paquet de cigarettes est enveloppé d'un papier fin et doux au toucher, avec le motif de l'Union coloré. Sur la face avant, le logo de l'Union est imprimé en caractères gras et noirs, tandis que des avertissements sanitaires sont inscrits sur la face arrière. En le tenant dans votre main, vous pouvez sentir le poids léger du paquet, ainsi que l'odeur distincte et forte du tabac qui en émane."
ITEM.allowNesting = true
ITEM.restriction = {"cigarette"}
ITEM.noEquip = true

function ITEM:GetName()
	return self:GetData("relabeled", false) and "Paquet de cigarettes réétiqueté" or "Paquet de cigarettes - Edition Bienfaiteur"
end

function ITEM:GetDescription()
	return self:GetData("relabeled", false) and "Un paquet de cigarettes réétiqueté pouvant contenir précisément 8 cigarettes" or "Un paquet de cigarettes délivré par l'Union et pouvant contenir précisément 8 cigarettes"
end

function ITEM:GetModel()
	return self:GetData("relabeled", false) and "models/willardnetworks/cigarettes/cigarette_pack_1.mdl" or "models/willardnetworks/cigarettes/cigarette_pack.mdl"
end

function ITEM:OnBagInitialized(inventory)
	inventory:Add("cigarette", 8)
end
