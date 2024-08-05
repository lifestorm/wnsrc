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
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	self.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur( self, 1 )

		surface.SetDrawColor(Color(255, 255, 255, 80))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/nlrbleedout/nlr-background.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	Schema:AllowMessage(self)

	local padding = 5
	local textPanel = self:Add("Panel")
	textPanel:SetSize(SScaleMin(520 / 3), SScaleMin(300 / 3))
	textPanel:Center()
	local x, y = textPanel:GetPos()
	textPanel:SetPos(x, y - SScaleMin(65 / 3)) -- center but with less y position because Atle
	textPanel.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/nlrbleedout/nlr-icon.png"))
		surface.DrawTexturedRect(w * 0.5 - SScaleMin(77 / 3) * 0.5, 0, SScaleMin(77 / 3), SScaleMin(78 / 3))
	end

	local function textStandard(parent, color, font, topMargin, text)
		parent:Dock(TOP)
		parent:DockMargin(0, SScaleMin(topMargin / 3), 0, 0)
		parent:SetText(text)
		parent:SetTextColor(color)
		parent:SetFont(font)
		parent:SetContentAlignment(5)
		parent:SizeToContents()
	end

	local nlrTitle = textPanel:Add("DLabel")
	textStandard(nlrTitle, Color(234, 236, 233, 255), "WNBleedingTitleNoClamp", 78 + padding, string.utf8upper("you are dead")) -- 78 icon height

	local nlrText = textPanel:Add("DLabel")
	local nlrText2 = textPanel:Add("DLabel")
	local nlrText3 = textPanel:Add("DLabel")
	textStandard(nlrText, Color(200, 200, 200, 255), "WNBleedingTextNoClamp", -padding, "New life rule applies, your inventory is reset")
	textStandard(nlrText2, Color(200, 200, 200, 255), "WNBleedingTextNoClamp", -padding, "and your skill levels are reduced.")

	textStandard(nlrText3, Color(200, 200, 200, 255), "WNBleedingTextBold", -padding + 10, "You may perform one final /me action on this screen.")

	local okayButton = textPanel:Add("DButton")
	okayButton:SetSize(self:GetWide(), SScaleMin(46 / 3))
	okayButton:Dock(TOP)
	okayButton:SetText("Okay")
	okayButton:SetFont("MenuFontNoClamp")
	okayButton:DockMargin(SScaleMin(175 / 3), padding * 4, SScaleMin(175 / 3), 0)
	okayButton.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 178))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(112, 112, 112, 178))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	okayButton.DoClick = function()
		netstream.Start("ixConfirmRespawn")
		self:Remove()
	end
end

vgui.Register("ixDeathScreen", PANEL, "EditablePanel")
