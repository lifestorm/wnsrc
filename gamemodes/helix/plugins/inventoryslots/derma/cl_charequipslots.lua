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

local PANEL = {}

local path = "willardnetworks/tabmenu/inventory/equipslots/icon-"
local partPaintsDefault = {
	[1] = {icon = ix.util.GetMaterial(path.."head.png"), category = "Head"},
	[2] = {icon = ix.util.GetMaterial(path.."glasses.png"), category = "Glasses"},
	[3] = {icon = ix.util.GetMaterial(path.."face.png"), category = "Face"},
	[4] = {icon = ix.util.GetMaterial(path.."torso.png"), category = "Torso"},
	[5] = {icon = ix.util.GetMaterial(path.."hands.png"), category = "Hands"},
	[6] = {icon = ix.util.GetMaterial(path.."legs.png"), category = "Legs"},
	[7] = {icon = ix.util.GetMaterial(path.."shoes.png"), category = "Shoes"},
	[8] = {icon = ix.util.GetMaterial(path.."bagsmall.png"), category = "Satchel"},
	[9] = {icon = ix.util.GetMaterial(path.."baglarge.png"), category = "Bag"},
	[10] = {icon = ix.util.GetMaterial(path.."outfit.png"), category = "model"},
}



function PANEL:PaintParts()
	local parent = self:GetParent()
	local openedStorage = (!ix.gui.openedStorage or ix.gui.openedStorage and !IsValid(ix.gui.openedStorage)) or false

	for k, v in pairs(self:GetChildren()) do
		local partPaints = hook.Run("GetEquipSlotsPartPaints", self, openedStorage) or partPaintsDefault
		if !partPaints[k] then continue end
		if !partPaints[k].icon then continue end
		if !partPaints[k].category then continue end

		v.Paint = function(this, w, h)
			local char = LocalPlayer():GetCharacter()
			local faction = char and char.GetFaction and char:GetFaction()
			local noEquipFactions = PLUGIN.noEquipFactions
			local isNoEquipFaction = !openedStorage and self.isNoEquipFaction or faction and noEquipFactions and noEquipFactions[faction]

			local bNoEquip = hook.Run("CanEquipSlot", self, openedStorage, k) == false

			local color = (isNoEquipFaction or bNoEquip) and Color(80, 80, 80, 150) or Color(35, 35, 35, 85)
			surface.SetDrawColor(color)
			surface.DrawRect(1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3))

			local iconSize2 = SScaleMin(45 / 3)

			if (isNoEquipFaction or bNoEquip) then
				surface.SetDrawColor(Color(150, 150, 150, 255))
				surface.DrawLine( 1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3) )
				surface.DrawLine( 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3), 1 )
			end

			surface.SetDrawColor(80, 80, 80, 255)
			surface.DrawOutlinedRect(1, 1, w - SScaleMin(2 / 3), h - SScaleMin(2 / 3))

			local squareSize = SScaleMin(90 / 3)
			local halfSquare = squareSize * 0.5
			local halfIcon = iconSize2 * 0.5

			surface.SetDrawColor(color_white)
			surface.SetMaterial(partPaints[k] and partPaints[k].icon or partPaintsDefault[k].icon)
			surface.DrawTexturedRect(halfSquare - halfIcon, halfSquare - halfIcon, iconSize2, iconSize2)
		end

		v.clothingCategory = partPaints[k].category
		if k > 5 then
			local cX, cY = v:GetPos()
			v:SetPos(cX + (SScaleMin(90 / 3) * 4), cY - (SScaleMin(90 / 3) * 5))
		end
	end

	local invSize = (SScaleMin(90 / 3) * 5)
	self:SetSize(invSize, invSize)

	local imgBackground = parent:GetChildren()[1]
	if imgBackground and IsValid(imgBackground) then
		local imgBackgroundW, imgBackgroundH = parent:GetWide() * 0.65, parent:GetTall()

		self:SetPos(imgBackgroundW * 0.5 - self:GetWide() * 0.5, imgBackgroundH * 0.5 - self:GetTall() * 0.5)
	end
end

vgui.Register("ixEquipSlots", PANEL, "ixInventory")