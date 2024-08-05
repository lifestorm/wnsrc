--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function Schema:PopulateCharacterInfo(client, character, tooltip)
	if (client:IsRestricted()) then
		local panel = tooltip:AddRowAfter("name", "ziptie")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("tiedUp"))
		panel:SizeToContents()
	elseif (client:GetNetVar("tying")) then
		local panel = tooltip:AddRowAfter("name", "ziptie")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("beingTied"))
		panel:SizeToContents()
	elseif (client:GetNetVar("untying")) then
		local panel = tooltip:AddRowAfter("name", "ziptie")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("beingUntied"))
		panel:SizeToContents()
	end
end

function Schema:ShouldShowPlayerOnScoreboard(client)
	local faction = LocalPlayer():Team()

	if (faction == FACTION_SERVERADMIN) then return true end

	if (client:Team() == FACTION_OTA or client:Team() == FACTION_OVERWATCH) then
		return (faction == FACTION_OTA
			or (faction == FACTION_CP and client:Team() == FACTION_OVERWATCH)
			or faction == FACTION_ADMIN
			or faction == FACTION_RESISTANCE
			or faction == FACTION_OVERWATCH)
	end
end

function Schema:CanPlayerJoinClass(client, class, info)
	return false
end

function Schema:PlayerFootstep(client, position, foot, soundName, volume)
	return true
end

function Schema:RenderScreenspaceEffects()
	if (ix.option.Get("ColorModify", true)) then
		local colorModify = {}
		colorModify["$pp_colour_colour"] = 0.77 + ix.option.Get("ColorSaturation", 0)

		if (system.IsWindows()) then
			colorModify["$pp_colour_brightness"] = -0.02
			colorModify["$pp_colour_contrast"] = 1.2
		else
			colorModify["$pp_colour_brightness"] = 0
			colorModify["$pp_colour_contrast"] = 1
		end
		DrawColorModify(colorModify)
	end
end

-- creates labels in the status screen
function Schema:CreateCharacterInfo(panel)
	if (LocalPlayer():Team() == FACTION_CITIZEN or LocalPlayer():Team() == FACTION_WORKERS or LocalPlayer():Team() == FACTION_MEDICAL) then
		panel.cid = panel:Add("ixListRow")
		panel.cid:SetList(panel.list)
		panel.cid:Dock(TOP)
		panel.cid:DockMargin(0, 0, 0, 8)
	end
end

-- populates labels in the status screen
function Schema:UpdateCharacterInfo(panel)
	if (LocalPlayer():Team() == FACTION_CITIZEN or LocalPlayer():Team() == FACTION_WORKERS or LocalPlayer():Team() == FACTION_MEDICAL) then
		panel.cid:SetLabelText(L("citizenid"))
		panel.cid:SetText(string.format("##%s", LocalPlayer():GetCharacter():GetCid() or "UNKNOWN"))
		panel.cid:SizeToContents()
	end
end

function Schema:BuildBusinessMenu(panel)
	local bHasItems = false

	for k, _ in pairs(ix.item.list) do
		if (hook.Run("CanPlayerUseBusiness", LocalPlayer(), k) != false) then
			bHasItems = true

			break
		end
	end

	return bHasItems
end

function Schema:PopulateHelpMenu(tabs)
	tabs["voices"] = function(container)
		local classes = {}

		for k, v in pairs(Schema.voices.classes) do
			if (v.condition(LocalPlayer())) then
				classes[#classes + 1] = k
			end
		end

		if (#classes < 1) then
			local info = container:Add("DLabel")
			info:SetFont("MenuFontNoClamp")
			info:SetText("You do not have access to any voice lines!")
			info:SetContentAlignment(5)
			info:SetTextColor(color_white)
			info:SetExpensiveShadow(1, color_black)
			info:Dock(TOP)
			info:DockMargin(0, 0, 0, SScaleMin(8 / 3))
			info:SizeToContents()
			info:SetTall(info:GetTall() + SScaleMin(16 / 3))

			info.Paint = function(_, width, height)
				surface.SetDrawColor(ColorAlpha(derma.GetColor("Error", info), 160))
				surface.DrawRect(0, 0, width, height)
			end

			return
		end

		table.sort(classes, function(a, b)
			return a < b
		end)

		local function FillList(query)
			for _, class in ipairs(classes) do
				local category = container:Add("Panel")
				category:Dock(TOP)
				category:DockMargin(0, 0, 0, SScaleMin(8 / 3))
				category:DockPadding(SScaleMin(8 / 3), SScaleMin(8 / 3), SScaleMin(8 / 3), SScaleMin(8 / 3))
				category.Paint = function(_, width, height)
					surface.SetDrawColor(Color(0, 0, 0, 66))
					surface.DrawRect(0, 0, width, height)
				end

				local categoryLabel = category:Add("DLabel")
				categoryLabel:SetFont("MenuFontLargerNoClamp")
				categoryLabel:SetText(class:utf8upper())
				categoryLabel:Dock(FILL)
				categoryLabel:SetTextColor(color_white)
				categoryLabel:SetExpensiveShadow(1, color_black)
				categoryLabel:SizeToContents()
				category:SizeToChildren(true, true)

				for command, info in SortedPairs(self.voices.stored[class]) do
					if (query and !(command:find(query) or info.text:find(query))) then
						continue
					end

					local title = container:Add("DLabel")
					title:SetFont("MenuFontLargerNoClamp")
					title:SetText(command:utf8upper())
					title:Dock(TOP)
					title:SetTextColor(ix.config.Get("color"))
					title:SetExpensiveShadow(1, color_black)
					title:SetMouseInputEnabled(true)
					title:SizeToContents()
					title.DoClick = function()
						SetClipboardText(command:utf8upper())
						LocalPlayer():Notify("Voice Command copied to clipboard.")
					end

					local description = container:Add("DLabel")
					description:SetFont("MenuFontNoClamp")
					description:SetText(info.text)
					description:Dock(TOP)
					description:SetTextColor(color_white)
					description:SetExpensiveShadow(1, color_black)
					description:SetWrap(true)
					description:SetAutoStretchVertical(true)
					description:SetMouseInputEnabled(true)
					description:SizeToContents()
					description:DockMargin(0, 0, 0, SScaleMin(8 / 3))
					description.DoClick = function()
						SetClipboardText(command:utf8upper())
						LocalPlayer():Notify("Voice Command copied to clipboard.")
					end
				end
			end
		end

		local search = container:GetParent():Add("DTextEntry")
		search:Dock(TOP)
		search:SetFont("MenuFontNoClamp")
		search:SetTall(SScaleMin(30 / 3))
		search:DockMargin(SScaleMin(8 / 3), 0, SScaleMin(8 / 3), SScaleMin(8 / 3))
		search:SetPlaceholderText("Start typing voiceline text...")
		search:SetTextColor(Color(200, 200, 200, 255))
		search:SetCursorColor(Color(200, 200, 200, 255))
		search:SetFont("MenuFontNoClamp")
		search:SetText(value or "")
		search.Paint = function(panel, w, h)
			surface.SetDrawColor(Color(0, 0, 0, 100))
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawOutlinedRect(0, 0, w, h)

			if ( panel.GetPlaceholderText and panel.GetPlaceholderColor and panel:GetPlaceholderText() and
				panel:GetPlaceholderText():Trim() != "" and panel:GetPlaceholderColor() and ( !panel:GetText() or panel:GetText() == "" ) ) then

				local oldText = panel:GetText()

				local str = panel:GetPlaceholderText()
				if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
				str = language.GetPhrase( str )

				panel:SetText( str )
				panel:DrawTextEntryText( panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
				panel:SetText( oldText )

				return
			end

			panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
		end

		search.OnChange = function(self)
			local text = self:GetValue()
			container:Clear()
			FillList(text:utf8lower())
		end
		search.Think = function(pnl)
			if (pnl:IsVisible() and !IsValid(container) or !container:IsVisible()) then
				pnl:SetVisible(false)
			end
		end

		container.Think = function(pnl)
			if (!search:IsVisible()) then
				search:SetVisible(true)
			end
		end

		FillList()
	end
end

netstream.Hook("PlaySound", function(sound)
	surface.PlaySound(sound)
end)

netstream.Hook("ViewObjectives", function(data)
	if (IsValid(ix.gui.combine)) then
		ix.gui.combine:AddLine("@cViewObjectives")
	end
	vgui.Create("ixViewObjectives"):Populate(data)
end)

local blocked = {}
netstream.Hook("SearchRequest", function(client)
	if (blocked[client]) then
		netstream.Start("SearchDecline")
		return
	end

	local name = hook.Run("GetCharacterName", client, "ic") or client:GetName()
	local panel = Derma_Query(name.." tries to search you. Will you let them do that?", "Inventory Search Request",
	"Allow", function()
		netstream.Start("SearchAllow")
	end,
	"Decline", function()
		netstream.Start("SearchDecline")
	end,
	"Block", function()
		netstream.Start("SearchDecline")
		blocked[client] = true
	end)

	timer.Simple(30, function()
		if (IsValid(panel)) then
			panel:Remove()
			netstream.Start("SearchTimeout")
		end
	end)
end)

function Schema:AllowMessage(panel)
	panel.OnKeyCodePressed = function(this, keyCode)
		-- Allow to open chat while playing
		if (input.LookupKeyBinding(keyCode) == "messagemode") then
			hook.Run("PlayerBindPress", LocalPlayer(), "messagemode", true, keyCode)
		end
	end
end

local sentences = {
	["Short"] = {
		"hi01",
		"hi02",
		"ok01",
		"ok02",
		"no01",
		"no02",
		"ow01",
		"ow02"
	},
	["Med"] = {
		"question20",
		"question21",
		"question25",
		"question27",
		"question29",
		"question30",
		"question01",
		"question07",
		"question08",
		"question12",
		"question13",
		"question15",
		"question18",
		"question19"
	},
	["Long"] = {
		"question02",
		"question04",
		"question06",
		"question09",
		"question10",
		"question11",
		"question14",
		"gordead_ques15",
		"abouttime02"
	}
}

local function PlaySentence(client, length)
	if (length < 10) then
		client:EmitSound("vo/npc/male01/" .. table.Random(sentences["Short"]) .. ".wav", 1, 100)
	elseif (length < 30 ) then
		client:EmitSound("vo/npc/male01/" .. table.Random(sentences["Med"]) .. ".wav", 1, 100)
	else
		client:EmitSound("vo/npc/male01/" .. table.Random(sentences["Long"]) .. ".wav", 1, 100)
	end
end

local chatTypes = {
	["ic"] = true,
	["w"] = true,
	["wd"] = true,
	["y"] = true,
	["radio"] = true,
	["radio_eavesdrop"] = true,
	["radio_eavesdrop_yell"] = true,
	["dispatch"] = true,
	["dispatch_radio"] = true,
	["overwatch_radio"] = true,
	["dispatchota_radio"] = true,
	["dispatchcp_radio"] = true,
	["scanner_radio"] = true,
	["request"] = true
}

function Schema:MessageReceived(speaker, info)
	if (!speaker or !info or !info.chatType or !info.text) then return end

	if (chatTypes[info.chatType]) then
		PlaySentence(speaker, #info.text)
	end
end

function GAMEMODE:KeyRelease(client, key)
	if (!IsFirstTimePredicted()) then
		return
	end

	if (key == IN_USE) then
		local weapon = client:GetActiveWeapon()
		if (weapon and IsValid(weapon) and weapon:GetClass() == "weapon_physgun") then return false end

		if (!ix.menu.IsOpen()) then
			local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client

			local entity = util.TraceLine(data).Entity

			if (IsValid(entity) and isfunction(entity.GetEntityMenu)) then
				hook.Run("ShowEntityMenu", entity)
			end
		end

		timer.Remove("ixItemUse")

		client.ixInteractionTarget = nil
		client.ixInteractionStartTime = nil
	end
end


function Schema:CreateExtraCharacterTabInfo(character, informationSubframe, CreatePart)
	if (LocalPlayer():IsCombine()) or (character:GetFaction() == FACTION_CCR) then
		local editBodygroupsButton = informationSubframe:Add("DButton")
		editBodygroupsButton:Dock(BOTTOM)
		editBodygroupsButton:DockMargin(0, SScaleMin(25 / 3), 0, 0)
		editBodygroupsButton:SetText("Edit Character Bodygroups")
		editBodygroupsButton:SetFont("MenuFontBoldNoClamp")
		editBodygroupsButton:SetTall(SScaleMin(16.666666666667))
		editBodygroupsButton.Paint = function(_, w, h)
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(0, 1, w - 2, h - 1)

			surface.SetDrawColor(Color(111, 111, 136, 255 / 100 * 30))
			surface.DrawOutlinedRect(0, 0, w, h)
		end

		editBodygroupsButton.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")

			local panel = vgui.Create("ixBodygroupView")
			panel:SetViewModel(LocalPlayer():GetModel())
			panel:SetTarget(LocalPlayer(), LocalPlayer():GetCharacter():GetProxyColors())
		end
	end
end