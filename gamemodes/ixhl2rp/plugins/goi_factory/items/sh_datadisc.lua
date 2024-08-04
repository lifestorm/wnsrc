--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Dysk Danych"
ITEM.model = "models/willardnetworks/gearsofindustry/wn_data_card.mdl"
ITEM.category = "Combine"
ITEM.description = "Mały, stosunkowo cienki metalowy dysk używany do przechowywania danych."

function ITEM:GetSkin()
	return self:GetData("item") and 0 or 1
end

function ITEM:PopulateTooltip(tooltip)
	local item = self:GetData("item")

	local itemPnl = tooltip:AddRow("item")
	itemPnl:SetBackgroundColor(derma.GetColor(item and "Info" or "Error", tooltip))
	itemPnl:SetText(item and ix.item.list[item] and "Zakodowany Przedmiot: " .. ix.item.list[item].name or "Brak zakodowanych danych na Dysku")
	itemPnl:SizeToContents()
end
