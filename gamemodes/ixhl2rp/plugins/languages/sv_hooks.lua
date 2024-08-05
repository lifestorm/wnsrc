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

netstream.Hook("QueryDeleteLanguageSuccess", function(client)
	if client:GetCharacter():GetLearningLanguages() then
		local learningLanguages = client:GetCharacter():GetLearningLanguages()
		if !table.IsEmpty(learningLanguages) then
			table.Empty(learningLanguages)
			client:GetCharacter():SetLearningLanguages(learningLanguages)
			client:NotifyLocalized("You have scrapped the progress on your learning languages.")
		end
	end
end)

netstream.Hook("ForceShoutAnim", function(client, speaker)
	if speaker and speaker:Alive() then
		if !client:IsVortigaunt() then
			return false
		end
		
		timer.Simple(1.5, function()
			local sounds = {"ol01_vortcall01", "ol01_vortcall02c", "ol01_vortresp01", "ol01_vortresp04"}
			if (speaker) then
				speaker:EmitSound( "vort/"..table.Random(sounds)..".wav", 511 / 2, 100, 1, CHAN_AUTO )
			end
		end)

		speaker:ForceSequence("vort_shout", function()
			if (!speaker:Alive()) then return end
			speaker:Freeze(true)


			speaker:ForceSequence("vort_shout_end", function()
				speaker:Freeze(false)
			end)
		end)
	end
end)

function PLUGIN:ListenToAudioBook(itemTable, client)
	local character = client:GetCharacter()
	local learningLanguages = character:GetLearningLanguages() or {}
	local knownLanguages = character:GetLanguages() or {}
	local v = itemTable.language

	local cooldown = 86400 -- 24 hours in seconds (24*60*60)
	local time = os.time()

	if (table.HasValue(knownLanguages, v.uniqueID)) then
		client:NotifyLocalized("Your character already knows "..v.name.."!")
		return false
	end

	if client.CantPlace then
		client:NotifyLocalized("You need to wait before you can use this!")
		return false
	end

	if !table.IsEmpty(learningLanguages) and learningLanguages[1] then
		if learningLanguages[1].name then
			client.CantPlace = true

			timer.Simple(3, function()
				if client then
					client.CantPlace = false
				end
			end)

			if v.name != learningLanguages[1].name then
				netstream.Start(client, "QueryDeleteLanguageLearningProgress", learningLanguages[1].name)
				return false
			end

			if v.name == learningLanguages[1].name then
				if learningLanguages[1].progress then
					local str = ""
					string.gsub(itemTable.name,"%d+",function(e)
						str = str .. e
					end)

					if learningLanguages[1].progress + 1 != tonumber(str) then
						client:NotifyLocalized("You need to listen to chapter "..tostring(tonumber(learningLanguages[1].progress) + 1).." of this audiobook to learn more!")
						return false
					end

					local nextUse = learningLanguages[1].timestamp

					if time < nextUse then
						client:NotifyLocalized("I am not ready to listen to another book.. I need to wait.")
						return false
					end

					learningLanguages[1].progress = math.Clamp(learningLanguages[1].progress + 1, 0, 5)
					learningLanguages[1].timestamp = time + cooldown

					if learningLanguages[1].progress == 5 then
						table.insert(knownLanguages, v.uniqueID)
						character:SetLanguages(knownLanguages)
						client:NotifyLocalized("Congratulations, you have now become fluent in "..v.name.."!")

						table.Empty(learningLanguages)
						character:SetLearningLanguages(learningLanguages)
					else
						client:NotifyLocalized("You have increased your proficiency to level "..learningLanguages[1].progress.." in "..v.name)
						character:SetLearningLanguages(learningLanguages)
					end
				end
			end
		end
	else
		if string.find(itemTable.name, "1") then
			learningLanguages[1] = {name = v.name, progress = 0, timestamp = time + cooldown}
			learningLanguages[1].progress = math.Clamp(learningLanguages[1].progress + 1, 0, 5)

			client:NotifyLocalized("You have increased your proficiency to level "..learningLanguages[1].progress.." in "..v.name)
			character:SetLearningLanguages(learningLanguages)
		else
			client:NotifyLocalized("You need to listen to chapter 1 first!")
			return false
		end
	end
end