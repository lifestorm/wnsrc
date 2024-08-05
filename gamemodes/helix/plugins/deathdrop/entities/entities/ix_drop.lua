--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- local DEFINE_BASECLASS = DEFINE_BASECLASS
local IsValid = IsValid
local hook = hook
local CurTime = CurTime
local net = net
local Color = Color
local surface = surface
local ix = ix


DEFINE_BASECLASS("ix_container")

ENT.Type = "anim"
ENT.PrintName = "Dropped Items"
ENT.Category = "Helix"
ENT.Spawnable = false

if (SERVER) then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}

		self:SetDisplayName("Dropped Items")

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:OnRemove()
		local index = self:GetID()

		if (!ix.shuttingDown and !self.ixIsSafe and ix.entityDataLoaded and index) then
			local inventory = index != 0 and ix.item.inventories[index]

			if (inventory) then
				ix.item.inventories[index] = nil

				local query = mysql:Delete("ix_items")
					query:Where("inventory_id", index)
				query:Execute()

				query = mysql:Delete("ix_inventories")
					query:Where("inventory_id", index)
				query:Execute()
			end

			hook.Run("DropRemoved", self, inventory)
		end
	end

	function ENT:Use(activator)
		local inventory = self:GetInventory()

		if (inventory and (activator.ixNextOpen or 0) < CurTime()) then
			local character = activator:GetCharacter()

			if (character) then
				if (self:GetLocked() and !self.Sessions[character:GetID()]) then
					self:EmitSound("doors/default_locked.wav")

					if (!self.keypad) then
						net.Start("ixContainerPassword")
							net.WriteEntity(self)
						net.Send(activator)
					end
				else
					self:OpenInventory(activator)
				end
			end

			activator.ixNextOpen = CurTime() + 1
		end
	end
else
	ENT.PopulateEntityInfo = true

	local COLOR_LOCKED = Color(200, 38, 19, 200)
	local COLOR_UNLOCKED = Color(135, 211, 124, 200)

	function ENT:OnPopulateEntityInfo(tooltip)
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
	end
end
