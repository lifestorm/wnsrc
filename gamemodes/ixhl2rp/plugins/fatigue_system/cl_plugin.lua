--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.energyConsumptionRateTooltips = {
	[1] = {
		maxRate = 0.002,
		color = "green",
		text = "This item is lightweight"
	},
	[2] = {
		maxRate = 0.004,
		color = "yellow",
		text = "This item is of medium weight"
	}
}

local energyIcon = ix.util.GetMaterial("willardnetworks/hud/energy.png")

function PLUGIN:DrawBars(client, character, alwaysShow, minimalShow, DrawBar)
	if (!character:IsAffectedByFatigue()) then return end

	if (alwaysShow or character:GetEnergy() > 20) then
		if (alwaysShow or !minimalShow or character:GetEnergy() > 20) then
			DrawBar(energyIcon, character:GetEnergy() / 100)
		end
	end
end

function PLUGIN:PopulateItemTooltip(tooltip, item)
	if (item.energyConsumptionRate) then
		local color, text

		for _, info in ipairs(self.energyConsumptionRateTooltips) do
			if (item.energyConsumptionRate <= info.maxRate) then
				color, text = info.color, info.text

				break
			end
		end

		if (!color) then
			color, text = "red", "This item is pretty heavy"
		end

		local appendix = tooltip:Add("DLabel")
		appendix:SetText(text)
		appendix:SetTextColor(ix.hud.appendixColors[color] or color_white)
		appendix:SetTextInset(15, 0)
		appendix:Dock(BOTTOM)
		appendix:DockMargin(0, 0, 0, 5)
		appendix:SetFont("ixSmallFont")
		appendix:SizeToContents()
		appendix:SetTall(appendix:GetTall() + 15)
	end
end

function PLUGIN:AdjustInnerStatusPanel(innerStatus, CreateTitle, CreateSubBar)
	local smallerIconSize = SScaleMin(16 / 3)
	local energyPanel = innerStatus:Add("Panel")
	local energy = LocalPlayer():GetCharacter():GetEnergy()
	local energyText

	for _, v in ipairs(self.energyStatusSubBars) do
		if (energy <= v.minLevel) then
			energyText = v.text

			break
		end
	end

	if (!energyText) then
		energyText = "Rested"
	end

	CreateSubBar(energyPanel, "willardnetworks/hud/stamina.png", "Energy", energyText, smallerIconSize, smallerIconSize)
end

function PLUGIN:RestingEntity_FindValidSequenceOptions(entityModel, client, actName)
	local sequences = self:FindModelActSequences(client, actName)

	if (!sequences) then
		return
	end

	local validSequences = self.restingEntities[entityModel].sequences
	local options = {}

	for k, v in ipairs(sequences) do
		if (!validSequences[v]) then
			continue
		end

		options[actName .. " " .. k] = function()
			return {actName = actName, sequenceID = k}
		end
	end

	return options
end

function PLUGIN:InitializedPlugins3()
	self.energyStatusSubBars = {
		[1] = {
			minLevel = ix.config.Get("energyLevelToApplyDebuffs", 50),
			text = "Fatigued"
		},
		[2] = {
			minLevel = 100,
			text = "Normal"
		}
	}

	--[[ OVERRIDES ]]--
	local WNSkillPanel = vgui.GetControlTable("WNSkillPanel")

	function WNSkillPanel:CreateBoostInfo(boostPanel, skill)
		local character = LocalPlayer():GetCharacter()
		local attributes = ix.special.list or {}
		local skillAttributes = {}

		-- Find the attributes that boost the skill
		for _, v in pairs(attributes) do
			if v.skills then
				if v.skills[skill.uniqueID] then
					skillAttributes[v.skills[skill.uniqueID]] = v
				end
			end
		end

		if skillAttributes[2] then
			local boostedByLabel = boostPanel:Add("DLabel")
			boostedByLabel:SetText("Major boost from " .. skillAttributes[2].name)
			boostedByLabel:SetFont("MenuFontBoldNoClamp")
			boostedByLabel:SetContentAlignment(4)
			boostedByLabel:SizeToContents()
			boostedByLabel:Dock(TOP)
		end

		if skillAttributes[1] then
			local boostedByLabel = boostPanel:Add("DLabel")
			boostedByLabel:SetText("Minor boost from " .. skillAttributes[1].name)
			boostedByLabel:SetFont("MenuFontBoldNoClamp")
			boostedByLabel:SetContentAlignment(4)
			boostedByLabel:SizeToContents()
			boostedByLabel:Dock(TOP)
		end

		local varBoostLevel, boostedEnergy, boostedEnergyAmount = character:GetSkillBoostLevels(skill.uniqueID)
		local varNeedsLevel, reducedHunger, reducedThirst, reducedGas, reducedHealth = character:GetSkillNeedsReducing(skill.uniqueID)

		if (varBoostLevel > 0 and boostedEnergy and boostedEnergyAmount and boostedEnergyAmount > 0) then
			local energyBoostedLevels = boostPanel:Add("DLabel")
			energyBoostedLevels:Dock(TOP)
			energyBoostedLevels:SetContentAlignment(4)
			energyBoostedLevels:SetFont("MenuFontLargerBoldNoFix")
			energyBoostedLevels:SetTextColor(Color(75, 238, 75))
			energyBoostedLevels:SetText("+" .. boostedEnergyAmount .. " levels due to low fatigue.")
			energyBoostedLevels:SizeToContents()
			varBoostLevel = varBoostLevel - boostedEnergyAmount
		end

		if (varBoostLevel > 0) then
			local boostedLevels = boostPanel:Add("DLabel")
			boostedLevels:Dock(TOP)
			boostedLevels:SetContentAlignment(4)
			boostedLevels:SetFont("MenuFontLargerBoldNoFix")
			boostedLevels:SetTextColor(Color(75, 238, 75))
			boostedLevels:SetText("+" .. varBoostLevel .. " levels due to character attributes.")
			boostedLevels:SizeToContents()
		end

		if (varNeedsLevel > 0) then
			if (reducedEnergy) then
				local energyReducing = boostPanel:Add("DLabel")
				energyReducing:Dock(TOP)
				energyReducing:SetContentAlignment(4)
				energyReducing:SetFont("MenuFontLargerBoldNoFix")
				energyReducing:SetTextColor(Color(238, 75, 75))
				energyReducing:SetText("-" .. math.Round(reducedEnergy, 1) .. " levels due to Fatigue")
				energyReducing:SizeToContents()
			end

			if (reducedHunger) then
				local hungerReducing = boostPanel:Add("DLabel")
				hungerReducing:Dock(TOP)
				hungerReducing:SetContentAlignment(4)
				hungerReducing:SetFont("MenuFontLargerBoldNoFix")
				hungerReducing:SetTextColor(Color(238, 75, 75))
				hungerReducing:SetText("-" .. math.Round(reducedHunger, 1) .. " levels due to Hunger")
				hungerReducing:SizeToContents()
			end
			
			if (reducedThirst) then
				local thirstReducing = boostPanel:Add("DLabel")
				thirstReducing:Dock(TOP)
				thirstReducing:SetContentAlignment(4)
				thirstReducing:SetFont("MenuFontLargerBoldNoFix")
				thirstReducing:SetTextColor(Color(238, 75, 75))
				thirstReducing:SetText("-" .. math.Round(reducedThirst, 1) .. " levels due to Thirst")
				thirstReducing:SizeToContents()
			end

			if (reducedGas) then
				local gasReducing = boostPanel:Add("DLabel")
				gasReducing:Dock(TOP)
				gasReducing:SetContentAlignment(4)
				gasReducing:SetFont("MenuFontLargerBoldNoFix")
				gasReducing:SetTextColor(Color(238, 75, 75))
				gasReducing:SetText("-" .. math.Round(reducedGas, 1) .. " levels due to Spores")
				gasReducing:SizeToContents()
			end

			if (reducedHealth) then
				local healthReducing = boostPanel:Add("DLabel")
				healthReducing:Dock(TOP)
				healthReducing:SetContentAlignment(4)
				healthReducing:SetFont("MenuFontLargerBoldNoFix")
				healthReducing:SetTextColor(Color(238, 75, 75))
				healthReducing:SetText("-" .. math.Round(reducedHealth, 1) .. " levels due to Injuries")
				healthReducing:SizeToContents()
			end

			local needsReducing = boostPanel:Add("DLabel")
			needsReducing:Dock(TOP)
			needsReducing:SetContentAlignment(4)
			needsReducing:SetFont("MenuFontLargerBoldNoFix")
			needsReducing:SetTextColor(Color(238, 75, 75))
			needsReducing:SetText("Total Reduced Levels: -" .. varNeedsLevel)
			needsReducing:SizeToContents()
		end
	end
end
