--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


do
	local function spawnerESP(client, entity, x, y, factor, distance)
		local alpha = math.Remap(math.Clamp(distance, 1500, 2000), 1500, 2000, 255, 45)
		local npcClass = entity:GetNPCClass()
		local npcCount = 0
		local entityIndex = entity:EntIndex()
		local timerName = "NPCSpawner" .. entityIndex

		for _, npc in ipairs(ents.FindByClass(npcClass)) do
			if (npc:GetNetVar("SpawnerID", 0) == entityIndex) then
				npcCount = npcCount + 1
			end
		end
		
		ix.util.DrawText(npcClass .. " Spawner (" .. npcCount .. "/" .. entity:GetMaxNPCs() .. ")", x, y, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
	end

	ix.observer:RegisterESPType("ix_npcspawner", spawnerESP, "npcspawner")
end

net.Receive("NPCSpawner_Edit", function()
	local spawner = net.ReadEntity()
	local bEnabled = net.ReadBool()
	local sClass = net.ReadString()
	local fPlayerNoSpawnRange = net.ReadFloat()
	local fMaxNPCs = net.ReadFloat()
	local fSpawnInterval = net.ReadFloat()

	vgui.Create("ixNPCSpawnerEditor"):Populate(spawner, bEnabled, sClass, fPlayerNoSpawnRange, fMaxNPCs, fSpawnInterval)
end)
