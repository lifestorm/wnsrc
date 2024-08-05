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

function PANEL:Init()
	local parent = self:GetParent():GetParent()
	self:SetSize(parent.contentPanel:GetSize())

	-- Config
	self.firstTitle = "Level Unlocks"
	self.skill = "guns"

	-- Create titles
	self:Add("CraftingBaseTopTitleBase")

	-- Create inner content
	self:Add("CraftingBaseInnerContent")

	-- Rebuild inner content
	self:Add("CraftingBaseRebuild")
end

vgui.Register("GunsBasePanel", PANEL, "EditablePanel")

local function CreateGunsPanel(container)
	local panel = container:Add("GunsBasePanel")

	ix.gui.gunspanel = panel
	ix.gui.activeSkill = panel

	return container
end

hook.Add("CreateSkillPanels", "GunsBasePanel", function(tabs)
    tabs[ix.skill.list["guns"].uniqueID] = CreateGunsPanel
end)