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
local SScaleMin30 = SScaleMin(30 / 3)
local SScaleMin120 = SScaleMin(125 / 3)
local SScaleMin90 = SScaleMin(90 / 3)
local SScaleMin300 = SScaleMin(100 / 3)

function PANEL:Init()
    local notepadPanel = self:CreateMainPanel(SScaleMin(623 / 3), SScaleMin(987 / 3))
	notepadPanel.Paint = function(this, w, h)
		surface.SetDrawColor(color_white)
		surface.SetMaterial(ix.util.GetMaterial("willardnetworks/writing/notepad.png"))
		surface.DrawTexturedRect(0, 0, w, h)
	end

    local optionTop = self:CreateOptionPanel(notepadPanel, TOP)
    optionTop:DockMargin(0, SScaleMin30 * 2, 0, 0)
    self:CreateExitButton(optionTop, RIGHT, 0, 0, SScaleMin30, 0)

    self.title = self:CreateTextEntry(notepadPanel, nil, SScaleMin(55 / 3), TOP, SScaleMin120 - (padding / 2), SScaleMin120 - (SScaleMin30 * 2) + padding, SScaleMin90 + padding, SScaleMin(7 / 3), nil, self.charHandwriting, 28, false, true, "", nil, "Write your title here (if any).")
    self.content = self:CreateTextEntry(notepadPanel, nil, nil, FILL, SScaleMin120 - (padding / 2), 0, SScaleMin90 + (padding / 2), SScaleMin300, nil, self.charHandwriting, 830, true, true, "", nil, "Write your content here (if any).")

    local optionBot = self:CreateOptionPanel(notepadPanel, BOTTOM)
    self:CreateOption(optionBot, LEFT, "PREVIEW", function(button)
        self:TogglePreview(button)
        button:SetVisible(true)
    end, SScaleMin30)

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

    self:CreateDividerLine(self.optionPanels[2], LEFT)
    self:CreateOption(self.optionPanels[2], LEFT, "EDITS LEFT: "..ix.config.Get("maxEditTimes"..Schema:FirstToUpper(identifier), 0) - data.editedTimes, nil)
end

vgui.Register("ixWritingNotepad", PANEL, "ixWritingBase")