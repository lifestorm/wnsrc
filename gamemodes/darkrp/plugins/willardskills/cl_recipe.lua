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

netstream.Hook("RebuildCrafting", function(data)
	PLUGIN.craftingPanel:Rebuild()
end)

netstream.Hook("CraftTime", function(data)
	ix.CraftCooldown = data
end)

netstream.Hook("SendMessageListToClient", function(messagelist, storedNewspapers)
	LocalPlayer().messagelist = messagelist
	local capda = vgui.Create("ixCAPDA")
	capda.storedNewspapers = storedNewspapers
	capda:CreateNewspaperButton()
end)

-- Called when the local player's crafting is rebuilt.
function PLUGIN:PlayerCraftingRebuilt(panel, categories) end

-- Called when the local player's crafting item should be adjusted.
function PLUGIN:PlayerAdjustCraftingRecipe(recipe) end