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

surface.CreateFont("VisorScrolling", {
	font = "Tahoma",
	size = ScreenScale(24 / 3),
	weight = 0,
	antialias = true,
})

local PANEL = {}

function PANEL:Init()
	self.scrollingmessage = "SOCIO-STABILIZATION INTACT" -- Default Message
	self.scrollspeed = 150 -- Default Scrollspeed
	self.scrollingcolor = "blue" -- If Color Is Not Defined Fallback On This
	self.width = ScrW() * 0.1823 -- Width Of The Box
	self.open = false
	self.closed = true

	self:SetTall(0)
	self:SetWidth(self.width)
	self:SetPos(ScrW() - self.width / 2 - 50 - self.width / 2, 50)

	ix.gui.visor = self
end

function PANEL:DrawScrollingText(w, h)
	local text = self.scrollingmessage.."     ///     " -- So The Message Appears Like So, EX: JUDGEMENT WAIVER     ///   JUDGEMENT WAIVER
	surface.SetFont("VisorScrolling") -- Set The Font

	local textw, _ = surface.GetTextSize(text) -- Text Size From The Font
	surface.SetTextColor(Schema.colors[self.scrollingcolor]) -- Set The Color To The Variable

	local x = RealTime() * self.scrollspeed % textw * -1 -- Magic
	while (x < w) do -- More Magic
		surface.SetTextPos(x, 8.5)
		surface.DrawText(text)
		x = x + textw
	end
end

function PANEL:DrawCorners(x, y, w, h)
	local length = 12
	local thickness = 3

	surface.DrawRect(x, y, length, thickness) -- Top Left
	surface.DrawRect(x, y, thickness, length)

	surface.DrawRect(x + (w - length), y, length, thickness) -- Top Right
	surface.DrawRect(x + (w - thickness), y, thickness, length)

	surface.DrawRect(x, y + (h - length), thickness, length) -- Bottom Left
	surface.DrawRect(x, y + (h - thickness), length, thickness)

	surface.DrawRect(x + (w - thickness), y + (h - length), thickness, length) -- Bottom Right
	surface.DrawRect(x + (w - length), y + (h - thickness), length, thickness)
end

function PANEL:Open()
	if (self.open) then return end

	-- check if close animation finished
	if (!self.closed) then
		self.shouldReopen = true
	end

	surface.PlaySound("ui/hint.wav")

	self.open = CurTime() -- It's open so it's set to true.
	self.closed = false

	surface.SetFont("VisorScrolling")
	local _, textH = surface.GetTextSize("000")
	local x, y = self:GetPos()

	self:SetAlpha(255) -- Make Sure Its Visible
	self:SizeTo(-1, textH + 15.5, 0.3, 0) -- Animation
	self:MoveTo(x, (y - (textH / 2)), 0.3, 0)
end

function PANEL:Close()
	if (!self.open) then return end
	self.open = false -- It's not open so it's set to false.

	surface.SetFont("VisorScrolling") -- Get The Height/Width Of The Font So We Can Move It Accordingly
	local _, textH = surface.GetTextSize("000")
	local x, y = self:GetPos()

	self:SizeTo(-1, 0, 0.3, 0, -1, function()
		self.closed = true
		if (self.shouldReopen) then
			self.shouldReopen = nil
			-- make sure to reopen with latest data
			self.scrollingcolor = GetNetVar("visorColor", "blue")
			self.scrollingmessage = GetNetVar("visorText", "SOCIO-STABILIZATION INTACT")
			self:Open()
		end
	end) -- Animation
	self:MoveTo(x, (y + (textH / 2)), 0.3, 0)
end

function PANEL:Think()
	if (!IsValid(LocalPlayer())) then return end

	if (LocalPlayer():HasActiveCombineMask() or LocalPlayer():IsDispatch()) then
		-- Close if blue and open for more than 10 seconds
		if (self.open and (self.open < CurTime() - 10)) then
			self:Close()
		end

		-- Check if text/colors needs to be updated
		if (self.scrollingcolor != GetNetVar("visorColor", "blue") or self.scrollingmessage != GetNetVar("visorText", "SOCIO-STABILIZATION INTACT")) then
			-- If open for at least five seconds, close
			-- If fully closed, update and open
			if (self.open and (self.open < CurTime() - 5)) then
				self:Close()
			elseif (self.closed) then
				self.scrollingcolor = GetNetVar("visorColor", "blue")
				self.scrollingmessage = GetNetVar("visorText", "SOCIO-STABILIZATION INTACT")
				self:Open()
			end
		end

	end
end

function PANEL:Paint(w, h)
	if (!LocalPlayer():HasActiveCombineMask() and !LocalPlayer():IsDispatch()) then
		return
	end

	if (self.closed) then
		return
	end

	local color = Schema.colors[self.scrollingcolor]
	surface.SetDrawColor(color.r, color.g, color.b, 25) -- Background
	surface.DrawRect(0, 0, w, h)

	self:DrawScrollingText(self.width, h) -- Scrolling Text

	surface.SetDrawColor(color) -- Corners
	self:DrawCorners(0, 0, w, h)
end

vgui.Register("ixVisorScroller", PANEL, Panel)