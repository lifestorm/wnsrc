--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

for _, v in pairs(ix.item.list) do
	if v.category == "Clothing - Citizen" or v.category == "Clothing - Citizen Trousers" then 
		local RECIPE = ix.recipe:New()
		RECIPE.uniqueID = "rec_"..v.uniqueID
		RECIPE.name = "Tear "..v.name
		RECIPE.description = "Tears the "..v.name.." to shreds to obtain some cloth scraps."
		RECIPE.model = v.model
		RECIPE.category = "Breakdown"
		RECIPE.subcategory = "Clothes"
		RECIPE.tool = "tool_scissors"
		RECIPE.ingredients = {[v.uniqueID] = 1}
		RECIPE.result = {["comp_cloth"] = 1} 
		RECIPE.hidden = false
		RECIPE.skill = "crafting"
		RECIPE.level = 0
		RECIPE.experience = {
			{level = 0, exp = 30}, -- full xp
			{level = 10, exp = 15}, -- half xp
			{level = 25, exp = 0} -- no xp
		}
		RECIPE:Register()
	end
end