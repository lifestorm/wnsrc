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
						client:Notify("Binme isteği gönderildi.")

						net.Start("BirdMountRequest")
							net.WriteEntity(client)
						net.Send(target)
						
						target.ixBirdMountRequester = client
					else
						client:Notify("Şu an zaten birine biniyorsun, veya o karaktere biri binmiş.")
					end
				else
					client:Notify("Bu geçerli bir karakter değil veya çok uzak!")
				end
			else
				client:Notify("Bebekken insanlara binemezsin!")
			end
		else
			client:Notify("Martıyken insanlara binemezsin!")
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

						client:Notify("Yeni bir yumurta çıkardın.")
						targetCharacter:Notify("Partnerin yeni bir yumurta çıkardı.")
					else
						client:Notify("Sen ve/veya partnerin yumurta çıkarmak için çok aç veya susuz!")
					end
				else
					client:Notify("Sen ve/veya partnerin henüz başka bir yumurta çıkaramaz!")
				end
			else
				client:Notify("You must be looking at and be close enough to a valid bird of the same species to lay an egg!")
				client:Notify("Bir yumurta çıkarmak için aynı cins bir kuşa bakmalı veya yakın olmalısınız!")
			end
		else
			client:Notify("Bir yumurta çıkarmak için kendini baya zorluyorsun. Ancak insanlar yumurta çıkaramıyor, o yüzden hiçbir şey olmuyor.")
		end
	end
})

ix.command.Add("ToggleFlight", {
	description = "Enable or disable flying.",
	OnRun = function(self, client)
		if (client:Team() == FACTION_BIRD) then
			local state = client:GetNetVar("noFlying")

			client:SetNetVar("noFlying", !state)
			client:Notify(state and "Uçmayı etkinleştirdin, artık kanat çırpabilirsin." or "Uçmayı kapattın, artık etrafta zıplayabilirsin.")
		else
			client:Notify("Kollarını genişçe açıyor ve çırpmaya başlıyorsun. Ancak insanlar uçamıyor, bu yüzden sadece bir ahmak gibi görünüyorsun.")
		end
	end
})
