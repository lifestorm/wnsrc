--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Infestation Control"
PLUGIN.author = "Aspect™"
PLUGIN.description = "Adds a comprehensive Infestation Control system."

ix.util.Include("cl_hooks.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sv_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("meta/sh_player.lua")
ix.util.IncludeDir("darkrp/plugins/infestationcontrol/recipes", true)

ix.container.Register("models/hlvr/combine_hazardprops/combinehazardprops_crate.mdl", {
	name = "Enfekte Kontrolü Kutusu",
	description = "Sarı bir Enfekte Kontrolü kutusu.",
	width = 7,
	height = 7
})

ix.container.Register("models/hlvr/combine_hazardprops/combinehazardprops_container.mdl", {
	name = "Enfekte Kontrolü Konteyneri",
	description = "Sarı bir Enfekte Kontrolü konteyneri.",
	width = 6,
	height = 4
})

ix.container.Register("models/hlvr/combine_hazardprops/combinehazardprops_barrel.mdl", {
	name = "Enfekte Kontrolü Varili",
	description = "Sarı bir Enfekte Kontrolü varili.",
	width = 4,
	height = 6
})

ix.container.Register("models/hlvr/combine_hazardprops/combinehazardprops_barrel_lock.mdl", {
	name = "Kilitli Enfekte Kontrolü Varili",
	description = "Kilitli sarı bir Enfekte Kontrolü varili.",
	width = 4,
	height = 6
})

do
	local COMMAND = {}
	COMMAND.description = "@cmdInfestationEdit"
	COMMAND.adminOnly = true

	function COMMAND:OnRun(client)
		if (!client:GetCharacter():HasFlags("pet")) then
			return "@noPetFlags"
		end

		client:SetNetVar("InfestationEditMode", 0)
		ix.log.Add(client, "infestationLog", client:GetName() .. " (" .. client:SteamID() .. ") " .. " has entered Infestation Edit Mode.")
	end

	ix.command.Add("InfestationEdit", COMMAND)
end

function PLUGIN:InitializedPlugins()
	-- Generate medical items - need the medical base to be initialized first before creating them.
	local ITEM = ix.item.Register("ic_coarctate_mucus", "base_medical", false, nil, true)
	ITEM.name = "coarctateItemName"
	ITEM.description = "coarctateItemDesc"
	ITEM.model = Model("models/jq/hlvr/props/xenpack/xen_bulb002.mdl")
	ITEM.width = 1
	ITEM.height = 1
	ITEM.category = "Infestation Control"
	ITEM.colorAppendix = {
		["blue"] = "itemCrafted",
		["red"] = "itemSus"
	}
	ITEM.healing = {
		painkillers = 20
	}

	ITEM = ix.item.Register("ic_erebus_mucus", "base_medical", false, nil, true)
	ITEM.name = "erebusItemName"
	ITEM.description = "erebusItemDesc"
	ITEM.model = Model("models/props_lab/jar01a.mdl")
	ITEM.width = 1
	ITEM.height = 1
	ITEM.category = "Infestation Control"
	ITEM.colorAppendix = {
		["blue"] = "itemHarvestedCrafted",
		["red"] = "itemSus"
	}
	ITEM.healing = {
		painkillers = 10
	}

	self:GenerateRecipes()
end
