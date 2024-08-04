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
PLUGIN.targetedLandlineEndpointID = nil
PLUGIN.targetedLandlinePBX = nil
PLUGIN.targetedLandlineExt = nil
PLUGIN.targetedLandlineName = nil

do
	surface.CreateFont("phoneMonoDebug", {
		font = "Consolas",
		size = 16,
		extended = true,
		weight = 1200
	})
end

function PLUGIN:InitializedPlugins()
	local color = Color(255, 0, 255)
	local function drawConnectorESP(client, entity, x, y, factor)
		ix.util.DrawText(
			"Landline Phone",
			x,
			y - math.max(10, 32 * factor),
			color,
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			nil,
			math.max(255 * factor, 80)
		)
	end

	ix.observer:RegisterESPType("landline_phone", drawConnectorESP, "Landline Phone")
end

net.Receive("EnterLandlineDial", function()
	PLUGIN.targetedLandlineEndpointID = net.ReadInt(15)
	PLUGIN.targetedLandlinePBX = net.ReadInt(5)
	PLUGIN.targetedLandlineExt = net.ReadInt(11)
	PLUGIN.targetedLandlineName = net.ReadString()
	PLUGIN.landlineEntIdx = net.ReadInt(17)

	if (PLUGIN.panel) then
		LocalPlayer():Notify("You're currently using a phone!")
	else
		vgui.Create("ixLandlineDial")
	end
end)

net.Receive("ixConnectedCallStatusChange", function()
	local active = net.ReadBool()
	local inCall = net.ReadBool()

	if (active) then
		PLUGIN.offHook = true
	end

	if (active and inCall) then
		PLUGIN.otherSideActive   = true
		PLUGIN.otherSideRinging  = false
		PLUGIN.currentCallStatus = ""

		net.Start("RunGetPeerName")
		net.SendToServer()

		timer.Simple(0.25, function()
			-- wait for the vgui panel to come up (if we're picking up in this state)
			LocalPlayer():StopSound("landline_ringtone.wav")
			LocalPlayer():StopSound("landline_dialtone.wav")
		end)
	else
		PLUGIN.otherSideRinging    = false
		PLUGIN.otherSideActive     = false
		PLUGIN.currentCallStatus   = "WAITING"
		PLUGIN.currentCallPeerName = "Unknown"

		if (PLUGIN.panel) then
			LocalPlayer():StopSound("landline_dialtone.wav")
			LocalPlayer():EmitSound("landline_dialtone.wav", 40, 100, 1, CHAN_STATIC)
		end
	end
end)

net.Receive("OnGetPeerName", function()
	PLUGIN.currentCallPeerName = net.ReadString()
end)

net.Receive("LineTestChat", function()
	local text = net.ReadString()
	local chatIcon = ix.util.GetMaterial("willardnetworks/chat/message_icon.png")
	local color = Color(105, 157, 178)
	local formattedText = string.format("[PHONE] %s: \"%s\"", "Line Test", text or "Error!")

	if (ix.option.Get("standardIconsEnabled")) then
		chat.AddText(chatIcon, color, formattedText)
	else
		chat.AddText(color, formattedText)
	end
end)

net.Receive("LineStatusUpdate", function()
	PLUGIN.currentLineStatus = net.ReadString()
	if (PLUGIN.currentLineStatus ~= ix.phone.switch.DialStatus.Success and
		PLUGIN.currentLineStatus ~= ix.phone.switch.DialStatus.DebugMode) then

		LocalPlayer():StopSound("landline_ringtone.wav")
		LocalPlayer():EmitSound("landline_dialtone.wav", 40, 100, 1, CHAN_STATIC)
	elseif (PLUGIN.currentLineStatus == ix.phone.switch.DialStatus.LineBusy) then
		LocalPlayer():EmitSound("landline_line_busy.wav", 40, 100, 1, CHAN_STATIC)

	elseif (PLUGIN.currentLineStatus == ix.phone.switch.DialStatus.Success or
		PLUGIN.currentLineStatus == ix.phone.switch.DialStatus.DebugMode) then
		timer.Simple(0.25, function()
			-- wait for the vgui panel to come up (if we're picking up in this state)
			LocalPlayer():StopSound("landline_dialtone.wav")
		end)
	end
end)

net.Receive("ForceHangupLandlinePhone", function()
	if (PLUGIN.panel and PLUGIN.panel.Close) then
		PLUGIN.panel:Close()

		PLUGIN.offHook = false
		PLUGIN.otherSideRinging    = false
		PLUGIN.otherSideActive     = false
		PLUGIN.currentCallStatus   = "WAITING"
		PLUGIN.currentCallPeerName = "Unknown"

		net.Start("RunHangupLandline")
		net.SendToServer()
	end
end)
