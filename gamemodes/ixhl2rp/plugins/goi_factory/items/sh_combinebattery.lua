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

ITEM.name = "Combine Battery"
ITEM.model = "models/willardnetworks/gearsofindustry/wn_battery.mdl"
ITEM.category = "Combine"
ITEM.description = "A small rechargable Combine Battery. It features a charging port in the back, and several ports displaying its charge level."
ITEM.iconCam = {
	pos = Vector(199.98, 5.3, 7.35),
	ang = Angle(0.66, -178.43, 0),
	fov = 3.08
}

function ITEM:OnInstanced(invID, x, y, item)
	self:SetData("charge", 0)
end

ITEM.functions.SetFullCharge = { -- sorry, for name order.
	name = "Set Full Charge",
	tip = "repairTip",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		item:SetData("charge", 10)
		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		return IsValid(client) and client:IsAdmin()
	end
}

-- Setting damageInfo manually because we're doing some weirdness with the item destruction.
function ITEM:OnEntityTakeDamage(entity, damageInfo)
	entity.ixDamageInfo = {damageInfo:GetAttacker(), damage, damageInfo:GetInflictor()}
end

if (SERVER) then return end

function ITEM:PopulateTooltip(tooltip)
	local charge = self:GetData("charge", 0)
	local color = PLUGIN.chargeIndicatorColors[charge] or Color(255, 0, 0)

	local name = tooltip:GetRow("name")
	name:SetBackgroundColor(color)

	local chargePnl = tooltip:AddRow("charge")
	chargePnl:SetBackgroundColor(color)
	chargePnl:SetText("Charge: " .. (charge * 10) .. "%")
	chargePnl:SizeToContents()
end

function ITEM:DrawEntity(entity)
	if (entity.colorSetup) then return end

	entity.GetBatteryColor = function()
		local color = entity:GetNetVar("beeping", false) and Color(255, 0, 0) or PLUGIN.chargeIndicatorColors[entity:GetData("charge", 0)] or Color(0, 255, 255)

		return Vector(color.r / 255, color.g / 255, color.b / 255)
	end

	entity.colorSetup = true
end

function ITEM:OnInventoryDraw(entity)
	entity.GetBatteryColor = function()
		local color = PLUGIN.chargeIndicatorColors[self:GetData("charge", 0)] or Color(255, 0, 0)

		return Vector(color.r / 255, color.g / 255, color.b / 255)
	end
end

matproxy.Add({
	name = "BatteryColor",
	init = function(self, mat, values)
		self.ResultTo = values.resultvar
	end,
	bind = function(self, mat, ent)
		if (ent.GetBatteryColor) then
			mat:SetVector(self.ResultTo, ent:GetBatteryColor())
		end
	end
})
