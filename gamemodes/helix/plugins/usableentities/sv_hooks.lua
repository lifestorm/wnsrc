--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]



ix.log.AddType("usableEntitySpawned", function(client, ...)
	local arg = {...}
	return string.format("%s has spawned a usable entity class '%s' with model '%s'.", client:Name(), arg[1], arg[2])
end)

function PLUGIN:RegisterSaveEnts()
	ix.saveEnts:RegisterEntity("ix_clock", true, true, true, {
		OnSave = function(entity, data)
			data.model = entity:GetModel()
		end,
		OnRestorePreSpawn = function(entity, data)
			entity:SetModel(data.model)
		end
	})

	ix.saveEnts:RegisterEntity("ix_lamp", true, true, true, {
		OnSave = function(entity, data)
			data.model = entity:GetModel()
		end,
		OnRestorePreSpawn = function(entity, data)
			entity:SetModel(data.model)
		end
	})

	ix.saveEnts:RegisterEntity("ix_toilet", true, true, true, {
		OnSave = function(entity, data)
			local inventory = ix.item.inventories[entity:GetNetVar("ID")]
			data.invID = inventory:GetID()
			data.model = entity:GetModel()
		end,
		OnRestore = function(entity, data)
			ix.inventory.Restore(data.invID, 1, 1, function(inventory)
				inventory.vars.isBag = true

				if (IsValid(entity)) then
					entity:SetNetVar("ID", inventory:GetID())
				end
			end)
		end,
		OnRestorePreSpawn = function(entity, data)
			entity:SetModel(data.model)
		end,
		ShouldSave = function(entity)
			local inventory = ix.item.inventories[entity:GetNetVar("ID")]
			return inventory:GetID() >= 1
		end,
		ShouldRestore = function(data)
			return data.invID >= 1
		end
	})

	ix.saveEnts:RegisterEntity("ix_shop_sign", true, true, true, {
		OnSave = function(entity, data) end
	})
end
