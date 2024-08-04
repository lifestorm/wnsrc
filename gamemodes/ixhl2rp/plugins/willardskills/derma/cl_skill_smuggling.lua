--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local vgui = vgui

local PANEL = {}

function PANEL:Init()
	local parent = self:GetParent():GetParent()
	self:SetSize(parent.contentPanel:GetSize())

	-- Config
	self.firstTitle = "Przedmioty"
	self.secondTitle = "Info"
	self.thirdTitle = "Podgląd"
	self.nothingSelected = "Nie wybrano przedmiotu"
	self.requirementsTitleText = "Wymagania: "
	self.skill = "smuggling"

	-- Create titles
	self:Add("CraftingBaseTopTitleBase")

	-- Create inner content
	self:Add("CraftingBaseInnerContent")

	-- Rebuild inner content
	self:Add("CraftingBaseRebuild")
end

function PANEL:Remove()
	if (self.model) then
		self.model:Remove()
	end
end

vgui.Register("SmugglingBasePanel", PANEL, "EditablePanel")

local function CreateSmugglingPanel(container)
	local panel = container:Add("SmugglingBasePanel")

	ix.gui.smugglingpanel = panel
	ix.gui.activeSkill = panel

	return container
end

hook.Add("CreateSkillPanels", "SmugglingBasePanel", function(tabs)
    tabs[ix.skill.list["smuggling"].uniqueID] = CreateSmugglingPanel
end)