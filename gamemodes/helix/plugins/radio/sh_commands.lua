--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ix.command.Add("CharAddRadioChannel", {
	description = "@cmdCharAddRadioChannel",
	privilege = "Manage Radio",
	arguments = {
		ix.type.player,
		ix.type.string
	},
	OnRun = function(self, client, target, channelID)
		local channel = ix.radio:FindByID(channelID)
		if (channel) then
			ix.radio:AddPlayerChannelSubscription(target, channel.uniqueID)

			client:NotifyLocalized("radioSubbed", target:Name(), channel.name)
			target:NotifyLocalized("radioSubbedT", channel.name, client:Name())
		else
			return "@radioChannelNotExist"
		end
	end
})

ix.command.Add("CharRemoveRadioChannel", {
	description = "@cmdCharRemoveRadioChannel",
	privilege = "Manage Radio",
	arguments = {
		ix.type.player,
		ix.type.string
	},
	OnRun = function(self, client, target, channelID)
		local channel = ix.radio:FindByID(channelID)
		if (channel) then
			ix.radio:RemovePlayerChannelSubscription(target, channel.uniqueID)

			client:NotifyLocalized("radioUnsubbed", target:Name(), channel.name)
			target:NotifyLocalized("radioUnsubbedT", channel.name, client:Name())
		else
			return "@radioChannelNotExist"
		end
	end
})

ix.command.Add("SC", {
	description = "@cmdSC",
	alias = "SetChannel",
	arguments = ix.type.text,
	privilege = "Radio Use",
	OnRun = function(self, client, text)
		text = text:Trim()

		local character = client:GetCharacter()
		local channels = ix.radio:GetAllChannelsFromChar(character)

		for _, v in ipairs(channels) do
			if (v == text) then
				character:SetRadioChannel(v)
				client:NotifyLocalized("radioSetChannel", v)
				return
			end
		end

		local shortest = nil
		for _, v in ipairs(channels) do
			local channel = ix.radio:FindByID(v)
			if (string.find(v, text, 1, true)
				or string.find(channel.name, text, 1, true)) then
				if (!shortest or string.utf8len(shortest) > string.utf8len(v)) then
					shortest = channel.uniqueID
				end
			end
		end

		local channel = ix.radio:FindByID(shortest)
		if (channel) then
			character:SetRadioChannel(channel.uniqueID)
			client:NotifyLocalized("radioSetChannel", channel.name)
			return
		end

		client:NotifyLocalized("radioChannelNotExist")
	end,
})

ix.command.Add("Radio", {
	alias = "R",
	arguments = ix.type.text,
	privilege = "Radio Use",
	combineBeep = true,
	OnRun = function(self, client, text)
		return ix.radio:SayOnRadio(client, text, ix.radio.types.talk)
	end
})

ix.command.Add("RadioWhisper", {
	alias = "RW",
	arguments = ix.type.text,
	privilege = "Radio Use",
	combineBeep = true,
	OnRun = function(self, client, text)
		return ix.radio:SayOnRadio(client, text, ix.radio.types.whisper)
	end,
})

ix.command.Add("RadioYell", {
	alias = "RY",
	arguments = ix.type.text,
	privilege = "Radio Use",
	combineBeep = true,
	OnRun = function(self, client, text)
		return ix.radio:SayOnRadio(client, text, ix.radio.types.yell)
	end,
})

--[[
	Quick comm radio stuff - we don't use this but leaving it here
for i = 1, 5 do
	ix.command.Add("Com"..i, {
		alias = "R"..i,
		arguments = ix.type.text,
		OnCheckAccess = function(self, client)
			return client:GetQuickComms(i) and CAMI.PlayerHasAccess(client, "Helix - Radio Use")
		end,
		OnRun = function(self, client, text)
			local character = client:GetCharacter()
			if (!character) then return end

			if (ix.radio:CharacterHasChannel(character, client:GetQuickComms(i))) then
				return ix.radio:SayOnRadio(client, text, ix.radio.types.talk, client:GetQuickComms(i))
			end

			return "You do not have any quick comms channels!"
		end,
	})

	ix.command.Add("Com"..i.."Whisper", {
		alias = {"Com"..i.."W", "R"..i.."W"},
		arguments = ix.type.text,
		OnCheckAccess = function(self, client)
			return client:GetQuickComms(i) and CAMI.PlayerHasAccess(client, "Helix - Radio Use")
		end,
		OnRun = function(self, client, text)
			local character = client:GetCharacter()
			if (!character) then return end

			if (ix.radio:CharacterHasChannel(character, client:GetQuickComms(i))) then
				return ix.radio:SayOnRadio(client, text, ix.radio.types.whisper, client:GetQuickComms(i))
			end

			return "You do not have any quick comms channels!"
		end,
	})

	ix.command.Add("Com"..i.."Yell", {
		alias = {"Com"..i.."Y", "R"..i.."Y"},
		arguments = ix.type.text,
		OnCheckAccess = function(self, client)
			return client:GetQuickComms(i) and CAMI.PlayerHasAccess(client, "Helix - Radio Use")
		end,
		OnRun = function(self, client, text)
			local character = client:GetCharacter()
			if (!character) then return end

			if (ix.radio:CharacterHasChannel(character, client:GetQuickComms(i))) then
				return ix.radio:SayOnRadio(client, text, ix.radio.types.yell, client:GetQuickComms(i))
			end

			return "You do not have any quick comms channels!"
		end,
	})

	ix.option.Add("com"..i.."Color", ix.type.color, Color(200,200,255,255), {
		category = "chat",
		hidden = function()
			return !CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Radio Use") or !LocalPlayer():GetQuickComms(i)
		end
	})

	ix.lang.AddTable("english", {
		["optCom"..i.."Color"] = "Set Com"..i.." Color",
		["optdCom"..i.."Color"] = "Set the color of radio messages received on the 'Freq "..i.."' frequency of your radio."
	})
end
--]]