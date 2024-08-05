--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.name = "Test"
PLUGIN.author = "Gr4Ss"
PLUGIN.description = ""

PLUGIN.ingIndex = {}
PLUGIN.ingredients = {}
PLUGIN.itemRecipes = {}
PLUGIN.uncraftables = {}
PLUGIN.baseResourceCost = {}
PLUGIN.recipeTier = {}
PLUGIN.smugglingWorth = {}
PLUGIN.makeFromBaseCost = {}
PLUGIN.recipeVariantPreference = {
	["comp_chemicals"] = "break_artwhiskey_chemical",
	["comp_adhesive"] = "rec_comp_adhesive",
}

PLUGIN.costOverride = {
	["drink_proc_whiskey"] = 12,
	["drink_breen_water"] = 5
}

PLUGIN.bIncludeCooking = false

function PLUGIN:InitializedPlugins()
	self:CalculateCraftingMatrix()
end

function PLUGIN:CalculateCraftingMatrix()
	self:ParseRecipes()
	self:ManualCraftingRecipe("comp_bloodsyringe", 1, {["comp_syringe"] = 1})
	if (self.bIncludeCooking) then
		self:ManualCraftingRecipe("baking_bread_slice", 8, {["baking_bread"] = 1}, {"tool_knife"})
	end

	for k, v in pairs(ix.plugin.list.smuggler.itemList) do
		self.smugglingWorth[k] = v.buy / (v.stackSize or 1)
		self.makeFromBaseCost[k] = v.sell / (v.stackSize or 1)
	end

	for k, v in pairs(self.costOverride) do
		self.makeFromBaseCost[k] = v
	end

	self:AddToolsAsIngredients()

	self:CalculateUncraftables()

	self:CreateCraftingMatrixCSV()

	--[[
	for k, v in pairs(ix.recipe.stored) do
		if (!self:IsValidRecipe(v)) then continue end
		for result, amount in pairs(v.result) do
			if (!ingIndex[result]) then
				ingIndex[result] = #ingredients + 1
				ingredients[#ingredients + 1] = {
					sources = {v.name},
					craftable = true
				}
			else
				ingredients[ ingIndex[result] ].craftable = true
				table.insert(ingredients[ ingIndex[result] ].sources, v.name)
			end
		end
	end
	--]]

	self:CalculateResultCosts()
	table.SortByMember(self.uncraftables, "count")

	local changed = true
	local loop = 0
	while (changed and loop < 20) do
		changed = false
		loop = loop + 1
		for k, v in pairs(self.baseResourceCost) do
			local cost = 0
			for ing, amount in pairs(v) do
				if (!self.makeFromBaseCost[ing]) then
					--print("missing sell price", ing)
					continue
				end
				cost = cost + amount * self.makeFromBaseCost[ing]
			end

			local craftingRecipes = self.itemRecipes[k]
			if (craftingRecipes) then
				for _, data in pairs(craftingRecipes) do
					if (#craftingRecipes > 1 and data.id != self.recipeVariantPreference[k]) then continue end
					local cost2 = 0
					for ing, amount in pairs(data.ingredients) do
						if (!self.makeFromBaseCost[ing]) then
							--print("missing sell price", ing)
							continue
						end
						cost2 = cost2 + amount * self.makeFromBaseCost[ing]
					end

					cost = math.min(cost2, cost)
				end
			end
			local newCost = math.min(self.makeFromBaseCost[k] or math.huge, cost)
			if (!self.makeFromBaseCost[k] or self.makeFromBaseCost[k] != newCost) then
				changed = true
			end
			self.makeFromBaseCost[k] = math.min(self.makeFromBaseCost[k] or math.huge, cost)
		end
	end
	self:CreateResultCostCSV()

	--PrintTable(self.uncraftables)
end

local whitelist = {["crafting"] = true, ["medicine"] = true}
if (PLUGIN.bIncludeCooking) then whitelist["cooking"] = true end
function PLUGIN:IsValidRecipe(recipe)
	if (!whitelist[recipe.skill]) then return false end
	if (recipe.category == "Breakdown") then return false end
	if (!recipe.ingredients or !recipe.result) then return false end

	return true
end

function PLUGIN:AddNewIngredient(ingredient)
	if (!self.ingIndex[ingredient]) then
		self.ingIndex[ingredient] = #self.ingredients + 1
		self.ingredients[#self.ingredients + 1] = {
			id = ingredient,
			sources = {},
			craftable = self.itemRecipes[ingredient] != nil
		}
	end
end

function PLUGIN:SetIngredientCraftable(ingredient, name)
	if (self.ingIndex[ingredient]) then
		self.ingredients[self.ingIndex[ingredient]].craftable = true
		table.insert(self.ingredients[self.ingIndex[ingredient]].sources, name)
	end
end

function PLUGIN:AddToolsAsIngredients()
	for result, variants in pairs(self.itemRecipes) do
		for variant, data in ipairs(variants) do
			for _, tool in ipairs(data.tools) do
				self:AddNewIngredient(tool)
			end
		end
	end
end

function PLUGIN:ManualCraftingRecipe(result, amount, ingredients, tools, station, skill, level)
	for ingredient in pairs(ingredients) do
		self:AddNewIngredient(ingredient)
	end

	self.itemRecipes[result] = self.itemRecipes[result] or {}
	table.insert(self.itemRecipes[result], {
		amount = amount,
		ingredients = ingredients,
		tools = tools or {},
		station = station,
		recipe = "Manual Crafting",
		skill = skill or "None",
		level = level or 0
	})
	self.ingredients[self.ingIndex[result]].craftable = true
	table.insert(self.ingredients[self.ingIndex[result]].sources, "Manual Crafting")
end

function PLUGIN:ParseRecipes()
	for _, recipe in pairs(ix.recipe.stored) do
		if (!self:IsValidRecipe(recipe)) then continue end
		for ingredient, amount in pairs(recipe.ingredients) do
			self:AddNewIngredient(ingredient)
		end

		for result, amount in pairs(recipe.result) do
			self:SetIngredientCraftable(result, recipe.name)

			self.itemRecipes[result] = self.itemRecipes[result] or {}
			table.insert(self.itemRecipes[result], {
				id = recipe.uniqueID,
				amount = amount,
				ingredients = recipe.ingredients,
				tools = recipe.tools,
				station = recipe.station,
				recipe = recipe.name,
				skill = recipe.skill,
				level = recipe.level
			})

			if (!recipe.tools) then
				self.itemRecipes[result][#self.itemRecipes[result]].tools = {recipe.tool}
			end
		end
	end
end

function PLUGIN:CalculateUncraftables()
	for k, v in ipairs(self.ingredients) do
		if (!v.craftable) then
			self.uncraftables[#self.uncraftables + 1] = {id = v.id, count = 0}
		end
	end
end

function PLUGIN:IsUncraftable(item)
	for k, v in ipairs(self.uncraftables) do
		if (v.id == item) then
			return true
		end
	end
end

function PLUGIN:SelectSingleVariant(result, variants)
	if (#variants > 1) then
		if (self.recipeVariantPreference[result]) then
			for _, data in pairs(variants) do
				if (data.id ==self.recipeVariantPreference[result]) then
					return data.ingredients, data.amount
				end
			end
		else
			table.SortByMember(variants, "level", true)
			self.recipeVariantPreference[result] = variants[1].id
			return variants[1].ingredients, variants[1].amount
		end
	else
		return variants[1].ingredients, variants[1].amount
	end
end

function PLUGIN:CalculateBaseResourceCost(ingredients, resAmount)
	local inputs = {}
	for ing, amount in pairs(ingredients) do
		if (self:IsUncraftable(ing)) then
			inputs[ing] = (inputs[ing] or 0) + amount / resAmount
		elseif (self.baseResourceCost[ing]) then
			for resIng, resAm in pairs(self.baseResourceCost[ing]) do
				inputs[resIng] = (inputs[resIng] or 0) + resAm * amount / resAmount
			end
		else
			return false
		end
	end

	return inputs
end

function PLUGIN:CalculateResultCosts()
	local bNewFound = false
	local iters = 1
	repeat
		-- reset loop condition
		local tempResult = {}
		bNewFound = false
		for result, variants in pairs(self.itemRecipes) do
			-- prevent doing the same recipe again and again
			if (self.baseResourceCost[result]) then continue end

			local ingredients, amount = self:SelectSingleVariant(result, variants)
			if (!ingredients) then print("PANIC", result) end

			local inputs = self:CalculateBaseResourceCost(ingredients, amount)
			if (inputs) then
				bNewFound = true
				self.recipeTier[result] = iters
				tempResult[result] = inputs
				for ing in pairs(inputs) do
					for k, tbl in ipairs(self.uncraftables) do
						if (tbl.id == ing) then
							self.uncraftables[k].count = (self.uncraftables[k].count or 0) + 1
							break
						end
					end
				end
			end
		end

		for k, v in pairs(tempResult) do
			self.baseResourceCost[k] = v
		end

		iters = iters + 1
	until bNewFound == false
end

function PLUGIN:CreateCraftingMatrixCSV()
	if (file.Exists("craftingMatrix.csv", "DATA")) then
		file.Delete("craftingMatrix.csv")
	end

	local outputString = ""
	local ingOffset = 5
	for i = 1, ingOffset do
		outputString = outputString..";"
	end
	for k, v in ipairs(self.ingredients) do
		outputString =  outputString..v.id..";"
	end
	file.Append("craftingMatrix.csv", outputString.."\n")

	for result, variants in pairs(self.itemRecipes) do
		table.SortByMember(variants, "level", true)
		for variant, data in ipairs(variants) do
			local outputRow = {result, data.recipe, data.skill, data.level, data.amount}
			for ingredient, amount in pairs(data.ingredients) do
				outputRow[self.ingIndex[ingredient] + ingOffset] = amount
			end

			for _, tool in ipairs(data.tools) do
				outputRow[self.ingIndex[tool] + ingOffset] = "T"
			end

			outputString = ""
			for i = 1, #self.ingredients + ingOffset do
				outputString = outputString..string.gsub(outputRow[i] or "", "%.", ",")..";"
			end
			file.Append("craftingMatrix.csv", outputString.."\n")
		end
	end
end

function PLUGIN:CreateResultCostCSV()
	if (file.Exists("craftingBaseResourceMatrix.csv", "DATA")) then
		file.Delete("craftingBaseResourceMatrix.csv")
	end

	local outputString = ""
	local ingOffset = 5
	for i = 1, ingOffset do
		outputString = outputString..";"
	end
	for k, v in ipairs(self.uncraftables) do
		outputString =  outputString..v.id..";"
	end
	file.Append("craftingBaseResourceMatrix.csv", outputString.."\n")

	for result, costs in pairs(self.baseResourceCost) do
		local outputRow = {result, self.recipeTier[result], self.smugglingWorth[result] or "N/A", self.makeFromBaseCost[result], math.max((self.smugglingWorth[result] or 0) - self.makeFromBaseCost[result])}
		for ingredient, amount in pairs(costs) do
			for k, uncraft in ipairs(self.uncraftables) do
				if (uncraft.id == ingredient) then
					outputRow[k + ingOffset] = amount
				end
			end
		end

		outputString = ""
		for i = 1, #self.uncraftables + ingOffset do
			outputString = outputString..string.gsub(outputRow[i] or "", "%.", ",")..";"
		end
		file.Append("craftingBaseResourceMatrix.csv", string.gsub(outputString, "%.", ",").."\n")
	end
end