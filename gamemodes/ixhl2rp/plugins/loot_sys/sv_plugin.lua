--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

netstream.Hook("ixLootProceed", function(client, data)
	local ent = data.ent 
	local action = data.act 
	local tool = data.tool or false
	local key = data.key
	local tpy = data.tpy // 1 = default, 2 = without action and additional loot.
	local getTool	
	if tool then 
		getTool = client:GetCharacter():GetInventory():GetItemByID(tool.id, false)
		if (getTool.isTool) then
            getTool:DamageDurability(1)
        end
	end
	if action == 1 then 
		if tpy == 1 then 
			ent:EmitSound("willardnetworks/inventory/inv_bandage.wav")
			client:SetAction("You are interacting with container.", 3.5, function()
				if not ent:IsValid() then return client:Notify("This container is empty!") end
				if ix.loot.CheckDist(client, ent) <= 200 then 
					ent:FinalizeLoot(client:GetCharacter(), tool)
				else  
					client:Notify("You are too far away!")
				end
			end)
		elseif tpy == 2 then 
			ent:FinalizeLoot(client:GetCharacter(), tool, true)
		end
	elseif action == 2 then 
		if tpy == 1 then 
			if not getTool then 
				return client:Notify("You have no required tools.")				
			end
			ent:EmitSound("willardnetworks/inventory/inv_bandage.wav")
			client:SetAction("You are interacting with container.", 3.5, function()
				if not ent:IsValid() then return client:Notify("This container is empty!") end
				if ix.loot.CheckDist(client, ent) <= 200 then 
					ent:FinalizeLoot(client:GetCharacter(), false)
				else  
					client:Notify("You are too far away!")
				end
			end)
		end
	elseif action == 3 then 
		local getKey = client:GetCharacter():GetInventory():HasItem(key)
		if not getKey then 
			return client:Notify("You have no required keys.") 
		else 
			getKey:Remove()
		end
		client:Notify("You just used the key!")

		ent:EmitSound("willardnetworks/inventory/inv_bandage.wav")
		client:SetAction("You are interacting with container.", 3.5, function()
			if not ent:IsValid() then return client:Notify("Контейнер уже обыскан кем-то другим!") end
			if ix.loot.CheckDist(client, ent) <= 200 then 
				ent:FinalizeLoot(client:GetCharacter(), false)
			else  
				client:Notify("You are too far away!")
			end
		end)
	end		
end)
netstream.Hook("ixLootInt", function(client, data)
	local action = data.act 
	local ent = data.ent
	netstream.Start(client, "ixLootInteractStart", {act = action, ent = ent})
end)
function PLUGIN:LoadData()
	local contSpawns = ix.data.Get("contSpawns")

	if contSpawns then
		for k, v in pairs(contSpawns) do
			local entity = ents.Create("ix_containerspawn")
			entity:SetAngles(v[1])
			entity:SetPos(v[2])
			entity:SetLootType(v[3])
			entity:Spawn()
		end
	end
end

function PLUGIN:SaveData()
	local contSpawns = {}

	for k, v in pairs(ents.FindByClass("ix_containerspawn")) do
		contSpawns[#contSpawns + 1] = {
			v:GetAngles(),
			v:GetPos(), 
			v:GetLootType()
		}
	end

	ix.data.Set("contSpawns", contSpawns)
end