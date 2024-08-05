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

netstream.Hook("CraftRecipe", function(client, data, barteringStock)
	local recipe = ix.recipe.stored[data]

	local bPlayerCanCraft, err = PLUGIN:PlayerCanCraft(client)

	if (!bPlayerCanCraft) then
		if (!err) then
			err = "You cannot craft right now (but a Dev fucked up and forgot to add in why)!"
		end
		client:NotifyLocalized(err)
		return false
	end

	local bCanCraftRecipe, err2 = ix.recipe:PlayerCanCraftRecipe(recipe, client)

	if (!bCanCraftRecipe) then
		if (!err2) then
			err2 = "You cannot craft this (but a Dev fucked up and forgot to add in why)!"
		end
		client:NotifyLocalized(err2)
		return false
	end

	if !barteringStock then
		ix.recipe:PlayerCraftRecipe(recipe, client)
		client:NotifyLocalized("You've successfully made a "..recipe.name)
	else
		if (ix.config.Get("creditsNoConnection")) then
			client:NotifyLocalized("errorNoConnection")
			return false
		end

		local character = client:GetCharacter()
		local result = recipe.result or {["piece_of_metal"] = 1}
		local k = next(result)
		local index = ix.item.list[k] or client:NotifyLocalized("INVALID RESULT")
		if istable(index) then
			local resultName = index.name or "INVALID"
			local recipeCost = recipe.cost
			if recipe.skill == "bartering" then
				local barteringMultiplier = ix.config.Get("BarteringPriceMultiplier"..recipe.category) or 1
				recipeCost = (recipe.cost * barteringMultiplier) or 0

				local city = ix.city.main
				if !city:HasItem(k) then
					client:NotifyLocalized("No items in city stock.")
					return false
				end
			end

			character:SetPurchasedItems(k, 1)
			ix.city.main:TakeItem(k)
			client:NotifyLocalized("You've successfully bought a "..resultName)
			character:TakeCredits(recipeCost, "Bartering", "Bartering: "..recipe.name)
			ix.city.main:AddCredits(recipeCost)
			ix.city:SyncCityStock(client)

			character:DoAction("recipe_"..recipe.uniqueID)
		else
			return
		end
	end
end)

function PLUGIN:PlayerCanCraft(client)
	-- Check if the player has waited long enough for the next craft time
	local curTime = CurTime()
	if (client.ixNextCraftTime and curTime < client.ixNextCraftTime) then
		return false, "You need to wait "..tostring(math.Round(client.ixNextCraftTime - curTime, 1)).." seconds."
	end

	return true
end

-- Called when a player's crafted item should be adjusted.
function PLUGIN:PlayerAdjustCraftRecipe(client, recipe) end

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_pickupterminal", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})

	ix.saveEnts:RegisterEntity("ix_campfire", true, true, true, {
		OnSave = function(entity, data) --OnSave
            return {pos = data.pos, angles = data.angles, motion = false}
		end,
	})
end

-- data saving
function PLUGIN:SavePickupTerminals()
	local data = {}

	local entities = ents.GetAll()
	for i = 1, #entities do
		if (entities[i]:GetClass() != "ix_pickupterminal") then continue end

		local v = entities[i]
		data[#data + 1] = {v:GetPos(), v:GetAngles()}
	end

	ix.data.Set("pickupTerminals", data)
end

-- data loading
function PLUGIN:LoadPickupTerminals()
	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

	for _, v in ipairs(ix.data.Get("pickupTerminals") or {}) do
		local terminal = ents.Create("ix_pickupterminal")

		terminal:SetPos(v[1])
		terminal:SetAngles(v[2])
		terminal:Spawn()
	end
end

function PLUGIN:LoadCampfires()
	if (!ix.config.Get("SaveEntsOldLoadingEnabled")) then return end

	local campfires = ix.data.Get("campfire")
	if campfires then
		for _, v in pairs(campfires) do
			local entity = ents.Create("ix_campfire")
			entity:SetAngles(v.angles)
			entity:SetPos(v.position)
			entity:Spawn()

			local physicsObject = entity:GetPhysicsObject()
			if (IsValid(physicsObject)) then
				physicsObject:EnableMotion(false)
			end
		end
		MsgC(Color(0, 255, 0), "[CAMPFIRE] Campfires Loaded.\n")
	else
		MsgC(Color(0, 255, 0), "[CAMPFIRE] No Campfires Loaded.\n")
	end
end

-- A function to save the static props.
function PLUGIN:SaveCampfires()
	local campfires = {}

	for _, v in pairs(ents.FindByClass("ix_campfire")) do
		campfires[#campfires + 1] = {
			angles = v:GetAngles(),
			position = v:GetPos()
		}
	end

	ix.data.Set("campfire", campfires)
end

-- Called when Helix has loaded all of the entities.
function PLUGIN:InitPostEntity()
	self:LoadPickupTerminals()
end

-- Called just after data should be saved.
function PLUGIN:SaveData()
	self:SavePickupTerminals()
end

netstream.Hook("GetMessageList", function(client)
	local writingPlugin = ix.plugin.list["writing"]
	local storedNewspapers = writingPlugin.storedNewspapers or {}

	local query = mysql:Select("ix_camessaging")
	query:Select("message_id")
	query:Select("message_cid")
	query:Select("message_text")
	query:Select("message_date")
	query:Select("message_poster")
	query:Select("message_reply")
	query:Callback(function(result)
		result = result or {}
		netstream.Start(client, "SendMessageListToClient", result, storedNewspapers)
	end)

	query:Execute()
end)

netstream.Hook("RemoveCAMessage", function(client, messageid)
	local queryObj = mysql:Delete("ix_camessaging")
		queryObj:Where("message_id", messageid)
	queryObj:Execute()
end)

netstream.Hook("SetCAMessageReply", function(client, messageid, reply)
	local queryObj = mysql:Update("ix_camessaging")
		queryObj:Where("message_id", messageid)
		queryObj:Update("message_reply", reply)
	queryObj:Execute()
end)