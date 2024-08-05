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

local color = Color(41, 243, 229, 255)

function PLUGIN:CreateRow(parent, title, text, date, bSecondInRow, bUpdateable)
	parent:SetSize(parent:GetWide(), SScaleMin(48 / 3))
	parent:Dock(TOP)
	parent.Paint = function(this, w, h)
		if (bSecondInRow) then
			surface.SetDrawColor(0, 0, 0, 75)
			surface.DrawRect(0, 0, w, h)
		else
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)
		end
	end

	local top = parent:Add("EditablePanel")
	top:SetSize(parent:GetWide(), parent:GetTall() * 0.5)
	top:Dock(TOP)
	top.Paint = nil

	local topTitle = top:Add("DLabel")
	topTitle:SetTextColor(Color(154, 169, 175, 255))
	topTitle:SetFont("MenuFontNoClamp")
	topTitle:SetText(string.utf8upper(title)..":")
	topTitle:Dock(LEFT)
	topTitle:DockMargin(SScaleMin(20 / 3), SScaleMin(5 / 3), 0, 0)
	topTitle:SizeToContents()

	parent.bottom = parent:Add("EditablePanel")
	parent.bottom:SetSize(parent:GetWide(), parent:GetTall() * 0.4)
	parent.bottom:Dock(TOP)
	parent.bottom.Paint = nil
	parent.bottom:SetName( "bottom" )

	parent.bottom.titleText = parent.bottom:Add("DLabel")
	parent.bottom.titleText:SetTextColor(color)
	parent.bottom.titleText:SetFont("MenuFontNoClamp")
	parent.bottom.titleText:SetText(text)
	parent.bottom.titleText:Dock(LEFT)
	parent.bottom.titleText:DockMargin(SScaleMin(20 / 3), 0, 0, 0)
	parent.bottom.titleText:SizeToContents()

	if (bUpdateable) then
		local topDate = top:Add("DLabel")
		topDate:SetFont("MenuFontNoClamp")
		topDate:SetTextColor(Color(154, 169, 175, 255))
		topDate:SetText(string.utf8upper((string.find(title, "receiver") and "date" or "updated")..": "..date))
		topDate:Dock(RIGHT)
		topDate:DockMargin(0, SScaleMin(5 / 3), SScaleMin(20 / 3), 0)
		topDate:SizeToContents()
	end
end

local function CreateButton(name, text, path)
	name:SetSize(SScaleMin(480 / 3), SScaleMin(40 / 3))
	name:SetContentAlignment(4)
	name:SetTextInset(SScaleMin(20 / 3), 0)
	name:Dock(TOP)
	name:SetFont("TitlesFontNoClamp")
	name:DockMargin(0, 0, 0, SScaleMin(9 / 3))
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/"..path))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

local function CreateHalfButton(name, text, path, bDockLeft)
	name:SetSize(SScaleMin(235 / 3), SScaleMin(40 / 3))
	name:SetContentAlignment(4)
	name:SetTextInset(SScaleMin(20 / 3), 0)
	if bDockLeft then
		name:Dock(LEFT)
		name:DockMargin(0, 0, SScaleMin(5 / 3), 0)
	else
		name:Dock(RIGHT)
		name:DockMargin(SScaleMin(5 / 3), 0, 0, 0)
	end

	name:SetFont("TitlesFontNoClamp")
	name:SetText(string.utf8upper(text))
	name.Paint = function(self, w, h)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/"..path))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

local function createUpdateButton(parent)
	parent:SetSize(SScaleMin(137 / 3), SScaleMin(18 / 3))
	parent:Dock(RIGHT)
	parent:DockMargin(0, 0, SScaleMin(21 / 3), 0)
	parent:SetFont("MenuFontNoClamp")
	parent:SetText(string.utf8upper("update"))
	parent:SetContentAlignment(5)
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/smallestbutton.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

local PANEL = {}

function PANEL:GetLoyaltyText()
	local loyaltyText = PLUGIN.file.genericdata.loyaltyStatus or "N/A"
	if PLUGIN.file.genericdata.socialCredits and !PLUGIN.file.genericdata.combine then
		if PLUGIN.file.genericdata.socialCredits < 40 then
			return "UNDERCLASS"
		end
	end

	return loyaltyText
end

function PANEL:Init()
	ix.gui.citizenDatafile = self

	if !PLUGIN.file.genericdata.permits then
		PLUGIN.file.genericdata.permits = {}
		netstream.Start("RemovePermitDatapad", PLUGIN.file.genericdata)
	end

	local permitsGeneric = PLUGIN.file.genericdata.permit
	if permitsGeneric == true or permitsGeneric == false then
		PLUGIN.file.genericdata.permits = {}
		netstream.Start("RemovePermitDatapad", PLUGIN.file.genericdata)
	end

	PLUGIN.mainTitle:SetText(string.utf8upper("datafile"))
	self:SetSize(self:GetParent():GetWide(), SScaleMin(338 / 3))
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(15 / 3))
	self.Paint = nil

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "information")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(300 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local viewLogs = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(viewLogs, titleSubframe, 87, "view logs", RIGHT)

	PLUGIN:DrawDividerLine(titleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, titleSubframe, 68, "back", RIGHT)
	back.DoClick = function()
		PLUGIN.mainTitle:SetText(string.utf8upper("datapad"))
		surface.PlaySound("willardnetworks/datapad/back.wav")
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(false)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(false)
		end

		PLUGIN.updates:SetVisible(true)
		PLUGIN.functions:SetVisible(true)
	end

	viewLogs.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		PLUGIN.datafileInfo:SetVisible(false)
		PLUGIN.datafileFunctions:SetVisible(false)
		PLUGIN.viewEntryLogs = vgui.Create("ixDatafileEntryLogs", PLUGIN.contentSubframe)
	end

	local infoContentFrame = self:Add("EditablePanel")
	infoContentFrame:SetSize(self:GetWide(), SScaleMin(288 / 3))
	infoContentFrame:Dock(TOP)
	infoContentFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	infoContentFrame.Paint = nil

	local name = infoContentFrame:Add("EditablePanel")

	if (!PLUGIN.file.genericdata.cohesionPoints) then
		PLUGIN:CreateRow(name, "name", PLUGIN.file.genericdata.name, nil, false, false)
	end

	local clientName = LocalPlayer():Name()
	local clientRank = 1
	local genericName = PLUGIN.file.genericdata.name
	local genericRank = 1

	local ranks = {}
	ranks[1] = "RCT"
	ranks[2] = "i5"
	ranks[3] = "i4"
	ranks[4] = "i3"
	ranks[5] = "i2"
	ranks[6] = "i1"
	ranks[7] = "RL"
	ranks[8] = "CpT"
	ranks[9] = "ChF"

	if PLUGIN.file.genericdata.combine == true and LocalPlayer():IsCombine() then
		for k, v in pairs(ranks) do
			if Schema:IsCombineRank(clientName, v) then
				clientRank = k
			end

			if Schema:IsCombineRank(genericName, v) then
				genericRank = k
			end
		end

		if clientRank == 7 or clientRank == 8 or clientRank == 9 then
			if (clientRank > genericRank) or (genericRank == 9 and clientRank != 9) then
				local rankTopTitle = name:GetChildren()[1]:Add("DLabel")
				rankTopTitle:SetTextColor(Color(154, 169, 175, 255))
				rankTopTitle:SetFont("MenuFontNoClamp")
				rankTopTitle:SetText(string.utf8upper("RANK OPTIONS")..":")
				rankTopTitle:Dock(RIGHT)
				rankTopTitle:DockMargin(0, SScaleMin(5 / 3), SScaleMin(20 / 3), 0)
				rankTopTitle:SizeToContents()

				local demote = name.bottom:Add("DButton")
				demote:Dock(RIGHT)
				demote:SetText("DEMOTE")
				demote:SetFont("MenuFontNoClamp")
				demote:DockMargin(SScaleMin(4 / 3), 0, SScaleMin(18 / 3), 0)
				demote.Paint = nil
				demote:SetTextColor(color)
				demote:SizeToContents()
				demote.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/navigate2.wav")

					if genericRank == 1 then
						return
					end

					local newName = string.Replace( name.bottom.titleText:GetText(), ranks[genericRank], ranks[genericRank - 1] )
					PLUGIN.file.genericdata.name = newName

					name.bottom.titleText:SetText(newName)
					name.bottom.titleText:SizeToContents()
					genericRank = genericRank - 1

					netstream.Start("DatafilePromoteDemote", PLUGIN.file.genericdata.id, newName)
					netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "DEMOTED TO: "..ranks[genericRank])
				end

				local divider = name.bottom:Add("DShape")
				divider:SetType("Rect")
				divider:SetColor(color)
				divider:Dock(RIGHT)
				divider:SetWide(SScaleMin(2 / 3))
				divider:DockMargin(SScaleMin(5 / 3), SScaleMin(3 / 3), 0, SScaleMin(3 / 3), 0)

				if genericRank != 9 then
					local promote = name.bottom:Add("DButton")
					promote:Dock(RIGHT)
					promote:SetText("PROMOTE")
					promote:SetFont("MenuFontNoClamp")
					promote.Paint = nil
					promote:SetTextColor(color)
					promote:SizeToContents()
					promote.DoClick = function()
						surface.PlaySound("willardnetworks/datapad/navigate2.wav")
						if genericRank + 1 == 8 or genericRank + 1 >= clientRank then
							promote:Remove()
							demote:Remove()
							divider:Remove()

							rankTopTitle:SetText(string.utf8upper("RANK UNTOUCHABLE"))
							rankTopTitle:SizeToContents()
						end

						local newName = string.Replace( name.bottom.titleText:GetText(), ranks[genericRank], ranks[genericRank + 1] )
						PLUGIN.file.genericdata.name = newName
						name.bottom.titleText:SetText(newName)
						name.bottom.titleText:SizeToContents()
						genericRank = genericRank + 1

						netstream.Start("DatafilePromoteDemote", PLUGIN.file.genericdata.id, newName)
						netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "PROMOTED TO: "..ranks[genericRank])
					end
				end
			end
		end
	end

	self.cid = infoContentFrame:Add("EditablePanel")

	local function shouldGetBioticCredits()
		if (PLUGIN.file.genericdata.cid != "N/A") then
			netstream.Start("RequestCIDCreditsDatafile", PLUGIN.file.genericdata.cid)
		end
	end

	if (PLUGIN.file.genericdata.collarID) then
		PLUGIN:CreateRow(self.cid, "collar id | cid | credits", PLUGIN.file.genericdata.collarID.. " | " .. PLUGIN.file.genericdata.cid .. " | ".."0", nil, false, false)

		shouldGetBioticCredits()
	else
		PLUGIN:CreateRow(self.cid, "cid | credits", PLUGIN.file.genericdata.cid.." | ".."0", nil, true, false)
		netstream.Start("RequestCIDCreditsDatafile", PLUGIN.file.genericdata.cid)
	end

	local nullification = infoContentFrame:Add("EditablePanel")

	if PLUGIN.file.genericdata.cohesionPoints then
		PLUGIN:CreateRow(nullification, "nullification", string.upper(PLUGIN.file.genericdata.nulled), PLUGIN.file.genericdata.cohesionPointsDate, true, true)

		for _, v in ipairs(nullification:GetChildren()) do
			if v:GetName() == "bottom" then
				local updateStatusButton = v:Add("DButton")
				createUpdateButton(updateStatusButton)
				updateStatusButton.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/navigate2.wav")
					titleFrame:SetVisible(false)
					infoContentFrame:SetVisible(false)

					local updateStatusTitleFrame = self:Add("EditablePanel")
					PLUGIN:CreateTitle(updateStatusTitleFrame, self, "edit nullification status")

					local updateStatusTitleSubframe = updateStatusTitleFrame:Add("EditablePanel")
					updateStatusTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
					updateStatusTitleSubframe:Dock(RIGHT)
					updateStatusTitleSubframe.Paint = nil

					local editStatus = updateStatusTitleSubframe:Add("DButton")
					PLUGIN:CreateTitleFrameRightTextButton(editStatus, updateStatusTitleSubframe, 87, "edit status", RIGHT)

					PLUGIN:DrawDividerLine(updateStatusTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

					local back2 = updateStatusTitleSubframe:Add("DButton")
					PLUGIN:CreateTitleFrameRightTextButton(back2, updateStatusTitleSubframe, 68, "back", RIGHT)

					local updateStatusFrame = self:Add("DPanel")
					updateStatusFrame:SetSize(self:GetWide(), SScaleMin(288 / 3))
					updateStatusFrame:Dock(TOP)
					updateStatusFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
					updateStatusFrame.Paint = function(this, w, h)
						surface.SetDrawColor(40, 88, 115, 40)
						surface.DrawRect(0, 0, w, h)
					end

					local statusName = updateStatusFrame:Add("DLabel")
					statusName:SetFont("MenuFontNoClamp")
					statusName:SetText(string.utf8upper("select state:"))
					statusName:SetTextColor(color)
					statusName:Dock(TOP)
					statusName:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

					local nullificationOptions = vgui.Create("DComboBox", updateStatusFrame)
					nullificationOptions:SetZPos(7)
					nullificationOptions:SetFont("MenuFontNoClamp")
					nullificationOptions:SetTextColor(color)
					nullificationOptions:Dock(TOP)
					nullificationOptions:SetTall(SScaleMin(46 / 3))
					nullificationOptions:SetFont("TitlesFontNoClamp")
					nullificationOptions:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), 0)
					nullificationOptions:SetValue(string.utf8upper("/////"))
					nullificationOptions:AddChoice( string.utf8upper("ACTIVE") )
					nullificationOptions:AddChoice( string.utf8upper("INACTIVE") )
					nullificationOptions.Paint = function(panel, width, height)
						surface.SetDrawColor(40, 88, 115, 75)
						surface.DrawRect(0, 0, width, height)
					end

					back2.DoClick = function()
						surface.PlaySound("willardnetworks/datapad/back.wav")
						updateStatusTitleFrame:SetVisible(false)
						updateStatusFrame:SetVisible(false)
						titleFrame:SetVisible(true)
						infoContentFrame:SetVisible(true)
					end

					editStatus.DoClick = function()
						if (nullificationOptions:GetSelected()) then
							PLUGIN.file.genericdata.nulled = nullificationOptions:GetSelected()
							PLUGIN.file.genericdata.cohesionPointsDate = os.date("%d/%m/%Y")
							surface.PlaySound("willardnetworks/datapad/navigate.wav")
							netstream.Start("EditDatafile", PLUGIN.file.genericdata, "Nullification Status updated to " .. nullificationOptions:GetSelected())
							netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "UPDATED NULLIFICATION STATUS TO: ".. nullificationOptions:GetSelected())
						end
					end
				end
			end
		end
	end

	local statusTopTitle = self.cid:GetChildren()[1]:Add("DLabel")
	statusTopTitle:SetTextColor(Color(154, 169, 175, 255))
	statusTopTitle:SetFont("MenuFontNoClamp")
	statusTopTitle:SetText(string.utf8upper("LOYALTY STATUS")..":")
	statusTopTitle:Dock(RIGHT)
	statusTopTitle:DockMargin(0, SScaleMin(5 / 3), SScaleMin(20 / 3), 0)
	statusTopTitle:SizeToContents()

	local titleText = self.cid:GetChildren()[2]:Add("DLabel")
	titleText:SetTextColor(color)
	titleText:SetFont("MenuFontNoClamp")
	titleText:SetText(self:GetLoyaltyText())
	titleText:Dock(RIGHT)
	titleText:DockMargin(0, 0, SScaleMin(20 / 3), 0)
	titleText:SizeToContents()

	local socialCredits = infoContentFrame:Add("EditablePanel")

	if (isbool(PLUGIN.file.genericdata.combine)) then
		local date = PLUGIN.file.genericdata.socialCreditsDate

		if (PLUGIN.file.genericdata.combine) then
			PLUGIN:CreateRow(socialCredits, "sterilized credits", !PLUGIN.file.genericdata.combine and math.Clamp(tonumber(PLUGIN.file.genericdata.socialCredits), 0, 200) or tonumber(PLUGIN.file.genericdata.socialCredits), isnumber(date) and os.date("%d/%m/%Y", date) or date, false, true)
		elseif PLUGIN.file.genericdata.cohesionPoints or PLUGIN.file.genericdata.collarID then
			date = PLUGIN.file.genericdata.cohesionPointsDate
			PLUGIN:CreateRow(socialCredits, "cohesion points", !PLUGIN.file.genericdata.combine and math.Clamp(tonumber(PLUGIN.file.genericdata.cohesionPoints), 0, 200) or tonumber(PLUGIN.file.genericdata.cohesionPoints), isnumber(date) and os.date("%d/%m/%Y", date) or date, false, true)
		else
			PLUGIN:CreateRow(socialCredits, "social credits", !PLUGIN.file.genericdata.combine and math.Clamp(tonumber(PLUGIN.file.genericdata.socialCredits), 0, 200) or tonumber(PLUGIN.file.genericdata.socialCredits), isnumber(date) and os.date("%d/%m/%Y", date) or date, false, true)
		end
	end

	for _, v in pairs(socialCredits:GetChildren()) do
		if v:GetName() == "bottom" then
			local updateSocialButton = v:Add("DButton")
			createUpdateButton(updateSocialButton)
			updateSocialButton.DoClick = function()
				surface.PlaySound("willardnetworks/datapad/navigate2.wav")
				titleFrame:SetVisible(false)
				infoContentFrame:SetVisible(false)

				local updateCreditsTitleFrame = self:Add("EditablePanel")

				if (PLUGIN.file.genericdata.cohesionPoints) then
					PLUGIN:CreateTitle(updateCreditsTitleFrame, self, "edit cohesion points")
				else
					PLUGIN:CreateTitle(updateCreditsTitleFrame, self, "edit social credits")
				end

				local updateCreditsTitleSubframe = updateCreditsTitleFrame:Add("EditablePanel")
				updateCreditsTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
				updateCreditsTitleSubframe:Dock(RIGHT)
				updateCreditsTitleSubframe.Paint = nil

				local editCredits = updateCreditsTitleSubframe:Add("DButton")
				PLUGIN:CreateTitleFrameRightTextButton(editCredits, updateCreditsTitleSubframe, 87, "edit credits", RIGHT)

				PLUGIN:DrawDividerLine(updateCreditsTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

				local back2 = updateCreditsTitleSubframe:Add("DButton")
				PLUGIN:CreateTitleFrameRightTextButton(back2, updateCreditsTitleSubframe, 68, "back", RIGHT)

				local updateCreditsFrame = self:Add("DPanel")
				updateCreditsFrame:SetSize(self:GetWide(), SScaleMin(288 / 3))
				updateCreditsFrame:Dock(TOP)
				updateCreditsFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
				updateCreditsFrame.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 40)
					surface.DrawRect(0, 0, w, h)
				end

				local reason = updateCreditsFrame:Add("DLabel")
				reason:SetFont("MenuFontNoClamp")
				reason:SetText(string.utf8upper("reason:"))
				reason:SetTextColor(color)
				reason:Dock(TOP)
				reason:DockMargin( SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

				local entry = vgui.Create("DTextEntry", updateCreditsFrame)
				entry:Dock(TOP)
				entry:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
				entry:SetMultiline(false)
				entry:SetVerticalScrollbarEnabled( false )
				entry:SetEnterAllowed(false)
				entry:SetTall(SScaleMin(20 / 3))
				entry:SetFont("MenuFontNoClamp")
				entry:SetTextColor( color )
				entry:SetCursorColor( color )
				entry.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 75)
					surface.DrawRect(0, 0, w, h)

					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				entry.MaxChars = 50
				entry.OnTextChanged = function(this)
					local txt = this:GetValue()
					local amt = string.utf8len(txt)
					if amt > this.MaxChars then
						this:SetText(this.OldText)
						this:SetValue(this.OldText)
					else
						this.OldText = txt
					end
				end

				local amount = updateCreditsFrame:Add("DLabel")
				amount:SetFont("MenuFontNoClamp")
				amount:SetText(string.utf8upper("amount:"))
				amount:SetTextColor(color)
				amount:Dock(TOP)
				amount:DockMargin( SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))

				local number = vgui.Create("DNumberWang", updateCreditsFrame)
				number:Dock(TOP)

				number:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), 0)
				number:SetMinMax( -10, 10 )
				number:SetTall(SScaleMin(20 / 3))
				number:SetFont("MenuFontNoClamp")
				number:SetTextColor( color )
				number:SetCursorColor( color )
				number.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 75)
					surface.DrawRect(0, 0, w, h)

					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				local limitCount = 0

				for _, v1 in pairs(PLUGIN.file.datafilelogs) do
					if v1.points and v1.points != 0 and isnumber(v1.date) and (os.date("%d/%m/%Y", v1.date) == os.date("%d/%m/%Y")) then
						limitCount = limitCount + v1.points
					end
				end

				editCredits.DoClick = function()
					if (!PLUGIN.file.genericdata.cohesionPoints and number:GetValue() > 20 or number:GetValue() < -20) then
						LocalPlayer():NotifyLocalized("The amount has to be between -20 and 20!")
						return false
					elseif (PLUGIN.file.genericdata.cohesionPoints and number:GetValue() > 20 or number:GetValue() < -20) then
						LocalPlayer():NotifyLocalized("The amount has to be between -20 and 20!")
						return false
					end

					if (LocalPlayer():Team() != FACTION_ADMIN and PLUGIN.file.genericdata.name and ((number:GetValue() + limitCount) > 20 or (number:GetValue() + limitCount) < -20)) then
						LocalPlayer():NotifyLocalized("This person has received "..limitCount.." SC today, the max per day is -20/20!")
						return false
					end

					if (number:GetValue() == 0) then
						LocalPlayer():NotifyLocalized("You need to either add or deduct points!")
						return false
					end

					surface.PlaySound("willardnetworks/datapad/navigate.wav")

					if PLUGIN.file.genericdata.collarID then
						PLUGIN.file.genericdata.cohesionPoints = !PLUGIN.file.genericdata.combine and math.Clamp(PLUGIN.file.genericdata.cohesionPoints + number:GetValue(), 0, 200) or PLUGIN.file.genericdata.cohesionPoints + number:GetValue()
						netstream.Start("EditDatafile", PLUGIN.file.genericdata, "Cohesion Points count updated by " .. number:GetValue())
					else
						PLUGIN.file.genericdata.socialCredits = !PLUGIN.file.genericdata.combine and math.Clamp(PLUGIN.file.genericdata.socialCredits + number:GetValue(), 0, 200) or PLUGIN.file.genericdata.socialCredits + number:GetValue()
						netstream.Start("EditDatafile", PLUGIN.file.genericdata, "Social Credits count updated by " .. number:GetValue())
					end

					PLUGIN.file.genericdata.socialCreditsDate = os.time()
					netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), number:GetValue(), entry:GetText())
				end

				back2.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/back.wav")
					updateCreditsTitleFrame:SetVisible(false)
					updateCreditsFrame:SetVisible(false)
					titleFrame:SetVisible(true)
					infoContentFrame:SetVisible(true)
				end
			end
		end
	end

	local geneticDescription = infoContentFrame:Add("EditablePanel")
	if PLUGIN.file.genericdata.combine != "overwatch" then
		PLUGIN:CreateRow(geneticDescription, "genetic description", PLUGIN.file.genericdata.geneticDesc, nil, true, false)
	else
		PLUGIN:CreateRow(geneticDescription, "genetic description", "OVERWATCH", nil, true, false)
	end

	local occupation = infoContentFrame:Add("EditablePanel")
	PLUGIN:CreateRow(occupation, "occupation", string.Left(PLUGIN.file.genericdata.occupation, 38), PLUGIN.file.genericdata.occupationDate, false, true)

	for _, v in pairs(occupation:GetChildren()) do
		if v:GetName() == "bottom" then
			local updateOccupationButton = v:Add("DButton")
			createUpdateButton(updateOccupationButton)
			updateOccupationButton.DoClick = function()
				surface.PlaySound("willardnetworks/datapad/navigate2.wav")
				titleFrame:SetVisible(false)
				infoContentFrame:SetVisible(false)

				local updateOccupationTitleFrame = self:Add("EditablePanel")
				PLUGIN:CreateTitle(updateOccupationTitleFrame, self, "edit occupation")

				local updateOccupationTitleSubframe = updateOccupationTitleFrame:Add("EditablePanel")
				updateOccupationTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
				updateOccupationTitleSubframe:Dock(RIGHT)
				updateOccupationTitleSubframe.Paint = nil

				local editOccupation = updateOccupationTitleSubframe:Add("DButton")
				PLUGIN:CreateTitleFrameRightTextButton(editOccupation, updateOccupationTitleSubframe, 87, "edit occupation", RIGHT)

				PLUGIN:DrawDividerLine(updateOccupationTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

				local back2 = updateOccupationTitleSubframe:Add("DButton")
				PLUGIN:CreateTitleFrameRightTextButton(back2, updateOccupationTitleSubframe, 68, "back", RIGHT)

				local updateOccupationFrame = self:Add("DPanel")
				updateOccupationFrame:SetSize(self:GetWide(), SScaleMin(288 / 3))
				updateOccupationFrame:Dock(TOP)
				updateOccupationFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
				updateOccupationFrame.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 40)
					surface.DrawRect(0, 0, w, h)
				end

				local occupationName = updateOccupationFrame:Add("DLabel")
				occupationName:SetFont("MenuFontNoClamp")
				occupationName:SetText(string.utf8upper("enter occupation name:"))
				occupationName:SetTextColor(color)
				occupationName:Dock(TOP)
				occupationName:DockMargin( SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

				local entry = vgui.Create("DTextEntry", updateOccupationFrame)
				entry:Dock(TOP)
				entry:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
				entry:SetMultiline(false)
				entry:SetVerticalScrollbarEnabled( false )
				entry:SetText(PLUGIN.file.genericdata.occupation)
				entry:SetEnterAllowed(false)
				entry:SetTall(SScaleMin(20 / 3))
				entry:SetFont("MenuFontNoClamp")
				entry:SetTextColor( color )
				entry:SetCursorColor( color )
				entry.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 75)
					surface.DrawRect(0, 0, w, h)

					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				entry.MaxChars = 50
				entry.OnTextChanged = function(this)
					local txt = this:GetValue()
					local amt = string.utf8len(txt)
					if amt > this.MaxChars then
						this:SetText(this.OldText)
						this:SetValue(this.OldText)
					else
						this.OldText = txt
					end
				end

				editOccupation.DoClick = function()
					local occupation = entry:GetText()

					surface.PlaySound("willardnetworks/datapad/navigate.wav")
					PLUGIN.file.genericdata.occupation = occupation
					PLUGIN.file.genericdata.occupationDate = os.date("%d/%m/%Y")
					netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "OCCUPATION: " .. occupation)
					netstream.Start("EditDatafile", PLUGIN.file.genericdata, "Occupation updated to '" .. string.upper(occupation) .. "'")
				end

				back2.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/back.wav")
					updateOccupationTitleFrame:SetVisible(false)
					updateOccupationFrame:SetVisible(false)
					titleFrame:SetVisible(true)
					infoContentFrame:SetVisible(true)
				end
			end
		end
	end

	local designatedStatus = infoContentFrame:Add("EditablePanel")
	PLUGIN:CreateRow(designatedStatus, "designated status", string.Left(PLUGIN.file.genericdata.designatedStatus, 38), PLUGIN.file.genericdata.designatedStatusDate, true, true)

	for _, v in pairs(designatedStatus:GetChildren()) do
		if v:GetName() == "bottom" then
			local updateStatusButton = v:Add("DButton")
			createUpdateButton(updateStatusButton)
			updateStatusButton.DoClick = function()
				surface.PlaySound("willardnetworks/datapad/navigate2.wav")
				titleFrame:SetVisible(false)
				infoContentFrame:SetVisible(false)

				local updateStatusTitleFrame = self:Add("EditablePanel")
				PLUGIN:CreateTitle(updateStatusTitleFrame, self, "edit designated status")

				local updateStatusTitleSubframe = updateStatusTitleFrame:Add("EditablePanel")
				updateStatusTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
				updateStatusTitleSubframe:Dock(RIGHT)
				updateStatusTitleSubframe.Paint = nil

				local editStatus = updateStatusTitleSubframe:Add("DButton")
				PLUGIN:CreateTitleFrameRightTextButton(editStatus, updateStatusTitleSubframe, 87, "edit status", RIGHT)

				PLUGIN:DrawDividerLine(updateStatusTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

				local back2 = updateStatusTitleSubframe:Add("DButton")
				PLUGIN:CreateTitleFrameRightTextButton(back2, updateStatusTitleSubframe, 68, "back", RIGHT)

				local updateStatusFrame = self:Add("DPanel")
				updateStatusFrame:SetSize(self:GetWide(), SScaleMin(288 / 3))
				updateStatusFrame:Dock(TOP)
				updateStatusFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
				updateStatusFrame.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 40)
					surface.DrawRect(0, 0, w, h)
				end

				local statusName = updateStatusFrame:Add("DLabel")
				statusName:SetFont("MenuFontNoClamp")
				statusName:SetText(string.utf8upper("enter status name:"))
				statusName:SetTextColor(color)
				statusName:Dock(TOP)
				statusName:DockMargin( SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

				local entry = vgui.Create("DTextEntry", updateStatusFrame)
				entry:Dock(TOP)
				entry:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
				entry:SetMultiline(false)
				entry:SetVerticalScrollbarEnabled( false )
				entry:SetText(PLUGIN.file.genericdata.designatedStatus)
				entry:SetEnterAllowed(false)
				entry:SetFont("MenuFontNoClamp")
				entry:SetTall(SScaleMin(20 / 3))
				entry:SetTextColor( color )
				entry:SetCursorColor( color )
				entry.Paint = function(this, w, h)
					surface.SetDrawColor(40, 88, 115, 75)
					surface.DrawRect(0, 0, w, h)

					this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
				end

				entry.MaxChars = 50
				entry.OnTextChanged = function(this)
					local txt = this:GetValue()
					local amt = string.utf8len(txt)
					if amt > this.MaxChars then
						this:SetText(this.OldText)
						this:SetValue(this.OldText)
					else
						this.OldText = txt
					end
				end

				editStatus.DoClick = function()
					local status = entry:GetText()

					surface.PlaySound("willardnetworks/datapad/navigate.wav")
					PLUGIN.file.genericdata.designatedStatus = status
					PLUGIN.file.genericdata.designatedStatusDate = os.date("%d/%m/%Y")
					netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "DESIGNATED STATUS: " .. status)
					netstream.Start("EditDatafile", PLUGIN.file.genericdata, "Designated Status updated to '" .. string.upper(status) .. "'")
				end

				back2.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/back.wav")
					updateStatusTitleFrame:SetVisible(false)
					updateStatusFrame:SetVisible(false)
					titleFrame:SetVisible(true)
					infoContentFrame:SetVisible(true)
				end
			end
		end
	end
end

vgui.Register("ixDatafileInfo", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(15 / 3))
	self.Paint = nil

	PLUGIN.viewDatafileLogs = self

	self.titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(self.titleFrame, self, "view datafile logs")

	local titleSubframe = self.titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(300 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local addGenericNote = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(addGenericNote, titleSubframe, 87, "add generic note", RIGHT)

	PLUGIN:DrawDividerLine(titleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, titleSubframe, 68, "back", RIGHT)

	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(true)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(true)
		end
	end

	self.transactionLogs = self:Add("DButton")
	CreateButton(self.transactionLogs, "transaction logs", "smallerbuttonarrow.png")
	self.transactionLogs:DockMargin(0, 0 - SScaleMin(2 / 3), 0, SScaleMin(9 / 3))

	self.logsFrame = self:Add("DScrollPanel")
	self.logsFrame:SetSize(self:GetWide(), SScaleMin(576 / 3) - self.transactionLogs:GetTall() - SScaleMin(11 / 3))
	self.logsFrame:Dock(FILL)
	self.logsFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)

	self.transactionLogs.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")

		if (LocalPlayer():Team() != FACTION_ADMIN and !LocalPlayer():GetCharacter():HasFlags("T")) then
			LocalPlayer():Notify("Only the CCA can access transaction logs!")

			return
		end

		if self.titleFrame then
			self.titleFrame:SetVisible(false)
		end

		self.logsFrame:SetVisible(false)
		self.transactionLogs:SetVisible(false)

		self.genericTitleFrame = self:Add("EditablePanel")
		PLUGIN:CreateTitle(self.genericTitleFrame, self, "transaction logs")

		local genericTitleSubframe = self.genericTitleFrame:Add("EditablePanel")
		genericTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
		genericTitleSubframe:Dock(RIGHT)
		genericTitleSubframe.Paint = nil

		self.genericBack = genericTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(self.genericBack, genericTitleSubframe, 68, "back", RIGHT)

		PLUGIN.viewTransactionLogs = vgui.Create("ixDatafileTransactionLogs", self)

		self.genericBack.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/back.wav")
			self.genericTitleFrame:SetVisible(false)
			self.transactionLogs:SetVisible(true)
			if self.titleFrame then
				self.titleFrame:SetVisible(true)
			end

			self.logsFrame:SetVisible(true)
			PLUGIN.viewTransactionLogs:SetVisible(false)
		end
	end

	addGenericNote.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		if self.titleFrame then
			self.titleFrame:SetVisible(false)
		end
		self.logsFrame:SetVisible(false)
		self.transactionLogs:SetVisible(false)

		local genericTitleFrame = self:Add("EditablePanel")
		PLUGIN:CreateTitle(genericTitleFrame, self, "add generic note")

		local genericTitleSubframe = genericTitleFrame:Add("EditablePanel")
		genericTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
		genericTitleSubframe:Dock(RIGHT)
		genericTitleSubframe.Paint = nil

		local saveGenericNote = genericTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(saveGenericNote, genericTitleSubframe, 87, "save generic note", RIGHT)

		PLUGIN:DrawDividerLine(genericTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

		local genericBack = genericTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(genericBack, genericTitleSubframe, 68, "back", RIGHT)

		local textEntryPanel = self:Add("DPanel")
		textEntryPanel:Dock(TOP)
		textEntryPanel:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
		textEntryPanel:SetSize(self:GetWide(), SScaleMin(576 / 3))
		textEntryPanel.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)
		end

		local genericEntry = textEntryPanel:Add("DTextEntry")
		genericEntry:Dock(FILL)
		genericEntry:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
		genericEntry:SetMultiline(true)
		genericEntry:RequestFocus()
		genericEntry:SetFont("MenuFontNoClamp")
		genericEntry:SetVerticalScrollbarEnabled( true )
		genericEntry:SetTextColor( color )
		genericEntry:SetCursorColor( color )
		genericEntry.Paint = function(this, w, h)
			this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
		end
		genericEntry.MaxChars = 70 * 20
		genericEntry.OnTextChanged = function(this)
			local txt = this:GetValue()
			local amt = string.utf8len(txt)
			if amt > this.MaxChars then
				this:SetText(this.OldText)
				this:SetValue(this.OldText)
			else
				this.OldText = txt
			end
		end

		saveGenericNote.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, genericEntry:GetText(), false, true)
		end

		genericBack.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/back.wav")
			genericTitleFrame:SetVisible(false)
			textEntryPanel:SetVisible(false)
			self.transactionLogs:SetVisible(true)
			if self.titleFrame then
				self.titleFrame:SetVisible(true)
			end
			self.logsFrame:SetVisible(true)
		end
	end

	for k, v in SortedPairs(PLUGIN.file.datafilelogs, true) do
		if v.disabled then continue end
		local frame = self.logsFrame:Add("DPanel")
		frame:SetTall(SScaleMin(48 / 3))
		frame:Dock(TOP)
		frame.Paint = function(this, w, h)
			if (k % 2 == 0) then
				surface.SetDrawColor(0, 0, 0, 75)
				surface.DrawRect(0, 0, w, h)
			else
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)
			end
		end

		local top = frame:Add("EditablePanel")
		top:SetSize(frame:GetWide(), frame:GetTall() * 0.5)
		top:Dock(TOP)
		top.Paint = nil

		local topPoster = top:Add("DLabel")
		topPoster:SetTextColor(Color(154, 169, 175, 255))
		topPoster:SetFont("MenuFontNoClamp")
		topPoster:SetText(string.utf8upper(PLUGIN.file.datafilelogs[k].poster))
		topPoster:Dock(LEFT)
		topPoster:DockMargin(SScaleMin(20 / 3), SScaleMin(5 / 3), 0, 0)
		topPoster:SizeToContents()

		local topDate = top:Add("DLabel")
		topDate:SetTextColor(Color(154, 169, 175, 255))
		topDate:SetFont("MenuFontNoClamp")
		local date = PLUGIN.file.datafilelogs[k].date
		topDate:SetText(string.utf8upper("posted: ")..(isnumber(date) and os.date("%H:%M:%S - %d/%m/%Y", date) or date))
		topDate:Dock(RIGHT)
		topDate:DockMargin(0, SScaleMin(5 / 3), SScaleMin(20 / 3), 0)
		topDate:SizeToContents()

		local bottom = frame:Add("EditablePanel")
		bottom:SetSize(frame:GetWide(), frame:GetTall() * 0.4)
		bottom:Dock(TOP)
		bottom.Paint = nil
		bottom:SetName( "bottom" )

		local excerpt = string.Left( PLUGIN.file.datafilelogs[k].text, 33)

		if string.len(PLUGIN.file.datafilelogs[k].text) > 33 then
			excerpt = excerpt..".."
		end

		local bottomText = bottom:Add("DLabel")
		bottomText:SetTextColor(color)
		bottomText:SetFont("MenuFontNoClamp")
		bottomText:SetText(excerpt)
		bottomText:Dock(LEFT)
		bottomText:DockMargin(SScaleMin(20 / 3), 0, 0, SScaleMin(5 / 3))
		bottomText:SizeToContents()

		local viewLog = bottom:Add("DButton")
		viewLog:Dock(RIGHT)
		viewLog:DockMargin(0, 0, SScaleMin(20 / 3), SScaleMin(5 / 3))
		viewLog:SetFont("MenuFontNoClamp")
		viewLog:SetTextColor(color)
		viewLog:SetText(string.utf8upper("view"))
		viewLog:SizeToContents()
		viewLog.Paint = nil
		viewLog.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")
			PLUGIN.viewDatafileLogs:SetVisible(false)
			PLUGIN.viewDatafileLog = vgui.Create("ixDatafileOpenLog", PLUGIN.contentSubframe)
			PLUGIN.viewDatafileLog:Update(PLUGIN.file.datafilelogs[k].text)
		end

		PLUGIN:DrawDividerLine(bottom, 2, 13, 0, SScaleMin( 4 / 3), RIGHT, true )

		local removeLog = bottom:Add("DButton")
		removeLog:Dock(RIGHT)
		removeLog:DockMargin(0, 0, 0, SScaleMin(5 / 3))
		removeLog:SetFont("MenuFontNoClamp")
		removeLog:SetTextColor(color)
		removeLog:SetText(string.utf8upper("remove"))
		removeLog:SizeToContents()
		removeLog.Paint = nil
		removeLog.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")

			if (!LocalPlayer():IsCombineRankAbove("RL") and !LocalPlayer():GetCharacter():HasFlags("L") and LocalPlayer():Team() != FACTION_ADMIN) then
				LocalPlayer():Notify("You cannot remove this log because you are not high enough rank or you are not wearing your combine suit!")

				return false
			end

			frame:Remove()

			PLUGIN.file.datafilelogs[k] = {
				poster = PLUGIN.file.datafilelogs[k].poster,
				date = PLUGIN.file.datafilelogs[k].date,
				text = PLUGIN.file.datafilelogs[k].text,
				points = PLUGIN.file.datafilelogs[k].points or 0,
				disabled = true
			}

			if !PLUGIN.file.genericdata.name then
				netstream.Start("UpdateDatafileLogs", PLUGIN.file.genericdata.id, PLUGIN.file.datafilelogs, k, PLUGIN.file.genericdata.collarID)
			else
				netstream.Start("UpdateDatafileLogs", PLUGIN.file.genericdata.id, PLUGIN.file.datafilelogs, k, PLUGIN.file.genericdata.name)
			end
		end

		if PLUGIN.file.datafilelogs[k].points then
			if PLUGIN.file.datafilelogs[k].points != 0 then
				PLUGIN:DrawDividerLine(bottom, 2, 13, 0, SScaleMin( 4 / 3), RIGHT, true )

				local points = bottom:Add("DLabel")
				points:SetTextColor(color)
				points:SetFont("MenuFontNoClamp")
				points:SetText(string.utf8upper("points: ")..PLUGIN.file.datafilelogs[k].points)
				points:Dock(RIGHT)
				points:SizeToContents()
				points:DockMargin(0, 0, SScaleMin(2 / 3), SScaleMin(5 / 3))
			end
		end
	end
end

vgui.Register("ixDatafileEntryLogs", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(15 / 3))
	self.Paint = nil

	PLUGIN.openDatafileLog = self

	self.shouldOpenMedical = false

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "view log")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(300 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	self.back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.back, titleSubframe, 68, "back", RIGHT)

	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.viewDatafileLogs) and !self.shouldOpenMedical then
			PLUGIN.viewDatafileLogs:SetVisible(true)
			return
		end

		if IsValid(PLUGIN.viewDatafileMedicalLogs) then
			PLUGIN.viewDatafileMedicalLogs:SetVisible(true)
		end

		PLUGIN.viewDatafileLog.shouldOpenMedical = false
	end
end

function PANEL:Update(text)
	local textEntryPanel = self:Add("DPanel")
	textEntryPanel:Dock(TOP)
	textEntryPanel:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	textEntryPanel:SetSize(self:GetWide(), SScaleMin(576 / 3))
	textEntryPanel.Paint = function(this, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)
	end

	local genericEntry = textEntryPanel:Add("DTextEntry")
	genericEntry:Dock(FILL)
	genericEntry:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
	genericEntry:SetMultiline(true)
	genericEntry:SetEditable(true)
	genericEntry:RequestFocus()
	genericEntry:SetValue(text)
	genericEntry:SetFont("MenuFontNoClamp")
	genericEntry:SetVerticalScrollbarEnabled( true )
	genericEntry:SetTextColor( color )
	genericEntry:SetCursorColor( color )
	genericEntry.Paint = function(this, w, h)
		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	local cover = genericEntry:Add("Panel")
	cover:Dock(FILL)
	cover:DockMargin(0, 0, 19, 0)
end

vgui.Register("ixDatafileOpenLog", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), SScaleMin(300 / 3))
	self:Dock(TOP)
	self.Paint = nil

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "functions")

	local titleViolations = self:Add("DButton")
	CreateButton(titleViolations, "title violations", "smallerbuttonarrow.png")
	titleViolations:DockMargin(0, 0 - SScaleMin(2 / 3), 0, SScaleMin(9 / 3))

	titleViolations.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		PLUGIN.datafileInfo:SetVisible(false)
		PLUGIN.datafileFunctions:SetVisible(false)
		PLUGIN.viewTitleViolations = vgui.Create("ixDatafileTitleViolations", PLUGIN.contentSubframe)
	end

	local medicalRecords = self:Add("DButton")
	CreateButton(medicalRecords, "medical records", "smallerbuttonarrow.png")

	medicalRecords.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		PLUGIN.datafileInfo:SetVisible(false)
		PLUGIN.datafileFunctions:SetVisible(false)
		PLUGIN.viewMedicalRecords = vgui.Create("ixDatafileMedicalRecords", PLUGIN.contentSubframe)
		PLUGIN.viewMedicalRecords.medicalRecords = PLUGIN.file.datafilemedicalrecords
		PLUGIN.viewMedicalRecords.genericData = PLUGIN.file.genericdata
		PLUGIN.viewMedicalRecords:Populate(PLUGIN.file.datafilemedicalrecords)
	end

	local housingInfo = self:Add("DButton")
	CreateButton(housingInfo, "housing info", "smallerbuttonarrow.png")
	housingInfo.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		PLUGIN.datafileInfo:SetVisible(false)
		PLUGIN.datafileFunctions:SetVisible(false)
		PLUGIN.viewHousingInfo = vgui.Create("ixDatafileHousingInfo", PLUGIN.contentSubframe)
	end

	local permitWagesFrame = self:Add("Panel")
	permitWagesFrame:Dock(TOP)
	permitWagesFrame:SetTall(SScaleMin(40 / 3))
	permitWagesFrame:DockMargin(0, 0, 0, SScaleMin(9 / 3))

	local permits = permitWagesFrame:Add("DButton")
	CreateHalfButton(permits, "permits", "licensebutton.png", true)
	local characterFaction = LocalPlayer():GetCharacter():GetFaction()

	permits.DoClick = function()
		if (characterFaction != FACTION_WORKERS and characterFaction != FACTION_ADMIN and characterFaction != FACTION_SERVERADMIN and !LocalPlayer():GetCharacter():HasFlags("U")) then
			LocalPlayer():NotifyLocalized("Only CWU and CA have access to this.")
			return
		end

		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		PLUGIN.datafileInfo:SetVisible(false)
		PLUGIN.datafileFunctions:SetVisible(false)
		PLUGIN.viewPermits = vgui.Create("ixDatafilePermits", PLUGIN.contentSubframe)
	end

	local loyalistTools = permitWagesFrame:Add("DButton")
	CreateHalfButton(loyalistTools, "Loyalist Tools", "medium-button-arrow.png", false)

	loyalistTools.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		PLUGIN.datafileInfo:SetVisible(false)
		PLUGIN.datafileFunctions:SetVisible(false)

		PLUGIN.viewLoyalistTools = vgui.Create("ixDatafileLoyalistTools", PLUGIN.contentSubframe)
	end

	local bolAntiCitizenFrame = self:Add("Panel")
	bolAntiCitizenFrame:Dock(TOP)
	bolAntiCitizenFrame:SetTall(SScaleMin(40 / 3))
	bolAntiCitizenFrame:DockMargin(0, 0, 0, SScaleMin(9 / 3))

	local bol = bolAntiCitizenFrame:Add("DButton")
	if PLUGIN.file.genericdata.bol == false then
		CreateHalfButton(bol, "b.o.l", "bolbutton.png", false)
	else
		CreateHalfButton(bol, "b.o.l", "bolbuttonon.png", false)
	end

	bol.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")

		if (PLUGIN.file.genericdata.bol == false) then
			PLUGIN.file.genericdata.bol = true
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Enabled B.O.L. status")
		else
			PLUGIN.file.genericdata.bol = false
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Removed B.O.L status.")
		end

		netstream.Start("EditDatafile", PLUGIN.file.genericdata, "B.O.L status " .. (PLUGIN.file.genericdata.bol and "enabled" or "disabled"))
	end

	local anticitizen = bolAntiCitizenFrame:Add("DButton")
	if PLUGIN.file.genericdata.anticitizen == false then
		CreateHalfButton(anticitizen, "anti-citizen", "acbutton.png", true)
	else
		CreateHalfButton(anticitizen, "anti-citizen", "acbuttonon.png", true)
	end

	anticitizen.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		if PLUGIN.file.genericdata.anticitizen == false then
			PLUGIN.file.genericdata.anticitizen = true
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Enabled Anti-Citizen status.")
		else
			PLUGIN.file.genericdata.anticitizen = false
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Removed Anti-Citizen status.")
		end

		netstream.Start("EditDatafile", PLUGIN.file.genericdata, "Anti-Citizen status " .. (PLUGIN.file.genericdata.anticitizen and "enabled" or "disabled"))
	end
end

vgui.Register("ixDatafileFunctions", PANEL, "EditablePanel")

PANEL = {}

function PANEL:GetLoyaltyText()
	local loyaltyText = PLUGIN.file.genericdata.loyaltyStatus or "N/A"
	if PLUGIN.file.genericdata.socialCredits and !PLUGIN.file.genericdata.combine then
		if PLUGIN.file.genericdata.socialCredits < 40 then
			return "UNDERCLASS"
		end
	end

	return loyaltyText
end

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(15 / 3))
	self.Paint = nil

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "loyalist tools")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(159 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, titleSubframe, 87, "back", RIGHT)

	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(true)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(true)
		end
	end

	local wagesFrame = self:Add("DPanel")
	wagesFrame:Dock(TOP)
	wagesFrame:SetZPos(1)
	wagesFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, SScaleMin(5 / 3))
	wagesFrame:SetSize(self:GetWide(), (SScaleMin(576 / 3) / 3) - SScaleMin(5 / 3))
	wagesFrame.Paint = function(this, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h - SScaleMin(46 / 3))
	end

	local wagesTitle = wagesFrame:Add("DLabel")
	wagesTitle:SetFont("TitlesFontNoClamp")
	wagesTitle:SetTextColor(color)
	wagesTitle:SetText(string.utf8upper("extra wages added to rations"))
	wagesTitle:Dock(TOP)
	wagesTitle:SetZPos(2)
	wagesTitle:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

	local wagesString = wagesFrame:Add("DTextEntry")
	wagesString:Dock(TOP)
	wagesString:SetTall(SScaleMin(46 / 3))
	wagesString:SetMultiline(false)
	wagesString:RequestFocus()
	wagesString:MoveToFront()
	wagesString:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), 0)
	wagesString:SetEnterAllowed(false)
	wagesString:SetText(PLUGIN.file.genericdata.wages or 0)
	wagesString:SetVerticalScrollbarEnabled( false )
	wagesString:SetFont("TitlesFontNoClamp")
	wagesString:SetTextColor( color )
	wagesString:SetZPos(3)
	wagesString:SetCursorColor( color )
	wagesString.Paint = function(this, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h)

		this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
	end

	local saveWages = wagesFrame:Add("DButton")
	saveWages:Dock(BOTTOM)
	saveWages:SetTall(SScaleMin(46 / 3))
	saveWages:SetText("SAVE")
	saveWages:SetZPos(4)
	saveWages:SetContentAlignment(5)
	saveWages:SetFont("TitlesFontNoClamp")
	saveWages.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	saveWages.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")
		if LocalPlayer():GetCharacter():GetFaction() == FACTION_ADMIN or LocalPlayer():IsCombineRankAbove("i1") or LocalPlayer():GetCharacter():HasFlags("U") then
			if tonumber(wagesString:GetText()) > 200 then
				LocalPlayer():NotifyLocalized("The wages value has to be 200 or below.")
				return
			end

			netstream.Start("SetWagesDatafile", PLUGIN.file.genericdata, tonumber(wagesString:GetText()))
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Set Extra Wages Amount to "..wagesString:GetText())
		else
			LocalPlayer():NotifyLocalized("Only CCA can do this.")
		end
	end

	local loyalistStatusFrame = self:Add("DPanel")
	loyalistStatusFrame:Dock(TOP)
	loyalistStatusFrame:DockMargin(0, SScaleMin(5 / 3), 0, 0)
	loyalistStatusFrame:SetZPos(5)
	loyalistStatusFrame:SetSize(self:GetWide(), (SScaleMin(576 / 3) / 3) - SScaleMin(5 / 3))
	loyalistStatusFrame.Paint = function(this, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h - SScaleMin(46 / 3))
	end

	local loyalistTitle = loyalistStatusFrame:Add("DLabel")
	loyalistTitle:SetFont("TitlesFontNoClamp")
	loyalistTitle:SetTextColor(color)
	loyalistTitle:SetText(string.utf8upper("change loyalist status (above T3)"))
	loyalistTitle:Dock(TOP)
	loyalistTitle:SetZPos(6)
	loyalistTitle:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

	local loyalistBox = loyalistStatusFrame:Add("DComboBox")
	loyalistBox:SetZPos(7)
	loyalistBox:SetFont("MenuFontNoClamp")
	loyalistBox:SetTextColor(color)
	loyalistBox:Dock(TOP)
	loyalistBox:SetTall(SScaleMin(46 / 3))
	loyalistBox:SetFont("TitlesFontNoClamp")
	loyalistBox:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), 0)
	loyalistBox:SetValue( self:GetLoyaltyText() or string.utf8upper("None") )
	loyalistBox:AddChoice( string.utf8upper("TIER 4 (blue)") )
	loyalistBox:AddChoice( string.utf8upper("TIER 5 (green)") )
	loyalistBox:AddChoice( string.utf8upper("TIER 6 (white)") )
	loyalistBox:AddChoice( string.utf8upper("TIER 7 (commended)"))
	loyalistBox:AddChoice( string.utf8upper("CCA MEMBER") )
	loyalistBox:AddChoice( string.utf8upper("None") )
	loyalistBox.Paint = function(panel, width, height)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, width, height)
	end

	local saveLoyalist = loyalistStatusFrame:Add("DButton")
	saveLoyalist:Dock(BOTTOM)
	saveLoyalist:SetTall(SScaleMin(46 / 3))
	saveLoyalist:SetZPos(8)
	saveLoyalist:SetText("SAVE")
	saveLoyalist:SetContentAlignment(5)
	saveLoyalist:SetFont("TitlesFontNoClamp")
	saveLoyalist.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	saveLoyalist.DoClick = function()
		if (loyalistBox:GetSelected()) then
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			netstream.Start("SetLoyalistStatusDatafile", PLUGIN.file.genericdata, loyalistBox:GetSelected())
			netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Set Loyalist Status to "..loyalistBox:GetSelected())
		end
	end

	local bypassCommunionFrame = self:Add("DPanel")
	bypassCommunionFrame:Dock(TOP)
	bypassCommunionFrame:DockMargin(0, SScaleMin(5 / 3), 0, 0)
	bypassCommunionFrame:SetZPos(9)
	bypassCommunionFrame:SetSize(self:GetWide(), (SScaleMin(576 / 3) / 3) - SScaleMin(5 / 3))
	bypassCommunionFrame.Paint = function(this, w, h)
		surface.SetDrawColor(40, 88, 115, 75)
		surface.DrawRect(0, 0, w, h - SScaleMin(46 / 3))
	end

	local communionTitle = bypassCommunionFrame:Add("DLabel")
	communionTitle:SetFont("TitlesFontNoClamp")
	communionTitle:SetTextColor(color)
	communionTitle:SetText(string.utf8upper("Bypass Communion Requirement Terminal"))
	communionTitle:Dock(TOP)
	communionTitle:SetZPos(10)
	communionTitle:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

	local enableDisableCommunion = bypassCommunionFrame:Add("DButton")
	enableDisableCommunion:Dock(BOTTOM)
	enableDisableCommunion:SetTall(SScaleMin(46 / 3))
	enableDisableCommunion:SetZPos(8)
	enableDisableCommunion:SetText(PLUGIN.file.genericdata.bypassCommunion == true and "ENABLED" or "DISABLED")
	enableDisableCommunion:SetContentAlignment(5)
	enableDisableCommunion:SetFont("TitlesFontNoClamp")
	enableDisableCommunion.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))

		if PLUGIN.file.genericdata then
			if PLUGIN.file.genericdata.bypassCommunion == true then
				surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow.png"))
			else
				surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/buttonnoarrow-off.png"))
			end
		end

		surface.DrawTexturedRect(0, 0, w, h)
	end

	enableDisableCommunion.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate.wav")

		if PLUGIN.file.genericdata then
			if PLUGIN.file.genericdata.bypassCommunion then
				netstream.Start("SetBypassDatafile", PLUGIN.file.genericdata, false)
				netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Set Bypass Communion to: ENABLED")
			else
				netstream.Start("SetBypassDatafile", PLUGIN.file.genericdata, true)
				netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "Set Bypass Communion to: DISABLED")
			end
		end
	end
end

vgui.Register("ixDatafileLoyalistTools", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(15 / 3))
	self.Paint = nil

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "title violations")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(300 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local addViolation = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(addViolation, titleSubframe, 87, "add violation", RIGHT)

	PLUGIN:DrawDividerLine(titleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	local back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, titleSubframe, 68, "back", RIGHT)

	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(true)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(true)
		end
	end

	local violationsFrame = self:Add("DScrollPanel")
	violationsFrame:SetSize(self:GetWide(), SScaleMin(576 / 3))
	violationsFrame:Dock(TOP)
	violationsFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)

	addViolation.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		titleFrame:SetVisible(false)
		violationsFrame:SetVisible(false)

		local violationsTitleFrame = self:Add("EditablePanel")
		PLUGIN:CreateTitle(violationsTitleFrame, self, "add title violation")

		PLUGIN.violationsTitleSubframe = violationsTitleFrame:Add("EditablePanel")
		PLUGIN.violationsTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
		PLUGIN.violationsTitleSubframe:Dock(RIGHT)
		PLUGIN.violationsTitleSubframe.Paint = nil

		local saveViolation = PLUGIN.violationsTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(saveViolation, PLUGIN.violationsTitleSubframe, 87, "save violation", RIGHT)

		PLUGIN:DrawDividerLine(PLUGIN.violationsTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

		local violationBack = PLUGIN.violationsTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(violationBack, PLUGIN.violationsTitleSubframe, 68, "back", RIGHT)

		local violationsNewFrame = self:Add("DPanel")
		violationsNewFrame:Dock(TOP)
		violationsNewFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
		violationsNewFrame:SetSize(self:GetWide(), SScaleMin(576 / 3))
		violationsNewFrame.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)
		end

		local verdictCodeText = violationsNewFrame:Add("DLabel")
		verdictCodeText:SetFont("MenuFontNoClamp")
		verdictCodeText:SetTextColor(color)
		verdictCodeText:SetText(string.utf8upper("verdict code [format: V###]:"))
		verdictCodeText:Dock(TOP)
		verdictCodeText:SetZPos(1)
		verdictCodeText:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

		local verdictCode = violationsNewFrame:Add("DTextEntry")
		verdictCode:Dock(TOP)
		verdictCode:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
		verdictCode:SetMultiline(false)
		verdictCode:RequestFocus()
		verdictCode:SetFont("MenuFontNoClamp")
		verdictCode:SetEnterAllowed(false)
		verdictCode:SetTall(SScaleMin(20 / 3))
		verdictCode:SetVerticalScrollbarEnabled( false )
		verdictCode:SetTextColor( color )
		verdictCode:SetZPos(2)
		verdictCode:SetCursorColor( color )
		verdictCode.MaxChars = 4
		verdictCode.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)

			this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
		end

		verdictCode.OnTextChanged = function(this)
			local txt = this:GetValue()
			local amt = string.utf8len(txt)
			if amt > this.MaxChars then
				if this.OldText then
					this:SetText(this.OldText)
					this:SetValue(this.OldText)
				end
			else
				this.OldText = txt
			end
		end

		local reasonText = violationsNewFrame:Add("DLabel")
		reasonText:SetFont("MenuFontNoClamp")
		reasonText:SetTextColor(color)
		reasonText:SetText(string.utf8upper("reason:"))
		reasonText:Dock(TOP)
		reasonText:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
		reasonText:SetZPos(3)

		local reason = violationsNewFrame:Add("DTextEntry")
		reason:Dock(TOP)
		reason:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
		reason:SetMultiline(false)
		reason:RequestFocus()
		reason:SetEnterAllowed(false)
		reason:SetVerticalScrollbarEnabled( false )
		reason:SetTextColor( color )
		reason:SetFont("MenuFontNoClamp")
		reason:SetTall(SScaleMin(20 / 3))
		reason:SetCursorColor( color )
		reason:SetZPos(4)
		reason.MaxChars = 45
		reason.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)

			this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
		end

		reason.OnTextChanged = function(this)
			local txt = this:GetValue()
			local amt = string.utf8len(txt)
			if amt > this.MaxChars then
				if this.OldText then
					this:SetText(this.OldText)
					this:SetValue(this.OldText)
				end
			else
				this.OldText = txt
			end
		end

		local punishmentText = violationsNewFrame:Add("DLabel")
		punishmentText:SetFont("MenuFontNoClamp")
		punishmentText:SetTextColor(color)
		punishmentText:SetText(string.utf8upper("punishment:"))
		punishmentText:Dock(TOP)
		punishmentText:SetZPos(5)
		punishmentText:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))

		local punishmentBox = violationsNewFrame:Add("DComboBox")
		punishmentBox:SetZPos(6)
		punishmentBox:SetFont("MenuFontNoClamp")
		punishmentBox:SetTextColor(color)
		punishmentBox:Dock(TOP)
		punishmentBox:SetTall(SScaleMin(20 / 3))
		punishmentBox:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(10 / 3))
		punishmentBox:SetValue( string.utf8upper("options") )
		punishmentBox:AddChoice( string.utf8upper("amputation") )
		punishmentBox:AddChoice( string.utf8upper("re-education") )
		punishmentBox:AddChoice( string.utf8upper("verbal warning") )
		punishmentBox:AddChoice( string.utf8upper("other") )
		punishmentBox.Paint = function(panel, width, height)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, width, height)
		end

		saveViolation.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			netstream.Start("AddViolation", PLUGIN.file.datafileviolations, PLUGIN.file.genericdata, LocalPlayer():Name(), "["..verdictCode:GetText().."] :: ["..reason:GetText().."] :: ["..punishmentBox:GetText().."]", LocalPlayer():GetCharacter():GetID())
		end

		violationBack.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/back.wav")
			violationsTitleFrame:SetVisible(false)
			violationsNewFrame:SetVisible(false)
			titleFrame:SetVisible(true)
			violationsFrame:SetVisible(true)
		end
	end

	for k, v in SortedPairs(PLUGIN.file.datafileviolations, true) do
		local frame = violationsFrame:Add("DPanel")
		frame:SetTall(SScaleMin(48 / 3))
		frame:Dock(TOP)
		frame.Paint = function(this, w, h)
			if (k % 2 == 0) then
				surface.SetDrawColor(0, 0, 0, 75)
				surface.DrawRect(0, 0, w, h)
			else
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)
			end
		end

		local top = frame:Add("EditablePanel")
		top:SetSize(frame:GetWide(), frame:GetTall() * 0.5)
		top:Dock(TOP)
		top.Paint = nil

		local topPoster = top:Add("DLabel")
		topPoster:SetTextColor(Color(154, 169, 175, 255))
		topPoster:SetFont("MenuFontNoClamp")
		topPoster:SetText(string.utf8upper(v.poster))
		topPoster:Dock(LEFT)
		topPoster:DockMargin(SScaleMin(20 / 3), SScaleMin(5 / 3), 0, 0)
		topPoster:SizeToContents()

		local topDate = top:Add("DLabel")
		topDate:SetTextColor(Color(154, 169, 175, 255))
		topDate:SetFont("MenuFontNoClamp")
		topDate:SetText(string.utf8upper("posted: ")..v.date)
		topDate:Dock(RIGHT)
		topDate:DockMargin(0, SScaleMin(5 / 3), SScaleMin(20 / 3), 0)
		topDate:SizeToContents()

		local bottom = frame:Add("EditablePanel")
		bottom:SetSize(frame:GetWide(), frame:GetTall() * 0.4)
		bottom:Dock(TOP)
		bottom.Paint = nil
		bottom:SetName( "bottom" )

		local bottomText = bottom:Add("DLabel")
		bottomText:SetTextColor(color)
		bottomText:SetFont("MenuFontNoClamp")
		bottomText:SetText(v.text)
		bottomText:Dock(LEFT)
		bottomText:DockMargin(SScaleMin(20 / 3), 0, 0, 0)
		bottomText:SizeToContents()

		local removeLog = bottom:Add("DButton")
		removeLog:Dock(RIGHT)
		removeLog:DockMargin(0, 0, SScaleMin(18 / 3), 0)
		removeLog:SetFont("MenuFontNoClamp")
		removeLog:SetTextColor(color)
		removeLog:SetText(string.utf8upper("remove"))
		removeLog:SizeToContents()
		removeLog.Paint = nil
		removeLog.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")
			local posterID = PLUGIN.file.datafileviolations[k].posterID or false
			if (posterID and posterID == LocalPlayer():GetCharacter():GetID()) or (PLUGIN.file.datafileviolations[k].poster == LocalPlayer():GetName()) or (LocalPlayer():IsCombineRankAbove("RL")) then
				frame:Remove()
				PLUGIN.file.datafileviolations[k] = nil

				netstream.Start("UpdateDatafileViolations", PLUGIN.file.genericdata.id, PLUGIN.file.datafileviolations, PLUGIN.file.genericdata.name)
				netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, "REMOVED VIOLATION.")
			else
				LocalPlayer():NotifyLocalized("Access disallowed. You are not RL or CpT, not wearing a combine suit or you did not add this violation.")
			end
		end
	end
end

vgui.Register("ixDatafileTitleViolations", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self:DockMargin(0, 0, 0, SScaleMin(15 / 3))
	self.Paint = nil
	self.contentSubframe = PLUGIN.contentSubframe

	PLUGIN.viewDatafileMedicalLogs = self

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "medical records")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(300 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local addRecord = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(addRecord, titleSubframe, 87, "add record", RIGHT)

	self.topDivider = PLUGIN:DrawDividerLine(titleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

	self.back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(self.back, titleSubframe, 68, "back", RIGHT)

	self.back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(true)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(true)
		end
	end

	self.recordsFrame = self:Add("DScrollPanel")
	self.recordsFrame:SetSize(self:GetWide(), SScaleMin(576 / 3))
	self.recordsFrame:Dock(TOP)
	self.recordsFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)

	addRecord.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/navigate2.wav")
		titleFrame:SetVisible(false)
		self.recordsFrame:SetVisible(false)

		local recordsTitleFrame = self:Add("EditablePanel")
		PLUGIN:CreateTitle(recordsTitleFrame, self, "add medical record")

		local recordsTitleSubframe = recordsTitleFrame:Add("EditablePanel")
		recordsTitleSubframe:SetSize(SScaleMin(300 / 3), 0)
		recordsTitleSubframe:Dock(RIGHT)
		recordsTitleSubframe.Paint = nil

		local saveRecord = recordsTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(saveRecord, recordsTitleSubframe, 87, "save record", RIGHT)

		PLUGIN:DrawDividerLine(recordsTitleSubframe, 2, 13, 0, SScaleMin( 4 / 3), RIGHT )

		local recordBack = recordsTitleSubframe:Add("DButton")
		PLUGIN:CreateTitleFrameRightTextButton(recordBack, recordsTitleSubframe, 68, "back", RIGHT)

		local recordsNewFrame = self:Add("DPanel")
		recordsNewFrame:Dock(TOP)
		recordsNewFrame:DockMargin(0, 0 - SScaleMin(2 / 3), 0, 0)
		recordsNewFrame:SetSize(self:GetWide(), SScaleMin(576 / 3))
		recordsNewFrame.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)
		end

		local recordsCodeText = recordsNewFrame:Add("DLabel")
		recordsCodeText:SetFont("MenuFontNoClamp")
		recordsCodeText:SetTextColor(color)
		recordsCodeText:SetText(string.utf8upper("Record content:"))
		recordsCodeText:Dock(TOP)
		recordsCodeText:SetZPos(1)
		recordsCodeText:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(10 / 3))

		local record = recordsNewFrame:Add("DTextEntry")
		record:Dock(FILL)
		record:DockMargin(SScaleMin(20 / 3), 0, SScaleMin(20 / 3), SScaleMin(20 / 3))
		record:SetMultiline(true)
		record:RequestFocus()
		record:SetEnterAllowed(true)
		record:SetVerticalScrollbarEnabled( true )
		record:SetTextColor( color )
		record:SetFont("MenuFontNoClamp")
		record:SetTall(SScaleMin(20 / 3))
		record:SetZPos(2)
		record:SetCursorColor( color )
		record.Paint = function(this, w, h)
			surface.SetDrawColor(40, 88, 115, 75)
			surface.DrawRect(0, 0, w, h)

			this:DrawTextEntryText( this:GetTextColor(), this:GetHighlightColor(), this:GetCursorColor() )
		end

		saveRecord.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate.wav")
			netstream.Start("AddMedicalRecord", self.medicalRecords, self.genericData, LocalPlayer():Name(), record:GetText(), self.cmuPDA)

			self:OnSaveRecord()
		end

		recordBack.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/back.wav")
			recordsTitleFrame:SetVisible(false)
			recordsNewFrame:SetVisible(false)
			titleFrame:SetVisible(true)
			self.recordsFrame:SetVisible(true)
		end
	end
end

function PANEL:OnSaveRecord() end

function PANEL:Populate(records)
	for k, v in SortedPairs(records, true) do
		local frame = self.recordsFrame:Add("DPanel")
		frame:SetTall(SScaleMin(48 / 3))
		frame:Dock(TOP)
		frame.Paint = function(this, w, h)
			if (k % 2 == 0) then
				surface.SetDrawColor(0, 0, 0, 75)
				surface.DrawRect(0, 0, w, h)
			else
				surface.SetDrawColor(40, 88, 115, 75)
				surface.DrawRect(0, 0, w, h)
			end
		end

		local top = frame:Add("EditablePanel")
		top:SetSize(frame:GetWide(), frame:GetTall() * 0.5)
		top:Dock(TOP)
		top.Paint = nil

		local topPoster = top:Add("DLabel")
		topPoster:SetTextColor(Color(154, 169, 175, 255))
		topPoster:SetFont("MenuFontNoClamp")
		topPoster:SetText(string.utf8upper(v.poster))
		topPoster:Dock(LEFT)
		topPoster:DockMargin(SScaleMin(20 / 3), SScaleMin(5 / 3), 0, 0)
		topPoster:SizeToContents()

		local topDate = top:Add("DLabel")
		topDate:SetTextColor(Color(154, 169, 175, 255))
		topDate:SetFont("MenuFontNoClamp")
		topDate:SetText(string.utf8upper("posted: ")..v.date)
		topDate:Dock(RIGHT)
		topDate:DockMargin(0, SScaleMin(5 / 3), SScaleMin(20 / 3), 0)
		topDate:SizeToContents()

		local bottom = frame:Add("EditablePanel")
		bottom:SetSize(frame:GetWide(), frame:GetTall() * 0.4)
		bottom:Dock(TOP)
		bottom.Paint = nil
		bottom:SetName( "bottom" )

		local excerpt = string.Left( v.text, 33)

		if string.len(v.text) > 33 then
			excerpt = excerpt..".."
		end

		local bottomText = bottom:Add("DLabel")
		bottomText:SetTextColor(color)
		bottomText:SetFont("MenuFontNoClamp")
		bottomText:SetText(excerpt)
		bottomText:Dock(LEFT)
		bottomText:DockMargin(SScaleMin(20 / 3), 0, 0, SScaleMin(5 / 3))
		bottomText:SizeToContents()

		local viewLog = bottom:Add("DButton")
		viewLog:Dock(RIGHT)
		viewLog:DockMargin(0, 0, SScaleMin(20 / 3), SScaleMin(5 / 3))
		viewLog:SetFont("MenuFontNoClamp")
		viewLog:SetTextColor(color)
		viewLog:SetText(string.utf8upper("view"))
		viewLog:SizeToContents()
		viewLog.Paint = nil
		viewLog.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")
			PLUGIN.viewDatafileMedicalLogs:SetVisible(false)
			PLUGIN.viewDatafileLog = vgui.Create("ixDatafileOpenLog", self.contentSubframe)
			PLUGIN.viewDatafileLog.shouldOpenMedical = true
			PLUGIN.viewDatafileLog:Update(v.text)
		end

		PLUGIN:DrawDividerLine(bottom, 2, 13, 0, SScaleMin( 4 / 3), RIGHT, true )

		local removeLog = bottom:Add("DButton")
		removeLog:Dock(RIGHT)
		removeLog:DockMargin(0, 0, 0, SScaleMin(5 / 3))
		removeLog:SetFont("MenuFontNoClamp")
		removeLog:SetTextColor(color)
		removeLog:SetText(string.utf8upper("remove"))
		removeLog:SizeToContents()
		removeLog.Paint = nil
		removeLog.DoClick = function()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")
			frame:Remove()
			self.medicalRecords[k] = nil

			netstream.Start("UpdateDatafileMedical", self.genericData.id, self.medicalRecords, self.genericData.name, self.cmuPDA)
		end
	end
end

vgui.Register("ixDatafileMedicalRecords", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self.Paint = nil

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "permits")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(159 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, titleSubframe, 87, "back", RIGHT)

	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(true)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(true)
		end
	end

	local subtitlePanel = self:Add("Panel")
	subtitlePanel:Dock(TOP)
	subtitlePanel:SetTall(SScaleMin(20 / 3))

	local title = subtitlePanel:Add("DLabel")
	title:SetFont("MenuFontBoldNoClamp")
	title:SetTextColor(color)
	title:SetText(string.utf8upper("TIME / WEEKS"))
	title:SetTextInset(0, 0 - SScaleMin(5 / 3))
	title:SizeToContents()
	title:Dock(RIGHT)
	title:DockMargin(0, 0, SScaleMin(156 / 3), 0)

	local permitsTable = self:Add("DScrollPanel")
	permitsTable:Dock(FILL)

	if ix.permits.list and istable(ix.permits.list) then
		for name, _ in SortedPairs(ix.permits.list, false) do
			local permitPanel = permitsTable:Add("Panel")
			permitPanel:Dock(TOP)
			permitPanel:SetTall(SScaleMin(40 / 3))
			permitPanel:DockMargin(0, 0, 0, SScaleMin((0 - 1) / 3))

			local namePanel = permitPanel:Add("Panel")
			namePanel:Dock(FILL)
			namePanel.Paint = function(this, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(36, 243, 230, 255 / 100 * 30))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			local permitName = namePanel:Add("DLabel")
			permitName:Dock(LEFT)
			permitName:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
			permitName:SetTextColor(Color(36, 243, 230, 255))
			permitName:SetText(string.upper(name) or "")
			permitName:SetFont("MenuFontBoldNoClamp")
			permitName:SizeToContents()

			local disabled = permitPanel:Add("DButton")
			self:CreateButton(disabled, "X")

			local unlimited = permitPanel:Add("DButton")
			self:CreateButton(unlimited, "∞")

			local threeWeeks = permitPanel:Add("DButton")
			self:CreateButton(threeWeeks, "3")

			local twoWeeks = permitPanel:Add("DButton")
			self:CreateButton(twoWeeks, "2")

			local oneWeek = permitPanel:Add("DButton")
			self:CreateButton(oneWeek, "1")

			self:SetupButtons(unlimited, threeWeeks, twoWeeks, oneWeek, disabled, name, namePanel)
		end
	end

	local save = self:Add("DButton")
	createUpdateButton(save)
	save:Dock(BOTTOM)
	save:SetTall(SScaleMin(50 / 3))
	save:SetText("SAVE")
	save:DockMargin(0, 0, 0 ,0)
	save.DoClick = function()
		if self.toSave then
			for key, value in pairs(self.toSave) do
				PLUGIN.file.genericdata.permits[key] = value
			end
		end

		self:UpdatePermits()
	end
end

function PANEL:AddLog(text)
	local Timestamp = os.time()

    PLUGIN.file.datafilelogs[#PLUGIN.file.datafilelogs + 1] = {
        text = text,
        date = Timestamp,
        points = 0,
        poster = LocalPlayer():Name()
    }

	netstream.Start("AddLog", PLUGIN.file.datafilelogs, PLUGIN.file.genericdata, LocalPlayer():Name(), 0, text, true)
end

function PANEL:SetupButtons(unlimited, three, two, one, disabled, name, namePanel)
	local buttons = {unlimited, three, two, one, disabled}
	self:GetTimeSpan(buttons, name, namePanel)

	self.toSave = {}

	unlimited.DoClick = function()
		self.toSave[name] = true
		self:RefreshUpdatePanel(buttons, name, namePanel)
		self:AddLog("Enabled "..Schema:FirstToUpper(name).." Bartering Permit | Duration: Unlimited")
	end

	three.DoClick = function()
		self.toSave[name] = os.time() + 3600 * 24 * 7 * 3
		self:RefreshUpdatePanel(buttons, name, namePanel)
		self:AddLog("Enabled "..Schema:FirstToUpper(name).." Bartering Permit | Duration: Three Weeks")
	end

	two.DoClick = function()
		self.toSave[name] = os.time() + 3600 * 24 * 7 * 2
		self:RefreshUpdatePanel(buttons, name, namePanel)
		self:AddLog("Enabled "..Schema:FirstToUpper(name).." Bartering Permit | Duration: Two Weeks")
	end

	one.DoClick = function()
		self.toSave[name] = os.time() + 3600 * 24 * 7 * 1
		self:RefreshUpdatePanel(buttons, name, namePanel)
		self:AddLog("Enabled "..Schema:FirstToUpper(name).." Bartering Permit | Duration: One Week")
	end

	disabled.DoClick = function()
		PLUGIN.file.genericdata.permits[name] = nil
		self.toSave[name] = nil
		self:RefreshUpdatePanel(buttons, name, namePanel)
		self:AddLog("Disabled "..Schema:FirstToUpper(name).." Bartering Permit")
	end
end

function PANEL:RefreshUpdatePanel(buttons, name, namePanel)
	surface.PlaySound("willardnetworks/datapad/navigate.wav")
	self:GetTimeSpan(buttons, name, namePanel)
end

function PANEL:UpdatePermits()
	netstream.Start("SetDatafilePermit", PLUGIN.file.genericdata, PLUGIN.file.genericdata.permits)
end

function PANEL:CreateInfoText(text, namePanel, bDisabled)
	if namePanel:GetChildren()[2] then
		namePanel:GetChildren()[2]:Remove()
	end

	local infotext = namePanel:Add("DLabel")
	infotext:Dock(RIGHT)
	infotext:DockMargin(0, 0, SScaleMin(10 / 3), 0)
	infotext:SetTextColor(bDisabled and Color(243, 36, 36, 255) or Color(51, 243, 36, 255))
	infotext:SetText(string.utf8upper(text))
	infotext:SetFont("MenuFontBoldNoClamp")
	infotext:SizeToContents()
end

function PANEL:GetTimeSpan(buttons, name, namePanel)
	local permitTableValue = self.toSave and self.toSave[name] or PLUGIN.file.genericdata.permits[name]

	if !permitTableValue or ( permitTableValue and isnumber(permitTableValue) and (permitTableValue <= os.time()) ) then
		buttons[5].Paint = function(this, w, h)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/licensedisabled2.png"))
			surface.DrawTexturedRect(0, 0, w, h)
		end

		self:CreateInfoText("disabled", namePanel, true)

		for k, v in pairs(buttons) do
			if k == 5 then
				break
			end

			self:PaintDisabled(v)
		end

		return
	end

	-- Unlimited
	if isbool(permitTableValue) and permitTableValue == true then
		self:PaintEnabled(buttons[1])
		self:CreateInfoText("unlimited", namePanel)
	end

	if !isnumber(tonumber(permitTableValue)) then
		for k, v in pairs(buttons) do
			if k != 1 then
				self:PaintDisabled(v)
			end
		end

		return
	end

	-- 3 weeks
	if permitTableValue > (os.time() + 3600 * 24 * 7 * 2) then
		for _, v in pairs(buttons) do
			self:PaintDisabled(v)
		end

		self:CreateInfoText(os.date( "%d/%m/%Y" , permitTableValue ), namePanel)
		return self:PaintEnabled(buttons[2])
	end

	-- 2 weeks
	if permitTableValue > (os.time() + 3600 * 24 * 7 * 1) then
		for _, v in pairs(buttons) do
			self:PaintDisabled(v)
		end

		self:CreateInfoText(os.date( "%d/%m/%Y" , permitTableValue ), namePanel)

		return self:PaintEnabled(buttons[3])
	end

	-- 1 weeks
	if permitTableValue > os.time() then
		for _, v in pairs(buttons) do
			self:PaintDisabled(v)
		end

		self:CreateInfoText(os.date( "%d/%m/%Y" , permitTableValue ), namePanel)
		return self:PaintEnabled(buttons[4])
	end
end

function PANEL:CreateButton(parent, text)
	parent:Dock(RIGHT)
	parent:SetWide(SScaleMin(40 / 3))
	parent:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	parent:SetText(string.utf8upper(text))
	parent:SetFont("MenuFontBoldNoClamp")
end

function PANEL:PaintDisabled(parent)
	parent.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/licensedisabled.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

function PANEL:PaintEnabled(parent)
	parent.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/datafile/licenseenabled.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end
end

vgui.Register("ixDatafilePermits", PANEL, "EditablePanel")

PANEL = {}

function PANEL:Init()
	ix.gui.datafileHousingInfo = self
	self:SetSize(self:GetParent():GetWide(), self:GetParent():GetTall())
	self:Dock(TOP)
	self.Paint = nil

	local titleFrame = self:Add("EditablePanel")
	PLUGIN:CreateTitle(titleFrame, self, "housing info")

	local titleSubframe = titleFrame:Add("EditablePanel")
	titleSubframe:SetSize(SScaleMin(159 / 3), 0)
	titleSubframe:Dock(RIGHT)
	titleSubframe.Paint = nil

	local back = titleSubframe:Add("DButton")
	PLUGIN:CreateTitleFrameRightTextButton(back, titleSubframe, 87, "back", RIGHT)

	back.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/back.wav")
		self:SetVisible(false)
		if IsValid(PLUGIN.datafileInfo) then
			PLUGIN.datafileInfo:SetVisible(true)
		end

		if IsValid(PLUGIN.datafileFunctions) then
			PLUGIN.datafileFunctions:SetVisible(true)
		end
	end

	self.shouldNameShop = false
	if PLUGIN.file.genericdata.housing then
		netstream.Start("RequestApartmentNamesDatafile", tonumber(PLUGIN.file.genericdata.housing))
	end

	if PLUGIN.file.genericdata.shop then
		netstream.Start("RequestApartmentNamesDatafile", tonumber(PLUGIN.file.genericdata.shop))
	end

	self.apartmentsList = vgui.Create("ixDatapadApartments", PLUGIN.contentSubframe)
	self.apartmentsList:SetVisible(false)
end

function PANEL:CreateHousingRow(tApartments)
	for key, appTable in pairs(tApartments) do
		local apartment = self:Add("EditablePanel")
		PLUGIN:CreateRow(apartment, "last known "..(self.shouldNameShop and "shop" or "housing"), appTable.name, nil, false, false)

		local view = apartment:GetChildren()[2]:Add("DButton")
		view:SetFont("MenuFontNoClamp")
		view:Dock(RIGHT)
		view:SetTextColor(color)
		view:SetText("VIEW")
		view:SetContentAlignment(6)
		view:DockMargin(0, 0, SScaleMin(20 / 3), 0)
		view:SizeToContents()
		view.Paint = nil

		view.DoClick = function()
			self:SetVisible(false)
			self.apartmentsList:SetVisible(true)
			if self.apartmentsList.apartmentButtons then
				if self.apartmentsList.apartmentButtons[tonumber(key)] then
					if self.apartmentsList.apartmentButtons[key].DoClick then
						self.apartmentsList.apartmentButtons[key].DoClick()
					else
						surface.PlaySound("willardnetworks/datapad/navigate.wav")
					end

					self.apartmentsList.back.DoClick = function()
						surface.PlaySound("willardnetworks/datapad/back.wav")
						self:SetVisible(true)
						if IsValid(self.apartmentsList) then
							self.apartmentsList:Remove()
						end

						self.apartmentsList = vgui.Create("ixDatapadApartments", PLUGIN.contentSubframe)
						self.apartmentsList:SetVisible(false)
					end
				else
					LocalPlayer():NotifyLocalized("Could not find the apartment.")
				end
			end
		end
	end

	self.shouldNameShop = true
end

vgui.Register("ixDatafileHousingInfo", PANEL, "EditablePanel")

netstream.Hook("UpdateDatafileCredits", function(credits)
	if IsValid(ix.gui.citizenDatafile) then
		if (PLUGIN.file.genericdata.collarID) then
			ix.gui.citizenDatafile.cid.bottom.titleText:SetText(string.upper(PLUGIN.file.genericdata.collarID .. " | " .. PLUGIN.file.genericdata.cid.." | "..credits))
		else
			ix.gui.citizenDatafile.cid.bottom.titleText:SetText(string.upper(PLUGIN.file.genericdata.cid.." | "..credits))
		end

		ix.gui.citizenDatafile.cid.bottom.titleText:SizeToContents()
	end
end)

PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self:RequestTransactionLogs()
end

function PANEL:RequestTransactionLogs()
	netstream.Start("ixDatafileRequestTransactionLogs", PLUGIN.file.genericdata.cid)
end

function PANEL:UpdateLogs(list)
	if !list then return end

	for _, tTransaction in pairs(list) do
		local transaction = self:Add("EditablePanel")
		PLUGIN:CreateRow(transaction, "amount | sender | receiver", tTransaction.amount.." | "..tTransaction.sender_cid.." | "..tTransaction.receiver_cid, os.date("%d/%m/%Y", tTransaction.datetime), false, true)

		local viewLog = transaction.bottom:Add("DButton")
		viewLog:Dock(RIGHT)
		viewLog:DockMargin(0, 0, SScaleMin(20 / 3), SScaleMin(5 / 3))
		viewLog:SetFont("MenuFontNoClamp")
		viewLog:SetTextColor(color)
		viewLog:SetText(string.utf8upper("view reason"))
		viewLog:SizeToContents()
		viewLog.Paint = nil
		viewLog.DoClick = function()
			local parent = self:GetParent()
			surface.PlaySound("willardnetworks/datapad/navigate2.wav")
			parent:SetVisible(false)

			PLUGIN.viewDatafileLog = vgui.Create("ixDatafileOpenLog", PLUGIN.contentSubframe)
			PLUGIN.viewDatafileLog:Update(tTransaction.reason or "")

			PLUGIN.viewDatafileLog.back.DoClick = function()
				surface.PlaySound("willardnetworks/datapad/back.wav")
				parent:SetVisible(true)
				PLUGIN.viewDatafileLog:SetVisible(false)

				parent.genericBack.DoClick = function()
					surface.PlaySound("willardnetworks/datapad/back.wav")
					parent.genericTitleFrame:SetVisible(false)
					parent.transactionLogs:SetVisible(true)
					parent.titleFrame:SetVisible(true)
					parent.logsFrame:SetVisible(true)
					PLUGIN.viewTransactionLogs:SetVisible(false)
				end
			end
		end
	end
end

vgui.Register("ixDatafileTransactionLogs", PANEL, "DScrollPanel")

netstream.Hook("ixDatafileReplyTransactionLogs", function(list)
	if IsValid(PLUGIN.viewTransactionLogs) then
		PLUGIN.viewTransactionLogs:UpdateLogs(list)
	end
end)
