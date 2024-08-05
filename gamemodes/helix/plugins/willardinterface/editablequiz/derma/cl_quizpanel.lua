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

local PANEL = {}

local margin10 = SScaleMin(10 / 3)
local size50 = SScaleMin(50 / 3)

function PANEL:Init()
	ix.gui.quizMenu = self

    self:SetSize(SScaleMin(600 / 3), SScaleMin(500 / 3))
    self:Center()
    self:SetTitle("Quiz Manager")
	DFrameFixer(self)

	self.leftSide = self:Add("Panel")
	self.leftSide:Dock(LEFT)
	self.leftSide:SetWide(self:GetWide() * 0.5)
	self.leftSide:DockMargin(0, 0, margin10, 0)

	local divider = self:Add("DShape")
	divider:Dock(LEFT)
	divider:SetWide(SScaleMin(1 / 3))
	divider:SetType("Rect")
	divider:DockMargin(0, 0, margin10, 0)
	divider:SetColor(Color(111, 111, 136, (255 / 100 * 30)))

	self.rightSide = self:Add("Panel")
	self.rightSide:Dock(FILL)

	self:CreateRightSide()
	netstream.Start("RequestQuizzes", true)
end

function PANEL:CreateRightTitle()
	self:CreateTitle(self.rightSide, "Question Editor")
end

function PANEL:CreateLeftTitle()
	self:CreateTitle(self.leftSide, "Current Questions")
end

function PANEL:CreateTitle(parent, text, font)
	local title = parent:Add("DLabel")
	title:Dock(TOP)
	title:SetText(text)
	title:SetFont(font or "LargerTitlesFontNoClamp")
	title:SetContentAlignment(5)
	title:SizeToContents()
	title:DockMargin(0, 0, 0, margin10)
end

function PANEL:CreateLeftSide()
	for _, v in pairs(self.leftSide:GetChildren()) do
		v:Remove()
	end

	self:CreateLeftTitle()

	local addQuiz = self.leftSide:Add("DButton")
	addQuiz:Dock(BOTTOM)
	addQuiz:SetTall(size50)
	addQuiz:SetText("ADD QUESTION")
	addQuiz:SetFont("MenuFontLargerNoClamp")
	addQuiz:DockMargin(0, margin10, 0, 0)
	addQuiz.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		if self.quizAddEditPanel then
			self.quizAddEditPanel:Remove()
			self.quizAddEditPanel = nil
		end

		self:CreateQuizAddPanel()
	end

	self.quizScroll = self.leftSide:Add("DScrollPanel")
	self.quizScroll:Dock(FILL)

	self:RefreshQuizzes()
end

function PANEL:CreateRightSide()
	self:CreateRightTitle()
end

function PANEL:RefreshQuizzes()
	for id, table in pairs(PLUGIN.quizlist) do
		local question = table[1] or "NO QUESTION"
		local answers = table[2] or {}

		local quiz = self.quizScroll:Add("DButton")
		quiz:Dock(TOP)
		quiz:SetTall(size50)
		quiz:SetText(question and (string.len(question) > 30 and string.Left(question, 30).."..." or question) or "")
		quiz:SetContentAlignment(4)
		quiz:SetTextInset(margin10, 0)
		quiz:SetFont("MenuFontLargerNoClamp")
		quiz.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")

			if self.quizAddEditPanel then
				self.quizAddEditPanel:Remove()
				self.quizAddEditPanel = nil
			end

			self:CreateQuizAddPanel(id, table)
		end

		local deleteQuiz = quiz:Add("DButton")
		deleteQuiz:Dock(RIGHT)
		deleteQuiz:DockMargin(margin10, margin10 * 1.5, 0, margin10 * 1.5)
		deleteQuiz:SetWide(SScaleMin(30 / 3))
		deleteQuiz:SetText("")
		deleteQuiz.Paint = function(self, w, h)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("materials/willardnetworks/tabmenu/navicons/exit.png"))
			surface.DrawTexturedRect(0, 0, w - SScaleMin(10 / 3), h)
		end

		deleteQuiz.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			PLUGIN:RemoveQuiz(id)
			quiz:Remove()
		end
	end
end

function PANEL:CreateQuizAddPanel(id, table)
	self.answers = {}
	self.question = ""

	self.quizAddEditPanel = self.rightSide:Add("EditablePanel")
	self.quizAddEditPanel:Dock(FILL)

	self:CreateTitle(self.quizAddEditPanel, "Question", "MenuFontNoClamp")

	local question = self.quizAddEditPanel:Add("DTextEntry")
	question:Dock(TOP)
	question:SetTall(SScaleMin(30 / 3))
	question:DockMargin(0, 0, 0, margin10)
	question:SetZPos(1)
	self:CreateTextEntry(question, id and table[1] or "A cool question")

	local addAnswer = self.quizAddEditPanel:Add("DButton")
	addAnswer:Dock(TOP)
	addAnswer:DockMargin(0, 0, 0, margin10)
	addAnswer:SetFont("MenuFontLargerNoClamp")
	addAnswer:SetText("ADD ANSWER(S)")
	addAnswer:SetTall(size50)
	addAnswer:SetZPos(2)
	addAnswer.DoClick = function()
		if #self.answers == 6 then return LocalPlayer():NotifyLocalized("Max answers is 6!") end

		self:CreateAnswer(self.quizAddEditPanel)
	end

	if !id then
		for i = 1, 2 do
			addAnswer.DoClick()
		end

		local firstAnswer = self.answers[1]:GetChildren()[1]
		firstAnswer.DoClick(firstAnswer)

		self.answers[1]:SetText("A right answer")
		self.answers[2]:SetText("A wrong answer")
	else
		for answer, rightAnswer in pairs(table[2]) do
			self:CreateAnswer(self.quizAddEditPanel, answer, rightAnswer)
		end
	end

	local bPermanent = self.quizAddEditPanel:Add("DCheckBoxLabel")
	bPermanent:Dock(BOTTOM)
	bPermanent:SetZPos(4)
	bPermanent:SetFont("MenuFontNoClamp")
	bPermanent:SetText("Permanent Question")
	bPermanent:SizeToContents()
	bPermanent:DockMargin(0, 0, 0, SScaleMin(10 / 3))
	bPermanent:SetValue(id and table[3] or false)

	local saveQuiz = self.quizAddEditPanel:Add("DButton")
	saveQuiz:Dock(BOTTOM)
	saveQuiz:SetTall(size50)
	saveQuiz:SetZPos(3)
	saveQuiz:SetText(id and "EDIT" or "SAVE")
	saveQuiz:SetFont("MenuFontLargerNoClamp")
	saveQuiz.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self.question = question:GetText()
		self:SaveQuiz(id, bPermanent:GetChecked())
		self.quizAddEditPanel:Remove()
	end
end

function PANEL:CreateAnswer(parent, sAnswer, bRightAnswer)
	local answerPanel = parent:Add("Panel")
	answerPanel:Dock(TOP)
	answerPanel:SetTall(SScaleMin(30 / 3))
	answerPanel:SetZPos(5)

	local answer = answerPanel:Add("DTextEntry")
	answer:Dock(LEFT)
	answer:SetWide(SScaleMin(267 / 3))
	answer:SetText(sAnswer or "")
	self:CreateTextEntry(answer, sAnswer or "", 30, true)

	answer.rightAnswer = bRightAnswer or false

	local trueOrFalse = answer:Add("DButton")
	trueOrFalse:Dock(RIGHT)
	trueOrFalse:SetWide(SScaleMin(30 / 3))
	trueOrFalse:SetText("")
	trueOrFalse.Paint = function(self, w, h)
		if self:GetParent().rightAnswer then
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("materials/willardnetworks/charselect/check.png"))
			surface.DrawTexturedRect(SScaleMin(5 / 3), SScaleMin(5 / 3), w - margin10, h - margin10)
		else
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("materials/willardnetworks/tabmenu/navicons/exit.png"))
			surface.DrawTexturedRect(SScaleMin(5 / 3), SScaleMin(5 / 3), w - margin10, h - margin10)
		end
	end

	trueOrFalse.DoClick = function(this)
		if !this:GetParent().rightAnswer then
			this:GetParent().rightAnswer = true
		end

		for _, v in pairs(self.answers) do
			v.rightAnswer = false
		end

		this:GetParent().rightAnswer = true
	end

	table.insert(self.answers, answer)
end

function PANEL:SaveQuiz(id, bPermanent)
	local answers = {}
	for _, v in pairs(self.answers) do
		answers[v:GetText()] = v.rightAnswer
	end

	if id then
		PLUGIN:EditQuiz(id, self.question, answers, bPermanent)
	else
		PLUGIN:AddQuiz(self.question, answers, bPermanent)
	end
end

function PANEL:CreateTextEntry(parent, value, maxChars, bShouldBePaintedShorter)
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetCursorColor(Color(200, 200, 200, 255))
	parent:SetFont("MenuFontNoClamp")
	parent:SetText(value or "")
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, bShouldBePaintedShorter and (w - SScaleMin(30 / 3) - margin10) or w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, bShouldBePaintedShorter and (w - SScaleMin(30 / 3) - margin10) or w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	if maxChars then
		parent.MaxChars = maxChars
		parent.AllowInput = function()
			local value2 = parent:GetValue()
			if (string.utf8len(value2) > maxChars) then
			  return true
			end
		end
	end
end

vgui.Register("QuizPanel", PANEL, "DFrame")