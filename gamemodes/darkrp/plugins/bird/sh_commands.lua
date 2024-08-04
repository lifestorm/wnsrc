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
	description = "Tenter de vous poser sur une personne.",
	OnRun = function(self, client)
		if (client:GetModel() != "models/seagull.mdl") then
			if (client:GetCharacter():GetData("babyBird", 0) < os.time()) then
				local target = client:GetEyeTraceNoCursor().Entity

				if (target and target:IsPlayer() and target:Team() != FACTION_BIRD and client:GetPos():Distance(target:GetPos()) <= 100) then
					if (!client:GetNetVar("ixBirdMounting") and !target:GetNetVar("ixBirdMounted")) then
						client:Notify("Requête envoyée.")

						net.Start("BirdMountRequest")
							net.WriteEntity(client)
						net.Send(target)
						
						target.ixBirdMountRequester = client
					else
						client:Notify("Vous êtes déjà sur une personne.")
					end
				else
					client:Notify("Ce n'est pas une personne ou elle est trop loin !")
				end
			else
				client:Notify("Vous ne pouvez pas vous poser en tant que bébé !")
			end
		else
			client:Notify("Vous ne pouvez pas vous poser en tant que mouette !")
		end
	end,
	OnCheckAccess = function(self, client)
		return client:Team() == FACTION_BIRD
	end
})

ix.command.Add("LayEgg", {
	description = "Pondre un oeuf.",
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

						client:Notify("Vous avez pondu un oeuf.")
						targetCharacter:Notify("Votre partenaire a pondu un oeuf.")
					else
						client:Notify("Vous et/ou votre partenaire êtes trop affamé ou assoifé pour pondre !")
					end
				else
					client:Notify("Vous et/ou votre partenaire ne pouvez pas pondre encore un oeuf !")
				end
			else
				client:Notify("Vous devez regarder de près un oiseau de la même race pour pondre.")
			end
		else
			client:Notify("Vous essayez très fort de pondre un oeuf. Hélas, les humains ne pondent pas d'oeufs, alors rien ne se passe.")
		end
	end
})

ix.command.Add("ToggleFlight", {
	description = "Activer ou pas le vol.",
	OnRun = function(self, client)
		if (client:Team() == FACTION_BIRD) then
			local state = client:GetNetVar("noFlying")

			client:SetNetVar("noFlying", !state)
			client:Notify(state and "Vous avez activé le vol. Vous pouvez maintenant vous déplacer en volant" or "Vous avez désactivé le vol. Vous pouvez maintenant sauter partout.")
		else
			client:Notify("Vous étendez vos bras et commencez à les battre de haut en bas. Hélas, les humains ne peuvent pas voler, alors vous finissez par avoir l'air d'un idiot.")
		end
	end
})
