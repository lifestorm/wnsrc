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

function PANEL:Init()
    --self:SetText("Bodygroup Manager")
    self:SetSize(SScaleMin(800 / 3), SScaleMin(800 / 3))
    self:Center()
    self:SetTitle("Bodygroup Manager")
    DFrameFixer(self)

    self.clipboard = self:Add("DButton")
	self.clipboard:Dock(BOTTOM)
	self.clipboard:DockMargin(0, SScaleMin(4 / 3), 0, 0)
    self.clipboard:SetText("Save Changes")
	self.clipboard:SetFont("MenuFontBoldNoClamp")
	self.clipboard:SetTall(SScaleMin(50 / 3))
    self.clipboard.DoClick = function()
		LocalPlayer():NotifyLocalized("You have set this character's bodygroups.")
        local bodygroups = {}
        for _, v in pairs(self.bodygroupIndex) do
            table.insert(bodygroups, v.index, v.value)
        end

        local color = self.colorPicker:GetValue()

        net.Start("ixBodygroupTableSet")
            net.WriteEntity(self.target)
            net.WriteTable(bodygroups)
            net.WriteTable(color)
        net.SendToServer()
    end

    self.model = self:Add("ixModelPanel")
    self.model.rotating = true
	self.model:Dock(FILL)
	self.model:SetFOV(35)
    self.model:SetModel(Model("models/props_junk/watermelon01.mdl"))

	self.bodygroupPanel = self:Add("DScrollPanel")
	self.bodygroupPanel:Dock(RIGHT)
	self.bodygroupPanel:DockMargin(0, SScaleMin(7 / 3), 0, 0)
	self.bodygroupPanel:SetWide(self:GetWide() - SScaleMin(300 / 3))
    self.bodygroups = {}

    PLUGIN.viewer = self
end

function PANEL:SetTarget(target, proxyColors)
    self.target = target
    self:PopulateBodygroupOptions(proxyColors)
    self:SetTitle(target:GetName())

	self.model.Entity.overrideProxyColors = proxyColors
end

function PANEL:PopulateBodygroupOptions(proxyColors)
    self.bodygroupBox = {}
    self.bodygroupName = {}
    self.bodygroupPrevious = {}
    self.bodygroupNext = {}
    self.bodygroupIndex = {}

    for k, v in pairs(self.target:GetBodyGroups()) do
        -- Disregard the model bodygroup.
        if !(v.id == 0) then
            local index = v.id

            self.bodygroupBox[v.id] = self.bodygroupPanel:Add("DPanel")
            self.bodygroupBox[v.id]:Dock(TOP)
            self.bodygroupBox[v.id]:DockMargin(0, SScaleMin(25 / 3), SScaleMin(25 / 3), 0)
            self.bodygroupBox[v.id]:SetHeight(SScaleMin(50 / 3))
			self.bodygroupBox[v.id].Paint = function(self, w, h)
				surface.SetDrawColor(Color(40, 40, 40, 100))
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
				surface.DrawOutlinedRect(0, 0, w, h)
			end

            local hairBg = self.model.Entity:FindBodygroupByName("hair")

            self.bodygroupName[v.id] = self.bodygroupBox[v.id]:Add("DLabel")
            self.bodygroupName[v.id].index = v.id
            self.bodygroupName[v.id]:SetText(v.name:gsub("^%l", string.utf8upper))
            self.bodygroupName[v.id]:SetFont("TitlesFontNoClamp")
            self.bodygroupName[v.id]:Dock(LEFT)
            self.bodygroupName[v.id]:DockMargin(SScaleMin(30 / 3), 0, 0, 0)
            self.bodygroupName[v.id]:SetWidth(SScaleMin(200 / 3))

            self.bodygroupNext[v.id] = self.bodygroupBox[v.id]:Add("DButton")
            self.bodygroupNext[v.id].index = v.id
            self.bodygroupNext[v.id]:Dock(RIGHT)
			self.bodygroupNext[v.id]:SetFont("MenuFontNoClamp")
            self.bodygroupNext[v.id]:SetText("Next")
			self.bodygroupNext[v.id]:SetWide(SScaleMin(100 / 3))
            self.bodygroupNext[v.id].DoClick = function()
                local index = v.id
                if (self.model.Entity:GetBodygroupCount(index) - 1) <= self.bodygroupIndex[index].value then
                    return
                end

                self.bodygroupIndex[index].value = self.bodygroupIndex[index].value + 1
                self.bodygroupIndex[index]:SetText(self.bodygroupIndex[index].value)
                self.model.Entity:SetBodygroup(index, self.bodygroupIndex[index].value)

                local hairValue = self.bodygroupIndex[hairBg] and self.bodygroupIndex[hairBg].value
                self.model:SetCorrectHair(v.name == "headwear" and hairValue)
            end

            self.bodygroupIndex[v.id] = self.bodygroupBox[v.id]:Add("DLabel")
            self.bodygroupIndex[v.id].index = v.id
            self.bodygroupIndex[v.id].value = self.target:GetBodygroup(index)
            self.bodygroupIndex[v.id]:SetText(self.bodygroupIndex[v.id].value)
            self.bodygroupIndex[v.id]:SetFont("TitlesFontNoClamp")
            self.bodygroupIndex[v.id]:Dock(RIGHT)
            self.bodygroupIndex[v.id]:SetContentAlignment(5)

            self.bodygroupPrevious[v.id] = self.bodygroupBox[v.id]:Add("DButton")
            self.bodygroupPrevious[v.id].index = v.id
            self.bodygroupPrevious[v.id]:Dock(RIGHT)
			self.bodygroupPrevious[v.id]:SetFont("MenuFontNoClamp")
            self.bodygroupPrevious[v.id]:SetText("Previous")
			self.bodygroupPrevious[v.id]:SetWide(SScaleMin(100 / 3))
            self.bodygroupPrevious[v.id].DoClick = function()
                local index = v.id
                if 0 == self.bodygroupIndex[index].value then
                    return
                end

                self.bodygroupIndex[index].value = self.bodygroupIndex[index].value - 1
                self.bodygroupIndex[index]:SetText(self.bodygroupIndex[index].value)
                self.model.Entity:SetBodygroup(index, self.bodygroupIndex[index].value)

                local hairValue = self.bodygroupIndex[hairBg] and self.bodygroupIndex[hairBg].value
                self.model:SetCorrectHair(v.name == "headwear" and hairValue)
            end

            self.model.Entity:SetBodygroup(index, self.target:GetBodygroup(index))

            local hairValue = self.bodygroupIndex[hairBg] and self.bodygroupIndex[hairBg].value
            self.model:SetCorrectHair(v.name == "headwear" and hairValue)
        end
    end

    local hairColor = self.bodygroupPanel:Add("DPanel")
    hairColor:Dock(TOP)
    hairColor:DockMargin(0, SScaleMin(25 / 3), SScaleMin(25 / 3), 0)
    hairColor:SetHeight(SScaleMin(50 / 3))
    hairColor.Paint = function(this, w, h)
        surface.SetDrawColor(Color(40, 40, 40, 100))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    self.colorPicker = hairColor:Add("ixSettingsRowColor")
    self.colorPicker:Dock(FILL)
    self.colorPicker:SetText("Hair Color")
    if proxyColors["HairColor"] then
        self.colorPicker:SetValue(proxyColors["HairColor"])
    end

    self.colorPicker.OnValueChanged = function(this, newColor)
        proxyColors["HairColor"] = Color(newColor.r, newColor.g, newColor.b)

        self.model.Entity.GetProxyColors = function()
            return proxyColors
        end
    end
end

function PANEL:SetViewModel(model)
    self.playerModel = model
    if model then
        self.model:SetModel(Model(model))
    end
end

vgui.Register("ixBodygroupView", PANEL, "DFrame")
