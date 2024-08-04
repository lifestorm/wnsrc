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

function AddToSequenceList(sequenceList, modelPreview, parent)
    for _, child in pairs(sequenceList:GetChildren()) do
        child:Remove()
    end

    for _, v in ipairs(LocalPlayer():GetSequenceList()) do
        local container = sequenceList:Add("DPanel")
        container:Dock(TOP)

        local sequenceBtn = container:Add("ixMenuButton")
        sequenceBtn:Dock(FILL)
        sequenceBtn:SetText(v)
        sequenceBtn:SetFont("SmallerTitleFontNoBold")

        sequenceList:Layout()

        sequenceBtn.DoClick = function()
            local entity = modelPreview:GetEntity()

            entity:SetSequence(sequenceBtn:GetText())
            PLUGIN.selectedSequence = v
        end
    end
end

local PANEL = {}

function PANEL:Init()
    local screenWidth, screenHeight = ScrW(), ScrH()
    local panelWidth, panelHeight = SScaleMin(450 / 3), SScaleMin(570 / 3)

    self:SetSize(panelWidth, panelHeight)
    self:SetPos(screenWidth - panelWidth, screenHeight / 2 - panelHeight / 2)

    local closeBtn = self:Add("ixMenuButton")
    closeBtn:Dock(TOP)
    closeBtn:SetText("X")

    closeBtn.DoClick = function()
        self:Remove()
        PLUGIN.menu = nil
    end

    closeBtn.PaintOver = function(this, w, h)
        surface.SetDrawColor(184, 68, 68, 134)
        surface.DrawRect(0, 0, w, h)
    end

    local resetBtn = self:Add("ixMenuButton")
    resetBtn:Dock(BOTTOM)
    resetBtn:SetText(L"MAresetBtn")

    resetBtn.DoClick = function()
        netstream.Start("ixModelAnimationsResetSequence")
    end

    resetBtn.PaintOver = function(this, w, h)
        surface.SetDrawColor(68, 86, 184, 134)
        surface.DrawRect(0, 0, w, h)
    end

    local submitBtn = self:Add("ixMenuButton")
    submitBtn:Dock(BOTTOM)
    submitBtn:SetText(L"MAsubmitBtn")

    submitBtn.DoClick = function()
        if (!PLUGIN.selectedSequence) then
            return
        end

        netstream.Start("ixModelAnimationsRunSequence", PLUGIN.selectedSequence)
    end

    submitBtn.PaintOver = function(this, w, h)
        surface.SetDrawColor(68, 184, 72, 134)
        surface.DrawRect(0, 0, w, h)
    end

    local mainContainer = self:Add("DPanel")
    mainContainer:Dock(FILL)

    local modelPreview = mainContainer:Add("DModelPanel")
    modelPreview:Dock(TOP)
    modelPreview:SetTall(SScaleMin(150 / 3))
    modelPreview:SetModel(LocalPlayer():GetModel())
    modelPreview:SetAnimated(true)

    function modelPreview:LayoutEntity(Entity)
        self:RunAnimation()
        self:SetCamPos(Vector(200, 0, 50))
    end

    local sequencesContainer = mainContainer:Add("DPanel")
    sequencesContainer:Dock(FILL)

    local searchBar = sequencesContainer:Add("DButton")
    searchBar:Dock(TOP)
    searchBar:SetText("SEARCH...")
    searchBar:SetZPos(1)

    local clearSearch = sequencesContainer:Add("DButton")
    clearSearch:Dock(TOP)
    clearSearch:DockMargin(0, 0, 0, 7)
    clearSearch:SetText("CLEAR SEARCH")
    clearSearch:SetZPos(2)

    local scroller = sequencesContainer:Add("DScrollPanel")
    scroller:Dock(FILL)

    local sequenceList = scroller:Add("DIconLayout")
    sequenceList:Dock(FILL)

    AddToSequenceList(sequenceList, modelPreview, container)

    modelPreview.Think = function()
        local entity = modelPreview:GetEntity()

        if (LocalPlayer():GetModel() != entity:GetModel()) then
            modelPreview:SetModel(LocalPlayer():GetModel())

            AddToSequenceList(sequenceList, modelPreview, container)
        end
    end

    searchBar.DoClick = function(this)
        Derma_StringRequest(
            "Search...",
            "Input the animation name to look for",
            "",
            function(text)
                local searchText = string.lower(text)

                for _, v in pairs(sequenceList:GetChildren()) do
                    local animText = v:GetChild(0):GetText()

                    if (!string.find(animText, searchText, 1)) then
                        v:Remove()
                    end
                end

                sequenceList:Layout()
            end,
            nil
        )
    end

    clearSearch.DoClick = function(this)
        AddToSequenceList(sequenceList, modelPreview, container)
    end
end

vgui.Register("ixModelAnimationsList", PANEL, "EditablePanel")
