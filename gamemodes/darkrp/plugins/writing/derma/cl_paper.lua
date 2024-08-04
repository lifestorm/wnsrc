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
    local paperPanel = self:CreateMainPanel(SScaleMin(710 / 3), SScaleMin(995 / 3))
	paperPanel.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/writing/paper.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

    local optionTop = self:CreateOptionPanel(paperPanel, TOP)
    self:CreateExitButton(optionTop, RIGHT, padding, 0, SScaleMin30, 0)

    self.title = self:CreateTextEntry(paperPanel, nil, SScaleMin(55 / 3), TOP, SScaleMin84, 0, SScaleMin55, 0, nil, self.charHandwriting, 35, false, true, "", nil, "Write your title here (if any).")
    self.content = self:CreateTextEntry(paperPanel, nil, nil, FILL, SScaleMin84, padding, SScaleMin55, SScaleMin84, nil, self.charHandwriting, 1100, true, true, "", nil, "Write your content here (if any).")

    local optionBot = self:CreateOptionPanel(paperPanel, BOTTOM)
    self:CreateOption(optionBot, LEFT, "PREVIEW", function(button)
        self:TogglePreview(button)
        button:SetVisible(true)
    end, SScaleMin(35 / 3))

    self:CreateOption(optionBot, RIGHT, "SAVE", function(button)
        netstream.Start("ixWritingAddWriting", self.identifier, {title = self.title:GetValue(), content = self.content:GetValue()}, self.itemID)
        self:Remove()
    end, 0, 0, SScaleMin30, 0)
end

function PANEL:Populate(itemID, identifier, data)
    local owner = data.owner
    local localChar = LocalPlayer():GetCharacter()
    if !localChar then return end
    local titleText = data.title or ""
    local contentText = data.content or ""
    local canRead = localChar:GetCanread()

    self.title:SetValue(canRead and titleText or Schema:ShuffleText(titleText))
    self.title:SetFont(data.font or self.charHandwriting)
    if self.title:GetName() != "DTextEntry" then self.title:SizeToContents() end

    self.content:SetValue(canRead and contentText or Schema:ShuffleText(contentText))
    self.content:SetFont(data.font or self.charHandwriting)

    if localChar.id != owner then self:TogglePreview() return end

    self:CreateOption(self.optionPanels[2], LEFT, "EDITS LEFT: "..ix.config.Get("maxEditTimes"..Schema:FirstToUpper(identifier), 0) - data.editedTimes, nil, padding)
end

vgui.Register("ixWritingPaper", PANEL, "ixWritingBase")