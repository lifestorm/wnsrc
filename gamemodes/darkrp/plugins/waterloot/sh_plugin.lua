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

PLUGIN.name = "Water Loot"
PLUGIN.description = "Adds water pipe entity to loot water and possibility of retrieving water from deep water volumes, filtration required."
PLUGIN.author = "Fruity"

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

ix.config.Add("waterFillPerRefill", 100, "La quantité d'eau en pourcentage que doit contenir une bouteille d'eau lorsqu'elle est remplie.", nil, {
	data = {min = 1, max = 100},
	category = "Eau"
})

ix.config.Add("waterFiltrationTimeNeeded", 2, "Temps en minutes nécessaire pour filtrer l'eau dans une marmite.", nil, {
	data = {min = 1, max = 60},
	category = "Eau"
})

ix.config.Add("chanceToGetLeech", 50, "Pourcentage de chances d'obtenir une sangsue lors du filtrage de l'eau.", nil, {
	data = {min = 1, max = 100},
	category = "Eau"
})

function PLUGIN:InitializedPlugins()
    local cookingPot = ix.item.list["tool_cookingpot"]
    if !cookingPot then return end

    cookingPot.functions.Place = {
		name = "Placer sur la surface de cuisson",
		tip = "equipTip",
		icon = "icon16/link_add.png",
        OnRun = function(itemTable)
			if (SERVER) then
				local client = itemTable.player
				self:PlaceCookingPot(client, itemTable)

				return false
			end
        end,

		OnCanRun = function(itemTable)
			if IsValid(itemTable.entity) then return false end
		end
    }

	cookingPot.OnTransferred = function(item, curInv, inventory)
		if (SERVER) then
			if item.cookingPlatform and IsValid(item.cookingPlatform) then
				item.cookingPlatform.HasPotPlaced = nil
				item.cookingPlatform:StopSound( "ambient/levels/canals/water_flow_loop1.wav" )
			end
		end
	end
end

function PLUGIN:CanTransferItem(itemTable, curInv, inventory)
	if itemTable and IsValid(itemTable.entity) then
		local client = itemTable.player
		if itemTable.entity.HasPotPlaced then
			if IsValid(client) then client:Notify("Ce four est surmonté d'une marmite !") end
			return false
		end
	end
end