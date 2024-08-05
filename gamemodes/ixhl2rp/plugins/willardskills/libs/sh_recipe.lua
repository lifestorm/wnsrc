--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix

ix.recipe = ix.recipe or {}
ix.recipe.stored = ix.recipe.stored or {}

--[[
	Begin defining the recipe class base for other recipe's to inherit from.
--]]

--[[ Set the __index meta function of the class. --]]
local CLASS_TABLE = {__index = CLASS_TABLE}

CLASS_TABLE.name = "Blueprint Base"
CLASS_TABLE.uniqueID = "blueprint_base"
CLASS_TABLE.skin = 0
CLASS_TABLE.model = "models/error.mdl"
CLASS_TABLE.category = "Other"
CLASS_TABLE.description = "A recipe with no description."

-- Called when the recipe is converted to a string.
function CLASS_TABLE:__tostring()
	return "RECIPE["..self.name.."]"
end

--[[
	A function to override an recipe's base data. This is
	just a nicer way to set a value to go along with
	the method of querying.
--]]
function CLASS_TABLE:Override(varName, value)
	self[varName] = value
end

-- A function to register a new recipe.
function CLASS_TABLE:Register()
	return ix.recipe:Register(self)
end

function CLASS_TABLE:PlayerCanCraftRecipe(client)
	return ix.recipe:PlayerCanCraftRecipe(self, client)
end

--[[
	End defining the base recipe class.
	Begin defining the recipe utility functions.
--]]

-- A function to get all recipes.
function ix.recipe:GetAll()
	return self.stored
end

-- A function to get a new recipe.
function ix.recipe:New()
	local object = {}
		setmetatable(object, CLASS_TABLE)
		CLASS_TABLE.__index = CLASS_TABLE
	return object
end

-- A function to register a new recipe.
function ix.recipe:Register(recipe)
	recipe.uniqueID = string.utf8lower(string.gsub(recipe.uniqueID or string.gsub(recipe.name, "%s", "_"), "['%.]", ""))
	self.stored[recipe.uniqueID] = recipe

	if (recipe.model) then
		util.PrecacheModel(recipe.model)

		if (SERVER) then
			resource.AddFile(recipe.model)
		end
	end
end

-- A function to get an recipe by its name.
function ix.recipe:FindByID(identifier)
	if (identifier and identifier != 0 and type(identifier) != "boolean") then
		if (self.stored[identifier]) then
			return self.stored[identifier]
		end

		local lowerName = string.utf8lower(identifier)
		local recipe = nil

		for _, v in pairs(self.stored) do
			local recipeName = v.name

			if (string.find(string.utf8lower(recipeName), lowerName)
			and (!recipe or string.utf8len(recipeName) < string.utf8len(recipe.name))) then
				recipe = v
			end
		end

		return recipe
	end
end

function ix.recipe:Initialize()
	local recipes = self:GetAll()

	for _, v in pairs(recipes) do
		if (v.OnSetup) then
			v:OnSetup()
		end
	end
end

-- Called when a player attempts to craft an item.
function ix.recipe:PlayerCanCraftRecipe(recipe, client, inventory)
	local character = client:GetCharacter()
	inventory = inventory or character:GetInventory()

	if (recipe.skill != "bartering" and !character:CanDoAction("recipe_"..recipe.uniqueID)) then
		return false, "You do not have the required skill level to craft this recipe."
	end

	-- Check if the player has all the needed tools if there are any needed
	if (recipe.tool and !istable(recipe.tool)) then
		if !ix.item.list[recipe.tool] then
			ErrorNoHalt("[Crafting] Recipe "..recipe.name.." has an unexisting tool "..recipe.tool.."!\n")
			return false, "Recipe has unexisting tool "..recipe.tool.."!"
		elseif (!inventory:HasItem(recipe.tool)) then
			return false, "You do not have a "..ix.item.list[recipe.tool].name.."."
		end
	end

	if recipe.tools and istable(recipe.tools) then
		for _, v in pairs(recipe.tools) do
			if ix.item.list[v] then
				if (!inventory:HasItem(v)) then
					return false, "You do not have a "..ix.item.list[v].name.."."
				end
			else
				ErrorNoHalt("[Crafting] Recipe "..recipe.name.." has an unexisting tool "..v.."!\n")
				return false, "Recipe has unexisting tool "..v.."!"
			end
		end
	end

	-- Check for the ingredients
	if (recipe.ingredients) then
		for ingredient, amount in pairs(recipe.ingredients) do
			if (!ix.item.list[ingredient]) then
				ErrorNoHalt("[Crafting] Recipe "..recipe.name.." has an unexisting ingredient "..ingredient.."!\n")
				return false, "Recipe has unexisting ingredient "..ingredient.."!"
			end

			local count = inventory:GetItemCount(ingredient)
			if (count == 0) then
				return false, "You do not have any "..ix.item.list[ingredient].name.."."
			elseif (count < amount) then
				local name = ingredient
				if (amount > 1) then
					name = Schema:Pluralize(ix.item.list[ingredient].name)
				end
				return false, "You need at least "..tostring(amount).." "..name.."."
			end
		end
	end

	-- Check if player is near a crafting station if needed
	if (recipe.station) then
		if (!istable(recipe.station)) then
			if (ix.item.list[recipe.station]) then
				-- Find the entity the player is looking at
				local entity = client:GetEyeTraceNoCursor().Entity

				if (IsValid(entity)) then
					if (entity:GetClass() != "ix_item") then
						return false, "The attempted station is invalid!"
					else
						if !entity.GetItemTable or (entity.GetItemTable and !entity:GetItemTable()) then
							return false, "This is an invalid type of station for this recipe!"
						end

						local itemTable = entity:GetItemTable()
						if (itemTable.uniqueID != recipe.station) then
							return false, "This is the wrong type of station for this recipe!"
						end
						if (client:GetShootPos():DistToSqr(entity:GetPos()) > 100 * 100) then
							return false, "You need to be closer to the station!"
						end
					end
				else
					return false, "You need to be looking at a station!"
				end
			else
				ErrorNoHalt("[Crafting] Recipe "..recipe.name.." has an unexisting station "..recipe.station.."!\n")
				return false, "Recipe has unexisting station "..recipe.station.."!"
			end
		else
			local validStations = {}
			local bFound, bInvalidStationEntity = false, false

			local entity = client:GetEyeTraceNoCursor().Entity
			local bEntityValid = IsValid(entity)
			if (!bEntityValid or client:GetShootPos():DistToSqr(entity:GetPos()) > 100 * 100) then
				bInvalidStationEntity = true
			end

			local campFire = recipe.canUseCampfire
			local campFireText = campFire and " or a Campfire" or ""
			if (campFire and !bInvalidStationEntity and bEntityValid and entity:GetClass() == "ix_campfire") then
				bFound = true
			end

			if (!bFound) then
				if (entity:GetClass() != "ix_item" or !entity:GetItemTable()) then
					bInvalidStationEntity = true
				end

				for _, v in pairs(recipe.station) do
					if ix.item.list[v] then
						validStations[#validStations + 1] = ix.item.list[v]:GetName()

						if (bInvalidStationEntity) then continue end -- too far/invalid/wrong class, don't bother checking

						local itemTable = entity:GetItemTable()
						if (itemTable.uniqueID != v) then
							continue
						end

						bFound = true
						break -- valid station found, stop checking station loop
					end
				end
			end

			if (!bFound) then
				return false, string.format("You need to be near and looking at a %s"..campFireText..".", table.concat(validStations, " or a "))
			end
		end
	end

	-- Check if player has the crafting license if needed
	if (recipe.skill == "bartering" and !character:HasPermit(recipe.category)) then
		return false, "You do not have a business permit for this category of items, contact the Combine Civil Administration."
	end

	if (recipe.cost and isnumber(recipe.cost)) then
		local itemID = character:GetIdCard()
		if (itemID) then
			if (ix.item.instances[itemID]) then
				local credits = ix.item.instances[itemID]:GetCredits()

				if (credits < recipe.cost) then
					return false, "You do not have enough credits to purchase this item!"
				end
			else
				return false, "Could not find ID card!"
			end
		else
			return false, "You do not have an active ID card!"
		end
	end

	return true
end

if (CLIENT) then
	function ix.recipe:GetIconInfo(recipe)
		local model = recipe.model or "models/error.mdl"
		local skin = recipe.skin

		return model, skin
	end

	function ix.recipe:CanPlayerSeeRecipe(recipe)
		if (recipe.hidden) then
			return false
		end

		return true
	end
else
	function ix.recipe:PlayerCraftRecipe(recipe, client)
		if (recipe.PlayerCraftRecipe) then
			recipe:PlayerCraftRecipe(client)

			return
		end

		local character = client:GetCharacter()
		local inventory = character:GetInventory()

		-- Take all the ingredients
		for ingredient, amount in pairs(recipe.ingredients) do
			for _ = 1, amount do
				local item = inventory:HasItem(ingredient)
				if (item) then
					item:Remove()
				else
					break
				end
			end
		end

		-- Break tools
		if (recipe.tools and !table.IsEmpty(recipe.tools)) then
			for k, v in pairs(recipe.tools) do
				local item = inventory:HasItem(v)

				if (item and item.isTool) then
					item:DamageDurability(1)
				end
			end
		end

		if (recipe.tool) then
			local item = inventory:HasItem(recipe.tool)

			if (item and item.isTool) then
				item:DamageDurability(1)
			end
		end

		-- Give the result
		for result, amount in pairs(recipe.result) do
			local item = ix.item.list[result]
			if (!item) then continue end

			local actualAmount
			if (type(amount) == "table") then
				actualAmount = amount[math.random(1, #amount)]
			else
				actualAmount = amount
			end

			if (item.maxStackSize) then
				-- fill up existing stacks if possible
				local items = inventory:GetItemsByUniqueID(result)
				for _, v in ipairs(items) do
					if (v:GetStackSize() < v.maxStackSize) then
						local toAdd = math.min(v.maxStackSize - v:GetStackSize(), actualAmount)
						actualAmount = actualAmount - toAdd
						v:AddStack(toAdd)

						if (actualAmount == 0) then
							break
						end
					end
				end
			end

			if (actualAmount > 0) then
				for i = 1, actualAmount, (item.maxStackSize or 1) do
					-- Give new items in stacks if possible
					local data
					if (item.maxStackSize) then
						data = {stack = math.min(actualAmount + 1 - i, item.maxStackSize)}
					end

					if (!inventory:Add(result, 1, data)) then
						ix.item.Spawn(result, client, nil, nil, data)
					end
				end
			end
		end
		-- Set the player's next crafting time
		client.ixNextCraftTime = CurTime() + 2
		netstream.Start("CraftTime", client.ixNextCraftTime)

		character:DoAction("recipe_"..recipe.uniqueID)
	end
end
