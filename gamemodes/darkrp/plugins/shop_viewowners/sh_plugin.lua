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
PLUGIN.name = "Willard Shop Overview"
PLUGIN.author = "Naast"
PLUGIN.description = "Simple shop overview panel for CCA."

ix.util.Include("sv_plugin.lua")

ix.command.Add("ViewShops", {
	description = "Creates a panel with list of all shops and their owners.",
	OnRun = function(self, client)
		PLUGIN:OpenShopInfo(client)
	end,
	OnCheckAccess = function(self, client)
		return client:IsCombine() or client:GetCharacter():HasFlags("U")
	end,
	bNoIndicator = true
})

if CLIENT then
	net.Receive("ix.shopOverview.createPanel", function(len)
		local shopsInfo = net.ReadString()
		shopsInfo = util.JSONToTable(shopsInfo)

		local viewOwners = vgui.Create("ixShopOverview")
		viewOwners:Populate(shopsInfo)
	end)
end