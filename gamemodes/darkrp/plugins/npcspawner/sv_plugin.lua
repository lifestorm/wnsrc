--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


util.AddNetworkString("NPCSpawner_Edit")

net.Receive("NPCSpawner_Edit", function(_, client)
	if (client:IsAdmin()) then
		local spawner = net.ReadEntity()
		local bEnabled = net.ReadBool()
		local sClass = net.ReadString()
		local fPlayerNoSpawnRange = net.ReadFloat()
		local fMaxNPCs = net.ReadFloat()
		local fSpawnInterval = net.ReadFloat()

		spawner:SetEnabled(bEnabled)
		spawner:SetNPCClass(sClass)
		spawner:SetPlayerNoSpawnRange(fPlayerNoSpawnRange)
		spawner:SetMaxNPCs(fMaxNPCs)
		spawner:SetSpawnInterval(fSpawnInterval)

		spawner:SetupTimer(bEnabled)

		ix.saveEnts:SaveEntity(spawner)
	end
end)