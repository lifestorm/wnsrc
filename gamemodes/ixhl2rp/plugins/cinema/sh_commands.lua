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

ix.command.Add("MovieBars", {
	description = "Adds a movie bar effect to the player screen. Run the command again with the zero radius argument to remove the effect.",
	adminOnly = true,
    arguments = {
        ix.type.number 
	},
	OnRun = function(self, client, radius )
		PLUGIN:HandleMovieBars(client, radius)
	end
})

ix.command.Add("CinematicCamera", {
    description = "Sets every player in the range in the camera's perspective.",
    adminOnly = true,
    arguments = {
        ix.type.number,
        ix.type.text, 
    },
    argumentNames = { "Range(0 for global)", "Cam ID"},
    OnRun = function(self, client, range, camID)
		local cameraEnts = ents.FindByClass("ix_cutscenecamera")

		if !cameraEnts then 
			client:Notify("There aren't any cams in the map!")
		end 
		
        if range == 0 then
			for _, ent in ipairs(cameraEnts) do
				if IsValid(ent) and ent:GetNWInt("CameraID") == camID then
					for _, ply in ipairs(player.GetAll()) do
						if IsValid(ply) and ply:IsPlayer() then
							ply:SetViewEntity(ent)
						end
					end
				end 
			end
        else
            local cameraEnts = ents.FindByClass("ix_cutscenecamera")

            for _, ent in ipairs(cameraEnts) do
                if IsValid(ent) and ent:GetNWInt("CameraID") == camID then
                    for _, ply in ipairs(ents.FindInSphere(ent:GetPos(), tonumber(range))) do
                        if IsValid(ply) and ply:IsPlayer() then
                            ply:SetViewEntity(ent)
                        end
                    end
                    break
                end
            end
        end
    end
})

ix.command.Add("CinematicCameraPlayer", {
    description = "Sets a single player to a camera's ID.",
    adminOnly = true,
    arguments = {
        ix.type.character,
        ix.type.text, 
    },
    argumentNames = { "Character", "Cam ID"},
    OnRun = function(self, client, character, camID)
		local cameraEnts = ents.FindByClass("ix_cutscenecamera")
		local characterPly = character:GetPlayer()  

		if !characterPly then 
			client:Notify("Invalid Target!")
		end 

		if !cameraEnts then 
			client:Notify("No cams in the map!")
		end 
		
     
		local cameraEnts = ents.FindByClass("ix_cutscenecamera")

		for _, ent in ipairs(cameraEnts) do
			if IsValid(ent) and ent:GetNWInt("CameraID") == camID then
				characterPly:SetViewEntity(ent)
				break
			end
		end
        
    end
})

ix.command.Add("ResetCinematicCamera", {
	description = "Resets the cinematic camera for everybody",
	adminOnly = true,
	OnRun = function(self, client)
		for _, ply in ipairs(player.GetAll()) do
			if IsValid(ply) and ply:IsPlayer() then
				ply:SetViewEntity(ply)
			end
		end
	end
})


ix.command.Add("PortalNPC", {
	description = "Summon an NPC at your targeted point.",
	adminOnly = true,
	arguments = { ix.type.string },
	argumentNames = { "NPC" },
	OnRun = function(self, player, npcName)
		local npc = ents.Create(npcName)

		if IsValid(npc) then
			local trace = player:GetEyeTraceNoCursor()

			if trace.Hit then
				local destination = trace.HitPos + Vector(0, 0, 32) 
				local spawnDelay = math.Rand(1, 2)

				timer.Simple(spawnDelay, function()

					timer.Simple(0.2, function()
						local flash = ents.Create("light_dynamic")
						flash:SetKeyValue("brightness", "2")
						flash:SetKeyValue("distance", "256")
						flash:SetPos(destination + Vector(0, 0, 8))
						flash:Fire("Color", "33 255 0")
						flash:Spawn()
						flash:Activate()
						flash:Fire("TurnOn", "", 0)
						timer.Simple(0.5, function() if IsValid(flash) then flash:Remove() end end)

						util.ScreenShake(destination, 10, 100, 0.4, 1000, true)
					end)

					timer.Simple(0.25, function()
						if IsValid(npc) then
							if npc.CustomInitialize then
								npc:CustomInitialize()
							end

							npc:SetPos(destination + Vector(0, 0, 16))
							local angleToPlayer = (player:GetPos() - destination):Angle()
							npc:SetAngles(Angle(0, angleToPlayer.y, 0))

							
							local effectTeleport = VJ_HLR_Effect_PortalSpawn(destination)
							effectTeleport:SetKeyValue("ParticleScale", "2")
							effectTeleport:Fire("Kill", "", 1)

							local dynLight = ents.Create("light_dynamic")
							dynLight:SetKeyValue("brightness", "2")
							dynLight:SetKeyValue("distance", "200")
							dynLight:SetPos(destination)
							dynLight:SetLocalAngles(Angle(0, angleToPlayer.y, 0))
							dynLight:Fire("Color", "33 255 0")
							dynLight:Spawn()
							dynLight:Activate()
							dynLight:Fire("TurnOn", "", 0)
							dynLight:Fire("Kill", "", 0.3)

							npc:Spawn()
							npc:Activate()
						end
					end)
				end)
			else
				player:Notify("Look somewhere valid!")
			end
		else
			player:Notify(npcName.." isn't a valid NPC!")
		end
	end
})

ix.command.Add("PortalItem", {
	description = "Summon an item at your targeted point.",
	adminOnly = true,
	arguments = { ix.type.text },
	argumentNames = { "Item ID" },
	OnRun = function(self, client, item)
		local foundItem = false
		for uniqueID, itemData in pairs(ix.item.list) do
			if uniqueID == item then
				foundItem = true
				break
			end
		end

		if foundItem then
			local trace = client:GetEyeTraceNoCursor()
			if trace.Hit then
				local destination = trace.HitPos + Vector(0, 0, 32)
				local spawnDelay = math.Rand(1, 2)

				timer.Simple(spawnDelay, function()

					timer.Simple(0.2, function()
						local flash = ents.Create("light_dynamic")
						flash:SetKeyValue("brightness", "2")
						flash:SetKeyValue("distance", "256")
						flash:SetPos(destination + Vector(0, 0, 8))
						flash:Fire("Color", "33 255 0")
						flash:Spawn()
						flash:Activate()
						flash:Fire("TurnOn", "", 0)
						timer.Simple(0.5, function() if IsValid(flash) then flash:Remove() end end)

						util.ScreenShake(destination, 10, 100, 0.4, 1000, true)
					end)

					timer.Simple(0.25, function()
						local angleToPlayer = (client:GetPos() - destination):Angle()

						local effectTeleport = VJ_HLR_Effect_PortalSpawn(destination)
						effectTeleport:SetKeyValue("ParticleScale", "2") 
						effectTeleport:Fire("Kill", "", 1)

						local dynLight = ents.Create("light_dynamic")
						dynLight:SetKeyValue("brightness", "2")
						dynLight:SetKeyValue("distance", "200")
						dynLight:SetPos(destination)
						dynLight:SetLocalAngles(Angle(0, angleToPlayer.y, 0))
						dynLight:Fire("Color", "33 255 0")
						dynLight:Spawn()
						dynLight:Activate()
						dynLight:Fire("TurnOn", "", 0)
						dynLight:Fire("Kill", "", 0.3)

						local itemEntity = ix.item.Spawn(item, destination, function(item, entity)
							entity:SetRenderMode(RENDERMODE_TRANSCOLOR)
							entity:SetColor(Color(255, 255, 255, 0))
							
							timer.Create("portalItem"..CurTime(), 0.75, 1, function()
								if IsValid(entity) then
									entity:SetColor(Color(255, 255, 255, 255))
								end
							end)
						end)
					end)
				end)
			else
				client:Notify("Look at a valid spot!")
			end
		else
			client:Notify("You didn't put a valid item!")
		end
	end
})


ix.command.Add("PortalPlayer", {
	description = "Summon a player to your targeted point.",
	adminOnly = true,
	arguments = { ix.type.character },
	argumentNames = { "Nome" },
	OnRun = function(self, player, character)
		local target = character:GetPlayer()
		local trace = player:GetEyeTraceNoCursor()
		
		if trace.Hit then
			if target then
				local origin = target:GetPos()
				local destination = trace.HitPos
				
				targetPos = target:GetPos() 

				local flash = ents.Create("light_dynamic")
				flash:SetKeyValue("brightness", "2")
				flash:SetKeyValue("distance", "256")
				flash:SetPos(targetPos + Vector(0, 0, 8))
				flash:Fire("Color", "33 255 0")
				flash:Spawn()
				flash:Activate()
				flash:Fire("TurnOn", "", 0)
				timer.Simple(0.5, function() if IsValid(flash) then flash:Remove() end end)
				util.ScreenShake(targetPos, 10, 100, 0.4, 1000, true)

				local effectTeleport = VJ_HLR_Effect_PortalSpawn(targetPos + Vector(0, 0, 24))
				effectTeleport:SetKeyValue("ParticleScale", "10") 

				effectTeleport:Fire("Kill", "", 1)
				local dynLight = ents.Create("light_dynamic")
				dynLight:SetKeyValue("brightness", "2")
				dynLight:SetKeyValue("distance", "200")
				dynLight:SetPos(targetPos + Vector(0, 0, 8))
				dynLight:Fire("Color", "33 255 0")
				dynLight:Spawn()
				dynLight:Activate()
				dynLight:Fire("TurnOn", "", 0)
				dynLight:Fire("Kill", "", 0.3)


				timer.Create("summonplayer_"..tostring(target:EntIndex()), 0.75, 1, function()
					if IsValid(target) then
						target:SetPos(destination)
						local flash = ents.Create("light_dynamic")
						flash:SetKeyValue("brightness", "2")
						flash:SetKeyValue("distance", "256")
						flash:SetPos(destination + Vector(0, 0, 24))
						flash:Fire("Color", "33 255 0")
						flash:Spawn()
						flash:Activate()
						flash:Fire("TurnOn", "", 0)
						timer.Simple(0.5, function() if IsValid(flash) then flash:Remove() end end)
						util.ScreenShake(destination, 10, 100, 0.4, 1000, true)
		
						local effectTeleportExit = VJ_HLR_Effect_PortalSpawn(destination + Vector(0, 0, 100))
						effectTeleportExit:SetKeyValue("ParticleScale", "10")

						effectTeleportExit:Fire("Kill", "", 1)
						local dynLight = ents.Create("light_dynamic")
						dynLight:SetKeyValue("brightness", "2")
						dynLight:SetKeyValue("distance", "200")
						dynLight:SetPos(destination)
						dynLight:Fire("Color", "33 255 0")
						dynLight:Spawn()
						dynLight:Activate()
						dynLight:Fire("TurnOn", "", 0)
						dynLight:Fire("Kill", "", 0.3)
					end
				end)
			else
				player:Notify(arguments[1].." is not a valid player!")
			end
		else
			player:Notify("You're not looking at a valid place!")
		end
	end
})
