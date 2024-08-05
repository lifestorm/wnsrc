--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local FindMetaTable = FindMetaTable
local string = string
local ipairs = ipairs
local ix = ix
local PLUGIN = PLUGIN
local Schema = Schema
local pairs = pairs
local playerMeta = FindMetaTable("Player")

function playerMeta:HasActiveCombineSuit()
	return self:GetActiveCombineSuit() != false
end

function playerMeta:GetActiveCombineSuit()
	local character = self:GetCharacter()
	if (!character) then return false end

	local item = ix.item.instances[character:GetCombineSuit()]
	if (item) then
		return item:GetData("suitActive") and item
	end

	return false
end

function playerMeta:HasActiveCombineMask()
	if (!self:HasActiveCombineSuit()) then return false end

	local items = self:GetCharacter():GetInventory():GetItemsByBase("base_maskcp", true)
	for _, v in pairs(items) do
		if (v.isCombineMask and v:GetData("equip")) then
			return true
		end
	end
end

function playerMeta:HasActiveTracker()
	local character = self:GetCharacter()
	if (!character) then return false end

	local item = ix.item.instances[character:GetCombineSuit()]
	if (item) then
		if (item:GetData("trackingActive")) then return true end
	end
end

function playerMeta:GetCombineTag()
	local name = self:IsDispatch() and self:Name()
	local suit = self:GetActiveCombineSuit()
	if (suit) then
		name = suit:GetData("ownerName")
	end

	if (!name) then return self:Name() end
	if (string.find(name, "%a+%-%d+$")) then
		return string.match(name, "%a+%-%d+$")
	else
		return name
	end
end

function playerMeta:GetCombineRank()
	local name = self:IsDispatch() and self:Name()
	local suit = self:GetActiveCombineSuit()
	if (suit) then
		name = suit:GetData("ownerName")
	end

	if (!name) then return -1 end
	for k, v in ipairs(PLUGIN.ranks) do
		if (v and Schema:IsCombineRank(name, v)) then
			return k
		end
	end

	return 0
end

function playerMeta:IsCombineRankAbove(rank)
	for k, v in ipairs(PLUGIN.ranks) do
		if (v == rank) then
			return self:GetCombineRank() >= k
		end
	end
end

function playerMeta:IsCombine()
	local faction = ix.faction.Get(self:Team())
	if (faction and faction.isCombineFaction) then
		return true
	else
		local suit = self:GetActiveCombineSuit()
		if (suit and (suit:GetData("ownerID") == self:GetCharacter():GetID() or !suit:GetData("trackingActive"))) then
			return true
		end
	end
end

function playerMeta:IsCP()
	local faction = self:Team()
	return faction == FACTION_CP
end

function playerMeta:IsOTA()
	local faction = self:Team()
	return faction == FACTION_OTA
end

function playerMeta:IsDispatch()
	return self:Team() == FACTION_OVERWATCH
end

function playerMeta:IsOverwatch()
	return self:Team() == FACTION_OVERWATCH and !Schema:IsCombineRank(self:Name(), "SCN") and !Schema:IsCombineRank(self:Name(), "SHIELD") and !Schema:IsCombineRank(self:Name(), "Disp:AI")
end

function playerMeta:IsCombineScanner()
	return self:Team() == FACTION_OVERWATCH and (Schema:IsCombineRank(self:Name(), "SCN") or Schema:IsCombineRank(self:Name(), "SHIELD") or Schema:IsCombineRank(self:Name(), "Disp:AI"))
end