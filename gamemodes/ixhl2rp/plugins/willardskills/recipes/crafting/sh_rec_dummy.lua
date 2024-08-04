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

RECIPE.uniqueID = "rec_dummy_emp"
RECIPE.name = "Ładunek EMP"
RECIPE.description = "Mały jednorazowy ładunek elektromagnetyczny, służy do wyłączenia elektroniki w okolicy detonacji. Można także użyć ładunek na technologii Kombinatu - jest w stanie wyłączyć pola siłowe na 5 minut, wieżyczki na 10 minut i wyłączyć skanery na stałe."
RECIPE.model = "models/Items/car_battery01.mdl"
RECIPE.category = "Przedmioty RP"
RECIPE.tool = "tool_toolkit"
RECIPE.ingredients = {["comp_steel"] = 3, ["comp_screws"] = 2, ["comp_refined_plastic"] = 2, ["comp_electronics"] = 6}
RECIPE.result = {["dummy_emp"] = 1}
RECIPE.hidden = false
RECIPE.skill = "crafting"
RECIPE.level = 40
RECIPE.experience = {
	{level = 40, exp = 150}, -- full xp
	{level = 45, exp = 75}, -- half xp
	{level = 50, exp = 0} -- no xp
}
RECIPE:Register()