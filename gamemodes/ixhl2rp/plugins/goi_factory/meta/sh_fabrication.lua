--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local FABRICATION = ix.meta.fabrication or {}
FABRICATION.__index = FABRICATION
FABRICATION.id = ""
FABRICATION.category = ""
FABRICATION.mainMaterialCost = 1

function FABRICATION:__tostring()
	return "FABRICATION: " .. self.id
end

function FABRICATION:__eq(other)
	return self:GetID() == other:GetID()
end

function FABRICATION:SetCategory(category)
	if !category or !ix.fabrication.EXISTING_CATS[category] then
		return false
	end
	self.category = category

	return true
end

function FABRICATION:GetCategory()
	return self.category
end

function FABRICATION:SetMainMaterialCost(mainMaterialCost)
	if !mainMaterialCost or !isnumber(mainMaterialCost) then
		return false
	end
	self.mainMaterialCost = mainMaterialCost

	return true
end

function FABRICATION:GetMainMaterialCost()
	return self.mainMaterialCost
end

function FABRICATION:GetID()
	return self.id
end

ix.meta.fabrication = FABRICATION