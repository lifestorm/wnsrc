--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_cigarette"
RECIPE.name = "Relabel cigarette pack"
RECIPE.description = "How about we remove the Benefactor stuff..."
RECIPE.model = "models/willardnetworks/cigarettes/cigarette_pack_1.mdl"
RECIPE.category = "Cigarette"
RECIPE.tool = "tool_scissors"
RECIPE.ingredients = {["ciggie_pack"] = 1, ["comp_cloth"] = 1}
RECIPE.result = {["ciggie_pack"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 15}, -- full xp
	{level = 10, exp = 10}, -- half xp
	{level = 15, exp = 0} -- no xp
}

function RECIPE:PlayerCraftRecipe(client)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	
	-- Take all the ingredients
	for ingredient, amount in pairs(self.ingredients) do
		for _ = 1, amount do
			local item = inventory:HasItem(ingredient)

			if (item) then
				if (item.uniqueID == "ciggie_pack") then
					item:SetData("relabeled", true)
				else
					item:Remove()
				end
			else
				break
			end
		end
	end

	-- Set the player's next crafting time
	client.ixNextCraftTime = CurTime() + 2
	netstream.Start("CraftTime", client.ixNextCraftTime)

	character:DoAction("recipe_" .. self.uniqueID)
end

RECIPE:Register()
