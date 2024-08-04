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

    self.title1 = self:CreateTextEntry(leftPage, nil, SScaleMin(55 / 3), TOP, SScaleMin84, 0, SScaleMin55, 0, nil, self.charHandwriting, 35, false, true, "", nil, "Inscrivez votre titre ici (s'il y en a un).")
    self.title2 = self:CreateTextEntry(rightPage, nil, SScaleMin(55 / 3), TOP, SScaleMin84, 0, SScaleMin55, 0, nil, self.charHandwriting, 35, false, true, "", nil, "Inscrivez votre titre ici (s'il y en a un).")
    self.content1 = self:CreateTextEntry(leftPage, nil, nil, FILL, SScaleMin84, padding / 2, SScaleMin55, SScaleMin84, nil, self.charHandwriting, 1170, true, true, "", nil, "Rédigez votre contenu ici (s'il y en a un).")
    self.content2 = self:CreateTextEntry(rightPage, nil, nil, FILL, SScaleMin84, padding / 2, SScaleMin55, SScaleMin84, nil, self.charHandwriting, 1170, true, true, "", nil, "Rédigez votre contenu ici (s'il y en a un).")

	local colors = {
		["BLEU"] = "000000000",
		["NOIR"] = "100000000",
		["VERT"] = "200000000",
		["ORANGE"] = "300000000",
		["VIOLET"] = "400000000",
		["ROUGE"] = "500000000",
		["GRIS"] = "600000000",
		["JAUNE"] = "700000000"
	}

    local optionBot = self:CreateOptionPanel(bookPanel, BOTTOM)
    self:CreateOption(optionBot, LEFT, "PRÉVISUALISATION", function(button)
        self:TogglePreview(button)
        button:SetVisible(true)
    end, SScaleMin(35 / 3))

    self:CreateDividerLine(optionBot, LEFT)
    self:CreateOption(optionBot, LEFT, "COULEUR DU LIVRE : ", nil, 0)

	local canClick = true
	for colorName, bg in SortedPairs(colors) do
        self:CreateOption(optionBot, LEFT, colorName, function(button)
            if canClick then
                canClick = false
                netstream.Start("ixWritingSetBookColor", self.itemID, bg)
                LocalPlayer():NotifyLocalized("Vous avez réglé la couleur du livre sur "..string.utf8lower(colorName))

                timer.Simple(1, function()
                    canClick = true
                end)
            else
                LocalPlayer():NotifyLocalized("Vous ne pouvez pas encore cliquer sur ce bouton !")
            end
        end, 0)

        if colorName != "JAUNE" then
            local dividerLine = self:CreateDividerLine(optionBot, LEFT)
            dividerLine:DockMargin(SScaleMin(5 / 3), padding / 4, SScaleMin(5 / 3), padding / 4)
        end
	end

    self:CreateOption(optionBot, RIGHT, "SAUVEGARDER", function(button)
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
    self:CreateOption(self.optionPanels[2], RIGHT, "MODIFICATIONS RESTANTES : "..ix.config.Get("maxEditTimes"..Schema:FirstToUpper(identifier), 0) - data.editedTimes, nil)
end

vgui.Register("ixWritingBook", PANEL, "ixWritingBase")