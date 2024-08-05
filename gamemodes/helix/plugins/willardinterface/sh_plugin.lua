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

PLUGIN.name = "Willard UI"
PLUGIN.author = "Fruity"
PLUGIN.description = "The UI for Willard Industries."
PLUGIN.menuBackgrounds = PLUGIN.menuBackgrounds or {}
PLUGIN.logoData = PLUGIN.logoData or {}
PLUGIN.buttonColors = PLUGIN.buttonColors or {}

ix.util.Include("sh_fonts.lua")
ix.util.Include("sh_hud.lua")
ix.util.Include("cl_overrides.lua")
ix.util.Include("sv_plugin.lua")
ix.util.IncludeDir("helix/plugins/willardinterface/editablequiz", true)
ix.util.IncludeDir("helix/plugins/willardinterface/mainmenu-manager", true)
ix.util.IncludeDir("helix/plugins/willardinterface/editablequiz/derma", true)
ix.util.IncludeDir("helix/plugins/willardinterface/mainmenu-manager/derma", true)

CAMI.RegisterPrivilege({
	Name = "Helix - Character Creation Bypass",
	MinAccess = "admin"
})

ix.config.Add("CharCreationDisabled", false, "Whether or not char creation is enabled.", nil, {
	category = "Characters"
})

ix.config.Add("IntroTextLong", "", "The long text shown in the intro.", nil, {
	category = "Appearance",
	type = ix.type.string
})

ix.lang.AddTable("english", {
	optDisableAutoScrollChat = "Disable Auto Scroll Chat",
	optdDisableAutoScrollChat = "Whether or not the chatbox should NOT scroll automatically."
})

ix.lang.AddTable("spanish", {
	optDisableAutoScrollChat = "Desactiva el Auto Scroll del Chat"
})

ix.option.Add("disableAutoScrollChat", ix.type.bool, false, {
	category = "Chat"
})

ix.config.Add("ShowCPsOnScoreboard", true, "Whether or not CP's show on scoreboard.", nil, {
	category = "Characters"
})

ix.config.Add("CheckCrimeAmountNeeded", 4,
	"How many CP's are required to be online before the CheckCrime command allows crime.", nil, {
	data = {min = 1, max = 10},
	category = "Characters"
})

ix.config.Add("CheckPettyAmountNeeded", 2,
	"How many CP's are required to be online before the CheckPetty command allows petty crime.", nil, {
	data = {min = 1, max = 5},
	category = "Characters"
})

ix.config.Add("CheckOverwatchAmountNeeded", 4,
	"How many CCG or OTA are required to be online before the CheckOverwatch command allows crime.", nil, {
	data = {min = 1, max = 8},
	category = "Characters"
})

ix.command.Add("CheckCrime", {
	description = "See if there are enough CP's online to commit a crime.",
	OnRun = function(self, client)
		local count = 0
		for _, v in pairs(player.GetAll()) do
			if !IsValid(v) then continue end
			--luacheck: ignore 1
			if v:Team() != FACTION_CP then continue end

			count = count + 1
		end

		if count >= ix.config.Get("CheckCrimeAmountNeeded", 4) then
			client:Notify("There are enough CPs online to commit crime.")
		else
			client:Notify("Not enough CPs online to commit crimes.")
		end
	end
})

ix.command.Add("CheckPetty", {
	description = "See if there are enough CP's online to commit a petty crime.",
	OnRun = function(self, client)
		local count = 0
		for _, v in pairs(player.GetAll()) do
			if !IsValid(v) then continue end
			--luacheck: ignore 1
			if v:Team() != FACTION_CP then continue end

			count = count + 1
		end

		if count >= ix.config.Get("CheckPettyAmountNeeded", 2) then
			client:Notify("There are enough CPs online to commit petty crime.")
		else
			client:Notify("Not enough CPs online to commit petty crimes.")
		end
	end
})

ix.command.Add("CheckOverwatch", {
	description = "See if there are enough CCG or OTA online to commit a major crime on Nexus or Administrative functions.",
	OnRun = function(self, client)
		local count = 0
		for _, v in pairs(player.GetAll()) do
			if !IsValid(v) then continue end
			--luacheck: ignore 1
			if v:Team() != FACTION_OTA then continue end

			count = count + 1
		end

		if count >= ix.config.Get("CheckOverwatchAmountNeeded", 4) then
			client:Notify("There are enough OTA online to commit an assault on Overwatch.")
		else
			client:Notify("Not enough OTA online to commit an assault on Overwatch.")
		end
	end
})

if (SERVER) then
	function PLUGIN:CanPlayerCreateCharacter(client)
		if (ix.config.Get("CharCreationDisabled") and !CAMI.PlayerHasAccess(client, "Helix - Character Creation Bypass")) then
			return false
		end
	end
else
	local genDescColor = Color(255, 255, 255)
	function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
		if (character) then
			local faction = ix.faction.Get(client:Team())
			if (faction.noGenDesc) then return end

			local geneticDesc = {}
			local bMask = client:GetNetVar("ixMaskEquipped")
			if (!faction.noAge and !bMask and character:GetAge() != "N/A") then
				geneticDesc[#geneticDesc + 1] = character:GetAge()
			end
			if (!faction.noEyeColor and !bMask and character:GetEyeColor() != "N/A") then
				geneticDesc[#geneticDesc + 1] = character:GetEyeColor().." eyes"
			end
			if (!faction.noHeight and character:GetHeight() != "N/A") then
				table.insert(geneticDesc, math.min(2, #geneticDesc + 1), character:GetHeight()..(#geneticDesc > 0 and "" or " tall"))
			end

			if (#geneticDesc > 0) then
				local genDesc = tooltip:AddRow("geneticDesc")
				genDesc:SetBackgroundColor(genDescColor)
				genDesc:SetText(string.utf8upper(table.concat(geneticDesc, " | ")))
				genDesc:SizeToContents()
			end
		end
	end
end

ix.char.RegisterVar("background", {
	field = "background",
	fieldType = ix.type.string,
	default = "",
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("age", {
	field = "age",
	fieldType = ix.type.string,
	default = "N/A",
	bNoDisplay = true
})

ix.char.RegisterVar("height", {
	field = "height",
	fieldType = ix.type.string,
	default = "N/A",
	bNoDisplay = true
})

ix.char.RegisterVar("eyeColor", {
	field = "eyeColor",
	fieldType = ix.type.string,
	default = "N/A",
	bNoDisplay = true
})

ix.char.RegisterVar("hairColor", {
	field = "hairColor",
	fieldType = ix.type.string,
	default = "N/A",
	bNoDisplay = true
})

function PLUGIN:AdjustCreationPayload(client, payload, newPayload)
    if (newPayload.data.background) then
        newPayload.background = newPayload.data.background
        newPayload.data.background = nil
	end

	if (newPayload.data.age) then
        newPayload.age = newPayload.data.age
        newPayload.data.age = nil
	end

	if (newPayload.data.height) then
        newPayload.height = newPayload.data.height
        newPayload.data.height = nil
	end

	if (newPayload.data["eye color"]) then
        newPayload.eyeColor = newPayload.data["eye color"]
        newPayload.data["eye color"] = nil
	end
end

if (CLIENT) then
	hook.Add("CreateMenuButtons", "ixConfig", function(tabs)
		if (!CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Manage Config", nil)) then
			return
		end

			tabs["Admin"] = {

			Width = 16,

			Height = 17,

			Right = true,

			Icon = "willardnetworks/tabmenu/navicons/admin.png",

			Create = function(info, container)
				local settings = container:Add("ixSettings")
				settings:SetSearchEnabled(true)

				if settings.settingsTitle then
					settings.settingsTitleIcon:SetImage("willardnetworks/tabmenu/navicons/admin.png")
					settings.settingsTitleIcon:SetSize(SScaleMin(16 / 3), SScaleMin(17 / 3))

					settings.settingsTitle:SetFont("TitlesFontNoClamp")
					settings.settingsTitle:SetText("Admin")
					settings.settingsTitle:SetPos(SScaleMin(26 / 3))
					settings.settingsTitle:SizeToContents()
					settings.settingsTitle:SetPos(SScaleMin(26 / 3), settings.settingsTitleIcon:GetTall()
					* 0.5 - settings.settingsTitle:GetTall() * 0.5)
				end

				-- gather categories
				local categories = {}
				local categoryIndices = {}

				for k, v in pairs(ix.config.stored) do
					local index = v.data and v.data.category or "misc"

					categories[index] = categories[index] or {}
					categories[index][k] = v
				end

				-- sort by category phrase
				for k, _ in pairs(categories) do
					categoryIndices[#categoryIndices + 1] = k
				end

				table.sort(categoryIndices, function(a, b)
					return L(a) < L(b)
				end)

				-- add panels
				for _, category in ipairs(categoryIndices) do
					local categoryPhrase = L(category)
					settings:AddCategory(categoryPhrase)

					-- we can use sortedpairs since configs don't have phrases to account for
					for k, v in SortedPairs(categories[category]) do
						if (isfunction(v.hidden) and v.hidden()) then
							continue
						end

						local data = v.data.data
						local type = v.type
						local value = ix.util.SanitizeType(type, ix.config.Get(k))

						-- @todo check ix.gui.properties
						local row = settings:AddRow(type, categoryPhrase)
						row:SetText(ix.util.ExpandCamelCase(k))
						row:Populate(v.data.key, v.data)

						-- type-specific properties
						if (type == ix.type.number) then
							row:SetMin(data and data.min or 0)
							row:SetMax(data and data.max or 1)
							row:SetDecimals(data and data.decimals or 0)
						end

						row:SetValue(value, true)
						row:SetShowReset(value != v.default, k, v.default)

						row.OnValueChanged = function(panel)
							local newValue = ix.util.SanitizeType(type, panel:GetValue())

							panel:SetShowReset(newValue != v.default, k, v.default)

							net.Start("ixConfigSet")
								net.WriteString(k)
								net.WriteType(newValue)
							net.SendToServer()
						end

						row.OnResetClicked = function(panel)
							panel:SetValue(v.default, true)
							panel:SetShowReset(false)

							net.Start("ixConfigSet")
								net.WriteString(k)
								net.WriteType(v.default)
							net.SendToServer()
						end

						row:GetLabel():SetHelixTooltip(function(tooltip)
							local title = tooltip:AddRow("name")
							title:SetImportant()
							title:SetText(k)
							title:SizeToContents()
							title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

							local description = tooltip:AddRow("description")
							description:SetText(v.description)
							description:SizeToContents()
						end)
					end
				end

				settings:SizeToContents()
				container.panel = settings

				if settings.titlePanel then
					local pluginManager = settings.titlePanel:Add("DButton")
					pluginManager:Dock(RIGHT)
					pluginManager:SetWide(SScaleMin(100 / 3))
					pluginManager:SetFont("TitlesFontNoClamp")
					pluginManager:SetText("PLUGINS")
					pluginManager:DockMargin(0, 0, 0, settings.titlePanel:GetTall() - SScaleMin(26 / 3))
					pluginManager.Paint = function(self, w, h)
						surface.SetDrawColor(ColorAlpha(color_white, 100))
						surface.DrawOutlinedRect(0, 0, w, h)
					end

					pluginManager.DoClick = function()
						surface.PlaySound("helix/ui/press.wav")
						for _, v in pairs(container.panel:GetChildren()) do
							v:SetVisible(false)
						end

						ix.gui.pluginManager = container.panel:Add("ixPluginManager")

						if ix.gui.pluginManager.settingsTitle then
							ix.gui.pluginManager.settingsTitle:SetText("Plugins")

							local configManager = ix.gui.pluginManager.titlePanel:Add("DButton")
							configManager:Dock(RIGHT)
							configManager:SetWide(SScaleMin(100 / 3))
							configManager:SetFont("TitlesFontNoClamp")
							configManager:SetText("CONFIG")
							configManager:DockMargin(0, 0, 0, settings.titlePanel:GetTall() - SScaleMin(26 / 3))
							configManager.Paint = function(self, w, h)
								surface.SetDrawColor(ColorAlpha(color_white, 100))
								surface.DrawOutlinedRect(0, 0, w, h)
							end

							configManager.DoClick = function()
								surface.PlaySound("helix/ui/press.wav")
								for _, v in pairs(container.panel:GetChildren()) do
									v:SetVisible(true)
								end

								ix.gui.pluginManager:Remove()
							end
						end
					end

					local quizManager = settings.titlePanel:Add("DButton")
					quizManager:Dock(RIGHT)
					quizManager:SetWide(SScaleMin(150 / 3))
					quizManager:SetFont("TitlesFontNoClamp")
					quizManager:SetText("QUIZ MANAGER")
					quizManager:DockMargin(0, 0, SScaleMin(10 / 3), settings.titlePanel:GetTall() - SScaleMin(26 / 3))
					quizManager.Paint = function(self, w, h)
						surface.SetDrawColor(ColorAlpha(color_white, 100))
						surface.DrawOutlinedRect(0, 0, w, h)
					end

					quizManager.DoClick = function()
						surface.PlaySound("helix/ui/press.wav")
						vgui.Create("QuizPanel")
					end

					local mainMenuManager = settings.titlePanel:Add("DButton")
					mainMenuManager:Dock(RIGHT)
					mainMenuManager:SetWide(SScaleMin(220 / 3))
					mainMenuManager:SetFont("TitlesFontNoClamp")
					mainMenuManager:SetText("MAIN MENU MANAGER")
					mainMenuManager:DockMargin(0, 0, SScaleMin(10 / 3), settings.titlePanel:GetTall() - SScaleMin(26 / 3))
					mainMenuManager.Paint = function(self, w, h)
						surface.SetDrawColor(ColorAlpha(color_white, 100))
						surface.DrawOutlinedRect(0, 0, w, h)
					end

					mainMenuManager.DoClick = function()
						surface.PlaySound("helix/ui/press.wav")
						vgui.Create("MainMenuManager")
					end
				end
			end,

			OnSelected = function(info, container)
				container.panel.searchEntry:RequestFocus()
			end,

			RowNumber = 6
		}
	end)

	hook.Add("Think", "F1Menu", function()
		if input.IsKeyDown( KEY_F1 ) then
			if ix.gui.menu and ix.gui.menu:IsVisible() then
				return
			end

			if ix.gui.characterMenu and ix.gui.characterMenu:IsVisible() then
				return
			end

			if ix.gui.protectionTeams and ix.gui.protectionTeams:IsVisible() then
				return
			end

			if LocalPlayer():GetCharacter() then
				if ix.gui.F1Menu and ix.gui.F1Menu:IsVisible() then
					return
				end

				ix.gui.F1Menu = vgui.Create("ixF1Menu")
			end
		end
	end)
end

function PLUGIN:LoadData()
	local loaded = ix.data.Get("menuData", {})
	self.menuBackgrounds = loaded[1] or {}
	self.logoData = loaded[2] or {}
	self.buttonColors = loaded[3] or {}
end

function PLUGIN:SaveData()
	ix.data.Set("menuData", {self.menuBackgrounds, self.logoData, self.buttonColors})
end
