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
local padding = SScaleMin(20 / 3)
PANEL.templates = {}

function PANEL:RegisterTemplate(name, storedFunc)
	self.templates[name] = {
		create = storedFunc
	}
end

function PANEL:Init()
	local informedCitizen = function()
		local newspaperPanel = self.surrounder:Add("Panel")
		newspaperPanel:Dock(TOP)
		newspaperPanel:SetTall(SScaleMin(1391 / 3))
		newspaperPanel.Paint = function(this, w, h)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("models/wn/newspapers/newspaper_bg_noheadline.png"))
			surface.DrawTexturedRect(0, 0, w, h)
		end

		self.mainPanel = newspaperPanel

		self.optionTop = self:CreateOptionPanel(self, TOP)
		self.optionTop:DockMargin(ScrW() / 2 - self.surrounder:GetWide() / 2, padding / 2, ScrW() / 2 - self.surrounder:GetWide() / 2, 0)

		self.headlineText = self:CreateTextEntry(self.mainPanel, SScaleMin(164 / 3), SScaleMin(64 / 3), TOP, 0, 0, 0, 0, nil, "UnifrakturTitle", 20, true, true, "", nil, "The Informed Citizen")
		self.headlineText:SetZPos(-1)
		self.headlineText:SetContentAlignment(4)
		self.headlineText:DockMargin(self.surrounder:GetWide() * 0.21, SScaleMin(48 / 3), self.surrounder:GetWide() * 0.20, 0)

		self.date = self.mainPanel:Add("DLabel")
		self.date:Dock(TOP)
		self.date:SetFont("GeorgiaBold")
		self.date:SetText(string.upper(ix.date.GetFormatted("%A"..",".." %B %d".."th"..", ".."%Y")))
		self.date:SetTextColor(color_black)
		self.date:SizeToContents()
		self.date:SetContentAlignment(5)
		self.date:DockMargin(0, SScaleMin(12 / 3), 0, 0)
		self.date:SetZPos(0)

		self.bigHeadline = self:CreateTextEntry(self.mainPanel, nil, SScaleMin(117 / 3), TOP, SScaleMin(33 / 3), SScaleMin(3 / 3), SScaleMin(33 / 3), 0, nil, "FjallaOneRegularLarge", 20, false, true, "", nil, string.upper("TERROR IN THE STREET"))
		self.bigHeadline:SetZPos(1)
		self.subHeadline = self:CreateTextEntry(self.mainPanel, nil, SScaleMin(60 / 3), TOP, SScaleMin(33 / 3), 0, SScaleMin(33 / 3), 0, nil, "FjallaOneRegularSmall", 52, false, true, "", nil, string.upper("MONTH-WIDE LOCKDOWN DECLARED AFTER UNCIVIL RIOTS ERUPT"))
		self.subHeadline:SetZPos(2)

		local leftRight = self.mainPanel:Add("Panel")
		leftRight:Dock(FILL)
		leftRight:DockMargin(SScaleMin(32 / 3), 0, SScaleMin(30 / 3), 0)

		local left = leftRight:Add("Panel")
		left:Dock(LEFT)
		left:SetWide(SScaleMin(534 / 3))
		left:DockMargin(0, 0, SScaleMin(8 / 3), 0)

		local right = leftRight:Add("Panel")
		right:Dock(FILL)

		self.imageButton = self:CreateSelectorButton(left, SScaleMin(534 / 3), SScaleMin(480 / 3), TOP, 0, 0, 0, 0, nil, "SELECT IMAGE", function()
			-- if self.cracked then LocalPlayer():Notify("You cannot add images to cracked newspapers!") return end

			Derma_StringRequest(
				"URL (any pictures with sexually explicit content will get you banned)",
				"Input the URL to the image you want to be shown.",
				"",
				function(url)
					self.imageButton.OnRequest(url)
				end,
				nil
			)
		end)

		self.imageButton:SetZPos(3)
		self.imageButton.OnRequest = function(url)
			self.imageButton:Remove()
			local linkedImage = self:CreateLinkedImage(left, SScaleMin(534 / 3), SScaleMin(480 / 3), TOP, 0, 0, 0, 0, nil, url)
			linkedImage:SetZPos(3)
			self.image = url
		end

		self.articleTitle = self:CreateTextEntry(left, nil, SScaleMin(60 / 3), TOP, 0, 0, 0, 0, nil, "AdobeCaslonProBold", 30, false, true, "", nil, "C24 Admin. Stewart to Resign")
		self.articleTitle:SetZPos(4)
		self.articleTitle.bAlignLeft = true

		self.articleAuthor = self:CreateTextEntry(left, nil, SScaleMin(28 / 3), TOP, 0, SScaleMin(20 / 3), 0, SScaleMin(5 / 3), nil, "MinionProBold", 45, false, true, "", nil, string.upper("James Hawke"))
		self.articleAuthor:SetZPos(5)
		self.articleAuthor.bAlignLeft = true

		local articleContentPanel = left:Add("Panel")
		articleContentPanel:Dock(FILL)
		articleContentPanel:SetZPos(6)

		self.articleText1 = self:CreateTextEntry(articleContentPanel, (SScaleMin(534 / 3) / 2) + SScaleMin(3 / 3), nil, LEFT, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 655, true, true, "", nil, "Article text goes here")
		self.articleText1:SetZPos(7)
		self.articleText1.bAlignTopLeft = true
		self.articleText1:DockMargin(-SScaleMin(3 / 3), 0, 0, 0)

		self.articleText2 = self:CreateTextEntry(articleContentPanel, (SScaleMin(534 / 3) / 2) - padding / 2, nil, RIGHT, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 655, true, true, "", nil, "Article text part 2 goes here")
		self.articleText2:SetZPos(8)
		self.articleText2.bAlignTopLeft = true

		self.imageButton2 = self:CreateSelectorButton(right, SScaleMin(283 / 3) - SScaleMin(13 / 3), SScaleMin(202 / 3), TOP, 0, 0, 0, 0, nil, "SELECT IMAGE", function()
			-- if self.cracked then LocalPlayer():Notify("You cannot add images to cracked newspapers!") return end
			Derma_StringRequest(
				"URL (any pictures with sexually explicit content will get you banned)",
				"Input the URL to the image you want to be shown.",
				"",
				function(url)
					self.imageButton2.OnRequest(url)
				end,
				nil
			)
		end)

		self.imageButton2:SetZPos(9)
		self.imageButton2.OnRequest = function(url)
			self.imageButton2:Remove()
			local linkedImage = self:CreateLinkedImage(right, SScaleMin(283 / 3) - SScaleMin(12 / 3), SScaleMin(202 / 3), TOP, 0, 0, 0, 0, nil, url)
			linkedImage:SetZPos(9)
			self.image2 = url
		end

		self.sideArticleCaption = self:CreateTextEntry(right, nil, SScaleMin(28 / 3), TOP, 0, 0, 0, 0, nil, "ArialBold", 35, false, true, "", nil, string.upper("TINY HUMAN STANDS BEFORE SUMMIT 24"))
		self.sideArticleCaption:SetZPos(10)
		self.sideArticleCaption.bAlignLeft = true

		self.articleTitle2 = self:CreateTextEntry(right, nil, SScaleMin(58 / 3), TOP, 0, 0, 0, 0, nil, "AdobeCaslonProBoldSmaller", 26, false, true, "", nil, "Summit Meeting")
		self.articleTitle2:SetZPos(11)
		self.articleTitle2.bAlignLeft = true

		self.articleAuthor2 = self:CreateTextEntry(right, nil, SScaleMin(28 / 3), TOP, 0, SScaleMin(20 / 3), 0, SScaleMin(10 / 3), nil, "MinionProBold", 31, false, true, "", nil, string.upper("John Smith"))
		self.articleAuthor2:SetZPos(12)
		self.articleAuthor2.bAlignLeft = true

		self.article2Text = self:CreateTextEntry(right, 0, nil, FILL, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 1700, true, true, "", nil, "Article 2 text goes here")
		self.article2Text:SetZPos(13)
		self.article2Text.bAlignTopLeft = true

		self.adPanel = self.mainPanel:Add("Panel")
		self.adPanel:Dock(BOTTOM)
		self.adPanel:SetTall(SScaleMin(150 / 3))
		self.adPanel:DockMargin(SScaleMin(32 / 3), SScaleMin(23 / 3), SScaleMin(32 / 3), SScaleMin(78 / 3))
		self.adPanel:SetZPos(14)

		self.adImageButton = self:CreateSelectorButton(self.adPanel, SScaleMin(105 / 3), SScaleMin(105 / 3), LEFT, SScaleMin(47 / 3), SScaleMin(24 / 3), SScaleMin(54 / 3), SScaleMin(21 / 3), nil, "SELECT IMAGE", function()
			-- if self.cracked then LocalPlayer():Notify("You cannot add images to cracked newspapers!") return end
			self:CreateAdSelector(self.adPanel)
		end)

		self.adImageButton:SetZPos(15)

		local adTitleDescPanel = self.adPanel:Add("Panel")
		adTitleDescPanel:Dock(LEFT)
		adTitleDescPanel:SetSize(SScaleMin(400 / 3), self.adPanel:GetTall())
		adTitleDescPanel:DockMargin(0, SScaleMin(36 / 3), 0, SScaleMin(23 / 3))
		adTitleDescPanel:SetZPos(16)

		self.adTitle = self:CreateTextEntry(adTitleDescPanel, nil, SScaleMin(40 / 3), TOP, 0, 0, 0, 0, nil, "MinionProBoldAd", 11, false, true, "", nil, "THE TRIUMPH")
		self.adTitle:SetZPos(17)

		self.adSubtitle = self:CreateTextEntry(adTitleDescPanel, nil, SScaleMin(50 / 3), TOP, 0, 0, 0, 0, nil, "MinionProItalic", 15, false, true, "", nil, "Casino & Lounge")
		self.adSubtitle:SetZPos(18)

		self.adDesc = self:CreateTextEntry(self.adPanel, SScaleMin(125 / 3), nil, RIGHT, 0, SScaleMin(42 / 3), SScaleMin(42 / 3), SScaleMin(32 / 3), nil, "MinionProRegular", 80, true, true, "", nil, "Ad Desc")
		self.adDesc:SetZPos(19)

		local optionBot = self:CreateOptionPanel(self, BOTTOM)
		optionBot:DockMargin(ScrW() / 2 - self.surrounder:GetWide() / 2, 0, ScrW() / 2 - self.surrounder:GetWide() / 2, padding / 2)
		self:CreateOption(optionBot, LEFT, "PREVIEW", function(button)
			self.bigHeadline:SetText(string.upper(self.bigHeadline:GetText()))
			self.subHeadline:SetText(string.upper(self.subHeadline:GetText()))
			self.articleAuthor:SetText(string.upper(self.articleAuthor:GetText()))
			self.articleAuthor2:SetText(string.upper(self.articleAuthor2:GetText()))
			self.sideArticleCaption:SetText(string.upper(self.sideArticleCaption:GetText()))
			self:TogglePreview(button)
			button:SetVisible(true)
		end, 0, 0, 0, 0)

		self:CreateOption(optionBot, RIGHT, "PRINT", function(button)
			netstream.Start("ixWritingAddWriting", self.identifier, {
				headlineText = self.headlineText:GetText(),
				date = self.date:GetText(),
				bigHeadline = self.bigHeadline:GetValue(),
				subHeadline = self.subHeadline:GetValue(),
				image = self.image or "",
				articleTitle = self.articleTitle:GetValue(),
				articleAuthor = self.articleAuthor:GetValue(),
				articleText1 = self.articleText1:GetValue(),
				articleText2 = self.articleText2:GetValue(),
				image2 = self.image2 or "",
				sideArticleCaption = self.sideArticleCaption:GetValue(),
				articleTitle2 = self.articleTitle2:GetValue(),
				articleAuthor2 = self.articleAuthor2:GetValue(),
				article2Text = self.article2Text:GetValue(),
				adTitle = self.adTitle:GetValue(),
				adSubtitle = self.adSubtitle:GetValue(),
				adDesc = self.adDesc:GetValue(),
				adMaterial = self.adMaterial or "",
				template = "The Informed Citizen",
				unionDatabase = self.unionDatabase and self.unionDatabase:GetChecked() or false
			}, self.itemID)
			self:Remove()
		end, 0, 0, 0, 0)
	end
	self:RegisterTemplate("The Informed Citizen", informedCitizen)
	local GenevanTribute = function()
		local newspaperPanel = self.surrounder:Add("Panel")
		newspaperPanel:Dock(TOP)
		newspaperPanel:SetTall(SScaleMin(1391 / 3))
		newspaperPanel.Paint = function(this, w, h)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("models/wn/newspapers/newspaper_bg_two.png"))
			surface.DrawTexturedRect(0, 0, w, h)
		end

		self.mainPanel = newspaperPanel

		self.optionTop = self:CreateOptionPanel(self, TOP)
		self.optionTop:DockMargin(ScrW() / 2 - self.surrounder:GetWide() / 2, padding / 2, ScrW() / 2 - self.surrounder:GetWide() / 2, 0)

		self.headlineText = self:CreateTextEntry(self.mainPanel, SScaleMin(164 / 3), SScaleMin(64 / 3), TOP, 0, 0, 0, 0, nil, "UnifrakturTitle", 20, true, true, "", nil, "The Genevan Tribune")
		self.headlineText:SetZPos(-1)
		self.headlineText:SetContentAlignment(4)
		self.headlineText:DockMargin(self.surrounder:GetWide() * 0.21, SScaleMin(48 / 3), self.surrounder:GetWide() * 0.20, 0)

		self.date = self.mainPanel:Add("DLabel")
		self.date:Dock(TOP)
		self.date:SetFont("GeorgiaBold")
		self.date:SetText(string.upper(ix.date.GetFormatted("%A"..",".." %B %d".."th"..", ".."%Y")))
		self.date:SetTextColor(color_black)
		self.date:SizeToContents()
		self.date:SetContentAlignment(5)
		self.date:DockMargin(0, SScaleMin(-3 / 3), 0, 0)
		self.date:SetZPos(0)

		self.bigHeadline = self:CreateTextEntry(self.mainPanel, nil, SScaleMin(117 / 3), TOP, SScaleMin(33 / 3), SScaleMin(9 / 3), SScaleMin(33 / 3), 0, nil, "FjallaOneRegularLarge", 20, false, true, "", nil, string.upper("TERROR IN THE STREET"))
		self.bigHeadline:SetZPos(1)

		self.subHeadline = self:CreateTextEntry(self.mainPanel, nil, SScaleMin(60 / 3), TOP, SScaleMin(55 / 3), 0, SScaleMin(33 / 3), 0, nil, "FjallaOneRegularSmall", 52, false, true, "", nil, string.upper("MONTH-WIDE LOCKDOWN DECLARED AFTER UNCIVIL RIOTS ERUPT"))
		self.subHeadline:SetZPos(2)

		local bottomContents = self.mainPanel:Add("Panel")
		bottomContents:Dock(BOTTOM)
		bottomContents:DockMargin(SScaleMin(32 / 3), 0, SScaleMin(30 / 3), SScaleMin(6 / 3))
		bottomContents:SetTall(SScaleMin(370 / 3))

		local leftRight = self.mainPanel:Add("Panel")
		leftRight:Dock(FILL)
		leftRight:DockMargin(SScaleMin(32 / 3), 0, SScaleMin(30 / 3), 0)

		local left = leftRight:Add("Panel")
		left:Dock(LEFT)
		left:SetWide(SScaleMin(391 / 3))
		left:DockMargin(0, 0, SScaleMin(8 / 3), 0)

		local right = leftRight:Add("Panel")
		right:Dock(FILL)

		self.imageButton = self:CreateSelectorButton(right, SScaleMin(650 / 3), SScaleMin(555 / 3), TOP, 0, 0, 0, 0, nil, "SELECT IMAGE", function()
			-- if self.cracked then LocalPlayer():Notify("You cannot add images to cracked newspapers!") return end

			Derma_StringRequest(
				"URL (any pictures with sexually explicit content will get you banned)",
				"Input the URL to the image you want to be shown.",
				"",
				function(url)
					self.imageButton.OnRequest(url)
				end,
				nil
			)
		end)
		self.imageButton:SetZPos(3)
		self.imageButton.OnRequest = function(url)
			self.imageButton:Remove()
			local linkedImage = self:CreateLinkedImage(right, SScaleMin(650 / 3), SScaleMin(555 / 3), TOP, 0, 0, 0, 0, nil, url)
			linkedImage:SetZPos(3)
			self.image = url
		end

		self.articleTitle = self:CreateTextEntry(left, nil, SScaleMin(60 / 3), TOP, 0, 0, 0, 0, nil, "AdobeCaslonProBold", 30, false, true, "", nil, "HEADLINE")
		self.articleTitle:SetZPos(4)
		self.articleTitle.bAlignLeft = true

		local articleContentPanel = left:Add("Panel")
		articleContentPanel:Dock(TOP)
		articleContentPanel:SetTall(SScaleMin(100 / 3))
		articleContentPanel:SetZPos(5)

		self.articleText1 = self:CreateTextEntry(articleContentPanel, (SScaleMin(534 / 3) / 2) + SScaleMin(64 / 3), SScaleMin(60 / 3), LEFT, 0, 0, 0, 0, nil, "LusitanaSmall", 156, true, true, "", nil, "Article text goes here")
		self.articleText1:SetZPos(6)
		--self.articleText1.bAlignTopLeft = true
		self.articleText1.fixedHeight = false

		self.articleAuthor = self:CreateTextEntry(left, nil, SScaleMin(28 / 3), TOP, 0, SScaleMin(56 / 3), 0, SScaleMin(5 / 3), nil, "MinionProBold", 45, false, true, "", nil, string.upper("James Hawke"))
		self.articleAuthor:SetZPos(7)
		self.articleAuthor.bAlignLeft = true

		local articleContentPanel2 = left:Add("Panel")
		articleContentPanel2:Dock(TOP)
		articleContentPanel2:SetTall(SScaleMin(385 / 3))
		articleContentPanel2:SetZPos(8)

		self.articleText2 = self:CreateTextEntry(articleContentPanel2, (SScaleMin(534 / 3) / 2) + SScaleMin(128 / 3), nil, LEFT, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 1453, true, true, "", nil, "Article text goes here")
		self.articleText2:SetZPos(9)
		self.articleText2.bAlignTopLeft = true
		self.articleText2:DockMargin(-SScaleMin(3 / 3), 0, 0, 0)

		local articleContentPanel3 = right:Add("Panel")
		articleContentPanel3:Dock(TOP)
		articleContentPanel3:SetTall(SScaleMin(80 / 3))
		articleContentPanel3:SetZPos(10)

		self.articleText3 = self:CreateTextEntry(articleContentPanel3, (SScaleMin(534 / 3) / 2) + SScaleMin(128 / 3), nil, LEFT, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 190, true, true, "", nil, "Article text goes here")
		self.articleText3:SetZPos(11)
		self.articleText3.bAlignTopLeft = true
		self.articleText3:DockMargin(-SScaleMin(3 / 3), 0, 0, 0)

		local adContents = bottomContents:Add("Panel")
		adContents:Dock(LEFT)
		adContents:SetWide(SScaleMin(255 / 3))

		local rightContents = bottomContents:Add("Panel")
		rightContents:Dock(FILL)

		self.advert = self:CreateTextEntry(adContents, nil, SScaleMin(60 / 3), TOP, 0, 0, 0, 0, nil, "LusitanaTitle", 30, false, true, "", nil, "ADVERT")
		self.advert:SetZPos(12)

		self.advertName = self:CreateTextEntry(adContents, nil, SScaleMin(30 / 3), TOP, 0, 0, 0, 0, nil, "LusitanaItalic", 30, false, true, "", nil, "ADVERT NAME!")
		self.advertName:SetZPos(13)
		self.advertName:Dock(TOP)

		self.adPanel = adContents:Add("Panel")
		self.adPanel:Dock(BOTTOM)
		self.adPanel:DockMargin(SScaleMin(24 / 3), 0, SScaleMin(24 / 3), 0)
		self.adPanel:SetTall(SScaleMin(144 / 3))

		self.adImageButton = self:CreateSelectorButton(self.adPanel, SScaleMin(105 / 3), SScaleMin(105 / 3), FILL, 0, 0, 0, 0, nil, "SELECT IMAGE", function()
			-- if self.cracked then LocalPlayer():Notify("You cannot add images to cracked newspapers!") return end
			self:CreateAdSelector(self.adPanel)
		end)

		local articleContentPanel4 = adContents:Add("Panel")
		articleContentPanel4:Dock(FILL)

		self.advertArticle = self:CreateTextEntry(articleContentPanel4, (SScaleMin(534 / 3) / 2) - SScaleMin(24 / 3), nil, LEFT, SScaleMin(9 / 3), 0, SScaleMin(3 / 3), 0, nil, "AbrilTitlingRegular", 279, true, true, "", nil, "Article text goes here")
		self.advertArticle.bAlignTopLeft = true

		self.rightHeadline = self:CreateTextEntry(rightContents,  SScaleMin(96 / 3), SScaleMin(48 / 3), TOP, SScaleMin(48 / 3), 0, 0, 0, nil, "LusitanaTitle", 30, false, true, "", nil, "HEADLINE")
		self.rightHeadline:SetZPos(14)
		self.rightHeadline:SetTextColor(Color(244, 244, 244, 255))
		self.rightHeadline.fixedHeight = false

		local articleContentPanel5 = rightContents:Add("Panel")
		articleContentPanel5:Dock(LEFT)
		articleContentPanel5:SetZPos(15)
		articleContentPanel5:DockMargin(SScaleMin(6 / 3), SScaleMin(2 / 3), 0, SScaleMin(6 / 3))
		articleContentPanel5:SetWide(SScaleMin(272 / 3))

		self.articleText4 = self:CreateTextEntry(articleContentPanel5, (SScaleMin(534 / 3) / 2) + SScaleMin(2 / 3), nil, LEFT, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 791, true, true, "", nil, "Article text goes here")
		self.articleText4:SetZPos(16)
		self.articleText4.bAlignTopLeft = true
		self.articleText4:DockMargin(-SScaleMin(3 / 3), 0, 0, 0)

		local articleContentPanel6 = rightContents:Add("Panel")
		articleContentPanel6:Dock(TOP)
		articleContentPanel6:SetZPos(17)
		articleContentPanel6:DockMargin(SScaleMin(6 / 3), SScaleMin(2 / 3), SScaleMin(6 / 3), SScaleMin(24 / 3))
		articleContentPanel6:SetTall(SScaleMin(75 / 3))

		self.articleText5 = self:CreateTextEntry(articleContentPanel6, (SScaleMin(534 / 3) / 2) + SScaleMin(2 / 3), nil, LEFT, 0, 0, 0, 0, nil, "AbrilTitlingRegular", 160, true, true, "", nil, "Article text goes here")
		self.articleText5:SetZPos(17)
		self.articleText5.bAlignTopLeft = true
		self.articleText5:DockMargin(-SScaleMin(3 / 3), 0, 0, 0)

		self.articleAuthor2 = self:CreateTextEntry(rightContents, nil, SScaleMin(18 / 3), TOP, SScaleMin(90 / 3), -SScaleMin(9 / 3), 0, SScaleMin(5 / 3), nil, "MinionProBold", 45, false, true, "", nil, string.upper("James Hawke"))
		self.articleAuthor2:SetZPos(18)
		self.articleAuthor2.bAlignLeft = true

		self.imageButton2 = self:CreateSelectorButton(rightContents, SScaleMin(80 / 3), SScaleMin(190 / 3), TOP, SScaleMin(4 / 3), SScaleMin(8 / 3), SScaleMin(14 / 3), 0, nil, "SELECT IMAGE", function()
			-- if self.cracked then LocalPlayer():Notify("You cannot add images to cracked newspapers!") return end

			Derma_StringRequest(
				"URL (any pictures with sexually explicit content will get you banned)",
				"Input the URL to the image you want to be shown.",
				"",
				function(url)
					self.imageButton2.OnRequest(url)
				end,
				nil
			)
		end)
		self.imageButton2:SetZPos(19)
		self.imageButton2.OnRequest = function(url)
			self.imageButton2:Remove()
			local linkedImage = self:CreateLinkedImage(rightContents, SScaleMin(80 / 3), SScaleMin(190 / 3), TOP, SScaleMin(4 / 3), SScaleMin(8 / 3), SScaleMin(14 / 3), 0, nil, url)
			linkedImage:SetZPos(19)
			self.image2 = url
		end

		local sloganLR = self.mainPanel:Add("Panel")
		sloganLR:Dock(BOTTOM)
		sloganLR:DockMargin(SScaleMin(204 / 3), 0, SScaleMin(204 / 3), SScaleMin(16 / 3))


		sloganLR:SetZPos(-1)

		self.sloganL = self:CreateTextEntry(sloganLR, SScaleMin(176 / 3), SScaleMin(16 / 3), LEFT, SScaleMin(44 / 3), 0, 0, 0, nil, "MinionProBold", 45, false, true, "", nil, string.upper("The Genevan Tribune"))
		self.sloganL:SetZPos(20)
		self.sloganL.bAlignRight = true
		self.sloganL.fixedHeight = false

		self.sloganR = self:CreateTextEntry(sloganLR, SScaleMin(204 / 3), SScaleMin(16 / 3), RIGHT, 0, 0, 0, 0, nil, "MinionProBold", 45, false, true, "", nil, string.upper("FORWARD FROM GENEVA"))
		self.sloganR:SetZPos(20)
		self.sloganR.bAlignLeft = true
		self.sloganR.fixedHeight = false

		local optionBot = self:CreateOptionPanel(self, BOTTOM)
		optionBot:DockMargin(ScrW() / 2 - self.surrounder:GetWide() / 2, 0, ScrW() / 2 - self.surrounder:GetWide() / 2, padding / 2)
		self:CreateOption(optionBot, LEFT, "PREVIEW", function(button)

			self:TogglePreview(button)
			button:SetVisible(true)
		end, 0, 0, 0, 0)

		self:CreateOption(optionBot, RIGHT, "PRINT", function(button)
			netstream.Start("ixWritingAddWriting", self.identifier, {
				headlineText = self.headlineText:GetText(),
				date = self.date:GetText(),
				bigHeadline = self.bigHeadline:GetValue(),
				subHeadline = self.subHeadline:GetValue(),
				image = self.image or "",
				articleTitle = self.articleTitle:GetValue(),
				articleAuthor = self.articleAuthor:GetValue(),
				articleText1 = self.articleText1:GetValue(),
				articleText2 = self.articleText2:GetValue(),
				articleText3 = self.articleText3:GetValue(),
				articleText4 = self.articleText4:GetValue(),
				articleText5 = self.articleText5:GetValue(),
				advert = self.advert:GetValue(),
				advertName = self.advertName:GetValue(),
				advertArticle = self.advertArticle:GetValue(),
				sloganL = self.sloganL:GetValue(),
				sloganR = self.sloganR:GetValue(),
				image2 = self.image2 or "",
				articleAuthor2 = self.articleAuthor2:GetValue(),
				rightHeadline = self.rightHeadline:GetValue(),
				template = "The Genevan Tribune",
				adMaterial = self.adMaterial or "",
				unionDatabase = self.unionDatabase and self.unionDatabase:GetChecked() or false
			}, self.itemID)
			self:Remove()
		end, 0, 0, 0, 0)
	end
	self:RegisterTemplate("The Genevan Tribune", GenevanTribute)
	self.surrounder = self:CreateMainPanel(SScaleMin(900 / 3), SScaleMin(980 / 3), true)
end

function PANEL:CreateDropdownMenu()
	self.dropdown = self.optionTop:Add("DComboBox")
	self.dropdown:SetValue("Background")
	for newspaper, info in pairs(self.templates) do
		self.dropdown:AddChoice(newspaper)
	end
	self.dropdown.OnSelect = function( s, index, value )
		self.mainPanel:Remove()
		for _, optPanel in pairs(self.optionPanels) do
			optPanel:Remove()
		end
		self.optionPanels = {}

		self:BuildContents(value)

		if (self.data or (!self.data and self.tNewspaper)) then
			self:Populate(self.itemID, self.identifier, self.nData, self.tNewspaper, true)
		end

	end
	self.dropdown:Dock(LEFT)
	self.dropdown:SizeToContents()
end

function PANEL:BuildContents(template)
	if self.templates[template] then
		self.templates[template].create()
		if self.optionTop then
			self.exit = self:CreateExitButton(self.optionTop, RIGHT, 0, 0, 0, 0)
			self.exit.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")
				netstream.Start("ixWritingCloseNewspaperCreator", self.itemID)
				self:Remove()
			end
			self:CreateDropdownMenu()
		end
		self.newspaperTemplate = template
	end
end

function PANEL:Populate(itemID, identifier, data, tNewspaper, dropdownPopulate)
	local localChar = LocalPlayer():GetCharacter()
	if !localChar then return end
	local canRead = localChar:GetCanread()
	if !self.mainPanel then return end

	if (data) then
		for dermaName, value in pairs(data) do
			if string.find(dermaName, "image") then
				if (string.find(dermaName, 2)) then
					self.imageButton2.OnRequest(value)
				else
					self.imageButton.OnRequest(value)
				end

				continue
			end

			if dermaName == "adMaterial" then
				if value and value != "" then
					self.adImageButton:Remove()
					self:CreateAdImage(self.adPanel, value)
				end
				continue
			end

			if !self[dermaName] then continue end
			self[dermaName]:SetText(canRead and value or Schema:ShuffleText(value))
		end

		if self.headlineText and self.headlineText:GetValue() == "" and self.newspaperTemplate then
			self.headlineText:SetText(self.newspaperTemplate)
		end
	end

	if !self.cracked and tNewspaper.builder then
		self:CreateDividerLine(self.optionPanels[2], LEFT)

		self.unionDatabase = self.optionPanels[2]:Add( "DCheckBoxLabel" )
		self.unionDatabase:Dock(LEFT)
		self.unionDatabase:SetText("")
		self.unionDatabase:SetValue( false )
		self.unionDatabase:SizeToContents()

		local unionDatabaseLabel = self.optionPanels[2]:Add( "DLabel" )
		unionDatabaseLabel:Dock(LEFT)
		unionDatabaseLabel:SetFont("MenuFontLargerBoldNoFix")
		unionDatabaseLabel:SetText("Upload to Union database")
		unionDatabaseLabel:SizeToContents()
	end

	if tNewspaper and tNewspaper.builder then return end

	if !tNewspaper.builder and self.dropdown then self.dropdown:Remove() end

	if dropdownPopulate then
		self.previewEnabled = false
	end

	self:TogglePreview()
end

function PANEL:CreateAdImage(parent, material)
	self.adImage = parent:Add("Panel")
	self.adImage:Dock(LEFT)
	self.adImage:SetSize(SScaleMin(105 / 3), SScaleMin(105 / 3))
	self.adImage:DockMargin(SScaleMin(47 / 3), SScaleMin(24 / 3), SScaleMin(54 / 3), SScaleMin(21 / 3))
	self.adImage.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial(material))
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.adMaterial = material
end

function PANEL:CreateAdSelector(adPanel)
	local selector = vgui.Create("DFrame")
	selector:SetSize(SScaleMin((105 * 3) / 3) + SScaleMin(10 / 3), SScaleMin((105 * 4) / 3) + SScaleMin(34 / 3))
	selector:Center()
	selector:SetTitle("Ad Image Selector")
	DFrameFixer(selector)

	local grid = selector:Add("DGrid")
	grid:Dock(FILL)
	grid:SetCols( 3 )
	grid:SetColWide( SScaleMin(105 / 3) )
	grid:SetRowHeight( SScaleMin(105 / 3) )

	for i = 1, 10 do
		local image = vgui.Create( "DButton" )
		image:SetText("")
		image:SetSize( SScaleMin(105 / 3), SScaleMin(105 / 3) )
		image.Paint = function(this, w, h)
			surface.SetDrawColor(color_white)
			surface.DrawRect(0, 0, w, h)

			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/writing/newspaper_icon_"..i..".png"))
			surface.DrawTexturedRect(0, 0, w, h)

			surface.SetDrawColor(color_black)
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		image.DoClick = function(button)
			self:CreateAdImage(adPanel, "willardnetworks/writing/newspaper_icon_"..i..".png")
			selector:Remove()
			self.adImageButton:Remove()
		end

		grid:AddItem( image )
	end
end

function PANEL:TogglePreview(button)
	if self.previewEnabled then
		if (button) then
			button:SetText("PREVIEW")
			button:SizeToContents()
		end

		for _, textPanel in pairs(self.textEntries) do
			if !IsValid(textPanel) then continue end
			textPanel:SetVisible(true)
			textPanel:SetKeyboardInputEnabled(true)
			textPanel:SetCursorColor(Color(0, 0, 0, 255))

			textPanel.shouldVoidPlaceholder = false
		end

		for _, label in pairs(self.labels) do
			if !IsValid(label) then continue end
			label:SetVisible(false)
		end

		for _, selector in pairs(self.selectorButtons) do
			if IsValid(selector) then
				if IsValid(selector.temp) then
					selector.temp:SetVisible(false)
				end

				selector:SetVisible(true)
			end
		end

		for _, option in pairs(self.options) do
			if !IsValid(option) then continue end
			if option:GetText() == "EXIT" then continue end
			option:SetVisible(true)
		end

		if self.dropdown then
			self.dropdown:SetVisible(true)
		end

		self.previewEnabled = false
	else
		if (button) then
			button:SetText("STOP PREVIEW")
			button:SizeToContents()
		end

		for _, textPanel in pairs(self.textEntries) do
			if !IsValid(textPanel) then continue end
			if textPanel.fixedHeight then
				self:ConvertTextEntryToLabel(textPanel:GetParent(), textPanel)
			else
				textPanel:SetKeyboardInputEnabled(false)
				textPanel:SetCursorColor(Color(0, 0, 0, 0))
			end

			textPanel.shouldVoidPlaceholder = true
		end

		for _, selector in pairs(self.selectorButtons) do
			if IsValid(selector) then
				local temp = selector:GetParent():Add("Panel")
				temp:Dock(selector:GetDock())
				temp:SetSize(selector:GetSize())
				temp:SetZPos(selector:GetZPos())
				temp:DockMargin(selector:GetDockMargin())

				selector:SetVisible(false)
				selector.temp = temp

				selector:SetVisible(false)
			end
		end

		for _, option in pairs(self.options) do
			if !IsValid(option) then continue end
			if option:GetText() == "EXIT" then continue end
			option:SetVisible(false)
		end

		if self.dropdown then
			self.dropdown:SetVisible(false)
		end

		self.previewEnabled = true
	end
end

vgui.Register("ixWritingNewspaper", PANEL, "ixWritingBase")