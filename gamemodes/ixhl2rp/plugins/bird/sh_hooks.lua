--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix
local math = math
local string = string
local table = table

local PLUGIN = PLUGIN

local randomBirdWords = {"chirp", "caw", "squawk", "cheep", "tweet", "shriek", "crow"}

function PLUGIN:InitializedChatClasses()
	ix.chat.Register("icbird", {
		format = " \"%s\"",
		icon = "willardnetworks/chat/message_icon.png",
		indicator = "chatTalking",
		GetColor = function(self, speaker, text)
			-- If you are looking at the speaker, make it greener to easier identify who is talking.
			if (LocalPlayer():GetEyeTrace().Entity == speaker) then
				return ix.config.Get("chatListenColor")
			end

			-- Otherwise, use the normal text color.
			return color_white
		end,
		OnChatAdd = function(self, speaker, text, anonymous, info)
			local color = self:GetColor(speaker, text, info)
			local name = anonymous and L"someone" or hook.Run("GetCharacterName", speaker, "ic") or	(IsValid(speaker) and speaker:Name() or "Console")
			local translated = L2("icWNFormat", text)
			local bToYou = speaker:GetEyeTraceNoCursor().Entity == LocalPlayer()

			if (LocalPlayer():Team() != FACTION_BIRD) then
				text = string.Split(text, " ")

				for i = 1, #text do
					text[i] = randomBirdWords[math.random(#randomBirdWords)]
				end

				text = table.concat(text, " ")
			end

			text = ix.chat.Format(text)

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(ix.util.GetMaterial(self.icon), Color(255, 254, 153, 255), name, " says", bToYou and " (to you)" or "", color, translated or string.format(self.format, text))
			else
				chat.AddText(Color(255, 254, 153, 255), name, " says", bToYou and " (to you)" or "", color, translated or string.format(self.format, text))
			end
		end,
		CanHear = ix.config.Get("chatRange", 280)
	})

	ix.chat.Register("wbird", {
		format = "%s whispers \"%s\"",
		icon = "willardnetworks/chat/whisper_icon.png",
		color = Color(158, 162, 191, 255),
		CanHear = ix.config.Get("chatRange", 280) * 0.25,
		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			local color = self.color
			local name = anonymous and L"someone" or hook.Run("GetCharacterName", speaker, "wbird") or (IsValid(speaker) and speaker:Name() or "Console")
			local translated = L2("wbird" .." Format", name, text)

			if (LocalPlayer():Team() != FACTION_BIRD) then
				text = string.Split(text, " ")

				for i = 1, #text do
					text[i] = randomBirdWords[math.random(#randomBirdWords)]
				end

				text = table.concat(text, " ")
			end

			text = ix.chat.Format(text)

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(ix.util.GetMaterial(self.icon), color, translated or string.format(self.format, name, text))
			else
				chat.AddText(color, translated or string.format(self.format, name, text))
			end
		end
	})

	ix.chat.Register("ybird", {
		format = "%s yells \"%s\"",
		color = Color(254, 171, 103, 255),
		icon = "willardnetworks/chat/yell_icon.png",
		CanHear = ix.config.Get("chatRange", 280) * 2,
		OnChatAdd = function(self, speaker, text, bAnonymous, data)
			local color = self.color
			local name = anonymous and L"someone" or hook.Run("GetCharacterName", speaker, "ybird") or (IsValid(speaker) and speaker:Name() or "Console")
			local translated = L2("ybird" .. "Format", name, text)

			if (LocalPlayer():Team() != FACTION_BIRD) then
				text = string.Split(text, " ")

				for i = 1, #text do
					text[i] = randomBirdWords[math.random(#randomBirdWords)]
				end

				text = table.concat(text, " ")
			end

			text = ix.chat.Format(text)

			if (ix.option.Get("standardIconsEnabled")) then
				chat.AddText(ix.util.GetMaterial(self.icon), color, translated or string.format(self.format, name, text))
			else
				chat.AddText(color, translated or string.format(self.format, name, text))
			end
		end
	})
end

function PLUGIN:SetupMove(client, mv, cmd)
	if (client:Team() == FACTION_BIRD and !client:OnGround() and !client:GetNetVar("noFlying")) then
		local speed = ix.config.Get("birdFlightSpeed", 50)
		local angs = mv:GetAngles()

		if (cmd:KeyDown(IN_JUMP) and client:GetLocalVar("stm", 0) > 0) then
			angs.p = -30
			mv:SetVelocity(angs:Forward() * (100 * ((speed / 100) + 1)))
		elseif (cmd:KeyDown(IN_DUCK)) then
			angs.p = 30
			mv:SetVelocity(angs:Forward() * (100 * ((speed / 100) + 1)))
		else
			angs.p = 10
			mv:SetVelocity(angs:Forward() * (150 * ((speed / 100) + 1)))
		end
	end
end

-- Makes the player soar if they're falling down. Taken out for now because CalcMainActivity is awful.
--[[
	function PLUGIN:CalcMainActivity(client, velocity)
		if (SERVER and client:Team() == FACTION_BIRD) then
			if (client:GetNetVar("forcedSequence") and client:GetNetVar("forcedSequence") != 4) then
				client:LeaveSequence()
			end

			if (!client:OnGround()) then
				if (!client:GetNetVar("forcedSequence")) then
					client:ForceSequence("soar", nil, nil, true)
				end
			end
		end
	end
--]]

local birdPainSounds = {"npc/crow/pain2.wav", "npc/crow/pain1.wav"}
local birdDeathSounds = {"npc/crow/die1.wav", "npc/crow/die2.wav"}

function PLUGIN:GetPlayerPainSound(client)
	if (client:Team() == FACTION_BIRD) then return birdPainSounds[math.random(#birdPainSounds)] end
end

function PLUGIN:GetPlayerDeathSound(client)
	if (client:Team() == FACTION_BIRD) then return birdDeathSounds[math.random(#birdDeathSounds)] end
end

function PLUGIN:IsCharacterRecognized(character, id)
	local client = character:GetPlayer()
	local other = ix.char.loaded[id]:GetPlayer()

	if (other and ix.config.Get("birdRecogniseEachother", true) and (client:Team() == FACTION_BIRD and other:Team() == FACTION_BIRD)) then
		return true
	end
end

function PLUGIN:PrePlayerMessageSend(client, chatType, message, anonymous)
	if (client:Team() == FACTION_BIRD) then
		if (chatType == "ic" or chatType == "w" or chatType == "y") and ix.config.Get("birdChat", true) then
			ix.chat.Send(client, chatType .. "bird", message)
			ix.log.Add(client, "chat", string.upper(chatType), message)

			return false
		elseif ((chatType == "me" or chatType == "it") and !ix.config.Get("birdActions", true)) then
			client:Notify("You are not able to use this command as a Bird!")

			return false
		elseif (chatType == "ooc" and !ix.config.Get("birdOOC", true)) then
			client:Notify("You are not able to use this command as a Bird!")

			return false
		end
	end
end

function PLUGIN:CanTransferItem(item, oldInv, newInv)
	local client = item.player or item.GetOwner and item:GetOwner() or item.playerID and player.GetBySteamID64(item.playerID) or nil -- what the fuck? Why is this so inconsistent?

	if (client and client:Team() == FACTION_BIRD and oldInv != newInv and client:GetCharacter():GetInventory().id == newInv.id) then
		if (table.Count(client:GetCharacter():GetInventory():GetItems()) > 0) then
			client:Notify("You can only carry one item at a time!")

			return false
		elseif (item.width > 1 or item.height > 1) then
			client:Notify("That item is too heavy for you to carry!")

			return false
		end
	end
end

function PLUGIN:CanPlayerUseCharacter(client, character)
	if (character:GetFaction() == FACTION_BIRD) then
		local ratio = ix.config.Get("birdRatio", 10)
		local playerCount = player.GetCount()
		local birdCount = #team.GetPlayers(FACTION_BIRD)

		if (birdCount >= math.floor(playerCount / ratio)) then
			return false, "There are not enough players online for you to use your bird character at this time!"
		end

		if (character:GetData("babyBird") and !character:GetData("banned")) then
			return true -- Bad, I know, but, eh.
		end
	end
end

function PLUGIN:InitializedPlugins()
	if (ix.plugin.list.inventoryslosts and FACTION_BIRD) then
		ix.plugin.list.inventoryslots.noEquipFactions[FACTION_BIRD] = true
	end

	if (SERVER and ix.saveEnts) then
		ix.saveEnts:RegisterEntity("ix_birdnest", true, true, true, {
			OnSave = function(entity, data)
				data.progress = entity:GetNetVar("progress", 0)
			end,
			OnRestore = function(entity, data)
				entity:SetNetVar("progress", data.progress)
			end
		})
	end
end