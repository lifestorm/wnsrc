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
local ix = ix

local LocalPlayer = LocalPlayer
local IsValid = IsValid
local draw = draw

function PLUGIN:HUDPaint(width, height, alpha)
	if (!IsValid(LocalPlayer())) then
		return
	end

	local character = LocalPlayer():GetCharacter()
	if (character and IsValid(ix.gui.chat) and ix.gui.chat:IsVisible() and ix.gui.chat.bActive) then
		local radioChannels = {}
		--local quick = {}
		for k in pairs(LocalPlayer():GetLocalVar("radioChannels", {})) do
			--[[
			local quickCom = LocalPlayer():HasQuickComms(k)
			if (quickCom) then
				quick[quickCom] = k
				continue
			end
			--]]

			radioChannels[#radioChannels + 1] = k
		end
		table.sort(radioChannels, ix.radio.sortFunc)

		for k, v in ipairs(radioChannels) do
			radioChannels[k] = ix.radio:FindByID(v).name
		end

		--[[
		local seen = false
		if (!table.IsEmpty(quick)) then
			for i = 1, 5 do
				if (!seen and !quick[i]) then
					quick[i] = "none"
				elseif (quick[i]) then
					seen = true
					quick[i] = ix.radio:FindByID(quick[i]).name
				end
			end
		end
		--]]

		local channelsText = L("radioChannels")..": "..((#radioChannels > 0) and table.concat(radioChannels, ", ") or L("radioNone"))
		--local quickText = L("quickChannels")..": "..((#quick > 0) and table.concat(quick, ", ") or L("radioNone"))

		local currChannel = ix.radio:FindByID(character:GetRadioChannel())
		local currentText = L("radioSpeaking")..": "..(currChannel and currChannel.name or L("radioNone"))

		local x, y = ix.gui.chat:GetPos()
		y = y - SScaleMin(20 / 3)
		x = x + 10
		draw.SimpleTextOutlined(currentText, "DebugFixedRadio",
			x, y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0))

		--[[
		if (#quick > 0) then
			y = y - ScreenScale(20 / 3)
			draw.SimpleTextOutlined(quickText, "DebugFixed",
				x, y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0))
		end
		--]]

		if (#radioChannels > 0) then
			y = y - SScaleMin(20 / 3)
			draw.SimpleTextOutlined(channelsText, "DebugFixedRadio",
				x, y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color(0, 0, 0))
		end
	end
end

net.Receive("ixRadioChannels", function(len)
	local id = net.ReadUInt(32)
	local character = ix.char.loaded[id]
	local channels = {}

	local total = net.ReadUInt(16)
	for _ = 1, total do
		channels[#channels + 1] = net.ReadString()
	end

	character.vars.radioChannels = channels
end)

function PLUGIN:InitializedPlugins()
	CHAT_RECOGNIZED["radio"] = true
	CHAT_RECOGNIZED["radio_eavesdrop"] = true
	CHAT_RECOGNIZED["radio_eavesdrop_yell"] = true
end