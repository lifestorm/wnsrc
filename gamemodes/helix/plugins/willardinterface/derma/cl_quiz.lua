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
local PLUGIN = PLUGIN

function PANEL:Init()
	ix.gui.quizAnswering = self
	self.comboboxes = {}
		
    self:SetSize(SScaleMin(700 / 3), SScaleMin(700 / 3))
	self:Center()
    self:SetTitle("Quiz - In order to create a character, you will need to answer some questions.")
	DFrameFixer(self, false, true, true)
		
	self.quizContent = self:Add("DScrollPanel")
	self.quizContent:Dock(FILL)
	
	self.loadingLabel = self:Add("DLabel")
	self.loadingLabel:SetText("Loading Quiz Questions...")
	self.loadingLabel:SetFont("TitlesFontNoClamp")
	self.loadingLabel:SizeToContents()
	self.loadingLabel:Center()
end

function PANEL:Think()
	self:MoveToFront()
end

function PANEL:Paint(w, h)
	if (self.m_bBackgroundBlur) then
		Derma_DrawBackgroundBlur(self, self.m_fCreateTime)
	end

	surface.SetDrawColor(Color(40, 40, 40, 240))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
	surface.DrawOutlinedRect(0, 0, w, h)

	surface.DrawRect(0, 0, w, self.lblTitle:GetTall() + SScaleMin(5 / 3))
end

function PANEL:CreateQuizContent()		
	if self.loadingLabel then
		self.loadingLabel:Remove()
	end
	
	for k, table in pairs(PLUGIN.quizlist) do
		local question = table[1] or "NO QUESTION"
		local answers = table[2] or {}
				
		local questionTitle = self.quizContent:Add("DLabel")
		questionTitle:SetFont("TitlesFontNoClamp")
		questionTitle:Dock(TOP)
		questionTitle:SetText(question or "")
		questionTitle:SetContentAlignment(5)
		questionTitle:DockMargin(SScaleMin(20 / 3), k == 1 and SScaleMin(20 / 3) or 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
		questionTitle:SetWrap(true)
		questionTitle:SetAutoStretchVertical(true)
		
		local answerPanel = self.quizContent:Add("DComboBox")
		answerPanel:Dock(TOP)
		answerPanel:SetTall(SScaleMin(30 / 3))
		answerPanel:SetValue("Choose Answer")
		answerPanel:SetFont("SmallerTitleFontNoBoldNoClamp")
		answerPanel.question = k
		answerPanel:SetContentAlignment(5)
		answerPanel.Paint = function(self, w, h)
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		answerPanel.Think = function(self)
			if IsValid(self.Menu) then
				self.Menu:MoveToFront()
			end
		end
		
		answerPanel:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(20 / 3))
		
		for _, answer in pairs(table[2]) do
			answerPanel:AddChoice(answer or "")
		end
		
		self.comboboxes[#self.comboboxes + 1] = answerPanel
	end
	
	local textPanel = self.quizContent:Add("Panel")
	textPanel:Dock(TOP)
	textPanel:SetTall(SScaleMin(20 / 3))

	local warningIcon = textPanel:Add("DImage")
	warningIcon:SetSize(SScaleMin(12 / 3), SScaleMin(20 / 3))
	warningIcon:Dock(LEFT)
	warningIcon:DockMargin(0, 0, SScaleMin(8 / 3), 0)
	warningIcon:SetImage("willardnetworks/mainmenu/charcreation/warning.png")

	local panelText = textPanel:Add("DLabel")
	panelText:SetText("Unsure about the answers? Check our forums for more information.        ")
	panelText:SetFont("WNBackFontNoClamp")
	panelText:SetTextColor(Color(255, 204, 0, 255))
	panelText:Dock(LEFT)
	panelText:SetContentAlignment(4)
	panelText:SizeToContents()
	
	local lrMargins = (self:GetWide() * 0.5) - ((warningIcon:GetWide() + SScaleMin(8 / 3)) * 0.5) - (panelText:GetWide() * 0.5)
	textPanel:DockMargin(lrMargins, 0, lrMargins, 0)
	
	local finish = self:Add("DButton")
	finish:Dock(BOTTOM)
	finish:SetFont("TitlesFontNoClamp")
	finish:SetText("FINISH")
	finish:DockMargin(0, SScaleMin(20 / 3), 0, 0)
	finish:SetTall(SScaleMin(50 / 3))
	finish.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:GetAnswers()
	end
end

function PANEL:GetAnswers()
	local answers = {}
	
	for _, v in pairs(self.comboboxes) do
		if v:GetSelected() and v:GetSelected() != "" and v:GetSelected() != "Choose Answer" then
			answers[v.question] = v:GetSelected()
		end
	end
	
	netstream.Start("CompleteQuiz", answers)
end

vgui.Register("ixQuizMenu", PANEL, "DFrame")

netstream.Hook("RemoveQuizUI", function()
	if ix.gui.quizAnswering and IsValid(ix.gui.quizAnswering) then
		ix.gui.quizAnswering:Remove()
	end
end)
