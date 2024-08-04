--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include("shared.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_smallmonitor001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	self:SetTrigger(true)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	self:SetNetVar("isPurchasable", self:IsPurchasable())
end

function ENT:SetShop(shop)
	local housing = ix.plugin.Get("housing")
	local foundShop = false
	for k, apartment in pairs(housing.apartments) do
		if apartment.name == shop and apartment.type == "shop" then
			self:SetNetVar("shop", shop)
			self:SetNetVar("shopID", i)
			foundShop = true
		end
	end

	if !foundShop then
		return "No shops found"
	end

	self:UpdateScreen()
end

function ENT:GetShopID()
	local shop = self:GetShop()
	local housing = ix.plugin.Get("housing")
	for k, fShop in pairs(housing.apartments) do
		if fShop.name == shop and fShop.type == "shop" then
			return k
		end
	end

	return false
end

function ENT:SetShopCost(cost)
	if !self:GetShop() then return "You must link this terminal with shop first!" end

	self:SetNetVar("cost", cost)

	self:UpdateScreen()
end

function ENT:SetShopSocialCreditReq(sc)
	if !self:GetShop() then return "You must link this terminal with shop first!" end

	self:SetNetVar("sc", sc)

	self:UpdateScreen()
end

function ENT:UpdateRent()
	local shop = self:GetShop()
	if !shop then return false end

	local housing = ix.plugin.Get("housing")
	local foundShop = false
	for k, fShop in pairs(housing.apartments) do
		if fShop.name == shop and fShop.type == "shop" then
			foundShop = fShop
		end
	end

	if !foundShop then
		return false
	end

	self:SetNetVar("Rent", foundShop.rent)
end

function ENT:UpdateScreen()
	self:SetNetVar("isPurchasable", self:IsPurchasable())
	self:UpdateRent()

	for _, client in ipairs(player.GetAll()) do
		netstream.Start(client, "UpdateShopScreen")
	end
end

function ENT:StartTouch(entity)

end