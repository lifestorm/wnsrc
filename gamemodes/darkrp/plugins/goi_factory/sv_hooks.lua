--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:CanPlayerTakeItem(client, item)
	if (!item.inUse) then return end
	client:Notify("You cannot take an item that is being used by a machine!")

	return false
end

function PLUGIN:PostPlayerSay(client, chatType, message)
	if (chatType != "ic") then return end
	if (message == "" or message == " ") then return end

	local terminal = client:GetEyeTraceNoCursor().Entity
	if (!terminal or client:EyePos():DistToSqr(terminal:GetPos()) > 10000) then return end

	--if (!terminal:GetNetVar("authenticated")) then return end
	if (!terminal:GetNetVar("broadcasting")) then return end

	--ix.chat.Send(nil, "broadcast", message, false, nil, {speakerName = "Broadcast System"})
	ix.chat.Send(client, "broadcast", message, false, nil, {speakerName = "Broadcast System"})
end
