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

PLUGIN.name = "Simple item cleaner"
PLUGIN.description = "Automatically removes unwanted items"
PLUGIN.author = "DrodA"
PLUGIN.version = 2.0

ix.config.Add("EnableItemCleaner", true, "Enables or disables item cleaner.", function(oldVal, newVal)
		if (SERVER) then
			PLUGIN:CreateTimer()
		end
	end, {
	category = "Other"
})

if (!SERVER) then return end

PLUGIN.itemCategories = {
	["Junk"] = 300
}

PLUGIN.entityTypes = {
	["ix_drop"] = 300,
	["ix_workerk_water"] = 300,
	["ix_workerk_gas"] = 300,
	["ix_workerk_electric"] = 300
}

PLUGIN.markedEntities = PLUGIN.markedEntities or {}

function PLUGIN:OnSavedItemLoaded(items, entities)
	for _, v in ipairs(entities) do
		self:OnItemSpawned(v)
	end
end

function PLUGIN:OnItemSpawned(entity)
	local item = ix.item.instances[entity.ixItemID]
	if (item) then
		if (item.junkCleanTime) then
			self.markedEntities[entity] = os.time() + item.junkCleanTime * 60
		elseif (self.itemCategories[item.category]) then
			self.markedEntities[entity] = os.time() + self.itemCategories[item.category] * 60
		end
	end
end

function PLUGIN:OnEntityCreated(entity)
	local class = entity:GetClass()
	if (self.entityTypes[class]) then
		self.markedEntities[entity] = os.time() + self.entityTypes[class]
	end
end

function PLUGIN:EntityRemoved(entity)
	if (self.markedEntities[entity]) then
		self.markedEntities[entity] = nil
	end
end

function PLUGIN:CreateTimer()
	if (!ix.config.Get("EnableItemCleaner")) then
		timer.Remove("ixItemCleanerTimer")
		return
	end

	local pairs, IsValid = pairs, IsValid
	timer.Create("ixItemCleanerTimer", 61, 0, function()
		local time = os.time()
		for k, v in pairs(self.markedEntities) do
			if (v < time) then
				self.markedEntities[k] = nil
				if (IsValid(k)) then
					k:Remove()
				end
			end
		end
	end)
end

function PLUGIN:InitializedConfig()
	self:CreateTimer()
end
