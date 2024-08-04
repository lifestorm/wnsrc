--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local util = util
local net = net
local ipairs = ipairs

util.AddNetworkString("ixFakeName")
util.AddNetworkString("ixRecognizeFakeName")

net.Receive("ixFakeName", function(length, client)
	local text = net.ReadString()
	text = text != "" and text or nil

	client:GetCharacter():SetFakeName(text)

	if (text) then
		client:NotifyLocalized("fakeName", text)
	else
		client:NotifyLocalized("noFakeName")
	end
end)

net.Receive("ixRecognizeFakeName", function(_, client)
	local level = net.ReadUInt(2)
	local fakeName = client:GetCharacter():GetFakeName()
	local recogCharID = client:GetCharacter():GetID()
	local targets = {}

	if (level < 1) then
		local entity = client:GetEyeTraceNoCursor().Entity

		if (IsValid(entity) and entity:IsPlayer() and entity:GetCharacter()
		and ix.chat.classes.ic:CanHear(client, entity)) then
			targets[1] = entity
		end
	else
		local class = "w"

		if (level == 2) then
			class = "ic"
		elseif (level == 3) then
			class = "y"
		end

		class = ix.chat.classes[class]

		for _, v in ipairs(player.GetAll()) do
			if (client != v and v:GetCharacter() and class:CanHear(client, v)) then
				targets[#targets + 1] = v
			end
		end
	end

	if (#targets > 0) then
		for _, v in ipairs(targets) do
			local fakeNames = v:GetCharacter():GetFakeNames()

			if (fakeNames[recogCharID] == true) then
				continue
			end

			if (fakeName and fakeName != "") then
				fakeNames[recogCharID] = fakeName
			else
				fakeNames[recogCharID] = true
			end

			v:GetCharacter():SetFakeNames(fakeNames)
		end
	end
end)
