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

local smallerIconSize = SScaleMin(16 / 3)
local function firstUpper(str)
	return str:gsub("^%l", string.utf8upper)
end

function PLUGIN:PopulateHelpMenu(tabs)
	local permitsList = ix.permits.get()
	if (permitsList and !table.IsEmpty(permitsList)) then
		tabs["Permits"] = function(container)
			local permits = table.GetKeys(permitsList)
			table.sort(permits)

			for _, v in pairs(permits) do
				local permitsButton = container:Add("DButton")
				permitsButton:Dock(TOP)
				permitsButton:SetText(Schema:FirstToUpper(v))
				permitsButton:SetFont("TitlesFontNoClamp")
				permitsButton:SizeToContents()
				permitsButton.Paint = nil
				permitsButton:SetContentAlignment(4)
				permitsButton.DoClick = function()
					LocalPlayer():NotifyLocalized("Permit ID '"..v.."' copied to clipboard")
					SetClipboardText( v )
				end
			end
		end
	end
end

function PLUGIN:CreateExtraCharacterTabInfo(character, informationSubframe, CreatePart)
	-- Permits
	local permitsPanel = informationSubframe:Add("Panel")
	local permitsData = LocalPlayer():GetCharacter():GetGenericdata().permits
	if !istable(permitsData) then
		CreatePart(permitsPanel, "Business Permits:", "No permits", "licenses", true, false, true)
		return
	end

	permitsData = table.GetKeys(LocalPlayer():GetCharacter():GetGenericdata().permits)

	for k, v in pairs(permitsData) do
		permitsData[k] = firstUpper(v)
	end

	if !table.IsEmpty(permitsData) then
		CreatePart(permitsPanel, "Business Permits:", table.concat(permitsData, ", "), "licenses", true, false, true)
	else
		CreatePart(permitsPanel, "Business Permits:", "No permits", "licenses", true, false, true)
	end
end

function PLUGIN:AdjustInnerStatusPanel(innerStatus, CreateTitle, CreateSubBar)
	if (ix.special) then
		local attributesTitle = innerStatus:Add("DLabel")
		CreateTitle(attributesTitle, "ATTRIBUTES")

		local character = LocalPlayer():GetCharacter()
		for _, v in pairs(ix.special.list) do
			local attribute = innerStatus:Add("Panel")
			local special = character:GetSpecial(tostring(v.uniqueID))

			CreateSubBar(attribute, "willardnetworks/tabmenu/inventory/inv_" .. v.name .. ".png", v.name, special .. "/10", smallerIconSize, smallerIconSize)
		end
	end

	if (ix.skill) then
		local character = LocalPlayer():GetCharacter()

		local skillsTitle = innerStatus:Add("DLabel")
		CreateTitle(skillsTitle, "SKILLS")

		for skillID, skillInfo in pairs(ix.skill.list) do
			if (skillInfo.name == "Vortessence" and !LocalPlayer():IsVortigaunt()) or skillInfo.name == "Bartering" then
				continue
			end

			local skillsPanel = innerStatus:Add("Panel")
			local level = character:GetSkillLevel(skillID)
			CreateSubBar(skillsPanel, "willardnetworks/tabmenu/inventory/inv_" .. skillID .. ".png", skillInfo.name, level .. "/50", smallerIconSize, smallerIconSize)
		end

		local char = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()

		-- Misc section
		local miscTitle = innerStatus:Add("DLabel")
		CreateTitle(miscTitle, "MISC")

		if char then
			local money = char.GetMoney and char:GetMoney() or 0
			-- Display the amount of chips the player has
			local chipsPanel = innerStatus:Add("Panel")
			CreateSubBar(chipsPanel, "willardnetworks/tabmenu/charmenu/chips.png", "Chips", money, smallerIconSize, smallerIconSize)
		end
	end
end