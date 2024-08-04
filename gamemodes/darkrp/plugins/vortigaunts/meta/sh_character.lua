--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local CHAR = ix.meta.character

function CHAR:IsVortigaunt()
	local faction = self:GetFaction()

	if (faction == FACTION_VORT) then
		return true
	else
		return false
	end
end

function CHAR:HasVortalEnergy(amount)
	if self:GetVortalEnergy() and self:GetVortalEnergy() >= amount then
		return true
	end
	return false
end

function CHAR:TakeVortalEnergy(amount)
	if self:GetPlayer():GetNetVar("ixVortExtract") then return end
	self:SetVortalEnergy(math.Clamp(self:GetVortalEnergy() - amount, 0, ix.config.Get("maxVortalEnergy", 100)))
end

function CHAR:AddVortalEnergy(amount)
	if self:GetPlayer():GetNetVar("ixVortExtract") then return end
	self:SetVortalEnergy(math.Clamp(self:GetVortalEnergy() + amount, 0, ix.config.Get("maxVortalEnergy", 100)))
end