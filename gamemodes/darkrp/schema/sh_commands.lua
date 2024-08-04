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
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	local lastDispatchCommand = 0

	function COMMAND:OnRun(client, message)
		if (!client:IsRestricted()) then
			local doubleCommand = false
			local curTime = CurTime()
			local isVoiceCommand = false

			-- This could probably be done a bit smarter but I'm sure it'll do.
			if (string.Left(string.lower(message), 9) == "/dispatch") then
				doubleCommand = true

				message = string.Right(message, #message - 10)
			elseif (string.Left(string.lower(message), 8) == "dispatch") then
				doubleCommand = true

				message = string.Right(message, #message - 9)
			end

			for voiceCommand, _ in pairs(Schema.voices.stored["dispatch"]) do
				if (message:lower() == voiceCommand:lower()) then
					isVoiceCommand = true

					break
				end
			end

			if (!isVoiceCommand) then
				if (lastDispatchCommand < curTime) then
					lastDispatchCommand = curTime + 5

					return "@dispatchTypoWarning"
				else
					lastDispatchCommand = 0
				end
			end

			if (doubleCommand) then
				client:NotifyLocalized("textDoubleCommand", "/dispatch")
			end

			ix.chat.Send(client, "dispatch", message)
		else
			return "@notNow"
		end
	end

	ix.command.Add("Dispatch", COMMAND)
end

do
	local COMMAND = {}
	COMMAND.arguments = ix.type.text

	function COMMAND:OnRun(client, message)
		if (!client:IsRestricted()) then
			local doubleCommand = false

			-- This could probably be done a bit smarter but I'm sure it'll do.
			if (string.Left(string.lower(message), 10) == "/broadcast") then
				doubleCommand = true

				message = string.Right(message, #message - 11)
			elseif (string.Left(string.lower(message), 9) == "broadcast") then
				doubleCommand = true

				message = string.Right(message, #message - 10)
			end

			if (doubleCommand) then
				client:NotifyLocalized("textDoubleCommand", "/broadcast")
			end

			ix.chat.Send(client, "broadcast", message)
		else
			return "@notNow"
		end
	end

	ix.command.Add("Broadcast", COMMAND)
end

ix.command.Add("Event", {
	description = "@cmdEvent",
	arguments = ix.type.text,
	privilege = "Event",
	OnRun = function(self, client, message)
		local doubleCommand = false

		-- This could probably be done a bit smarter but I'm sure it'll do.
		if (string.Left(string.lower(message), 6) == "/event") then
			doubleCommand = true

			message = string.Right(message, #message - 7)
		elseif (string.Left(string.lower(message), 5) == "event") then
			doubleCommand = true

			message = string.Right(message, #message - 6)
		end

		if (doubleCommand) then
			client:NotifyLocalized("textDoubleCommand", "/Event")
		end

		ix.chat.Send(client, "event", message)
	end
})

do
	local COMMAND = {}

	function COMMAND:OnRun(client, arguments)
		if (!hook.Run("CanPlayerViewObjectives", client)) then
			return "@noPerm"
		end

		netstream.Start(client, "ViewObjectives", Schema.CombineObjectives)
	end

	ix.command.Add("ViewObjectives", COMMAND)
end

do
	ix.command.Add("CharSearch", {
		description = "Recherchez le joueur que vous regardez. Cela demandera la permission de le faire s'il n'est pas encore lié.",
		OnCheckAccess = function(self, client)
			if (client:IsRestricted()) then
				return false, "@notNow"
			end

			return true
		end,
		OnRun = function(self, client)
			local data = {}
				data.start = client:GetShootPos()
				data.endpos = data.start + client:GetAimVector() * 96
				data.filter = client
			local target = util.TraceLine(data).Entity
			local isRagdoll = false

			if (target:IsRagdoll() and target.ixPlayer) then
				target = target.ixPlayer
				isRagdoll = true
			end

			if (IsValid(target) and target:IsPlayer()) then
				if (target:IsRestricted() or isRagdoll) then
					Schema:SearchPlayer(client, target)
				elseif (!IsValid(target.ixSearchRequest)) then
					-- first search
					-- succesful searches or searching other target clears this
					if (!client.ixLastSearchRequest or client.ixLastSearchRequest.target != target) then
						client.ixLastSearchRequest = {target = target, time = 0, count = 1}
					-- second search
					elseif (count == 1) then
						-- if it was within 15 seconds
						if (os.time() < client.ixLastSearchRequest.time) then
							client.ixLastSearchRequest.count = 2
						end
					-- third search
					elseif (count == 2) then
						-- again within 15 seconds -> deny it
						if (os.time() < client.ixLastSearchRequest.time) then
							client:NotifyLocalized("Veuillez attendre 15 secondes avant d'envoyer une troisième demande !")
							return
						end
					end
					client.ixLastSearchRequest.time = os.time() + 15

					client:NotifyLocalized("Demande de recherche envoyée.")
					netstream.Start(target, "SearchRequest", client)
					target.ixSearchRequest = client
				else
					return "@notNow"
				end
			else
				return "@plyNotValid"
			end
		end
	})
end

local applyPhrases = {
	"%s, CID #%s.",
	"Mon nom est %s et mon CID est le #%s.",
	"Je suis %s avec le CID #%s.",
	"%s. Mon CID est %s."
}

local namePhrases = {
	"%s.",
	"Je suis %s.",
	"My name is %s.",
	"Name: %s"
}

ix.command.Add("apply", {
	description = "@cmdApply",
	OnRun = function(self, client, arguments)
		local character = client:GetCharacter()
		local cid = character:GetCid()

		if (cid) then
			ix.chat.Send(client, "ic", string.format(table.Random(applyPhrases), character:GetData("fakeName", client:GetName()), cid))
		else
			ix.chat.Send(client, "ic", string.format(table.Random(namePhrases), character:GetData("fakeName", client:GetName())))
		end

	end
})

ix.command.Add("CharFallOver", {
	description = "@cmdCharFallOver",
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, client, time)
		-- Anti-Exploit measure. Just silently fail if near a door.
		for _, entity in ipairs(ents.FindInSphere(client:GetPos(), 50)) do
			if (entity:GetClass() == "func_door" or entity:GetClass() == "func_door_rotating" or entity:GetClass() == "prop_door_rotating") then return end
		end

		if (!client:Alive() or client:GetMoveType() == MOVETYPE_NOCLIP) then
			return "@notNow"
		end

		if (hook.Run("PlayerCanFallOver", client) == false) then
			return "@notNow"
		end

		if (time and time > 0) then
			time = math.Clamp(time, 1, 60)
		end

		if (!IsValid(client.ixRagdoll)) then
			client:SetRagdolled(true, time)
		end
	end
})

ix.command.Add("CharGetUp", {
	description = "@cmdCharGetUp",
	OnRun = function(self, client, arguments)
		-- Anti-Exploit measure. Just silently fail if near a door.
		for _, entity in ipairs(ents.FindInSphere(client:GetPos(), 50)) do
			if (entity:GetClass() == "func_door" or entity:GetClass() == "func_door_rotating" or entity:GetClass() == "prop_door_rotating") then return end
		end

		local entity = client.ixRagdoll

		if (IsValid(entity) and entity.ixGrace and entity.ixGrace < CurTime() and
			entity:GetVelocity():Length2D() < 8 and !entity.ixWakingUp) then
			entity.ixWakingUp = true
			entity:CallOnRemove("CharGetUp", function()
				client:SetAction()
			end)

			client:SetAction("@gettingUp", 5, function()
				if (!IsValid(entity)) then
					return
				end

				-- Anti-Exploit measure. Just silently fail if near a door.
				for _, entity in ipairs(ents.FindInSphere(client:GetPos(), 50)) do
					if (entity:GetClass() == "func_door" or entity:GetClass() == "func_door_rotating" or entity:GetClass() == "prop_door_rotating") then return end
				end

				hook.Run("OnCharacterGetup", client, entity)
				entity:Remove()
			end)
		end
	end
})

ix.command.Add("ListColors", {
	description = "@cmdListColors",
	OnRun = function(self, client)
		client:SendLua([[for colorName, color in pairs(Schema.colors) do MsgC(color, "██████████ " .. colorName:upper() .. "\n") end]])

		return "@ColorsPrinted" -- Bogos Binted
	end
})

ix.command.Add("VisorMessage", {
	description = "@cmdVisorMessage",
	arguments = {
		ix.type.string,
		bit.bor(ix.type.string, ix.type.optional),
		bit.bor(ix.type.bool, ix.type.optional)
	},
	OnCheckAccess = function(self, client)
		local character = client:GetCharacter()

		return character and character:GetFaction() == FACTION_OTA and (character:GetClass() == CLASS_ORD or character:GetClass() == CLASS_EOW)
	end,
	OnRun = function(self, client, visorMessage, messageColor, isImportant)
		if (messageColor and Schema.colors[messageColor]) then
			messageColor = Schema.colors[messageColor]
		else
			messageColor = Color(255, 255, 255)
		end

		local receivers = {}
		for _, player in pairs(player.GetAll()) do
			if (player:Team() == FACTION_OTA) then
				receivers[#receivers + 1] = player
			end
		end

		if (isImportant) then
			ix.combineNotify:AddImportantNotification("MSG:// " .. visorMessage, messageColor, nil, nil, receivers)
		else
			ix.combineNotify:AddNotification("MSG:// " .. visorMessage, messageColor, nil, nil, receivers)
		end
	end
})

ix.command.Add("PlyNotify", {
	description = "@cmdPlyNotify",
	adminOnly = true,
	arguments = {
		ix.type.player,
		ix.type.text
	},
	OnRun = function(self, client, target, notification)
		target:Notify(notification)

		return "@notificationSent"
	end
})

ix.command.Add("WhisperDirect", {
	alias = {"WD"},
	description = "@cmdWD",
	combineBeep = true,
	arguments = {
		ix.type.string,
		ix.type.text
	},
	OnRun = function(self, client, target, text)
		if (target == "@") then
			local traceEnt = client:GetEyeTraceNoCursor().Entity

			if (traceEnt and traceEnt:IsPlayer()) then
				target = traceEnt
			end
		else
			target = ix.util.FindPlayer(target)
		end

		if (!target or isstring(target)) then
			return "@charNoExist"
		end

		if (target:GetPos():Distance(client:GetPos()) <= ix.config.Get("chatRange", 280) * 0.25) then
			ix.chat.Send(client, "wd", text, false, {client, target}, {target = target})
		else
			return "@targetTooFar"
		end
	end
})

ix.command.Add("GetCWUFlags", {
	description = "@cmdGetCWUFlags",
	OnCheckAccess = function(self, client)
		return client:Team() == FACTION_WORKERS or client:Team() == FACTION_MEDICAL
	end,
	OnRun = function(self, client) -- Just going to recycle the tempflags code.
		local curTime = CurTime()
		local nextCommandUse = client:GetLocalVar("nextCWUFlags", 0)

		if (nextCommandUse > curTime) then return "@cwuFlagsCooldown" end

		local flags = client:GetLocalVar("tempFlags", {})
		local newTime = os.time() + 3600 -- 1 Hour
		local character = client:GetCharacter()
		local flagsToGive = "pet"

		for i = 1, 3 do
			local flag = flagsToGive[i]
			local info = ix.flag.list[flag]

			if (!flags[flag] and character:HasFlags(flag)) then continue end

			flags[flag] = newTime

			if (info.callback) then
				info.callback(client, true)
			end
		end

		client:SetLocalVar("tempFlags", flags)

		for _, player in ipairs(player.GetAll()) do
			if (player:IsAdmin()) then
				player:ChatNotifyLocalized("cwuFlagsGivenAdmins", client:GetName(), client:SteamName())
			end
		end

		client:NotifyLocalized("cwuFlagsGivenPlayer")

		client:SetLocalVar("nextCWUFlags", curTime + 3600)
	end
})

ix.command.Add("UnStuck", {
	description = "@cmdUnstuck",
	OnRun = function(self, client)
		local curTime = CurTime()
		local nextCommandUse = client:GetLocalVar("nextUnstuck", 0)

		if (nextCommandUse > curTime) then return "@unstuckCooldown" end

		local operators = {"+", "-", "*"}

		local unstuckNumberOne = math.random(1, 100)
		local unstuckNumberTwo = math.random(1, 100)
		local unstuckOperator = operators[math.random(1, 3)]
		-- sorry for the spaces
		client:RequestString("A utiliser si vous êtes bloqué ou tué par un props. Le TP retourne au spawn et réinitialise les HP. Ne pas abuser.", "Pour continuer, veuillez résoudre le problème mathématique suivant : " .. unstuckNumberOne .. " " .. unstuckOperator .. " " .. unstuckNumberTwo .. " = ?     ", function(text)
			if (text) then text = tonumber(text) end

			if (text and isnumber(text)) then
				local answer = 0

				if (unstuckOperator == "+") then
					answer = unstuckNumberOne + unstuckNumberTwo
				elseif (unstuckOperator == "-") then
					answer = unstuckNumberOne - unstuckNumberTwo
				else
					answer = unstuckNumberOne * unstuckNumberTwo
				end

				if (text == answer) then
					client:RequestString("Raison", "Donnez une raison valable. Les staffs la verront.", function(reasontext)
						for _, player in ipairs(player.GetAll()) do
							if (player:IsAdmin()) then
								player:ChatNotifyLocalized("unstuckAdmins", client:GetName(), client:SteamName(), client:GetArea(), reasontext)
								ix.log.Add(client, "command"," /UnStuck avec comme raison : "..reasontext)
							end
						end

						client:NotifyLocalized("unstuckPlayer")

						client:Spawn()
						client:SetLocalVar("nextUnstuck", curTime + 3600)
					end, "")
				else
					client:NotifyLocalized("unstuckAnswerIncorrect")
				end
			else
				client:NotifyLocalized("unstuckAnswerInvalid")
			end
		end, "")
	end
})

ix.command.Add("SetOwnName", {
	description = "Set your own character's name, if allowed.",
	arguments = ix.type.text,
	OnRun = function(self, client, name)
		if (client:Team() != FACTION_OTA) then
			client:Notify("You are not allowed to set your own name!")

			return
		end

		client:GetCharacter():SetName(name)
		client:Notify("You have set your name to " .. name .. ".")
	end
})
