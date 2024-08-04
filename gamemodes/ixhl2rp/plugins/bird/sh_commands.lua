--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.command.Add("BirdMount", {
	description = "Attempt to mount a character.",
	OnRun = function(self, client)
		if (client:GetModel() != "models/seagull.mdl") then
			if (client:GetCharacter():GetData("babyBird", 0) < os.time()) then
				local target = client:GetEyeTraceNoCursor().Entity

				if (target and target:IsPlayer() and target:Team() != FACTION_BIRD and client:GetPos():Distance(target:GetPos()) <= 100) then
					if (!client:GetNetVar("ixBirdMounting") and !target:GetNetVar("ixBirdMounted")) then
						client:Notify("Mount request sent.")

						net.Start("BirdMountRequest")
							net.WriteEntity(client)
						net.Send(target)
						
						target.ixBirdMountRequester = client
					else
						client:Notify("You are already mounting someone, or that character is already being mounted.")
					end
				else
					client:Notify("That is not a valid character or that character is too far away!")
				end
			else
				client:Notify("You cannot mount humans as a baby!")
			end
		else
			client:Notify("You cannot mount a human as a seagull!")
		end
	end,
	OnCheckAccess = function(self, client)
		return client:Team() == FACTION_BIRD
	end
})

ix.command.Add("LayEgg", {
	description = "Lay an egg.",
	OnRun = function(self, client)
		if (client:Team() == FACTION_BIRD) then
			local target = client:GetEyeTraceNoCursor().Entity
			
			if (target and target:IsPlayer() and target:Team() == FACTION_BIRD and client:GetModel() == target:GetModel() and client:GetPos():Distance(target:GetPos()) <= 100) then
				local character = client:GetCharacter()
				local targetCharacter = target:GetCharacter()
				local realTime = os.time()
				
				if (character:GetData("nextEgg", 0) < realTime and targetCharacter:GetData("nextEgg", 0) < realTime) then
					if (character:GetHunger() <= 25 and character:GetThirst() <= 25 and targetCharacter:GetHunger() <= 25 and targetCharacter:GetThirst() <= 25) then
						character:GetInventory():Add("birdegg", 1, {hatchTime = realTime + 86400}) -- 24 hours
						character:SetData("nextEgg", realTime + 604800) -- 1 week
						targetCharacter:SetData("nextEgg", realTime + 604800) -- 1 week
						
						character:SetHunger(character:GetHunger() + 25)
						character:SetThirst(character:GetThirst() + 25)
						targetCharacter:SetHunger(targetCharacter:GetHunger() + 25)
						targetCharacter:SetThirst(targetCharacter:GetThirst() + 25)

						client:Notify("You lay a fresh egg.")
						targetCharacter:Notify("Your partner has layed a fresh egg.")
					else
						client:Notify("You and/or your partner are too hungry or thirsty to lay an egg!")
					end
				else
					client:Notify("You and/or your partner cannot lay another egg just yet!")
				end
			else
				client:Notify("You must be looking at and be close enough to a valid bird of the same species to lay an egg!")
			end
		else
			client:Notify("You try really hard to lay an egg. Alas, humans do not lay eggs, so nothing happens.")
		end
	end
})

ix.command.Add("ToggleFlight", {
	description = "Enable or disable flying.",
	OnRun = function(self, client)
		if (client:Team() == FACTION_BIRD) then
			local state = client:GetNetVar("noFlying")

			client:SetNetVar("noFlying", !state)
			client:Notify(state and "You have enabled flying. You can now fly around." or "You have disabled flying. You can now hop around.")
		else
			client:Notify("You spread your arms and begin flapping them up and down. Alas, humans cannot fly, so you end up just looking like an idiot.")
		end
	end
})
