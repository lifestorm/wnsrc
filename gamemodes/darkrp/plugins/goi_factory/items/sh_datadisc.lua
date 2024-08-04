--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Data-Disk"
ITEM.model = "models/willardnetworks/gearsofindustry/wn_data_card.mdl"
ITEM.category = "Combine"
ITEM.description = "Küçük, veri depolamak için ince bir metalik disk."

function ITEM:GetSkin()
	return self:GetData("item") and 0 or 1
end

function ITEM:PopulateTooltip(tooltip)
	local item = self:GetData("item")

	local itemPnl = tooltip:AddRow("item")
	itemPnl:SetBackgroundColor(derma.GetColor(item and "Info" or "Error", tooltip))
	itemPnl:SetText(item and "Kodlanmış Öğe: " .. ix.item.list[item].name or "Diskte Kodlanmış Veri Yok")
	itemPnl:SizeToContents()
end
