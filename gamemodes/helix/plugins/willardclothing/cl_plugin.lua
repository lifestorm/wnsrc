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

netstream.Hook("ItemEquipBodygroups", function(index, value)
	if IsValid(ix.gui.characterpanel) then
		if ix.gui.characterpanel.model then
			ix.gui.characterpanel.model.Entity:SetBodygroup(index, value)
		end
	end

	if IsValid(ix.gui.menuInventoryParent) then
		if IsValid(ix.gui.inventoryModel.Entity) then
			ix.gui.inventoryModel.Entity:SetBodygroup(index, value)
		end
	end
end)

net.Receive("ixOpenClothingCreator", function()
	if ix.gui.clothingCreator and IsValid(ix.gui.clothingCreator) then
		ix.gui.clothingCreator:Remove()
	end

	ix.gui.clothingCreator = vgui.Create("ixClothingCreator")
end)