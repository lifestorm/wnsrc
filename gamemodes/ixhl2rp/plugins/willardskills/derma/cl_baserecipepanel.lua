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

local function CreateBoxPattern(self, w, h)
	surface.SetDrawColor(Color(0, 0, 0, 50))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(150, 150, 150, 20))
	surface.SetMaterial(ix.util.GetMaterial("willardnetworks/tabmenu/crafting/box_pattern.png"))
	surface.DrawTexturedRect(0, 0, w, h)

	surface.SetDrawColor(Color(100, 100, 100, 150))
	surface.DrawOutlinedRect(0, 0, w, h)
end

local PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()

	local firstTitle = parent:Add("DLabel")
	firstTitle:SetFont("TitlesFontNoClamp")
	firstTitle:SetText(parent.firstTitle or "")
	firstTitle:SetPos(SScaleMin(24 / 3))
	firstTitle:SizeToContents()

	local firstIcon = parent:Add("DImage")
	firstIcon:SetImage("willardnetworks/tabmenu/charmenu/licenses.png")
	firstIcon:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	firstIcon:SetPos(-2, firstTitle:GetTall() * 0.5 - firstIcon:GetTall() * 0.5)

	local secondIcon = parent:Add("DImage")
	secondIcon:SetImage("willardnetworks/tabmenu/navicons/crafting.png")
	secondIcon:SetSize(SScaleMin(18 / 3), SScaleMin(18 / 3))
	secondIcon:SetPos(parent:GetWide() / 3 - (SScaleMin(40 / 3) / 3) + secondIcon:GetWide() + SScaleMin(3 / 3), firstIcon:GetTall() * 0.5 - secondIcon:GetTall() * 0.5)

	local secondTitle = parent:Add("DLabel")
	secondTitle:SetFont("TitlesFontNoClamp")
	secondTitle:SetText(parent.secondTitle or "")
	secondTitle:SetPos(parent:GetWide() / 3 - (SScaleMin(40 / 3) / 3) + secondIcon:GetWide() + SScaleMin(27 / 3), 0 - SScaleMin(2 / 3))
	secondTitle:SizeToContents()

	local thirdIcon = parent:Add("DImage")
	thirdIcon:SetImage("willardnetworks/tabmenu/charmenu/name.png")
	thirdIcon:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	thirdIcon:SetPos(parent:GetWide() / 1.5 - (SScaleMin(40 / 3) / 3) + thirdIcon:GetWide() + SScaleMin(6 / 3), firstIcon:GetTall() * 0.5 - thirdIcon:GetTall() * 0.5)

	local thirdTitle = parent:Add("DLabel")
	thirdTitle:SetFont("TitlesFontNoClamp")
	thirdTitle:SetText(parent.thirdTitle or "")
	thirdTitle:SetPos(parent:GetWide() / 1.5 - (SScaleMin(40 / 3) / 3) + thirdIcon:GetWide() + SScaleMin(32 / 3), 0 - SScaleMin(2 / 3))
	thirdTitle:SizeToContents()

	if parent.skill == "guns" or parent.skill == "speed" or parent.skill == "melee" then
		secondIcon:SetVisible(false)
		thirdIcon:SetVisible(false)
		secondTitle:SetVisible(false)
		thirdTitle:SetVisible(false)
	end
end

vgui.Register("CraftingBaseTopTitleBase", PANEL, "Panel")

PANEL = {}
function PANEL:Init()
	local parent = self:GetParent()

	local innerContent = parent:Add("Panel")
	innerContent:SetSize(parent:GetWide(), parent:GetTall() - SScaleMin(30 / 3))
	innerContent:SetPos(0, SScaleMin(30 / 3))

	local marginDivider = (SScaleMin(40 / 3) / 3) -- two panels use 20 right margin, divide with 3 for proper size
	local oneContentSizeX, oneContentSizeY = innerContent:GetWide() / 3 - marginDivider, innerContent:GetTall()

	-- "Recipes" panel
	parent.firstPanel = innerContent:Add("DScrollPanel")
	parent.firstPanel:Dock(LEFT)
	parent.firstPanel:DockMargin(0, 0, SScaleMin(20 / 3), 0)
	parent.firstPanel:SetSize(oneContentSizeX, oneContentSizeY)
	parent.firstPanel.Paint = function(panel, w, h)
		CreateBoxPattern(panel, w, h)
	end

	parent.firstPanel.categories = {}

	-- "Crafting" Panel
	parent.secondPanel = innerContent:Add("Panel")
	parent.secondPanel:Dock(LEFT)
	parent.secondPanel:DockMargin(0, 0, SScaleMin(20 / 3), 0)
	parent.secondPanel:SetSize(oneContentSizeX, oneContentSizeY)
	parent.secondPanel.Paint = function(panel, w, h)
		CreateBoxPattern(panel, w, h)
	end

	parent.secondPanel.EmptyText = parent.secondPanel:Add("DLabel")
	parent.secondPanel.EmptyText:SetFont("MenuFontLargerBoldNoFix")
	parent.secondPanel.EmptyText:SetText(parent.nothingSelected or "")
	parent.secondPanel.EmptyText:SizeToContents()
	parent.secondPanel.EmptyText:Center()

	-- Preview Panel
	parent.preview = innerContent:Add("Panel")
	parent.preview:Dock(LEFT)
	parent.preview:SetSize(oneContentSizeX, oneContentSizeY)
	parent.preview.Paint = function(panel, w, h)
		CreateBoxPattern(panel, w, h)
	end

	parent.preview.EmptyText = parent.preview:Add("DLabel")
	parent.preview.EmptyText:SetFont("MenuFontLargerBoldNoFix")
	parent.preview.EmptyText:SetText(parent.nothingSelected or "")
	parent.preview.EmptyText:SizeToContents()
	parent.preview.EmptyText:Center()

	parent.previewModelFrame = parent.preview:Add("Panel")
	parent.previewModelFrame:SetSize(parent.preview:GetSize())

	parent.model = parent.previewModelFrame:Add("DModelPanel")
	parent.model:SetVisible(false)

	if parent.skill == "guns" or parent.skill == "speed" then
		parent.secondPanel:SetVisible(false)
		parent.preview:SetVisible(false)
		parent.firstPanel:SetSize(oneContentSizeX * 3 + SScaleMin(40 / 3), oneContentSizeY * 3)

		local boxPattern = Material("willardnetworks/tabmenu/crafting/box_pattern.png", "noclamp")
		parent.firstPanel.Paint = function(_, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 50))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(150, 150, 150, 20))
			surface.SetMaterial(boxPattern)
			surface.DrawTexturedRectUV( 0, 0, w, h, 0, 0, w / SScaleMin(414 / 3), h / SScaleMin(677 / 3) )

			surface.SetDrawColor(Color(100, 100, 100, 150))
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end
end

vgui.Register("CraftingBaseInnerContent", PANEL, "Panel")

PANEL = {}
local sortFuncCat = function(a, b)
	return a.category < b.category
end

function PANEL:CreateRecipeCategories(query)
	local parent = self:GetParent()
	local categories = {}
	local recipesList = {}

	for _, recipe in pairs(ix.recipe:GetAll()) do
		if (query) then
			if recipe.name then
				query = string.gsub(query, "[^%w%s]+", "")
				
				if !string.lower(recipe.name):find(query) then continue end
			end
		end

		if (ix.recipe:CanPlayerSeeRecipe(recipe)) then
			if recipe.skill == self:GetParent().skill then
				local list = recipesList[recipe.category] or {recipes = {}, subcategories = {}}
				if (recipe.subcategory) then
					list.subcategories[recipe.subcategory] = list.subcategories[recipe.subcategory] or {}

					table.insert(list.subcategories[recipe.subcategory], recipe)
				else
					list.recipes[#list.recipes + 1] = recipe
				end

				recipesList[recipe.category] = list
			end
		end
	end

	for category, recipeList in pairs(recipesList) do
		categories[#categories + 1] = {
			recipesList = recipeList,
			category = category
		}
		table.SortByMember( recipeList.recipes, "level", true )

		local subCategoryList = {}
		for subCategory, subCatRecipeList in pairs(recipeList.subcategories) do
			subCategoryList[#subCategoryList + 1] = {
				recipesList = subCatRecipeList,
				category = subCategory
			}
			table.SortByMember( subCatRecipeList, "level", true )
		end


		recipeList.subcategories = subCategoryList
		table.sort(recipeList.subcategories, sortFuncCat)
	end

	table.sort(categories, sortFuncCat)

	PLUGIN:PlayerCraftingRebuilt(parent, categories)

	-- Collapsible Categories
	for k, v in ipairs(categories) do
		local collapsibleCategory = vgui.Create( "DCollapsibleCategory", parent.firstPanel)
		collapsibleCategory:Dock(TOP)
		collapsibleCategory:SetTall(SScaleMin(20 / 3))
		collapsibleCategory:SetZPos(k)

		if k == 1 then
			collapsibleCategory:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
		else
			collapsibleCategory:DockMargin(0, 0, 0, SScaleMin(10 / 3))
		end

		collapsibleCategory:SetLabel("")
		collapsibleCategory:SetExpanded( false )
		collapsibleCategory.Paint = function(_, w, h)
			if collapsibleCategory:GetExpanded() then
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.SetMaterial( ix.util.GetMaterial("willardnetworks/tabmenu/crafting/minus.png"))
				surface.DrawTexturedRect(SScaleMin(20 / 3), SScaleMin(20 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(15 / 3))
			else
				surface.SetDrawColor(Color(255, 255, 255, 255))
				surface.SetMaterial( ix.util.GetMaterial("willardnetworks/tabmenu/crafting/plus.png"))
				surface.DrawTexturedRect(SScaleMin(20 / 3), SScaleMin(20 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(15 / 3))
			end
		end

		collapsibleCategory:GetChildren()[1]:SetHeight(SScaleMin(20 / 3))

		local categoryTitle = vgui.Create("DLabel", collapsibleCategory)
		categoryTitle:SetText(v.category)
		categoryTitle:SetFont("MenuFontLargerBoldNoFix")
		categoryTitle:SizeToContents()
		categoryTitle:SetPos(SScaleMin(45 / 3), collapsibleCategory:GetTall() * 0.5 - categoryTitle:GetTall() * 0.5)

		local categoryList = vgui.Create("DScrollPanel", collapsibleCategory)
			categoryList:Dock(FILL)
		collapsibleCategory:SetContents(categoryList)


		if (v.category == "Level Unlocks") then
			for _, recipe in SortedPairsByMemberValue(v.recipesList.recipes, "name") do
				parent.recipeData = {
					recipe = recipe
				}

				categoryList:AddItem(vgui.Create("ixCraftingItem", parent))
			end
		else
			for _, recipe in ipairs(v.recipesList.recipes) do
				parent.recipeData = {
					recipe = recipe
				}

				categoryList:AddItem(vgui.Create("ixCraftingItem", parent))
			end
		end

		for _, v2 in ipairs(v.recipesList.subcategories) do
			local collapsibleSubCategory = vgui.Create("DCollapsibleCategory", categoryList)
			collapsibleSubCategory:Dock(TOP)
			collapsibleSubCategory:SetLabel("")
			collapsibleSubCategory:DockMargin(0, SScaleMin(5 / 3), 0, 0)
			collapsibleSubCategory:SetExpanded( false )
			collapsibleSubCategory:SetTall(SScaleMin(20 / 3))
			collapsibleSubCategory.Paint = function(_, w, h)
				if collapsibleSubCategory:GetExpanded() then
					surface.SetDrawColor(Color(255, 255, 255, 255))
					surface.SetMaterial( ix.util.GetMaterial("willardnetworks/tabmenu/crafting/minus.png"))
					surface.DrawTexturedRect(SScaleMin(35 / 3), SScaleMin(20 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(15 / 3))
				else
					surface.SetDrawColor(Color(255, 255, 255, 255))
					surface.SetMaterial( ix.util.GetMaterial("willardnetworks/tabmenu/crafting/plus.png"))
					surface.DrawTexturedRect(SScaleMin(35 / 3), SScaleMin(20 / 3) * 0.5 - SScaleMin(15 / 3) * 0.5, SScaleMin(15 / 3), SScaleMin(15 / 3))
				end
			end
			collapsibleSubCategory.name = v2.category

			collapsibleSubCategory:GetChildren()[1]:SetHeight(SScaleMin(20 / 3))

			local subcategoryTitle = vgui.Create("DLabel", collapsibleSubCategory)
			subcategoryTitle:SetText(v2.category)
			subcategoryTitle:SetFont("MenuFontLargerNoClamp")
			subcategoryTitle:SizeToContents()
			subcategoryTitle:SetPos(SScaleMin(60 / 3), collapsibleSubCategory:GetTall() * 0.5 - subcategoryTitle:GetTall() * 0.5 + SScaleMin(1 / 3))

			local subcategoryList = vgui.Create("DScrollPanel", collapsibleSubCategory)
				subcategoryList:Dock(FILL)
				subcategoryList.name = v2.category
			collapsibleSubCategory:SetContents(subcategoryList)

			for _, recipe in ipairs(v2.recipesList) do
				parent.recipeData = {
					recipe = recipe
				}

				subcategoryList:AddItem(vgui.Create("ixCraftingItem", parent))
			end
		end

		parent.firstPanel.categories[#parent.firstPanel.categories + 1] = collapsibleCategory
	end
end

function PANEL:Init()
	local parent = self:GetParent()
	if parent.skill != "guns" and parent.skill != "speed" and parent.skill != "melee" then
		local search = parent.firstPanel:Add("DTextEntry")
		search:Dock(TOP)
		search:SetFont("MenuFontNoClamp")
		search:SetTall(SScaleMin(30 / 3))
		search:DockMargin(SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(20 / 3), SScaleMin(0 / 3))
		search:SetPlaceholderText("Search for something...")
		search:SetTextColor(Color(200, 200, 200, 255))
		search:SetCursorColor(Color(200, 200, 200, 255))
		search:SetFont("MenuFontNoClamp")
		search:SetZPos(0)
		search:SetText("")
		search.Paint = function(panel, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)

			if ( panel.GetPlaceholderText and panel.GetPlaceholderColor and panel:GetPlaceholderText() and
				panel:GetPlaceholderText():Trim() != "" and panel:GetPlaceholderColor() and ( !panel:GetText() or panel:GetText() == "" ) ) then

				local oldText = panel:GetText()

				local str = panel:GetPlaceholderText()
				if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
				str = language.GetPhrase( str )

				panel:SetText( str )
				panel:DrawTextEntryText( panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
				panel:SetText( oldText )

				return
			end

			panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
		end
	

		search.OnChange = function(this)
			local text = this:GetValue()
			for _, v in pairs(parent.firstPanel.categories) do
				v:Remove()
			end

			self:CreateRecipeCategories(text:utf8lower())
		end
	end

	self:CreateRecipeCategories()

	-- Actual crafting info
	-- Using 1080p as standard size
	local SScaleMin100 = SScaleMin(33.333333)
	local SScaleMin110 = SScaleMin(110 / 3)
	local SScaleMin60 = SScaleMin(20)
	local SScaleMinPadding = SScaleMin(6.66666)

	parent.craftingFrame = parent.secondPanel:Add("Panel")
	parent.craftingFrame:SetSize(parent.secondPanel:GetWide() - SScaleMin60, parent.secondPanel:GetTall() - SScaleMin60)
	parent.craftingFrame:Center()

	parent.craftingTopFrame = parent.craftingFrame:Add("Panel")
	parent.craftingTopFrame:Dock(TOP)
	parent.craftingTopFrame:DockMargin(0, 0, 0, SScaleMinPadding)
	parent.craftingTopFrame:SetSize(parent.craftingFrame:GetWide(), SScaleMin110)

	parent.iconFrame = parent.craftingTopFrame:Add("Panel")
	parent.iconFrame:Dock(LEFT)
	parent.iconFrame:SetSize(SScaleMin110, SScaleMin110)

	parent.itemIcon = parent.iconFrame:Add("ixItemIconAdvanced")
	parent.itemIcon:SetModel("");
	parent.itemIcon:SetSize(SScaleMin100, SScaleMin100)
	parent.itemIcon:SetVisible(false)
	parent.itemIcon.PaintOver = function(_, w, h) end
	parent.itemIcon:Center()

	parent.resultAmount = parent.itemIcon:Add("DLabel")
	parent.resultAmount:SetFont("MenuFontLargerNoClamp")
	parent.resultAmount:SetVisible(false)

	parent.craftingTextFrame = parent.craftingTopFrame:Add("DScrollPanel")
	parent.craftingTextFrame:Dock(LEFT)
	parent.craftingTextFrame:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	parent.craftingTextFrame:SetSize(parent.craftingFrame:GetWide() - SScaleMin110 - SScaleMin(10 / 3), SScaleMin110)

	parent.itemTitle = parent.craftingTextFrame:Add("DLabel")
	parent.itemTitle:SetVisible(false)

	parent.itemDesc = parent.craftingTextFrame:Add("DLabel")
	parent.itemDesc:SetVisible(false)

	parent.itemLevelUp = parent.craftingTextFrame:Add("DLabel")
	parent.itemLevelUp:SetVisible(false)

	if (parent.recipeData.recipe.skill == "smuggling") then
		parent.itemLevelUpBuy = parent.craftingTextFrame:Add("DLabel")
		parent.itemLevelUpBuy:SetVisible(false)
	end

	parent.craftingAttributeFrame = parent.craftingFrame:Add("Panel")
	parent.craftingAttributeFrame:SetSize(parent.craftingFrame:GetWide(), 0)
	parent.craftingAttributeFrame:Dock(TOP)
	parent.craftingAttributeFrame:SetVisible(false)
	parent.craftingAttributeFrame.Paint = function(_, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 150))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(100, 100, 100, 150))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	parent.craftingAttributeFrame.title = parent.craftingAttributeFrame:Add("DLabel")
	parent.craftingAttributeFrame.title:Dock(TOP)
	parent.craftingAttributeFrame.title:SetText("Boosts:")
	parent.craftingAttributeFrame.title:SetTextColor(Color(255, 204, 0, 255))
	parent.craftingAttributeFrame.title:SetContentAlignment(5)
	parent.craftingAttributeFrame.title:SetFont("MenuFontLargerBoldNoFix")
	parent.craftingAttributeFrame.title:DockMargin(0, SScaleMin(9 / 3), 0, 0)
	parent.craftingAttributeFrame.title:SizeToContents()

	parent.craftingAttributeText = parent.craftingAttributeFrame:Add("DLabel")
	parent.craftingAttributeText:SetText("This item offers no attribute boosts")
	parent.craftingAttributeText:SetFont("MenuFontLargerNoClamp")
	parent.craftingAttributeText:SetContentAlignment(5)
	parent.craftingAttributeText:Dock(TOP)
	parent.craftingAttributeText:SizeToContents()

	if parent.recipeData.recipe.cost then
		parent.costFrame = parent.craftingFrame:Add("Panel")
		parent.costFrame:Dock(TOP)
		parent.costFrame:SetTall(SScaleMin(20 / 3))
		parent.costFrame:SetVisible(false)
		parent.costFrame:DockMargin(0, 0, 0, SScaleMinPadding)
	end

	if parent.recipeData.recipe.buyPrice then
		parent.buyFrame = parent.craftingFrame:Add("Panel")
		parent.buyFrame:Dock(TOP)
		parent.buyFrame:SetTall(SScaleMin(20 / 3))
		parent.buyFrame:SetVisible(false)
		parent.buyFrame:DockMargin(0, 0, 0, SScaleMinPadding)
	end

	parent.requirementsFrame = parent.craftingFrame:Add("Panel")
	parent.requirementsFrame:SetSize(parent.craftingFrame:GetWide(), SScaleMin(70 / 3))
	parent.requirementsFrame:Dock(TOP)
	parent.requirementsFrame:SetVisible(false)

	if self:GetParent().skill == "crafting" or self:GetParent().skill == "cooking"
	or self:GetParent().skill == "chemistry" or self:GetParent().skill == "medicine" then
		local stationsPanel = parent.requirementsFrame:Add("Panel")
		stationsPanel:Dock(TOP)
		stationsPanel:SetTall(SScaleMin(20 / 3))

		parent.stationsTitle = stationsPanel:Add("DLabel")
		parent.stationsTitle:SetFont("MenuFontLargerNoClamp")
		parent.stationsTitle:SetText(parent.stationsTitleText or "Stations: ")
		parent.stationsTitle:SetTextColor(Color(255, 204, 0, 255))
		parent.stationsTitle:Dock(LEFT)
		parent.stationsTitle:SizeToContents()

		parent.stationsText = stationsPanel:Add("DLabel")
		parent.stationsText:Dock(LEFT)
		parent.stationsText:SetText("")

		local toolsPanel = parent.requirementsFrame:Add("Panel")
		toolsPanel:Dock(TOP)
		toolsPanel:SetTall(SScaleMin(20 / 3))

		parent.toolsTitle = toolsPanel:Add("DLabel")
		parent.toolsTitle:SetFont("MenuFontLargerNoClamp")
		parent.toolsTitle:SetText(parent.toolsTitleText or "Tools: ")
		parent.toolsTitle:SetTextColor(Color(255, 204, 0, 255))
		parent.toolsTitle:Dock(LEFT)
		parent.toolsTitle:SizeToContents()

		parent.toolsText = toolsPanel:Add("DLabel")
		parent.toolsText:Dock(LEFT)
		parent.toolsText:SetText("")

		parent.ingredientsTitle = parent.requirementsFrame:Add("DLabel")
		parent.ingredientsTitle:SetFont("MenuFontLargerNoClamp")
		parent.ingredientsTitle:SetText(parent.ingredientsTitleText or "Ingredients:")
		parent.ingredientsTitle:SetTextColor(Color(255, 204, 0, 255))
		parent.ingredientsTitle:Dock(TOP)
		parent.ingredientsTitle:SizeToContents()
		parent.ingredients = parent.craftingFrame:Add("DScrollPanel")
		parent.ingredients:Dock(FILL)
		parent.ingredients:DockMargin(0, 0, 0, SScaleMinPadding)
	end

	if (parent.recipeData.recipe.cost) then
		parent.requirementsFrame:SetSize(parent.craftingFrame:GetWide(), SScaleMin(100 / 3))
		if (parent.recipeData.recipe.skill == "bartering") then
			local stockFrame = parent.requirementsFrame:Add("Panel")
			stockFrame:Dock(TOP)
			stockFrame:SetTall(SScaleMin(20 / 3))

			parent.stockTitle = stockFrame:Add("DLabel")
			parent.stockTitle:SetFont("MenuFontLargerNoClamp")
			parent.stockTitle:SetText(parent.stockTitleText or "Stock: ")
			parent.stockTitle:SetTextColor(Color(255, 204, 0, 255))
			parent.stockTitle:Dock(LEFT)
			parent.stockTitle:SizeToContents()

			parent.actualStock = stockFrame:Add("DLabel")
			parent.actualStock:SetFont("MenuFontLargerNoClamp")
			parent.actualStock:Dock(LEFT)

			local licensePanel = parent.requirementsFrame:Add("Panel")
			licensePanel:Dock(TOP)
			licensePanel:SetTall(SScaleMin(20 / 3))

			parent.licenseTitle = licensePanel:Add("DLabel")
			parent.licenseTitle:SetFont("MenuFontLargerNoClamp")
			parent.licenseTitle:SetText(parent.licenseTitleText or "License: ")
			parent.licenseTitle:SetTextColor(Color(255, 204, 0, 255))
			parent.licenseTitle:Dock(LEFT)
			parent.licenseTitle:SizeToContents()

			parent.licenseText = licensePanel:Add("DLabel")
			parent.licenseText:Dock(LEFT)
			parent.licenseText:SetText("")

			local buyAmountFrame = parent.requirementsFrame:Add("Panel")
			buyAmountFrame:Dock(TOP)
			buyAmountFrame:SetTall(SScaleMin(20 / 3))

			parent.amountTitle = buyAmountFrame:Add("DLabel")
			parent.amountTitle:SetFont("MenuFontLargerNoClamp")
			parent.amountTitle:SetText(parent.amountTitleText or "Buy Amount: ")
			parent.amountTitle:SetTextColor(Color(255, 204, 0, 255))
			parent.amountTitle:Dock(LEFT)
			parent.amountTitle:SizeToContents()

			parent.amount = buyAmountFrame:Add("DLabel")
			parent.amount:SetFont("MenuFontLargerNoClamp")
			parent.amount:Dock(LEFT)
		end

		if (parent.recipeData.recipe.skill == "bartering" or parent.recipeData.recipe.skill == "smuggling") then
			local infoTextPanel = parent.requirementsFrame:Add("Panel")
			infoTextPanel:Dock(TOP)
			infoTextPanel:DockMargin(0, 0, parent.requirementsFrame:GetWide() * 0.3, 0)
			infoTextPanel:SetTall(SScaleMin(40 / 3))

			parent.infoText = infoTextPanel:Add("DLabel")
			parent.infoText:SetFont("MenuFontNoClamp")
			if (parent.recipeData.recipe.skill == "smuggling") then
				parent.infoText:SetText("You need to find a smuggler in the sewers to buy and/or sell this item.")
			else
				parent.infoText:SetText("Bought items are picked up from pickup terminals found throughout the streets.")
			end
			parent.infoText:SetVisible(true)
			parent.infoText:SetWrap(true)
			parent.infoText:SetTextColor(Color(180, 180, 180, 255))
			parent.infoText:SetAutoStretchVertical(true)
			parent.infoText:Dock(TOP)
		end
	end

	if (parent.recipeData.recipe.skill != "smuggling") then
		parent.craftButton = parent.craftingFrame:Add("DButton")
		parent.craftButton:Dock(BOTTOM)
		parent.craftButton:SetVisible(false)
	end
end

vgui.Register("CraftingBaseRebuild", PANEL, "EditablePanel")

PANEL = {}
-- Called when the panel is initialized.
function PANEL:Init()
	local recipeData = self:GetParent().recipeData
		self:SetSize(self:GetParent():GetWide(), SScaleMin(20 / 3))
		self:Dock(TOP)
		self.recipe = recipeData.recipe
	PLUGIN:PlayerAdjustCraftingRecipe(self.recipe)

	self.recipeButton = self:Add("DButton")

	-- Called when the spawn icon is clicked.
	function self.recipeButton.DoClick(spawnIcon)
		if !self.recipe.noIngredients then
			surface.PlaySound("helix/ui/press.wav")
		end

		if (!self.recipe.license and !self.recipe.tools and !self.recipe.station and self.recipe.noIngredients) then
			return
		else
			-- Rebuilds crafting panel
			self:RebuildCrafting()
		end
	end

	self.recipeButton:SetContentAlignment(4)

	if recipeData.recipe.subcategory then
		self.recipeButton:SetTextInset(SScaleMin(61 / 3), 0)
	else
		self.recipeButton:SetTextInset(SScaleMin(45 / 3), 0)
	end

	self.recipeButton:SetFont("MenuFontLargerNoClamp")
	self.recipeButton:SetText(self.recipe.name)
	self.recipeButton:SetSize(self:GetParent():GetWide(), SScaleMin(20 / 3))

	self.recipeButton.OnCursorEntered = function()
		if !self.recipe.noIngredients then
			surface.PlaySound("helix/ui/rollover.wav")
		end
	end

	local character = LocalPlayer():GetCharacter()
	local result = character:GetResult("recipe_"..self.recipe.uniqueID)

	if (self.recipe.skill != "bartering") then
		if (result) and !self.recipe.noIngredients and self.recipe.level then
			if self.recipe.level <= character:GetSkillLevel(self.recipe.skill) then
				self.experienceText = self:Add("DLabel")
				self.experienceText:SetFont("MenuFontBoldNoClamp")
				self.experienceText:SetText(result.." xp")
				self.experienceText:SizeToContents()
				self.experienceText:SetPos(self:GetWide() * 0.3 - self.experienceText:GetWide())
			end
		end

		if self.recipe.level then
			if (self.recipe.level > character:GetSkillLevel(self.recipe.skill)) and !self.recipe.noIngredients then
				self.levelRequirement = self:Add("DLabel")
				self.levelRequirement:SetFont("MenuFontBoldNoClamp")
				self.levelRequirement:SetText("Requires level ".. self.recipe.level)
				self.levelRequirement:SizeToContents()
				self.levelRequirement:SetPos(self:GetWide() * 0.3 - self.levelRequirement:GetWide())
			end
		end
	else
		if (!character:HasPermit(self.recipe.category)) then
			self.permitRequirement = self:Add("DLabel")
			self.permitRequirement:SetFont("MenuFontBoldNoClamp")
			self.permitRequirement:SetText("Requires "..self.recipe.category.." permit")
			self.permitRequirement:SizeToContents()
			self.permitRequirement:SetPos(self:GetWide() * 0.3 - self.permitRequirement:GetWide())
		end
	end

	if self.recipe.noIngredients then
		self.levelRequirement = self:Add("DLabel")
		self.levelRequirement:SetFont("MenuFontBoldNoClamp")

		if self.recipe.skillScale then
			local scale = ix.skill.scale[self.recipe.skillScaleID]
			local scaleValue = tostring(math.Round(LocalPlayer():GetCharacter():GetSkillScale(scale.uniqueID), scale.digits))
			if (scale.percentage) then
				scaleValue = tostring(math.Round(LocalPlayer():GetCharacter():GetSkillScale(scale.uniqueID) * 100, scale.digits)).."%"
			end

			if (scale.add) then
			  scaleValue = "+"..scaleValue
			elseif (scale.multiply) then
			  scaleValue = "x"..scaleValue
			end

			self.levelRequirement:SetText(scaleValue)
		else
			self.levelRequirement:SetText("Requires level ".. self.recipe.level or "")
		end

		self.levelRequirement:SizeToContents()
		self.levelRequirement:SetPos(self:GetWide() * 0.3 - self.levelRequirement:GetWide())
	end
end

function PANEL:GetColor()
	local character = LocalPlayer():GetCharacter()
	local inventory = character:GetInventory()
	local color = Color(150, 150, 150, 255)
	if (self.recipe.skillScale) then
		if (ix.skill.scale[self.recipe.skillScaleID]) then
			local scale = ix.skill.scale[self.recipe.skillScaleID]
			if (character:GetSkillLevel(scale.skill) > scale.minLevel) then
				color = Color(255, 204, 0, 255)
			else
				color = Color(152, 243, 124, 255)
			end
		else
			color = Color(255, 204, 0, 255)
		end
	elseif (self.recipe.skill == "smuggling") then
		local result = character:GetResult("recipe_"..self.recipe.uniqueID)
		if (result and result >= 5) then
			color = Color(255, 204, 0, 255)
		elseif (result > 0) then
			color = Color(152, 243, 124, 255)
		end
	else
		if (ix.recipe:PlayerCanCraftRecipe(self.recipe, LocalPlayer(), inventory)) then
			if self.recipe.skill == "bartering" then
				return Color(255, 204, 0, 255)
			end

			local result = character:GetResult("recipe_"..self.recipe.uniqueID)
			if (result) and (result >= 5) then
				color = Color(255, 204, 0, 255)
			else
				color = Color(152, 243, 124, 255)
			end

			if self.recipe.noIngredients then
				color = Color(255, 204, 0, 255)
			end
		end
	end

	return color
end

function PANEL:Paint()
	local color = self:GetColor()

	self.recipeButton.Paint = function(panel, w, h)
		if panel:IsHovered() then
			panel:SetTextColor(color)
			if !self.recipe.noIngredients then
				local gradient = ix.util.GetMaterial("willardnetworks/tabmenu/crafting/leftgradient.png")
				surface.SetDrawColor(ColorAlpha(color_white, 22))
				surface.SetMaterial(gradient)
				surface.DrawTexturedRect(0, 0, panel:GetWide(), h)
			end
		end
	end
end

-- Called each frame.
function PANEL:Think()
	local color = self:GetColor()
	self.recipeButton:SetTextColor(color)

	if (self.experienceText) then
		self.experienceText:SetTextColor(self.recipeButton:GetTextColor())
	end

	if (self.levelRequirement) then
		self.levelRequirement:SetTextColor(self.recipeButton:GetTextColor())
	end

	if (self.permitRequirement) then
		self.permitRequirement:SetTextColor(self.recipeButton:GetTextColor())
	end
end

function PANEL:RebuildCrafting()
	local character = LocalPlayer():GetCharacter()
	local inventory = character:GetInventory()
	local parentFrame = ix.gui.activeSkill or self:GetParent()

	local model, skin = ix.recipe:GetIconInfo(self.recipe);
	parentFrame.itemIcon:SetModel(model, skin, "000000000");
	parentFrame.itemIcon:SetVisible(true)

	local result = ix.item.list[table.GetKeys(self.recipe.result)[1]]
	if result then
		local entity = parentFrame.itemIcon:GetEntity()
		parentFrame.itemIcon:SetColor(color_white)

		if (result.OnInventoryDraw) then
			result.OnInventoryDraw(result, entity)
		end

		if (result.iconCam) then
			parentFrame.itemIcon:SetCamPos(result.iconCam.pos)
			parentFrame.itemIcon:SetFOV(result.iconCam.fov)
			parentFrame.itemIcon:SetLookAng(result.iconCam.ang)
		else
			local pos = entity:GetPos()
			local camData = PositionSpawnIcon(entity, pos)

			if (camData) then
				parentFrame.itemIcon:SetCamPos(camData.origin)
				parentFrame.itemIcon:SetFOV(camData.fov)
				parentFrame.itemIcon:SetLookAng(camData.angles)
			end
		end
	end

	parentFrame.itemIcon.LayoutEntity = function() end

	local resultTbl = self.recipe.result
	if (resultTbl and !table.IsEmpty(resultTbl)) then
		local _, amount = next(resultTbl)
		parentFrame.resultAmount:SetText(amount)
		parentFrame.resultAmount:SetContentAlignment(6)
		parentFrame.resultAmount:SizeToContents()
		parentFrame.resultAmount:SetPos(parentFrame.itemIcon:GetWide() - parentFrame.resultAmount:GetWide() - 5, parentFrame.itemIcon:GetTall() - parentFrame.resultAmount:GetTall() + 4)
		parentFrame.resultAmount:SetVisible(true)
	end

	if parentFrame.ingredients then
		parentFrame.ingredients:Clear()
	end

	if parentFrame.costFrame then
		parentFrame.costFrame:Clear()
	end

	if parentFrame.buyFrame then
		parentFrame.buyFrame:Clear()
	end

	parentFrame.iconFrame.Paint = function(_, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 150))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(100, 100, 100, 150))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	if self.recipe.cost then
		local costParent = parentFrame.costFrame
		costParent:SetVisible(true)

		local costImage = costParent:Add("DImage")
		costImage:Dock(LEFT)
		costImage:SetImage(self.recipe.costIcon or "willardnetworks/tabmenu/charmenu/currency_icon.png")
		costImage:SetWide(SScaleMin(20 / 3))
		costImage:DockMargin(0, 0, SScaleMin(10 / 3), 0)

		local costText = costParent:Add("DLabel")
		costText:Dock(LEFT)
		if (self.recipe.skill == "smuggling") then
			costText:SetText("Buy: ")
		else
			costText:SetText("Cost: ")
		end
		costText:SetFont("SmallerTitleFontNoClamp")
		costText:SetTextColor(Color(255, 204, 0, 255))
		costText:SizeToContents()

		local actualCost = costParent:Add("DLabel")
		local multiplier = 1
		if (self.recipe.skill == "bartering") then
			multiplier = ix.config.Get("BarteringPriceMultiplier"..self.recipe.category) or 1
		end
		local recipeCost = isnumber(self.recipe.cost) and (self.recipe.cost * multiplier) or self.recipe.cost
		actualCost:Dock(LEFT)
		actualCost:SetText(recipeCost)
		actualCost:SetFont("SmallerTitleFontNoClamp")

		if self.recipe.skill == "bartering" then
			parentFrame.amount:SetText(self.recipe.buyAmount or 0)
			parentFrame.amount:SizeToContents()

			local recipeItem = self.recipe.result and next(self.recipe.result) or "piece_of_metal"
			local barteringStock = ix.city.main.items[recipeItem] and ix.city.main.items[recipeItem].amount or 0
			parentFrame.actualStock:SetText(barteringStock.." Available")
			parentFrame.actualStock:SizeToContents()
		end
	end

	if (self.recipe.buyPrice) then
		local costParent = parentFrame.costFrame
		costParent:SetVisible(true)

		local costImage = costParent:Add("DImage")
		costImage:Dock(LEFT)
		costImage:SetImage(self.recipe.costIcon or "willardnetworks/tabmenu/charmenu/currency_icon.png")
		costImage:SetWide(SScaleMin(20 / 3))
		costImage:DockMargin(0, 0, SScaleMin(10 / 3), 0)

		local costText = costParent:Add("DLabel")
		costText:Dock(LEFT)
		costText:SetText("Sell: ")
		costText:SetFont("SmallerTitleFontNoClamp")
		costText:SetTextColor(Color(255, 204, 0, 255))
		costText:SizeToContents()

		local actualCost = costParent:Add("DLabel")
		local recipeCost = self.recipe.buyPrice
		actualCost:Dock(LEFT)
		actualCost:SetText(recipeCost)
		actualCost:SetFont("SmallerTitleFontNoClamp")
	end

	self.recipe.ingredients = self.recipe.ingredients or {}


	for ingredient, amount in pairs(self.recipe.ingredients) do
		local item = ix.item.list[ingredient]
		if (!item) then continue end

		if parentFrame.ingredients then
			local ingredientsFrame = parentFrame.ingredients:Add("Panel")
			ingredientsFrame:SetSize(parentFrame.craftingFrame:GetWide(), SScaleMin(83 / 3))
			ingredientsFrame:Dock(TOP)
			ingredientsFrame:DockMargin(0, 0, 0, SScaleMin(10 / 3))
			ingredientsFrame.name = item.name

			parentFrame.ingredientIconFrame = ingredientsFrame:Add("Panel")
			parentFrame.ingredientIconFrame:Dock(LEFT)
			parentFrame.ingredientIconFrame:DockMargin(0, 0, 0, 0)
			parentFrame.ingredientIconFrame:SetSize(SScaleMin(100 / 3), SScaleMin(75 / 3))
			parentFrame.ingredientIconFrame.Paint = function(_, w, h)
				surface.SetDrawColor(Color(0, 0, 0, 150))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(100, 100, 100, 150))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

			parentFrame.ingredientItemIcon = parentFrame.ingredientIconFrame:Add("SpawnIcon")
			parentFrame.ingredientItemIcon:SetModel(item.model)
			parentFrame.ingredientItemIcon:SetSize(SScaleMin(50 / 3), SScaleMin(50 / 3))
			parentFrame.ingredientItemIcon:Center()
			parentFrame.ingredientItemIcon:SetVisible(true)
			parentFrame.ingredientItemIcon.PaintOver = function(_, w, h) end

			local ingredientAmount = inventory:GetItemCount(ingredient)
			parentFrame.ingredientItemText = parentFrame.ingredientIconFrame:Add("DLabel")
			parentFrame.ingredientItemText:SetFont("MenuFontLargerNoClamp")
			parentFrame.ingredientItemText:SetText(ingredientAmount.."/"..amount)
			parentFrame.ingredientItemText:SetContentAlignment(6)
			parentFrame.ingredientItemText:SizeToContents()
			parentFrame.ingredientItemText:SetPos(parentFrame.ingredientIconFrame:GetWide() - parentFrame.ingredientItemText:GetWide() - 5, parentFrame.ingredientIconFrame:GetTall() - parentFrame.ingredientItemText:GetTall() + 4)

			parentFrame.ingredientTextFrame = ingredientsFrame:Add("Panel")
			parentFrame.ingredientTextFrame:Dock(LEFT)
			parentFrame.ingredientTextFrame:DockMargin(0, 0, 0, 0)
			parentFrame.ingredientTextFrame:SetSize(parentFrame.craftingFrame:GetWide() - SScaleMin(100 / 3), SScaleMin(83 / 3))

			parentFrame.ingredientTitle = parentFrame.ingredientTextFrame:Add("DLabel")
			parentFrame.ingredientTitle:SetFont("SmallerTitleFontNoClamp")
			parentFrame.ingredientTitle:SetText(L(item.name))
			parentFrame.ingredientTitle:SetVisible(true)
			parentFrame.ingredientTitle:SetWide(parentFrame.craftingTextFrame:GetWide() - SScaleMin(10 / 3))
			parentFrame.ingredientTitle:SetWrap(true)
			parentFrame.ingredientTitle:SetAutoStretchVertical(true)
			parentFrame.ingredientTitle:Dock(TOP)
			parentFrame.ingredientTitle:DockMargin(SScaleMin(10 / 3), 0 - SScaleMin(4 / 3), 0, SScaleMin(5 / 3))

			parentFrame.ingredientDesc = parentFrame.ingredientTextFrame:Add("DLabel")
			parentFrame.ingredientDesc:SetFont("MenuFontLargerNoClamp")
			parentFrame.ingredientDesc:SetText(L(item.description))
			parentFrame.ingredientDesc:SetVisible(true)
			parentFrame.ingredientDesc:SetWide(parentFrame.craftingTextFrame:GetWide() - SScaleMin(10 / 3))
			parentFrame.ingredientDesc:SetWrap(true)
			parentFrame.ingredientDesc:SetAutoStretchVertical(true)
			parentFrame.ingredientDesc:Dock(TOP)
			parentFrame.ingredientDesc:DockMargin(SScaleMin(10 / 3), 0, 0, SScaleMin(5 / 3))

			parentFrame.craftButton.DoClick = function()
				surface.PlaySound("helix/ui/press.wav")

				netstream.Start("CraftRecipe", self.recipe.uniqueID, false)
				timer.Simple(0.1, function()
					if self and IsValid(self) and self.RebuildCrafting then
						self:RebuildCrafting()
					end
				end)

				if parentFrame.craftSound then
					surface.PlaySound(parentFrame.craftSound)
				end
			end
		end
	end

	if (parentFrame.craftButton) then
		parentFrame.craftButton:SetVisible(true)
		parentFrame.craftButton:SetFont("MenuFontLargerBoldNoFix")
		if self.recipe.skill == "bartering" then
			parentFrame.craftButton:SetText("Purchase "..self.recipe.name)
		else
			parentFrame.craftButton:SetText("Create "..self.recipe.name)
		end

		parentFrame.craftButton:SetTextColor(Color(50, 50, 50, 255))
		parentFrame.craftButton:SetSize(parentFrame.craftingFrame:GetWide(), SScaleMin(40 / 3))
		parentFrame.craftButton:Dock(BOTTOM)
		parentFrame.craftButton.Paint = function(_, w, h)
			surface.SetDrawColor(255, 204, 0, 255)
			surface.DrawRect(0, 0, w, h)
		end

		if !parentFrame.ingredients then
			parentFrame.craftButton.DoClick = function()
				local recipeItem = self.recipe.result and next(self.recipe.result) or "piece_of_metal"
				local barteringStock = false

				if self.recipe.skill == "bartering" then
					barteringStock = ix.city.main.items[recipeItem] and ix.city.main.items[recipeItem].amount or 0

					if table.Count(character:GetPurchasedItems()) == ix.config.Get("PickupDispenserMaxItems") then
						LocalPlayer():NotifyLocalized("You cannot purchase this item due to having too many items to pickup.")
						return
					end

					if !character:HasPermit(self.recipe.category) then
						LocalPlayer():NotifyLocalized("You do not have a permit!")
						return
					end

					local itemID = character:GetIdCard()
					if itemID then
						if ix.item.instances[itemID] then
							local credits = ix.item.instances[itemID]:GetCredits()

							if (credits < self.recipe.cost) then
								LocalPlayer():NotifyLocalized("You do not have enough money!")
								return false
							end

							if barteringStock == 0 then
								LocalPlayer():NotifyLocalized("You cannot purchase this item due to low stock")
								return
							end

							timer.Simple(0.1, function()
								parentFrame.actualStock:SetText(ix.city.main.items[recipeItem] and ix.city.main.items[recipeItem].amount .. " Available" or 0 .. " Available")
							end)
						else
							LocalPlayer():NotifyLocalized("Could not find your ID card!")
							return false
						end
					else
						LocalPlayer():NotifyLocalized("You do not have an active ID card!")
						return false
					end
				end

				netstream.Start("CraftRecipe", self.recipe.uniqueID, barteringStock)
				surface.PlaySound("helix/ui/press.wav")
				if parentFrame.craftSound then
					surface.PlaySound(parentFrame.craftSound)
				end
			end
		end

		parentFrame.craftButton.OnCursorEntered = function()
			surface.PlaySound("helix/ui/rollover.wav")
			parentFrame.craftButton:SetTextColor(Color(20, 20, 20, 255))
			parentFrame.craftButton.Paint = function(_, w, h)
				surface.SetDrawColor(213, 170, 0, 255)
				surface.DrawRect(0, 0, w, h)
			end
		end

		parentFrame.craftButton.OnCursorExited = function()
			parentFrame.craftButton:SetTextColor(Color(50, 50, 50, 255))
			parentFrame.craftButton.Paint = function(_, w, h)
				surface.SetDrawColor(255, 204, 0, 255)
				surface.DrawRect(0, 0, w, h)
			end
		end
	end

	parentFrame.itemTitle:SetFont("SmallerTitleFontNoClamp")
	parentFrame.itemTitle:SetText(self.recipe.name)
	parentFrame.itemTitle:SetVisible(true)
	parentFrame.itemTitle:SetWide(parentFrame.craftingTextFrame:GetWide() - SScaleMin(10 / 3))
	parentFrame.itemTitle:SetWrap(true)
	parentFrame.itemTitle:SetAutoStretchVertical(true)
	parentFrame.itemTitle:Dock(TOP)
	parentFrame.itemTitle:DockMargin(0, 0 - SScaleMin(4 / 3), 0, SScaleMin(5 / 3))

	parentFrame.itemDesc:SetFont("MenuFontLargerNoClamp")
	parentFrame.itemDesc:SetText(self.recipe.description)
	parentFrame.itemDesc:SetVisible(true)
	parentFrame.itemDesc:SetWide(parentFrame.craftingTextFrame:GetWide() - SScaleMin(10 / 3))
	parentFrame.itemDesc:SetWrap(true)
	parentFrame.itemDesc:SetAutoStretchVertical(true)
	parentFrame.itemDesc:Dock(TOP)
	parentFrame.itemDesc:DockMargin(0, 0, 0, SScaleMin(5 / 3))

	parentFrame.itemLevelUp:SetFont("MenuFontLargerNoClamp")
	local result = character:GetResult("recipe_"..self.recipe.uniqueID)
	local bHasExp = false
	if (result and result > 0) then
		local text = "Increases "..self.recipe.skill.." by "..result.." xp"
		if (self.recipe.skill == "smuggling") then
			if (self.recipe.cost != "N/A") then
				text = "Buying increases "..self.recipe.skill.." by "..result.." xp"
			else
				text = "Selling increases "..self.recipe.skill.." by "..result.." xp"
			end
		end
		parentFrame.itemLevelUp:SetText(text)
		if (result >= 5) then
			parentFrame.itemLevelUp:SetTextColor(Color(255, 204, 0, 255))
		else
			parentFrame.itemLevelUp:SetTextColor(Color(152, 243, 124, 255))
		end

		bHasExp = true
	elseif self.recipe.level and (self.recipe.level > character:GetSkillLevel(self.recipe.skill)) then
		parentFrame.itemLevelUp:SetText("This recipe requires level "..self.recipe.level)
		parentFrame.itemLevelUp:SetTextColor(Color(191, 66, 67, 255))
	else
		parentFrame.itemLevelUp:SetText("This recipe will not level up "..self.recipe.skill)
		parentFrame.itemLevelUp:SetTextColor(Color(191, 66, 67, 255))
	end
	parentFrame.itemLevelUp:SetVisible(true)
	parentFrame.itemLevelUp:Dock(TOP)
	parentFrame.itemLevelUp:SizeToContents()

	if (parentFrame.itemLevelUpBuy) then
		if (bHasExp and self.recipe.cost != "N/A" and self.recipe.buyPrice != "N/A") then
			parentFrame.itemLevelUpBuy:SetFont("MenuFontLargerNoClamp")
			result = character:GetResult("recipe_"..self.recipe.uniqueID, false)
			if (result and result > 0) then
				parentFrame.itemLevelUpBuy:SetText("Selling increases "..self.recipe.skill.." by "..result.." xp")
				if (result >= 5) then
					parentFrame.itemLevelUpBuy:SetTextColor(Color(255, 204, 0, 255))
				else
					parentFrame.itemLevelUpBuy:SetTextColor(Color(152, 243, 124, 255))
				end
			elseif self.recipe.level and (self.recipe.level > character:GetSkillLevel(self.recipe.skill)) then
				parentFrame.itemLevelUpBuy:SetText("This recipe requires level "..self.recipe.level)
				parentFrame.itemLevelUpBuy:SetTextColor(Color(191, 66, 67, 255))
			else
				parentFrame.itemLevelUpBuy:SetText("This recipe will not level up "..self.recipe.skill)
				parentFrame.itemLevelUpBuy:SetTextColor(Color(191, 66, 67, 255))
			end
			parentFrame.itemLevelUpBuy:SetVisible(true)
			parentFrame.itemLevelUpBuy:Dock(TOP)
			parentFrame.itemLevelUpBuy:SizeToContents()
		else
			parentFrame.itemLevelUpBuy:SetText("")
			parentFrame.itemLevelUpBuy:SetVisible(true)
			parentFrame.itemLevelUpBuy:SizeToContents()
		end
	end

	local SScaleMin60 = SScaleMin(20)
	local SScaleMinPadding = SScaleMin(6.66666)
	local recipeResult = self.recipe.result or {["piece_of_metal"] = 1}
	local k = next(recipeResult)
	local index = ix.item.list[k] or LocalPlayer():NotifyLocalized("INVALID RESULT")

	if istable(index) then
		if !index.boosts then
			parentFrame.craftingAttributeFrame:SetVisible(true)
			parentFrame.craftingAttributeFrame:SetTall(0)
			parentFrame.craftingAttributeFrame:DockMargin(0, 0, 0, 0)
		else
			parentFrame.craftingAttributeFrame:SetVisible(true)
			parentFrame.craftingAttributeFrame:SetTall(SScaleMin60)
			parentFrame.craftingAttributeFrame:DockMargin(0, 0, 0, SScaleMinPadding)

			local desc = ""
			if index.boosts.strength then
				desc = desc.."Strength "..index.boosts.strength.." | "
			end

			if index.boosts.agility then
				desc = desc.."Agility "..index.boosts.agility.." | "
			end


			if index.boosts.intelligence then
				desc = desc.."Intelligence "..index.boosts.intelligence.." | "
			end


			if index.boosts.perception then
				desc = desc.."Perception "..index.boosts.perception.." | "
			end

			if parentFrame.craftingAttributeText then
				parentFrame.craftingAttributeText:SetFont("MenuFontLargerNoClamp")
				parentFrame.craftingAttributeText:SetText(desc)
				parentFrame.craftingAttributeText:SetVisible(true)
				parentFrame.craftingAttributeText:SizeToContents()
				parentFrame.craftingAttributeText:Center()
			end
		end
	end

	local licenseName = "Business Permit"
	local toolName = "No tool required"
	local stationName = "No station required"

	if self.recipe.license or self.recipe.category then
		licenseName = self.recipe.license or self.recipe.category
	end

	if self.recipe.tool then
		toolName = ix.item.list[self.recipe.tool].name
	end

	if self.recipe.tools and istable(self.recipe.tools) then
		for _, v in pairs(self.recipe.tools) do
			if toolName == "No tool required" then
				toolName = ix.item.list[v].name
			else
				toolName = toolName..", "..ix.item.list[v].name
			end
		end
	end

	if self.recipe.station then
		if !istable(self.recipe.station) then
			stationName = ix.item.list[self.recipe.station].name
		else
			for _, v in pairs(self.recipe.station) do
				if stationName == "No station required" then
					stationName = ix.item.list[v].name
				else
					stationName = stationName..", "..ix.item.list[v].name
				end
			end

			if self.recipe.canUseCampfire == true then
				stationName = stationName.." or a Campfire"
			end
		end
	end

	parentFrame.requirementsFrame:SetVisible(true)

	if (self.recipe.cost and self.recipe.skill == "bartering") then
		parentFrame.licenseText:SetFont("MenuFontLargerNoClamp")
		parentFrame.licenseText:SetText(licenseName or "")
		parentFrame.licenseText:SizeToContents()
	elseif (!self.recipe.cost) then
		parentFrame.stationsText:SetFont("MenuFontLargerNoClamp")
		parentFrame.stationsText:SetText(stationName or "")
		parentFrame.stationsText:SizeToContents()

		parentFrame.toolsText:SetFont("MenuFontLargerNoClamp")
		parentFrame.toolsText:SetText(toolName or "")
		parentFrame.toolsText:SizeToContents()
	end

	parentFrame.secondPanel.EmptyText:SetVisible(false)
	parentFrame.preview.EmptyText:SetVisible(false)
	if IsValid(parentFrame.model) then
		parentFrame.model:SetVisible(true)
		parentFrame.model:SetSize(SScaleMin(600 / 3), SScaleMin(600 / 3))
		parentFrame.model:SetModel(self.recipe.model)
		parentFrame.model:SetSize(parentFrame.model:GetSize())
		parentFrame.model:Center()

		local item = ix.item.list[table.GetKeys(self.recipe.result)[1]]
		if item and item.proxy and istable(item.proxy) then
			parentFrame.model.Entity.GetProxyColors = function() return item.proxy end
		end

		local mn, mx = parentFrame.model.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

		parentFrame.model:SetFOV( 90 )
		parentFrame.model:SetCamPos( Vector( size, size, size ) )
		parentFrame.model:SetLookAt( ( mn + mx ) * 0.5 )
	end
end

vgui.Register("ixCraftingItem", PANEL, "DPanel")
