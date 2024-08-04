--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PANEL = {}

function PANEL:Init()
	local scrW, scrH = ScrW(), ScrH()

	self:SetSize(scrW * 0.3, scrH * 0.4)
	self.text = vgui.Create("DTextEntry", self)
	self.text:Dock(FILL)
	self.text:DockMargin(0, 0, 0, SScaleMin(4 / 3))
	self.text:SetMultiline(true)
	self.text:SetEditable(false)
	self.text:SetTextColor(Color(200, 200, 200, 255))
	self.text:SetCursorColor(Color(200, 200, 200, 255))
	self.text:SetFont("MenuFontNoClamp")
	self.text:SetText("")
	self.text.Paint = function(panel, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
	end

	self.text.OnChange = function()
		self.save:SetDisabled(false)
	end

	local maxLen = ix.config.Get("maxDescriptionLength", 512)

	self.text.AllowInput = function()
		local text = self.text:GetValue()
		if (string.utf8len(text) > maxLen) then
		  return true
		end
	end

	self.save = vgui.Create("DButton", self)
	self.save:SetText("Save")
	self.save:SetFont("MenuFontNoClamp")
	self.save:SetTextColor(color_white)
	self.save:SetTall(SScaleMin(30 / 3))
	self.save:Dock(BOTTOM)
	self.save:SetDisabled(true)
	self.save.DoClick = function(btn)
		local curTime = CurTime()

		if (!btn.nextClick or btn.nextClick <= curTime) then
			  surface.PlaySound("helix/ui/press.wav")
		  self.save:SetDisabled(true)

		  netstream.Start("ixChangeDescription", self.characterId, self.text:GetValue())

		  btn.nextClick = curTime + 0.5
		end
	end

	self:Center()
	DFrameFixer(self)
end

function PANEL:SetDescription(desc)
	self.text:SetText(desc)
	self:FixLabelTitle()
end

function PANEL:FixLabelTitle()
	self.lblTitle:SetFont("MenuFontNoClamp")
	self.lblTitle:SizeToContents()
end

function PANEL:SetEditable(edit)
  self.text:SetEditable(edit)
end

vgui.Register("ixExtendedDescription", PANEL, "DFrame")
