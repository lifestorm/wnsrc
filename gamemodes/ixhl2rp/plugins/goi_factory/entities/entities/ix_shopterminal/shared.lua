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
ENT.PrintName = "Shop Terminal"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.PhysgunAllowAdmin = true

function ENT:GetShop()
	return self:GetNetVar("shop", false)
end

function ENT:GetShopCost()
	return self:GetNetVar("cost", false)
end

function ENT:GetShopSocialCreditReq()
	return self:GetNetVar("sc", false)
end

function ENT:IsPurchasable()
	local shop = self:GetShop()
	if !shop then return false end

	local housing = ix.plugin.Get("housing")
	local foundShop = false
	for _, fShop in pairs(housing.apartments) do
		if fShop.name == shop and fShop.type == "shop" then
			foundShop = fShop
		end
	end

	if !foundShop then
		return false
	end

	if foundShop.tenants and table.IsEmpty(foundShop.tenants) then
		return true
	end

	return false
end