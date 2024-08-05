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
RECIPE.uniqueID = "rec_water_bucket_water"
RECIPE.name = "Watering Can (Full)"
RECIPE.description = "Fills your Watering Can with some water."
RECIPE.model = "models/props_junk/metalgascan.mdl"
RECIPE.category = "Farming"
RECIPE.ingredients = {["water_bucket"] = 1, ["crafting_water"] = 1}
RECIPE.result = {["water_bucket"] = 1}
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
				if (item.uniqueID == "water_bucket") then
					item:SetData("water", 100)
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


local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_water_bucket"
RECIPE.name = "Watering Can"
RECIPE.description = "A Watering Can, useful in farming."
RECIPE.model = "models/props_junk/metalgascan.mdl"
RECIPE.category = "Farming"
RECIPE.ingredients = {["comp_iron"] = 3}
RECIPE.result = {["water_bucket"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 10
RECIPE.experience = {
	{level = 10, exp = 105}, -- full xp
	{level = 15, exp = 50}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_fertilizer"
RECIPE.name = "Fertilizer"
RECIPE.description = "A sack filled with grounded bones, useful in gardening to Fertilize the plants"
RECIPE.model = "models/props_junk/garbage_milkcarton001a.mdl"
RECIPE.category = "Farming"
RECIPE.ingredients = {["ing_bone"] = 3}
RECIPE.result = {["fertilizer"] = 3}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 15}, -- full xp
	{level = 10, exp = 5}, -- half xp
	{level = 20, exp = 0} -- no xp
}

RECIPE:Register()

local RECIPE = ix.recipe:New()
RECIPE.uniqueID = "rec_craft_planter"
RECIPE.name = "Planter"
RECIPE.description = "A small and portable planter that's used to plant... plants! It's quite small and can even be placed indoors (if you have a proper light), go wild, farmer!"
RECIPE.model = "models/wn7new/advcrates/n7_planter_wood.mdl"
RECIPE.category = "New Frontiers"
RECIPE.station = "tool_craftingbench"
RECIPE.ingredients = {["comp_cloth"] = 2, ["comp_plastic"] = 3, ["comp_screws"] = 3, ["comp_wood"] = 5}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.result = {["planter_placer"] = 1}
RECIPE.level = 0
RECIPE.experience = {
	{level = 0, exp = 80}, -- full XP
	{level = 15, exp = 40}, -- half XP
	{level = 20, exp = 0} -- 0 XP
}
RECIPE:Register()
