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
	if parent then
		if parent.contentPanel then
			self:SetSize(parent.contentPanel:GetSize())
		else
			self:SetSize(ScrW() * 0.75, ScrH() * 0.70)
		end
	else
		self:SetSize(ScrW() * 0.75, ScrH() * 0.70)
	end

	-- Config
	self.firstTitle = "Recipes"
	self.secondTitle = "Crafting"
	self.thirdTitle = "Preview"
	self.nothingSelected = "No item/recipe selected"
	self.requirementsTitleText = "Requirements: "
	self.ingredientsTitleText = "Ingredients:"
	self.skill = "crafting"
	self.craftSound = "willardnetworks/skills/skill_crafting.wav"

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

vgui.Register("CraftingBasePanel", PANEL, "EditablePanel")

local function CreateCraftingPanel(container)
	local panel = container:Add("CraftingBasePanel")

	ix.gui.craftingpanel = panel
	ix.gui.activeSkill = panel

	return container
end

hook.Add("CreateSkillPanels", "CraftingBasePanel", function(tabs)
    tabs[ix.skill.list["crafting"].uniqueID] = CreateCraftingPanel
end)

netstream.Hook("OpenCraftingMenu", function()
	if ix.gui.craftingpanel then
		if ix.gui.craftingpanel.Remove then
			ix.gui.craftingpanel:Remove()
		end
	end

	local parentPanel = vgui.Create("Panel")
	parentPanel:SetSize(ScrW(), ScrH())
	parentPanel:SetAlpha(0)
	parentPanel:AlphaTo(200, 0.5, 0)
	parentPanel.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, w, h)
	end

	local craftingPanel = parentPanel:Add("CraftingBasePanel")
	craftingPanel:MakePopup()
	craftingPanel:Center()

	local close = craftingPanel:Add("DButton")
	close:Dock(BOTTOM)
	close:SetFont("TitlesFont")
	close:SetText("CLOSE CRAFTING")
	close:DockMargin(((craftingPanel:GetWide() + 20) / 1.5), 0, 2, 0)
	close:SetTall(math.Clamp(ScreenScale(50 / 3), 0, 50))
	close.DoClick = function()
		parentPanel:AlphaTo(0, 0.5, 0, function()
			parentPanel:Remove()
		end)
	end

	ix.gui.craftingpanel = craftingPanel
	ix.gui.activeSkill = craftingPanel
end)