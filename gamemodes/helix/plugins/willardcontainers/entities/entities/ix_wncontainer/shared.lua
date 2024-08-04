--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ENT.Type = "anim"
ENT.PrintName = "Container"
ENT.Category = "Helix"
ENT.Spawnable = false
ENT.bNoPersist = true

ENT.PUBLIC = 1
ENT.GROUP = 2
ENT.PRIVATE = 3
ENT.CLEANUP = 4
ENT.PKHOLD = 5
ENT.MANCLEANUP = 6

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ID")
	self:NetworkVar("Int", 1, "Type")
	self:NetworkVar("Int", 2, "Cleanup")
	self:NetworkVar("Int", 3, "LastUsed")
	self:NetworkVar("Int", 4, "CharID")
	self:NetworkVar("Bool", 0, "Premium")
	self:NetworkVar("String", 0, "DisplayName")
	self:NetworkVar("String", 1, "Pass")
	self:NetworkVar("String", 2, "AdminText")
end

function ENT:CanHavePassword()
	return self:GetType() != self.PUBLIC and self:GetType() != self.CLEANUP
end

function ENT:GetInventory()
	return ix.item.inventories[self:GetID()]
end

function ENT:GetLocked()
	if (self:GetType() == self.PKHOLD) then
		return self:GetCleanup() > os.time()
	end

	if (!self:CanHavePassword()) then
		return false
	else
		return self:GetPassword() != ""
	end
end

function ENT:GetPassword()
	if (!self:CanHavePassword()) then
		return ""
	else
		return self:GetPass()
	end
end

if (CLIENT) then
	ENT.PopulateEntityInfo = true

	local COLOR_LOCKED = Color(200, 38, 19, 200)
	local COLOR_UNLOCKED = Color(135, 211, 124, 200)

	function ENT:OnPopulateEntityInfo(tooltip)
		local definition = ix.container.stored[self:GetModel():lower()]
		local bLocked = self:GetLocked()

		surface.SetFont("ixIconsSmall")

		local iconText = bLocked and "P" or "Q"
		local iconWidth, iconHeight = surface.GetTextSize(iconText)

		-- minimal tooltips have centered text so we'll draw the icon above the name instead
		if (tooltip:IsMinimal()) then
			local icon = tooltip:AddRow("icon")
			icon:SetFont("ixIconsSmall")
			icon:SetTextColor(bLocked and COLOR_LOCKED or COLOR_UNLOCKED)
			icon:SetText(iconText)
			icon:SizeToContents()
		end

		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText(self:GetDisplayName())
		title:SetBackgroundColor(ix.config.Get("color"))
		title:SetTextInset(iconWidth + 8, 0)
		title:SizeToContents()

		if (!tooltip:IsMinimal()) then
			title.Paint = function(panel, width, height)
				panel:PaintBackground(width, height)

				surface.SetFont("ixIconsSmall")
				surface.SetTextColor(bLocked and COLOR_LOCKED or COLOR_UNLOCKED)
				surface.SetTextPos(4, height * 0.5 - iconHeight * 0.5)
				surface.DrawText(iconText)
			end
		end

		local description = tooltip:AddRow("description")
		description:SetText(definition.description)
		description:SizeToContents()

		if (LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP and !LocalPlayer():InVehicle()) then
			if (self:GetAdminText() != "") then
				local adminText = tooltip:AddRow("adminText")
				adminText:SetText(self:GetAdminText())
				adminText:SizeToContents()
			end

			local lastUsed = tooltip:AddRow("lastUsed")
			if (self:GetType() == self.PKHOLD) then
				lastUsed:SetText("CONTAINER ON PK HOLD UNTIL "..os.date("%Y-%m-%d %X", self:GetCleanup()))
				lastUsed:SizeToContents()
				return
			elseif (self:GetType() == self.CLEANUP or self:GetType() == self.MANCLEANUP) then
				lastUsed:SetText("CONTAINER TO BE REMOVED ON "..os.date("%Y-%m-%d %X", self:GetCleanup()))
				lastUsed:SizeToContents()
				return
			end

			local text = "Last used"
			if (self:GetType() == self.PRIVATE) then
				text = "Last seen"
			end
			lastUsed:SetText(string.format("%s: %s", text, os.date("%Y-%m-%d", self:GetLastUsed())))
			lastUsed:SizeToContents()
		end
	end
end