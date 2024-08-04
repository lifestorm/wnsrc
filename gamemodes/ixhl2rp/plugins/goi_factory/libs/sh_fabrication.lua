--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
ix.fabrication = ix.fabrication or {}
ix.fabrication.list = ix.fabrication.list or {}
ix.fabrication.EXISTING_CATS = {
	["advancedtech"] = true,
	["tech"] = true,
	["bio"] = true
}
ix.fabrication.MAIN_MATS = {
	["advancedtech"] = "comp_condensed_resin",
	["tech"] = "comp_resin",
	["bio"] = "biopaste"
}

function ix.fabrication:Register(id, category, mainMaterialCost)
	local fabrication = setmetatable({
		id = id,
		category = "",
		mainMaterialCost = 1
	}, ix.meta.fabrication)

	local cat = fabrication:SetCategory(category)
	local material = fabrication:SetMainMaterialCost(mainMaterialCost)

	if !cat or !material then
		fabrication = nil
		return
	end

	ix.fabrication.list[id] = fabrication
	return fabrication
end

function ix.fabrication:Get(id)
	return ix.fabrication.list[id]
end

function ix.fabrication:GetAll()
	return ix.fabrication.list
end

function ix.fabrication:GetAllAdvancedTech()
	local t = {}
	for id, fab in pairs(ix.fabrication.list) do
		if fab.category != "advancedtech" then continue end
		t[id] = fab
	end

	return t
end

function ix.fabrication:GetAllTech()
	local t = {}
	for id, fab in pairs(ix.fabrication.list) do
		if fab.category != "tech" then continue end
		t[id] = fab
	end

	return t
end

function ix.fabrication:GetAllBio()
	local t = {}
	for id, fab in pairs(ix.fabrication.list) do
		if fab.category != "bio" then continue end
		t[id] = fab
	end

	return t
end

function ix.fabrication:GetAdvancedTech(id)
	local fabrication = ix.fabrication.list[id]
	if fabrication and fabrication.category == "advancedtech" then
		return fabrication
	end
end

function ix.fabrication:GetTech(id)
	local fabrication = ix.fabrication.list[id]
	if fabrication and fabrication.category == "tech" then
		return fabrication
	end
end

function ix.fabrication:GetBio(id)
	local fabrication = ix.fabrication.list[id]
	if fabrication and fabrication.category == "bio" then
		return fabrication
	end
end