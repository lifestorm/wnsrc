--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:SaveData()
	local data = {}

	for _, v in ipairs(ents.FindByClass("ix_npcspawner")) do
		data[#data + 1] = {
			v:GetPos(),
			v:GetAngles(),
			v:GetEnabled(),
			v:GetNPCClass(),
			v:GetSpawnPosStart(),
			v:GetSpawnPosEnd(),
			v:GetPlayerNoSpawnRange(),
			v:GetMaxNPCs(),
			v:GetSpawnInterval()
		}
	end

	ix.data.Set("npcSpawners", data)
end

function PLUGIN:LoadData()
	for _, v in ipairs(ix.data.Get("npcSpawners") or {}) do
		local entity = ents.Create("ix_npcspawner")
		entity:SetPos(v[1])
		entity:SetAngles(v[2])
		entity:Spawn()

		entity:SetEnabled(v[3])
		entity:SetNPCClass(v[4])
		entity:SetSpawnPosStart(v[5])
		entity:SetSpawnPosEnd(v[6])
		entity:SetPlayerNoSpawnRange(v[7])
		entity:SetMaxNPCs(v[8])
		entity:SetSpawnInterval(v[9])

		local physicsObject = entity:GetPhysicsObject()
		
		if (IsValid(physicsObject)) then
			physicsObject:EnableMotion(false)
		end

		entity:SetupTimer(v[3])
	end
end
