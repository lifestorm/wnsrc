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
	self.firstTitle = "Recipes"
	self.secondTitle = "Cook"
	self.thirdTitle = "Preview"
	self.nothingSelected = "No item selected"
	self.requirementsTitleText = "Requirements: "
	self.ingredientsTitleText = "Ingredients:"
	self.skill = "cooking"
	self.craftSound = "willardnetworks/skills/skill_cooking.wav"

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

vgui.Register("CookingBasePanel", PANEL, "EditablePanel")

local function CreateCookingPanel(container)
	local panel = container:Add("CookingBasePanel")

	ix.gui.cookingpanel = panel
	ix.gui.activeSkill = panel

	return container
end

hook.Add("CreateSkillPanels", "CookingBasePanel", function(tabs)
    tabs[ix.skill.list["cooking"].uniqueID] = CreateCookingPanel
end)