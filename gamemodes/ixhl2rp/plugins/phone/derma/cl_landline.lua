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
PLUGIN.offHook = false
PLUGIN.otherSideRinging    = false
PLUGIN.otherSideActive     = false
PLUGIN.currentCallStatus   = "WAITING"
PLUGIN.currentCallPeerName = "Unknown"
PLUGIN.currentLineStatus   = ""

local dialSeq = {}
local buttonMap = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"}

local PANEL = {}

function dialSeq:insert(signal)
	self[#self+1] = signal
end

function dialSeq:reset()
	for k, signal in ipairs(self) do
		self[k] = nil
	end
end

function dialSeq:asStr()
	local dialSeqStr = ""
	for _, signal in ipairs(self) do
		dialSeqStr = dialSeqStr..signal
	end
	return dialSeqStr
end

function dialSeq:playDTMFTone(signal)
	local _signal = signal
	if (signal == "*") then _signal = "asterisk" end
	if (signal == "#") then _signal = "pound" end

	surface.PlaySound("dtmftones/dtmfgen_".._signal..".wav")
end

function PANEL:Init()
	PLUGIN.currentLineStatus = ""

	if (IsValid(PLUGIN.panel)) then
		PLUGIN.panel:Remove()
	end

	self:SetSize(500, 780)
	self:Center()
	self:CenterHorizontal(0.6)
	self:SetBackgroundBlur(false)
	self:SetDeleteOnClose(true)
	self:SetTitle(" ")
	self:ShowCloseButton(false)
	self:IsDraggable(true)

	self.verStamp = self:Add("DLabel")
	self.verStamp:Dock(TOP)
	self.verStamp:DockMargin(0, 7, 55, 0)
	self.verStamp:SetFont("DermaDefaultBold")
	self.verStamp:SetHeight(30)
	self.verStamp:SetColor(Color(215, 240, 231))
	self.verStamp:SetText(L("UU pbxOS BETA v0.254ga - NODEID - "..tostring(PLUGIN.targetedLandlineEndpointID)))
	self.verStamp:SetContentAlignment(9)

	self.status = self:Add("DLabel")
	self.status:Dock(TOP)
	self.status:DockMargin(0, -10, 0, 0)
	self.status:SetFont("DermaDefaultBold")
	self.status:SetHeight(30)
	self.status:SetColor(Color(215, 240, 231))
	local _connStatus = "DISCONNECTED!"
	local _curPBX = "N/A"
	if (PLUGIN.targetedLandlinePBX and PLUGIN.targetedLandlinePBX > 0) then
		_connStatus = "ACTIVE"
		_curPBX = "0"..tostring(PLUGIN.targetedLandlinePBX)
	end
	self.status:SetText(L("Connection Status: ".._connStatus))
	self.status:SetContentAlignment(5)

	self.name = self:Add("DLabel")
	self.name:Dock(TOP)
	self.name:DockMargin(0, 4, 75, 0)
	self.name:SetText(L(tostring(PLUGIN.targetedLandlineName)))
	self.name:SetHeight(35)
	self.name:SetFont("CloseCaption_Bold")
	self.name:SetColor(Color(15, 13, 44, 220))
	self.name:SetContentAlignment(9)

	self.pBX = self:Add("DLabel")
	self.pBX:Dock(TOP)
	self.pBX:DockMargin(75, 4, 0, 0)
	self.pBX:SetText(L("PBX   :> ".._curPBX))
	self.pBX:SetHeight(35)
	self.pBX:SetFont("CloseCaption_Bold")
	self.pBX:SetColor(Color(15, 13, 44, 220))
	self.pBX:SetContentAlignment(7)

	self.ext = self:Add("DLabel")
	self.ext:Dock(TOP)
	self.ext:DockMargin(75, 4, 0, 0)
	self.ext:SetText(L("EXT   :> "..tostring(PLUGIN.targetedLandlineExt)))
	self.ext:SetHeight(35)
	self.ext:SetFont("CloseCaption_Bold")
	self.ext:SetColor(Color(15, 13, 44, 220))
	self.ext:SetContentAlignment(7)

	self.dialSeqText = self:Add("DLabel")
	self.dialSeqText:Dock(TOP)
	self.dialSeqText:DockMargin(75, 4, 0, 0)
	self.dialSeqText:SetText(L("DIAL :> "))
	self.dialSeqText:SetHeight(50)
	self.dialSeqText:SetFont("CloseCaption_Bold")
	self.dialSeqText:SetColor(Color(15, 13, 44, 220))
	self.dialSeqText:SetContentAlignment(7)

	local close = vgui.Create("DButton")
	close:SetText(L("close"))
	close:SetSize(70, 70)
	close.DoClick = function()
		dialSeq:playDTMFTone("#")
		self:Close()

		PLUGIN.offHook = false
		PLUGIN.otherSideRinging    = false
		PLUGIN.otherSideActive     = false
		PLUGIN.currentCallStatus   = "WAITING"
		PLUGIN.currentCallPeerName = "Unknown"

		net.Start("RunHangupLandline")
		net.SendToServer()

		LocalPlayer():StopSound("landline_ringtone.wav")
		LocalPlayer():StopSound("landline_dialtone.wav")
	end

	local dial = vgui.Create("DButton")
	dial:SetText(L("Dial"))
	dial:SetColor(Color(0, 255, 0))
	dial:SetSize(70, 70)
	dial.DoClick = function()
		if (PLUGIN.otherSideRinging or PLUGIN.otherSideActive or
			PLUGIN.currentCallStatus ~= "WAITING") then
			return
		end

		net.Start("BeginDialToPeer")
			net.WriteString(dialSeq:asStr())
			net.WriteInt(PLUGIN.targetedLandlinePBX, 5)
			net.WriteInt(PLUGIN.targetedLandlineExt, 11)
		net.SendToServer()

		net.Start("LandlineKeyPress")
			net.WriteInt(PLUGIN.landlineEntIdx, 17)
		net.SendToServer()

		PLUGIN.offHook = true
		PLUGIN.otherSideRinging  = true
		PLUGIN.otherSideActive   = false
		PLUGIN.currentCallStatus = "RINGING"

		-- doing this instead of surface.PlaySound so we can stop it
		LocalPlayer():EmitSound("landline_ringtone.wav", 40, 100, 1, CHAN_STATIC)
	end

	local reset = vgui.Create("DButton")
	reset:SetText(L("Reset"))
	reset:SetColor(Color(255, 0, 0))
	reset:SetSize(70, 70)
	reset.DoClick = function()
		dialSeq:reset()
		dialSeq:playDTMFTone("0")
		self.dialSeqText:SetText(L("DIAL :> "))

		net.Start("LandlineKeyPress")
			net.WriteInt(PLUGIN.landlineEntIdx, 17)
		net.SendToServer()
	end

	self.optsGrid = self:Add("DGrid")
	self.optsGrid:SetPos(350, 400)
	self.optsGrid:SetCols(1)
	self.optsGrid:SetColWide(80)
	self.optsGrid:SetRowHeight(80)

	self.optsGrid:AddItem(reset)
	self.optsGrid:AddItem(dial)
	self.optsGrid:AddItem(close)

	self.numberGrid = self:Add("DGrid")
	self.numberGrid:SetPos(100, 400)
	self.numberGrid:SetCols(3)
	self.numberGrid:SetColWide(80)
	self.numberGrid:SetRowHeight(80)

	for _, key in ipairs(buttonMap) do
		local button = vgui.Create("DButton")
		button:SetText(key)
		button:SetSize(70, 70)
		button:SetFont("DermaLarge")

		button.DoClick = function()
			dialSeq:playDTMFTone(key)
			dialSeq:insert(key)
			self.dialSeqText:SetText(L("DIAL :> "..dialSeq:asStr()))

			LocalPlayer():StopSound("landline_dialtone.wav")

			net.Start("LandlineKeyPress")
				net.WriteInt(PLUGIN.landlineEntIdx, 17)
			net.SendToServer()
		end

		self.numberGrid:AddItem(button)
	end

	self:MakePopup()
	self:SetKeyboardInputEnabled(false)
	PLUGIN.panel = self

	LocalPlayer():EmitSound("landline_dialtone.wav", 40, 100, 1, CHAN_STATIC)
end

function PANEL:OnRemove()
	PLUGIN.panel = nil
	dialSeq:reset()

	LocalPlayer():StopSound("landline_dialtone.wav")
	LocalPlayer():StopSound("landline_line_busy.wav")
end

-- YES I know this is a bit of a mess but, what can you do?? its DERMA
function PANEL:Paint(w, h)
	-- background
	draw.RoundedBox(6, 0, 0, w, h, Color(35, 35, 45, 200))

	surface.SetDrawColor(61, 61, 77, 255)
	surface.DrawOutlinedRect(0, 0, w, h, 2)

	-- "screen"
	draw.RoundedBox(6, 60, 20, 390, 350, Color(215, 240, 231))
	-- outline
	surface.SetDrawColor(15, 13, 44, 255)
	surface.DrawOutlinedRect(65, 30, 380, 320, 4)

	-- boxes:
	local drawOutlineBoxPair = function (x, y, w, h, thick, darker, black)
		surface.SetDrawColor(150, 150, 140, 100)
		if (darker) then
			surface.SetDrawColor(150, 150, 140, 150)
		end
		if (black) then
			surface.SetDrawColor(0, 0, 0, 255)
		end
		surface.DrawRect(x, y, w, h)
		surface.SetDrawColor(15, 13, 44, 255)
		surface.DrawOutlinedRect(x, y, w, h, thick)
	end
	-- top box
	drawOutlineBoxPair(65, 30, 376, 55, 3, false, true)
	-- name
	drawOutlineBoxPair(67, 85, 376, 38, 2)
	-- exchange
	drawOutlineBoxPair(67, 123, 376, 38, 2, true)
	-- ext
	drawOutlineBoxPair(67, 161, 376, 38, 2)
	-- dial
	drawOutlineBoxPair(67, 199, 376, 38, 2, true)
	-- status
	drawOutlineBoxPair(65, 295, 376, 55, 3, false, true)

	-- line status text
	surface.SetFont("phoneMonoDebug")
	surface.SetTextColor(15, 13, 44, 220)
	local lineStatusHeight = 13
	local lineStatusLineNo = 1
	for lineStatusLine in string.gmatch(PLUGIN.currentLineStatus, "[^\n]+") do
		surface.SetTextPos(80, 227 + (lineStatusHeight * lineStatusLineNo))
		surface.DrawText(lineStatusLine)
		lineStatusLineNo = lineStatusLineNo + 1
	end

	-- call status text (YES i know)
	surface.SetFont("CloseCaption_Normal")
	surface.SetTextColor(215, 240, 231, 255)
	surface.SetTextPos(75, 300)
	surface.DrawText("STATUS :> ")
	surface.SetFont("CloseCaption_Bold")
	if (PLUGIN.targetedLandlinePBX and PLUGIN.targetedLandlinePBX == 0) then
		surface.DrawText("NOT SET UP")
	else
		surface.DrawText(tostring(PLUGIN.currentCallStatus))
	end
	surface.SetTextPos(190, 300)
	if (PLUGIN.otherSideActive == true and PLUGIN.currentCallStatus == "") then
		surface.SetFont("CloseCaption_Normal")
		surface.DrawText(tostring(PLUGIN.currentCallPeerName) or "Unknown")
		surface.SetFont("CloseCaption_Bold")
	end

	-- time text
	surface.SetTextColor(215, 240, 231, 255)
	surface.SetTextPos(70, 35)
	local ostime = os.time()
	surface.SetFont("DermaDefaultBold")
	surface.DrawText(os.date("%H:%M:%S", ostime))
	surface.SetTextPos(70, 50)
	surface.DrawText(ix.config.Get("day").."/"..ix.config.Get("month").."/"..ix.config.Get("year"))
end

vgui.Register("ixLandlineDial", PANEL, "DFrame")
