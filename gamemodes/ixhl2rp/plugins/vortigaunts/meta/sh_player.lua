--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local playerMeta = FindMetaTable("Player")

function playerMeta:IsVortigaunt()
	return self:GetCharacter() and self:GetCharacter():IsVortigaunt()
end

function playerMeta:HasVortalEnergy(amount)
	local character = self:GetCharacter()
	if character:GetVortalEnergy() and character:GetVortalEnergy() >= amount then
		return true
	end
	return false
end

function playerMeta:TakeVortalEnergy(amount)
	if self:GetNetVar("ixVortExtract") then return end
	local character = self:GetCharacter()
	character:SetVortalEnergy(math.Clamp(character:GetVortalEnergy() - amount, 0, ix.config.Get("maxVortalEnergy", 100)))
end

function playerMeta:AddVortalEnergy(amount)
	if self:GetNetVar("ixVortExtract") then return end
	local character = self:GetCharacter()
	character:SetVortalEnergy(math.Clamp(character:GetVortalEnergy() + amount, 0, ix.config.Get("maxVortalEnergy", 100)))
end