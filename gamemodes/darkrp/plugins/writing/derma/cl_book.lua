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
local SScaleMin55 = SScaleMin(55 / 3)
local SScaleMin84 = SScaleMin(84 / 3)
local SScaleMin30 = SScaleMin(30 / 3)

function PANEL:Init()
    local bookPanel = self:CreateMainPanel(SScaleMin(1297 / 3), SScaleMin(859 / 3))
	bookPanel.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/writing/book.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

    local optionTop = self:CreateOptionPanel(bookPanel, TOP)
    self:CreateExitButton(optionTop, RIGHT, padding, 0, SScaleMin30, 0)

    local contentPanel = bookPanel:Add("Panel")
    contentPanel:Dock(FILL)

    local leftPage = contentPanel:Add("Panel")
    leftPage:Dock(LEFT)
    leftPage:SetWide(bookPanel:GetWide() / 2)

    local rightPage = contentPanel:Add("Panel")
    rightPage:Dock(FILL)

    self.title1 = self:CreateTextEntry(leftPage, nil, SScaleMin(55 / 3), TOP, SScaleMin84, 0, SScaleMin55, 0, nil, self.charHandwriting, 35, false, true, "", nil, "Write your title here (if any).")
    self.title2 = self:CreateTextEntry(rightPage, nil, SScaleMin(55 / 3), TOP, SScaleMin84, 0, SScaleMin55, 0, nil, self.charHandwriting, 35, false, true, "", nil, "Write your title here (if any).")
    self.content1 = self:CreateTextEntry(leftPage, nil, nil, FILL, SScaleMin84, padding / 2, SScaleMin55, SScaleMin84, nil, self.charHandwriting, 1170, true, true, "", nil, "Write your content here (if any).")
    self.content2 = self:CreateTextEntry(rightPage, nil, nil, FILL, SScaleMin84, padding / 2, SScaleMin55, SScaleMin84, nil, self.charHandwriting, 1170, true, true, "", nil, "Write your content here (if any).")

	local colors = {
		["BLUE"] = "000000000",
		["BLACK"] = "100000000",
		["GREEN"] = "200000000",
		["ORANGE"] = "300000000",
		["PURPLE"] = "400000000",
		["RED"] = "500000000",
		["GREY UNION"] = "600000000",
		["YELLOW"] = "700000000"
	}

    local optionBot = self:CreateOptionPanel(bookPanel, BOTTOM)
    self:CreateOption(optionBot, LEFT, "PREVIEW", function(button)
        self:TogglePreview(button)
        button:SetVisible(true)
    end, SScaleMin(35 / 3))

    self:CreateDividerLine(optionBot, LEFT)
    self:CreateOption(optionBot, LEFT, "BOOK COLOR: ", nil, 0)

	local canClick = true
	for colorName, bg in SortedPairs(colors) do
        self:CreateOption(optionBot, LEFT, colorName, function(button)
            if canClick then
                canClick = false
                netstream.Start("ixWritingSetBookColor", self.itemID, bg)
                LocalPlayer():NotifyLocalized("You've set the book color to "..string.utf8lower(colorName))

                timer.Simple(1, function()
                    canClick = true
                end)
            else
                LocalPlayer():NotifyLocalized("You can't click this just yet!")
            end
        end, 0)

        if colorName != "YELLOW" then
            local dividerLine = self:CreateDividerLine(optionBot, LEFT)
            dividerLine:DockMargin(SScaleMin(5 / 3), padding / 4, SScaleMin(5 / 3), padding / 4)
        end
	end

    self:CreateOption(optionBot, RIGHT, "SAVE", function(button)
        netstream.Start("ixWritingAddWriting", self.identifier, {title1 = self.title1:GetValue(), content1 = self.content1:GetValue(), title2 = self.title2:GetValue(), content2 = self.content2:GetValue()}, self.itemID)
        self:Remove()
    end, 0, 0, SScaleMin30, 0)
end

function PANEL:Populate(itemID, identifier, data)
    local owner = data.owner
    local localChar = LocalPlayer():GetCharacter()
    if !localChar then return end
    local titleText1 = data.title1 or ""
    local contentText1 = data.content1 or ""
    local titleText2 = data.title2 or ""
    local contentText2 = data.content2 or ""
    local canRead = localChar:GetCanread()

    self.title1:SetValue(canRead and titleText1 or Schema:ShuffleText(titleText1))
    self.title1:SetFont(data.font or self.charHandwriting)
    if self.title1:GetName() != "DTextEntry" then self.title1:SizeToContents() end

    self.title2:SetValue(canRead and titleText2 or Schema:ShuffleText(titleText2))
    self.title2:SetFont(data.font or self.charHandwriting)
    if self.title2:GetName() != "DTextEntry" then self.title2:SizeToContents() end

    self.content1:SetValue(canRead and contentText1 or Schema:ShuffleText(contentText1))
    self.content1:SetFont(data.font or self.charHandwriting)

    self.content2:SetValue(canRead and contentText2 or Schema:ShuffleText(contentText2))
    self.content2:SetFont(data.font or self.charHandwriting)

    if localChar.id != owner then self:TogglePreview() return end

    self:CreateDividerLine(self.optionPanels[2], RIGHT)
    self:CreateOption(self.optionPanels[2], RIGHT, "EDITS LEFT: "..ix.config.Get("maxEditTimes"..Schema:FirstToUpper(identifier), 0) - data.editedTimes, nil)
end

vgui.Register("ixWritingBook", PANEL, "ixWritingBase")