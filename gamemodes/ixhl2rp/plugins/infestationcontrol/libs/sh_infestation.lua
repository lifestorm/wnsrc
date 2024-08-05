--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.infestation = ix.infestation or {}
ix.infestation.stored = ix.infestation.stored or {}
ix.infestation.types = {}

function ix.infestation.LoadFromDir(path)
	for _, v in ipairs(file.Find(path .. "/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		ix.infestation.RegisterInfestationType(niceName, path .. "/" .. v, false, nil)
	end
end

function ix.infestation.RegisterInfestationType(uniqueID, path, luaGenerated, infestationTable)
	INFESTATION = {index = table.Count(ix.infestation.types) + 1}
		if (!luaGenerated and path) then
			ix.util.Include(path, "shared")
		elseif (luaGenerated and infestationTable) then
			table.Merge(INFESTATION, infestationTable)
		end

		INFESTATION.name = INFESTATION.name or "Unknown"
		INFESTATION.color = INFESTATION.color or Color(255, 175, 0)
		INFESTATION.reading = INFESTATION.reading or {0, 0}
		INFESTATION.chemical = INFESTATION.chemical or nil
		INFESTATION.uniqueID = INFESTATION.uniqueID or uniqueID

		ix.infestation.types[INFESTATION.uniqueID] = INFESTATION
	INFESTATION = nil
end

function ix.infestation.Get(identifier)
	return ix.infestation.types[identifier]
end

hook.Add("DoPluginIncludes", "ixInfestation", function(path, pluginTable)
	ix.infestation.LoadFromDir(path .. "/infestations")
end)
