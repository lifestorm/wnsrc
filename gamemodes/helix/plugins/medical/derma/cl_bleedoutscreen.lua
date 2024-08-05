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
	self.startTime = CurTime()
	self.deathTime = 0

	self:SetSize(ScrW(), ScrH())
	self.Paint = function(self, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/nlrbleedout/bleedout-background.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	local padding = SScaleMin(5 / 3)
	local textPanel = self:Add("Panel")
	textPanel:SetSize(SScaleMin(520 / 3), SScaleMin(360 / 3))
	textPanel:Center()
	local x, y = textPanel:GetPos()
	textPanel:SetPos(x, y - SScaleMin(65 / 3)) -- center but with less y position because Atle
	textPanel.Paint = function(self, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/nlrbleedout/bleedout-icon.png"))
		surface.DrawTexturedRect(w * 0.5 - SScaleMin(42 / 3) * 0.5, 0, SScaleMin(42 / 3), SScaleMin(61 / 3))
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

	local bleedingTitle = textPanel:Add("DLabel")
	textStandard(bleedingTitle, Color(234, 236, 233, 255), "WNBleedingTitleNoClamp", 61 + padding, string.utf8upper("you are bleeding")) -- 61 icon height

	local bleedingText = textPanel:Add("DLabel")
	textStandard(bleedingText, Color(200, 200, 200, 255), "WNBleedingTextNoClamp", -padding, "You’re incapacitated and require bandages to stay alive.")

	local countdownPanel = textPanel:Add("Panel")
	countdownPanel:SetSize(self:GetWide(), SScaleMin(46 / 3))
	countdownPanel:Dock(TOP)
	countdownPanel:DockMargin(0, padding * 4, 0, 0)
	countdownPanel.Paint = function(pnl, w, h)
		local curTime = CurTime()

		surface.SetDrawColor(Color(0, 0, 0, 178)) -- 70% opacity
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(112, 112, 112, 178)) -- 70% opacity
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(Color(255, 78, 79, 255))
		surface.DrawRect(SScaleMin(8 / 3), SScaleMin(8 / 3), (w * (1 - ((curTime - self.startTime) / (self.deathTime - self.startTime)))) - SScaleMin(16 / 3), h - SScaleMin(16 / 3)) -- make config here for countdown
	end

	self.timeLeftText = textPanel:Add("DLabel")
	textStandard(self.timeLeftText, Color(255, 78, 69, 255), "WNBleedingMinutesBoldNoClamp", padding * 3, "")

	function self.timeLeftText:SetTime(time)
		self:SetText(string.utf8upper(time > 120 and math.Round(time / 60).." minutes" or math.Round(time, 1).." seconds"))
	end

	local controlText = textPanel:Add("DLabel")
	textStandard(controlText, Color(200, 200, 200, 255), "WNBleedingTextNoClamp", -padding, "Hold E to accept your character's death.")

	local hpInfoText = textPanel:Add("DLabel")
	local requiredHealth = math.ceil(LocalPlayer():GetMaxHealth() * ix.config.Get("WakeupTreshold") / 100)
	textStandard(hpInfoText, Color(200, 200, 200, 255), "TitlesFontNoBoldNoClamp", -padding + 15, "You need "..requiredHealth.."HP to get back up.")

	local currentHPText = textPanel:Add("DLabel")
	textStandard(currentHPText, Color(255, 78, 79, 255), "TitlesFontNoBoldNoClamp", -padding + 5, "Current HP: "..LocalPlayer():Health())

	timer.Create("ixBleedout", 0.1, 0, function()
		if (!IsValid(self)) then
			timer.Remove("ixBleedout")
		end

		textStandard(currentHPText, Color(255, 78, 79, 255), "TitlesFontNoBoldNoClamp", -padding + 5, "Current HP: "..LocalPlayer():Health())

		if (LocalPlayer():GetCharacter()) then
			if LocalPlayer():GetCharacter().GetBleedout then
				if (LocalPlayer():GetCharacter():GetBleedout() < 0) then
					self:Remove()
					timer.Remove("ixBleedout")
					return
				end
			end
		end

		local curTime = CurTime()

		if (input.IsKeyDown(KEY_E) and ix.gui.chat.entry:GetText() == "") then -- Make sure the player isn't typing in chat
			self.deathTime = self.deathTime - (self.deathTime - self.startTime) * 0.025
		end

		self.timeLeftText:SetTime(self.deathTime - curTime)

		if (self.deathTime <= curTime) then
			netstream.Start("ixAcceptDeath")
			self:Remove()
		end
	end)
end

function PANEL:OnRemove()
	timer.Remove("ixBleedout")
end

function PANEL:SetTime(time)
	self.startTime = CurTime()
	self.deathTime = self.startTime + time
end

vgui.Register("ixBleedoutScreen", PANEL, "EditablePanel")
