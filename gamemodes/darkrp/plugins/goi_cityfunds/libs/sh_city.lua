--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local pairs = pairs
local string = string
local isnumber = isnumber
local util = util
local net = net

ix.city = ix.city or {}
ix.city.list = ix.city.list or {}
ix.city.main = ix.city.main or false

ix.city.types = ix.city.types or {}
ix.city.types.list = ix.city.types.list or {}

ix.city.cwuAccess = {
    ["Member"] = {
        creditInteraction = false,
		budgetInteraction = false,
		marketInteraction = false,
		stockInteraction = true
    },
    ["Management"] = {
        creditInteraction = false,
		budgetInteraction = true,
		marketInteraction = true,
		stockInteraction = true
    },
	["Logistics"] = {
        creditInteraction = false,
		budgetInteraction = false,
		marketInteraction = true,
		stockInteraction = true
    }
}

function ix.city:TranslateCardLevel(cwuCard)
	local accessLevel = cwuCard:GetData("accessLevel", "Member Access")

	for reqAcLevel, perms in pairs(ix.city.cwuAccess) do
		local s1, s2 = string.find(accessLevel, reqAcLevel)

		if !isnumber(s1) or !isnumber(s2) then continue end

		local level = string.sub( reqAcLevel, s1, s2 )

		return level
	end
end

function ix.city:IsAccessable(cwuCard, interaction)
	if !cwuCard then return false end

	local accessLevel = ix.city:TranslateCardLevel(cwuCard)

	if ix.city.cwuAccess[accessLevel] and ix.city.cwuAccess[accessLevel][interaction] then
		return true
	end

	return false
end

if SERVER then
	function ix.city:SyncCityStock(client)
		local cityStock = util.TableToJSON(ix.city.main.items)

		net.Start("ix.city.SyncCityStock")
			net.WriteString(cityStock)
		net.Send(client)
	end
else
	function ix.city:SyncCityStock()
		net.Start("ix.city.SyncCityStock")
		net.SendToServer()
	end
end