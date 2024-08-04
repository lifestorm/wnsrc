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
PLUGIN.ui = PLUGIN.ui or {}

-- Progress Bar
local PANEL = {}

function PANEL:Init()
	self:SetMouseInputEnabled(false)
	self:SetTall(16)
	self:SetProgress(0)
end

function PANEL:SetProgress(amount)
	self.progress = math.Clamp(math.ceil(amount), 0, 100)
end

function PANEL:GetProgress()
	return self.progress
end

function PANEL:Think()
	self:SetProgress(((CurTime() - PLUGIN.startTime) / PLUGIN.currentSongDuration) * 100)
end

function PANEL:Paint(w, h)
	local progressWidth = math.Clamp(math.ceil(self.progress / 100 * self:GetWide()), 0, w - 4)

	surface.SetDrawColor(140, 140, 140)
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.SetDrawColor(170, 170, 170)
	surface.DrawRect(0, 0, progressWidth, h - 4)

	local textWidth = surface.GetTextSize(string.FormattedTime(PLUGIN.currentSongDuration, "%2i:%02i"))

	surface.SetTextColor(240, 240, 240)
	surface.SetTextPos(w - textWidth, 0)
	surface.DrawText(string.FormattedTime(PLUGIN.currentSongDuration, "%2i:%02i"))

	surface.SetTextColor(240, 240, 240)
	surface.SetTextPos(textWidth / 2, 0)
	surface.DrawText(string.FormattedTime(CurTime() - PLUGIN.startTime, "%2i:%02i"))
end

vgui.Register("ixSongPlayer.Bar", PANEL, "Panel")

PANEL = {}

AccessorFunc(PANEL, "m_bDragging", "Dragging", FORCE_BOOL)

function PANEL:Init()
	self:SetMouseInputEnabled(true)
	self:SetSize(16, 16)

	self.circleRadius = 4
	self.targetCircleRadius = 4

	self:SetDragging(false)
end

function PANEL:OnMousePressed(key)
	if (key != MOUSE_LEFT) then
		return
	end

	self:SetDragging(true)
end

function PANEL:Think()
	if (self:GetDragging()) then
		self.targetCircleRadius = 6

		if (!input.IsMouseDown(MOUSE_LEFT)) then
			self:SetDragging(false)
		end
	else
		self.targetCircleRadius = 4
	end
end

function PANEL:Paint(w, h)
	if (self.circleRadius != self.targetCircleRadius) then
		self.circleRadius = math.Approach(self.circleRadius, self.targetCircleRadius, 30 * FrameTime())
	end

	if (self:GetDragging()) then
		DisableClipping(true)
	end

	surface.SetDrawColor(164, 54, 56)
	draw.NoTexture()
	draw.Circle(self.circleRadius, self:GetTall() / 2, self.circleRadius, self.circleRadius * 2)

	DisableClipping(false)
end

vgui.Register("ixSongPlayer.SliderButton", PANEL, "Panel")

PANEL = {}

function PANEL:Init()
	self:SetMouseInputEnabled(true)
	self:SetSize(116, 16)

	self.button = self:Add("ixSongPlayer.SliderButton")
	self.button:SetPos(0, 0)
end

function PANEL:Think()
	if (self.button:GetDragging()) then
		local _, y = self.button:GetPos()
		local mouseX = self:CursorPos()

		self.button:SetPos(math.Clamp(mouseX - 6, 0, self:GetWide() - 8), y)

		if (PLUGIN.songVolume:GetInt() != self:GetAmount()) then
			PLUGIN.songVolume:SetInt(self:GetAmount())

			if IsValid(PLUGIN.mediaclip) then
				PLUGIN.mediaclip:setVolume(PLUGIN.songVolume:GetInt() / 100)
			end
		end
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(140, 140, 140)
	surface.DrawRect(0, 7, self:GetWide(), 2)
end

function PANEL:SetAmount(amount)
	local x = math.Clamp(math.ceil(math.Clamp(amount, 0, 100) / 100 * self:GetWide()), 0, self:GetWide())
	self.button:SetPos(x, 0)
end

function PANEL:GetAmount()
	local buttonX = self.button:GetPos()

	return math.ceil(buttonX / self:GetWide() * 100)
end

vgui.Register("ixSongPlayer.Slider", PANEL, "Panel")

PANEL = {}

AccessorFunc(PANEL, "m_Title", "Title", FORCE_STRING)
AccessorFunc(PANEL, "m_bLoading", "Loading", FORCE_BOOL)
AccessorFunc(PANEL, "m_bAnimating", "Animating", FORCE_BOOL)

function PANEL:Init()
	self:SetVisible(false)
	self:SetMouseInputEnabled(true)
	self:SetSize(180, 32)
	self:SetPos(ScrW() / 2, ScrH() / 2)
	self:SetPos(ScrW() / 2 - self:GetWide() / 2, 0)
	self:DockPadding(6, 4, 6, 4)

	self.label = self:Add("DLabel")
	self.label:SetContentAlignment(5)
	self.label:SetMouseInputEnabled(true)
	self.label:Dock(TOP)
	self.label:SetTextColor(Color(200, 200, 200))
	self.label:SetText(" ")
	self.label:SizeToContents()

	self.bar = self:Add("ixSongPlayer.Bar")
	self.bar:DockMargin(0, 6, 0, 0)
	self.bar:Dock(TOP)

	self.volume = self:Add("ixSongPlayer.Slider")
	self.volume:DockMargin(0, 2, 0, 0)
	self.volume:Dock(TOP)

	self:SetTitle(" ")
	self:SetLoading(true)
	self:SetAnimating(false)

	self:SetTall(self.label:GetTall() + 10)

	self.lastInteractTime = CurTime()
	self.currentAlpha = 255
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(35, 42, 61, 255)
	surface.DrawRect(0, 0, w, h)
end

function PANEL:Think()
	local w, h = self:GetSize()
	local x, y = self:GetPos()

	if ((gui.MouseX() > x and gui.MouseX() < x + w) and (gui.MouseY() > y and gui.MouseY() < y + h)) then
		if (!self:GetAnimating() and self.currentAlpha < 255) then
			self.currentAlpha = math.Approach(self.currentAlpha, 255, 600 * FrameTime())
			self:SetAlpha(self.currentAlpha)
		end

		self.lastInteractTime = CurTime()

		if (!self:GetLoading()) then
			local totalH = self.label:GetTall() + self.bar:GetTall() + self.volume:GetTall() + 14

			self:SetTall(math.Approach(h, totalH, 400 * FrameTime()))
		end
	else
		self:SetTall(math.Approach(h, self.label:GetTall() + 10, 200 * FrameTime()))

		if (!self:GetAnimating() and CurTime() > self.lastInteractTime + 6) then
			self.currentAlpha = math.Approach(self.currentAlpha, 50, 50 * FrameTime())
			self:SetAlpha(self.currentAlpha)
		end
	end
end

function PANEL:SetTitle(text)
	local _, y = self:GetPos()

	self.label:SetText(text)
	self.label:SizeToContents()

	self:SetWide(self.label:GetWide() + 64)
	self:SetPos(ScrW()/2 - self:GetWide()/2, y)

	self.bar:SetWide(self:GetWide())

	self.volume:SetWide(self:GetWide() - 16)
	self.volume:SetAmount(PLUGIN.songVolume:GetInt())

	self.m_Title = text
end

function PANEL:FadeIn()
	self:SetAnimating(true)
	self:SetVisible(true)
	self:SetAlpha(0)

	self:AlphaTo(255, 0.5, 0, function()
		self:SetAnimating(false)
		self.lastInteractTime = CurTime()
	end)
end

function PANEL:FadeOut()
	self:SetAnimating(true)
	self:SetVisible(true)

	self:AlphaTo(0, 0.5, 0, function()
		self:SetVisible(false)
		self:SetAnimating(false)
	end)
end

vgui.Register("ixSongPlayer", PANEL, "Panel")
