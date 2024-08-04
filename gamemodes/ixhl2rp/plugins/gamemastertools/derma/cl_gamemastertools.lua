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
local padding = SScaleMin(10 / 3)

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self.Paint = function(self, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( self, 1 )
	end

	self.content = self:Add("EditablePanel")
	self.content:SetSize(SScaleMin(700 / 3), SScaleMin(600 / 3))
	self.content:Center()
	self.content:MakePopup()
	self.content.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.content)

	self:CreateTopBar()

	self.innerSelf = self.content:Add("DScrollPanel")
	self.innerSelf:SetTall(SScaleMin(600 / 3) - SScaleMin(75 / 3))
	self.innerSelf:Dock(TOP)
end

function PANEL:CreateTopBar()
	self.topbar = self.content:Add("Panel")
	self.topbar:SetSize(self:GetWide(), SScaleMin(50 / 3))
	self.topbar:Dock(TOP)
	self.topbar:DockMargin(0, 0, 0, padding)
	self.topbar.Paint = function( self, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	self.titleText = self.topbar:Add("DLabel")
	self.titleText:SetFont("CharCreationBoldTitleNoClamp")
	self.titleText:Dock(LEFT)
	self.titleText:SetText("Character Information")
	self.titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	self.titleText:SetContentAlignment(4)
	self.titleText:SizeToContents()

	local exit = self.topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local divider = self.topbar:Add("Panel")
	self:CreateDivider(divider)
end

function PANEL:Update(targetPlayer, data)
	self.targetPlayer = targetPlayer
	self.data = data

	if self.data and self.targetPlayer then
		self:CreateToolButton()
	end
end

function PANEL:CreateToolButton()
	local gamemasterButton = self.topbar:Add("DButton")
	self:CreateButton(gamemasterButton, "narzędzie postaci", "umiejętności")

	gamemasterButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if !self.innerSelf:IsVisible() then
			gamemasterButton:SetText(string.utf8upper("Narzędzia postaci"))
			gamemasterButton.image = "skills"

			self.innerSelf:SetVisible(true)
			if self.gmInnerSelf then
				self.titleText:SetText("Informacje o postaci")
				self.gmInnerSelf:SetVisible(false)
				self.saveButton:SetVisible(false)
				self.saveDivider:SetVisible(false)
			end
		else
			self.titleText:SetText("Narzędzia postaci")
			self.innerSelf:SetVisible(false)
			gamemasterButton:SetText(string.utf8upper("Informacje o postaci"))
			gamemasterButton.image = "character"

			self.saveDivider = self.topbar:Add("Panel")
			self:CreateDivider(self.saveDivider)

			self.saveButton = self.topbar:Add("DButton")
			self:CreateButton(self.saveButton, "zapisz notatki", "wygląd")

			self:CreateGMInnerSelf()
		end
	end

	local createTimeLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(createTimeLabel, "STWORZONA:")

	local createTimeText = self.innerSelf:Add("DTextEntry")
	local Timestamp = self.data.createInfo
	local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
	self:CreateTextEntry(createTimeText, TimeString, 36)

	local nameLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(nameLabel, "IMIĘ")

	local name = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(name, self.data.name, 36)

	local genderLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(genderLabel, "PŁEĆ")

	local gender = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(gender, self:FirstUpper(self.data.gender), 36)

	local geneticLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(geneticLabel, "CECHY GEN.")

	local geneticAge = string.utf8lower(self.data.age or "N/A")
	local geneticHeight = string.utf8lower(self.data.height or "N/A")
	local geneticEyecolor = string.utf8lower(self.data.eyeColor or "N/A")
	local geneticText = self:FirstUpper(geneticAge).." | "..self:FirstUpper(geneticHeight).." | "..self:FirstUpper(geneticEyecolor).." Oczy"

	local genetics = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(genetics, geneticText, 36)

	local descLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(descLabel, "OPIS")

	local desc = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(desc, self.data.description, (40 * 2), true)

	local moneyLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(moneyLabel, "ŻETONY")

	local money = self.innerSelf:Add("DTextEntry")
	self:CreateTextEntry(money, self.data.money, 36)

	local attributesLabel = self.innerSelf:Add("DLabel")
	self:CreateTitleLabel(attributesLabel, "ATRYBUTY")

	self:CreateAttribute("willardnetworks/mainmenu/charcreation/strength.png", 45, 61, "strength", "strength")
	self:CreateAttribute("willardnetworks/mainmenu/charcreation/perception.png", 45, 30, "perception", "perception")
	self:CreateAttribute("willardnetworks/mainmenu/charcreation/agility.png", 38, 47, "agility", "agility")
	self:CreateAttribute("willardnetworks/mainmenu/charcreation/intelligence.png", 48, 29, "intelligence", "intelligence")

	local backgroundData = self.data.background

	if backgroundData != "N/A" and backgroundData != "" then
		local backgroundLabel = self.innerSelf:Add("DLabel")
		self:CreateTitleLabel(backgroundLabel, "TŁO")

		if backgroundData == "Relokowany Obywatel" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/relocatedcitizen.png", 45, 61, "Relokowany Obywatel", "Właśnie przybyłeś do nowego nieznanego Ci miasta. Nie masz tutaj żadnej rodziny, żadnych kontaktów, jesteś tylko kolejnym nic nie znaczącym nikim. Wysiadasz z pociągu i rozpoczynasz zupełnie nowe życie.", -5, "Dobre dla nowych graczy")
		end

		if backgroundData == "Miejscowy Obywatel" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Miejscowy Obywatel", "Mieszkasz tu od całkiem długiego czasu, może nawet od czasu przed okupacją. Jakimś cudem miałeś te szczęście i nigdy nie zostałeś relokowany. Znasz już to miasto praktycznie na wylot.", 0)
		end

		if backgroundData == "Zwolennik" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Zwolennik", "Z jakiegoś powodu przystałeś na zwierzchnictwo Kombinatu. Przestrzegasz ich przepisy i starasz sprostać się ich oczekiwaniu. Twoja współpraca może niektórym się nie spodobać.", 0)
		end

		if backgroundData == "Wyrzutek" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/outcast.png", 55, 55, "Wyrzutek", "Zawsze w ruchu i zawsze w cieniu. Żyjesz na własną rękę w najbiedniejszych rejonach miasta, sprawnie unikając ciężkiej ręki Kombinatu.", 0)
		end

		if backgroundData == "Biotyk" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Biotyk", "Zniewolony, uwolniony i ponownie zniewolony. Z obrożą na szyi i pod butem Kombinatu musisz znosić wszelkie ich tortury. Ty i tysiące innych.", 13, "Wybierz tę opcję, chyba że masz pozwolenie na użycie innych teł.")
		end

		if backgroundData == "Uwolniony" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Uwolniony", "Niegdyś zniewolony, teraz wolny. Żyłeś pod butem Kombinatu, lecz teraz już się to skończyło. Bądź ostrożny, Kombinat już zasmakował twojej krwi i nie okaże żadnej pobłażliwości, gdy Cię znowu znajdzie...", 13, "Trudny poziom trudności - nie używaj tej opcji, jeśli nie masz pozwolenia.")
		end

		if backgroundData == "Wolny" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/outcast.png", 55, 55, "Wolny", "Jako jeden z nielicznych vortigauntów nigdy nie zostałeś schwytany przez Kombinat. Ostatni łancuch jaki nosiłeś należał do Nihilantha. Kombinat nie wie o twoim istnieniu.", 15, "Nie używaj tej opcji, jeśli nie masz pozwolenia.")
		end

		if backgroundData == "Kolaborator" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/supporter.png", 53, 68, "Kolaborator", "Jakimś niewiadomym cudem Kombinatowi udało się złamać twój umysł. Jesteś ich ofiarą, funkcjonujesz jako anomalia dla rasy Vortigauntów. Możesz pozwolić sobie na luksusy podstępnie oferowanie przez Kombinat, masz status Kolaboranta.", 13, "Nie używaj tej opcji, jesli nie masz pozwolenia. To tło zaczyna z CIDem, 50 punktami kohezji, bez kajdan i ładną pracą spodni.")
		end

		if backgroundData == "Pracownik" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/relocatedcitizen.png", 45, 61, "Pracownik", "Jesteś pracownikem dla siły roboczej rządu okupacyjnego Kombinatu. Spędasz swój czas pozbywając się infestacji, w fabryce lub naprawiając infrastrukturę.", -8)
		end

		if backgroundData == "Lekarz" then
			self:CreateBackgroundSelectionPanels("willardnetworks/mainmenu/charcreation/local.png", 34, 61, "Lekarz", "Jesteś personelem medycznym tego miasta. Twoim zadaniem jest dbanie o zdrowie populacji. Jeśli będziesz miał wystarczająco szczęścia będziesz mógł operować zarówno na vortigauntach, jak i Civil Protection.", -10)
		end
	end

	if !table.IsEmpty(self.data.skillLvl) then
		local skillsLabel = self.innerSelf:Add("DLabel")
		self:CreateTitleLabel(skillsLabel, "UMIEJĘTNOŚCI")
	end

	for skill, level in pairs(self.data.skillLvl) do
		local skillEntry = self.innerSelf:Add("DTextEntry")
		self:CreateTextEntry(skillEntry, ix.skill:Find(skill).name.." | Poziom: "..level, 36)
	end

	local ac = ""
	local points = ""
	local occupation = ""
	local designatedStatus = ""
	local bol = ""

	if self.data.genericData.socialCredits then
		if (self.data.genericData.socialCredits >= 0 or self.data.genericData.socialCredits <= 0) then
			points = "SC/LP: "..math.Clamp(tonumber(self.data.genericData.socialCredits), 0, 200).." | "
		end
	end

	if (self.data.genericData.occupation) then
		if self.data.genericData.occupation != "N/A" then
			occupation = "ZAWÓD: "..self.data.genericData.occupation.." | "
		end
	end

	if self.data.genericData.designatedStatus then
		if self.data.genericData.designatedStatus != "N/A" then
			designatedStatus = "STATUS: "..self.data.genericData.designatedStatus
		end
	end

	if self.data.genericData then
		local datafileLabel = self.innerSelf:Add("DLabel")
		self:CreateTitleLabel(datafileLabel, "DANE OSOBOWE")

		if self.data.genericData.anticitizen == true then
			ac = "ANTYOBYWATEL | "
		end

		if self.data.genericData.bol == true then
			bol = "BOL | "
		end

		local datafileEntry = self.innerSelf:Add("DTextEntry")
		self:CreateTextEntry(datafileEntry, ac..bol..points..occupation..designatedStatus, 36)
	end
end

function PANEL:CreateGMInnerSelf()
	self.gmInnerSelf = self.content:Add("EditablePanel")
	self.gmInnerSelf:SetTall(SScaleMin(600 / 3) - SScaleMin(65 / 3))
	self.gmInnerSelf:Dock(TOP)

	self.gmTextEntry = self.gmInnerSelf:Add("DTextEntry")
	self.gmTextEntry:Dock(LEFT)
	self.gmTextEntry:SetSize(SScaleMin(450 / 3), self.gmInnerSelf:GetTall())
	self.gmTextEntry:DockMargin(padding * 2, SScaleMin(5 / 3), padding * 2 + SScaleMin(20 / 3), padding)
	self.gmTextEntry:SetMultiline( true )
	self.gmTextEntry:SetVerticalScrollbarEnabled( true )
	self.gmTextEntry:SetEnterAllowed( true )
	self.gmTextEntry:SetTextColor(Color(200, 200, 200, 255))
	self.gmTextEntry:SetCursorColor(Color(200, 200, 200, 255))
	self.gmTextEntry:SetFont("MenuFontNoClamp")
	self.gmTextEntry:SetText(self.data.info)
	self.gmTextEntry.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	local buttonList = self.gmInnerSelf:Add("Panel")
	buttonList:Dock(RIGHT)
	buttonList:SetWide(SScaleMin(250 / 3))
	buttonList:DockMargin(padding, 0, padding, 0)

	self:CreateButtonListTitle(buttonList, "Cechy genetyczne")

	local editGeneticAge = buttonList:Add("DButton")
	self:CreateFunctionButton(editGeneticAge, "Wiek", "appearances", function()
		Derma_StringRequest("Wiek genetyczny", "Młody dorosły / Dorosły / W średnim wieku / Starszy", nil, function(text)
			netstream.Start("setAge", self.targetPlayer, text)
			LocalPlayer():NotifyLocalized("Ustawiono wiek "..self.data.name.." na "..text)
		end)
	end)

	local editGeneticHeight = buttonList:Add("DButton")
	self:CreateFunctionButton(editGeneticHeight, "Wzrost", "appearances", function()
		Derma_StringRequest("Wzrost genetyczny", "np. 5'8\", 6'0\" (UPEWNIJ SIĘ, ŻE JEST ZAWARTE: ' i \" BO INACZEJ POSTAĆ SIĘ POPSUJE!!)", nil, function(text)
			local heightft, heightin = string.match(text, "^(%d+)'(%d+)\"$")
			if (!heightft or !heightin) then
				LocalPlayer():NotifyLocalized("Wprowadzono nieprawidłowy wzrost")
			else
				netstream.Start("setHeight", self.targetPlayer, text)
				LocalPlayer():NotifyLocalized("Ustawiono wzrost "..self.data.name.." na "..text)
			end
		end)
	end)

	local editGeneticEye = buttonList:Add("DButton")
	self:CreateFunctionButton(editGeneticEye, "Kolor oczu", "appearances", function()
		Derma_StringRequest("Genetyczny kolor oczu", "np. niebieskie / zielone / brązowe / piwne / bursztynowe / szare", nil, function(text)
			netstream.Start("setEyeColor", self.targetPlayer, text)
			LocalPlayer():NotifyLocalized("Ustawiono kolor oczu "..self.data.name.." na "..text)
		end)
	end)

	self:CreateButtonListDivider(buttonList)
	self:CreateButtonListTitle(buttonList, "Atrybuty")

	local charStrength = buttonList:Add("DButton")
	self:CreateFunctionButton(charStrength, "Siła", "attributes", function()
		Derma_StringRequest("Edytuj siłę", "Od 0 do 10", nil, function(number)
			netstream.Start("setStrength", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("Ustawiono siłę "..self.data.name.." na "..number)
		end)
	end)

	local charPerception = buttonList:Add("DButton")
	self:CreateFunctionButton(charPerception, "Percepcja", "attributes", function()
		Derma_StringRequest("Edytuj percepcję", "Od 0 do 10", nil, function(number)
			netstream.Start("setPerception", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("Ustawiono percepcję "..self.data.name.." na "..number)
		end)
	end)

	local charAgility = buttonList:Add("DButton")
	self:CreateFunctionButton(charAgility, "Zręczność", "attributes", function()
		Derma_StringRequest("Edytuj zręczność", "Od 0 do 10", nil, function(number)
			netstream.Start("setAgility", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("Ustawiono zręczność "..self.data.name.." na "..number)
		end)
	end)

	local charInt = buttonList:Add("DButton")
	self:CreateFunctionButton(charInt, "Inteligencja", "attributes", function()
		Derma_StringRequest("Edytuj inteligencję", "Od 0 do 10", nil, function(number)
			netstream.Start("setIntelligence", self.targetPlayer, number)
			LocalPlayer():NotifyLocalized("Ustawiono inteligencję "..self.data.name.." na "..number)
		end)
	end)

	self:CreateButtonListDivider(buttonList)
	self:CreateButtonListTitle(buttonList, "Tło")

	local charBackground = buttonList:Add("DButton")
	self:CreateFunctionButton(charBackground, "Edytuj tło", "background", function()
		if self.data.faction != FACTION_CITIZEN and self.data.faction != FACTION_VORT then
			LocalPlayer():NotifyLocalized("Wybór teł nie jest dostępny dla tej frakcji!")
			return false
		end

		if self.data.faction == FACTION_CITIZEN then
			Derma_Query( "Ustaw tło", "Wybierz jedno",
			"Relokowany Obywatel", function()
				netstream.Start("setBackground", self.targetPlayer, "Relokowany obywatel")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Relokowanego Obywatela.")
			end,

			"Miejscowy Obywatel", function()
				netstream.Start("setBackground", self.targetPlayer, "Miejscowy Obywatel")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Miejscowego Obywatela.")
			end,

			"Zwolennik", function()
				netstream.Start("setBackground", self.targetPlayer, "Zwolennik")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Zwolennika.")
			end,

			"Wyrzutek", function()
				netstream.Start("setBackground", self.targetPlayer, "Wyrzutek")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Wyrzutka.")
			end)
		end

		if self.data.faction == FACTION_VORT then
			Derma_Query( "Ustaw tło", "Wybierz jedno",
			"Biotyk", function()
				netstream.Start("setBackground", self.targetPlayer, "Biotyk")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Biotyka.")
			end,

			"Uwolniony", function()
				netstream.Start("setBackground", self.targetPlayer, "Uwolniony")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Uwolnionego.")
			end,

			"Wolny", function()
				netstream.Start("setBackground", self.targetPlayer, "Wolny")
				LocalPlayer():NotifyLocalized("Ustawiono tło "..self.data.name.." na Wolnego.")
			end,

			"Kolaborator", function()
				netstream.Start("setBackground", self.targetPlayer, "Kolaborator")
				LocalPlayer():NotifyLocalized("Ustawiono tlo "..self.data.name.." na Kolaboratora.")
			end)
		end
	end)

	self:CreateButtonListDivider(buttonList)
	self:CreateButtonListTitle(buttonList, "Narzędzia admina")

	local charName = buttonList:Add("DButton")
	self:CreateFunctionButton(charName, "Imię postaci", "character", function()
		Derma_StringRequest("Edytuj imię", "Jakie imię chcesz ustawić tej postaci?", nil, function(name)
			ix.command.Send("CharSetName", self.data.name, name)
		end)
	end)

	local charMoney = buttonList:Add("DButton")
	self:CreateFunctionButton(charMoney, "Pieniądze postaci", "appearances", function()
		Derma_StringRequest("Edytuj pieniądze", "Jaką kwotę pieniedzy chcesz ustawić tej postaci?", nil, function(money)
			ix.command.Send("CharSetTokens", self.data.name, money)
		end)
	end)

	local charDesc = buttonList:Add("DButton")
	self:CreateFunctionButton(charDesc, "Opis postaci", "appearances", function()
		Derma_StringRequest("Edytuj opis", "Jaki opis postaci chcesz ustawić tej postaci?", nil, function(desc)
			netstream.Start("setDescription", self.targetPlayer, desc)
			LocalPlayer():NotifyLocalized("Ustawiono opis "..self.data.name.." na "..desc)
		end)
	end)

	self.saveButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		LocalPlayer():NotifyLocalized("Saved gamemaster data for ".. self.data.name)
		netstream.Start("SaveGMData", self.targetPlayer, self.gmTextEntry:GetText())
	end
end

function PANEL:CreateDivider(parent)
	parent:SetSize(1, self.topbar:GetTall())
	parent:Dock(RIGHT)
	parent:DockMargin(SScaleMin(5 / 3), padding, padding + SScaleMin(5 / 3), padding)
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, 0, h)
	end
end

function PANEL:CreateButton(parent, text, image)
	parent:SetText(string.utf8upper(text))
	parent:SetFont("WNMenuFontNoClamp")
	parent:SetContentAlignment(4)
	parent:SetTextInset(SScaleMin(26 / 3), 0)
	parent:SetTextColor(color_white)
	parent:Dock(RIGHT)
	parent:SizeToContents()
	local width, height = parent:GetSize()
	parent:SetSize(width, SScaleMin(50 / 3))
	parent.image = image

	parent.OnCursorEntered = function()
		surface.PlaySound("willardnetworks/charactercreation/hover.wav")
	end

	parent.Paint = function(self, w, h)
		if self:IsHovered() then
			self:SetTextColor(color_white)
			surface.SetDrawColor(color_white)
		else
			self:SetTextColor(Color(200, 200, 200, 255))
			surface.SetDrawColor(Color(200, 200, 200, 255))
		end

		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/"..parent.image..".png"))
		surface.DrawTexturedRect(0, SScaleMin(15 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3))
	end
end

function PANEL:CreateFunctionButton(parent, name, image, callback)
	parent:SetText(string.utf8upper(name))
	parent:SetFont("WNMenuFontNoClamp")
	parent:SetContentAlignment(4)
	parent:SetTextInset(SScaleMin(26 / 3), 0)
	parent:SetTextColor(color_white)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(20 / 3))
	parent:DockMargin(SScaleMin(57 / 3), SScaleMin(3 / 3), padding, SScaleMin(7 / 3))
	parent.image = image

	parent.OnCursorEntered = function()
		surface.PlaySound("willardnetworks/charactercreation/hover.wav")
	end

	parent.Paint = function(self, w, h)
		if self:IsHovered() then
			self:SetTextColor(color_white)
			surface.SetDrawColor(color_white)
		else
			self:SetTextColor(Color(200, 200, 200, 255))
			surface.SetDrawColor(Color(200, 200, 200, 255))
		end

		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/"..parent.image..".png"))
		surface.DrawTexturedRect(0, 0, SScaleMin(20 / 3), SScaleMin(20 / 3))
	end

	parent.DoClick = callback
end

function PANEL:CreateButtonListTitle(parent, title)
	local buttonListTitle = parent:Add("DLabel")
	buttonListTitle:SetText(string.utf8upper(title))
	buttonListTitle:SetFont("TitlesFontNoClamp")
	buttonListTitle:Dock(TOP)
	buttonListTitle:DockMargin(SScaleMin(57 / 3), SScaleMin(3 / 3), padding, SScaleMin(7 / 3))
end

function PANEL:CreateButtonListDivider(parent)
	local buttonListDivider = parent:Add("Panel")
	buttonListDivider:Dock(TOP)
	buttonListDivider:SetTall(1)
	buttonListDivider:DockMargin(SScaleMin(57 / 3), SScaleMin(3 / 3), padding + SScaleMin(7 / 3), SScaleMin(7 / 3))
	buttonListDivider.Paint = function(self, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, w, 0)
	end
end

function PANEL:FirstUpper(str)
	if !str then return end
	if !isstring(str) then str = tostring(str) end
	return (str:gsub("^%l", string.utf8upper))
end

function PANEL:CreateTitleLabel(parent, value)
	parent:Dock(TOP)
	parent:SetContentAlignment(4)
	parent:SetText(value)
	parent:DockMargin(padding * 2, 0, padding * 2, 5)
	parent:SetFont("MenuFontNoClamp")
	parent:SetTextColor(color_white)
end

function PANEL:CreateTextEntry(parent, value, height, scrollAble)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(height / 3))
	parent:DockMargin(padding * 2, 0, padding * 2 + SScaleMin(5 / 3), padding)
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetCursorColor(Color(200, 200, 200, 255))
	parent:SetFont("MenuFontNoClamp")
	parent:SetText(value)
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end

	if (scrollAble) then
		parent:SetMultiline( true )
		parent:SetVerticalScrollbarEnabled( true )
	end
end

function PANEL:CreateBackgroundSelectionPanels(icon, iconW, iconH, title, desc, minusMargin, difficultyText)
	iconW = SScaleMin(iconW / 3)
	iconH = SScaleMin(iconH / 3)

	local backgroundPanel = self.innerSelf:Add("DSizeToContents")
	backgroundPanel:Dock(TOP)
	backgroundPanel:DockPadding(SScaleMin(90 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	backgroundPanel:DockMargin(padding * 2, 0, padding * 2, padding)
	backgroundPanel:SetSizeX( false )
	backgroundPanel:InvalidateLayout()
	backgroundPanel.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.SetMaterial(Material(icon))
		surface.DrawTexturedRect(SScaleMin(90 / 3) * 0.5 - iconW * 0.5, h * 0.5 - iconH * 0.5, iconW, iconH)
	end

	local textPanel = backgroundPanel:Add("DSizeToContents")
	textPanel:Dock(TOP)
	textPanel:SetSizeX( false )

	local titleText = textPanel:Add("DLabel")
	titleText:SetText(title)
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:SizeToContents()
	titleText:Dock(TOP)
	titleText:SetTextColor(Color(255, 204, 0, 255))

	local descText = textPanel:Add("DLabel")
	descText:SetText(desc)
	descText:SetFont("MenuFontNoClamp")
	descText:SetWrap(true)
	descText:SetAutoStretchVertical(true)
	descText:Dock(TOP)

	if difficultyText then
		local textDifficulty = textPanel:Add("DLabel")
		textDifficulty:Dock(TOP)
		textDifficulty:SetText(difficultyText)
		textDifficulty:SetFont("MenuFontNoClamp")
		textDifficulty:SetWrap(true)
		textDifficulty:SetAutoStretchVertical(true)
		textDifficulty:DockMargin(0, SScaleMin(10 / 3), 0, 0)

		if string.match(difficultyText, "Hard") then
			textDifficulty:SetTextColor(Color(255, 78, 69, 255))
		elseif string.match(difficultyText, "To tło zaczyna bez CID.") then
			textDifficulty:SetTextColor(Color(236, 218, 101, 255))
		else
			textDifficulty:SetTextColor(Color(101, 235, 130, 255))
		end
	end
end

function PANEL:CreateAttribute(icon, wIcon, hIcon, title, attribute)
	wIcon, hIcon = SScaleMin(wIcon / 3), SScaleMin(hIcon / 3)

	local attributePanel = self.innerSelf:Add("Panel")
	attributePanel:Dock(TOP)
	attributePanel:DockMargin(padding * 2, 0, padding * 2, padding)
	attributePanel:SetTall(SScaleMin(105 / 3))
	attributePanel.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material(icon))
		surface.DrawTexturedRect(SScaleMin(90 / 3) * 0.5 - wIcon * 0.5, SScaleMin(105 / 3) * 0.5 - hIcon * 0.5, wIcon, hIcon)
	end

	local textPanel = attributePanel:Add("Panel")
	textPanel:Dock(LEFT)
	textPanel:DockMargin(SScaleMin(90 / 3), 0, 0, 0)
	textPanel:SetSize(SScaleMin(460 / 3) - (SScaleMin(50 / 3) + wIcon) - (SScaleMin(15 / 3) + SScaleMin(50 / 3)), SScaleMin(105 / 3))

	local titleText = textPanel:Add("DLabel")
	titleText:SetText(string.utf8upper(title))
	titleText:SetFont("LargerTitlesFontNoClamp")
	titleText:SetPos(0, textPanel:GetTall() * 0.5 - SScaleMin(13 / 3))
	titleText:SizeToContents()
	titleText:SetContentAlignment(4)
	titleText:SetTextColor(Color(255, 204, 0, 255))

	local attributePointsPanel = attributePanel:Add("Panel")
	attributePointsPanel:Dock(RIGHT)
	attributePointsPanel:DockMargin(0, 0, SScaleMin(25 / 3), 0)
	attributePointsPanel:SetSize(SScaleMin(15 / 3), SScaleMin(105 / 3))

	local attributePoint = attributePointsPanel:Add("DLabel")
	attributePoint:SetFont("LargerTitlesFontNoClamp")
	attributePoint:SetPos(0, attributePointsPanel:GetTall() * 0.5 - SScaleMin(13 / 3))
	attributePoint:SetText(self.data.special[attribute] or "0")
	attributePoint:SetContentAlignment(6)
	attributePoint:SizeToContents()
end

vgui.Register("GamemasterTools", PANEL, "EditablePanel")