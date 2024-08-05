--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ITEM.name = "Maczeta"
ITEM.description = "Ostra maczeta, tylko po co ci ona?"
ITEM.model = "models/weapons/tfa_nmrih/w_me_machete.mdl"
ITEM.class = "tfa_nmrih_machete"
ITEM.isMelee = true
ITEM.weaponCategory = "melee"
ITEM.balanceCat = "medium"
ITEM.width = 1
ITEM.height = 4
ITEM.iconCam = {
  pos = Vector(0, 200, 0),
  ang = Angle(-0.01, 270.06, 0),
  fov = 2.51
}

ITEM.maxDurability = 15
ITEM.isTool = true

local color_green = Color(100, 255, 100)
local color_red = Color(200, 25, 25)

if (CLIENT) then
		function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 20, 8, 8)
		end			
		local maxDurability = item:GetMaxDurability()
		local durability = item:GetDurability()
		local width = w - 8
		local cellWidth = math.Round(width / maxDurability)
		local color = ix.util.ColorLerp(1 - durability / maxDurability, color_green, color_red)
		surface.SetDrawColor(color)
		
		for i = 0, durability - 1 do
			surface.DrawRect(5 + i * cellWidth, h - 8, cellWidth - 1, 4)
		end
	end
end

ITEM.functions.SetMaxDurability = {
	name = "Ustaw maks. wytrzymałość",
	icon = "icon16/wrench.png",
	OnClick = function(itemTable)
		local client = itemTable.player
		Derma_StringRequest("Ustaw wytrzymałość", "Wprowadź maks. wartość wytrzymałości", itemTable:GetMaxDurability(), function(text)
			local amount = tonumber(text)

			if (amount and amount > 0) then
				netstream.Start("ixSetToolMaxDurability", itemTable:GetID(), math.floor(amount))
			else
				client:Notify("Nieprawidłowy numer")
			end
		end)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		if (!CAMI.PlayerHasAccess(itemTable.player, "Helix - Basic Admin Commands")) then
			return false
		end

		return true
	end
}

ITEM.functions.SetDurability = {
	name = "Ustaw wytrzymałość",
	icon = "icon16/wrench.png",
	OnClick = function(itemTable)
		local client = itemTable.player
		Derma_StringRequest("Ustaw wytrzymałość", "Wprowadź tutaj wartość wytrzymałości dla tego narzędzia", itemTable:GetDurability(), function(text)
			local amount = tonumber(text)

			if (amount and amount > 0 and amount <= itemTable:GetMaxDurability()) then
				netstream.Start("ixSetToolDurability", itemTable:GetID(), math.floor(amount))
			else
				client:Notify("Nieprawidłowy numer")
			end
		end)
	end,
	OnRun = function(itemTable)
		return false
	end,
	OnCanRun = function(itemTable)
		if (IsValid(itemTable.entity)) then
			return false
		end

		if (!CAMI.PlayerHasAccess(itemTable.player, "Helix - Basic Admin Commands")) then
			return false
		end

		return true
	end
}

function ITEM:GetDescription()
  local maxDurability = self:GetMaxDurability()
  local durability = self:GetDurability()
  return self.description .. "\n\nWytrzymałość: " .. durability .. "/" .. maxDurability
end

function ITEM:OnInstanced(index, x, y, item)
  self:SetData("durability", self:GetMaxDurability())
end

function ITEM:DamageDurability(amount)
  self:SetData("durability", math.max(0, self:GetDurability() - 1))

  if (self:GetDurability() == 0) then
    self:OnBreak()
  end
end

function ITEM:GetBreakSound()
  return "weapons/crowbar/crowbar_impact"..math.random(1, 2)..".wav"
end

function ITEM:OnBreak()
  local breakSound = self:GetBreakSound()

  if (IsValid(self.player)) then
    self.player:EmitSound(breakSound, 65)
  elseif (IsValid(self.entity)) then
    self.entity:EmitSound(breakSound, 65)
  end

  self:Remove()
end

function ITEM:GetDurability()
  return self:GetData("durability", self:GetMaxDurability())
end

function ITEM:GetMaxDurability()
  return self:GetData("maxDurability", self.maxDurability)
end