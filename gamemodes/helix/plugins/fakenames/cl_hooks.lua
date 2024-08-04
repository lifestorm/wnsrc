--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local LocalPlayer = LocalPlayer
local ix = ix
local vgui = vgui
local L = L
local Color = Color
local SScaleMin = SScaleMin

function PLUGIN:IsPlayerRecognized(client)
	local fakeNames = LocalPlayer():GetCharacter():GetFakeNames()

	if (fakeNames and client:GetCharacter() and fakeNames[client:GetCharacter():GetID()]) then
		return true
	end
end

function PLUGIN:GetCharacterName(client, chatType)
	if (!IsValid(client)) then return end

	local localCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
	if (!localCharacter) then return end

	local clientCharacter = client:GetCharacter()
	if (!clientCharacter) then return end

	if (!hook.Run("IsCharacterRecognized", localCharacter, clientCharacter:GetID())) then
		local fakeNames = localCharacter:GetFakeNames()

		if (fakeNames and clientCharacter) then
			local fakeName = fakeNames[clientCharacter:GetID()]

			if (fakeName and fakeName != true) then
				return fakeName
			end
		end
	end
end

function PLUGIN:ShouldShowPlayerOnScoreboard(client, panel)
	local playerFaction = ix.faction.Get(client:GetCharacter():GetFaction())

	if (!panel.unknown and !LocalPlayer():GetCharacter():DoesRecognize(client:GetCharacter()) and !playerFaction.separateUnknownTab) then
		return false
	end
end

local function FakeRecognize(level)
	net.Start("ixRecognizeFakeName")
		net.WriteUInt(level, 2)
	net.SendToServer()
end

function PLUGIN:RecognizeMenuOpened(menu)
	local fakeName = LocalPlayer():GetCharacter():GetFakeName()

	if (fakeName and fakeName != "") then
		local lookingAt = menu:AddOption(L("rgnFakeLookingAt", fakeName), function()
			FakeRecognize(0)
		end)
		local whisper = menu:AddOption(L("rgnFakeWhisper", fakeName), function()
			FakeRecognize(1)
		end)
		local talk = menu:AddOption(L("rgnFakeTalk", fakeName), function()
			FakeRecognize(2)
		end)
		local yell = menu:AddOption(L("rgnFakeYell", fakeName), function()
			FakeRecognize(3)
		end)

		lookingAt:SetFont("MenuFontNoClamp")
		lookingAt:SetTextColor(Color(200, 100, 100))
		whisper:SetFont("MenuFontNoClamp")
		whisper:SetTextColor(Color(200, 100, 100))
		talk:SetFont("MenuFontNoClamp")
		talk:SetTextColor(Color(200, 100, 100))
		yell:SetFont("MenuFontNoClamp")
		yell:SetTextColor(Color(200, 100, 100))
	end
end
