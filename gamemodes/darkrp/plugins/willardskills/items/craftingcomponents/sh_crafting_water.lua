--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.uniqueID = "crafting_water"
ITEM.name = "Su İşçiliği"
ITEM.description = "İşçilik için kullanılan dönüştürülmüş bir su tenekesi."
ITEM.category = "Crafting"
ITEM.width = 1
ITEM.height = 1
ITEM.model = "models/props_junk/popcan01a.mdl"
ITEM.iconCam = {
	pos = Vector(509.64, 427.61, 310.24),
	ang = Angle(25.01, 220.01, 0),
	fov = 0.6
}
ITEM.maxStackSize = 4

ITEM.functions.Convert = {
	name = "Dönüştür",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()
		local originalID = item:GetData("original")
		local original = ix.item.list[originalID]

		if (!original) then return end

		inventory:Add(originalID, 1, {spoilTime = item:GetData("spoilTime", 0)})
		client:Notify("Üretim Suyunu şu hale getirdiniz: " .. original.name .. ".")
	end,
	OnCanRun = function(item)
		return item:GetData("original")
	end
}

function ITEM:GetDescription()
	local item = ix.item.list[self:GetData("original")]
	return "Dönüştürülmüş bir " .. (item and item.name or "su tenekesi") .. " üretim için kullanılır."
end