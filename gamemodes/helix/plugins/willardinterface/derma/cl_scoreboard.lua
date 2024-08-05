--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local rowPaintFunctions = {
	function(width, height)
	end,

	function(width, height)
		surface.SetDrawColor(0, 0, 0, 80)
		surface.DrawRect(0, 0, width, height)

		surface.SetDrawColor(50, 50, 50, 255)
		surface.DrawOutlinedRect(0, -1, width, height + 1)
	end
}

-- character icon
-- we can't customize the rendering of ModelImage so we have to do it ourselves
local PANEL = {}

AccessorFunc(PANEL, "model", "Model", FORCE_STRING)
AccessorFunc(PANEL, "bHidden", "Hidden", FORCE_BOOL)

function PANEL:Init()
	self:SetSize(SScaleMin(43 / 3), SScaleMin(50 / 3))
	self.bodygroups = "000000000"
end

function PANEL:SetModel(model, skin, bodygroups)
	model = model:gsub("\\", "/")

	if (isstring(bodygroups) and bodygroups:utf8len() != 9) then
		self.bodygroups = "000000000"
	end

	self.model = model
	self.skin = skin
	self.path = "materials/spawnicons/" ..
		model:utf8sub(1, #model - 4) .. -- remove extension
		((isnumber(skin) and skin > 0) and ("_skin" .. tostring(skin)) or "") .. -- skin number
		(self.bodygroups != "000000000" and ("_" .. self.bodygroups) or "") .. -- bodygroups
		".png"

	local material = Material(self.path, "smooth")

	-- we don't have a cached spawnicon texture, so we need to forcefully generate one
	if (material:IsError()) then
		self.id = "ixScoreboardIcon" .. self.path
		self.renderer = self:Add("ModelImage")
		self.renderer:SetVisible(false)
		self.renderer:SetModel(model, skin, self.bodygroups)
		self.renderer:RebuildSpawnIcon()

		-- this is the only way to get a callback for generated spawn icons, it's bad but it's only done once
		hook.Add("SpawniconGenerated", self.id, function(lastModel, filePath, modelsLeft)
			filePath = filePath:gsub("\\", "/"):utf8lower()

			if (filePath == self.path) then
				hook.Remove("SpawniconGenerated", self.id)

				self.material = Material(filePath, "smooth")
				self.renderer:Remove()
			end
		end)
	else
		self.material = material
	end
end

function PANEL:SetBodygroup(k, v)
	if (k < 0 or k > 9 or v < 0 or v > 9) then
		return
	end

	self.bodygroups = self.bodygroups:SetChar(k + 1, v)
end

function PANEL:GetModel()
	return self.model or "models/error.mdl"
end

function PANEL:GetSkin()
	return self.skin or 1
end

function PANEL:DoClick()
end

function PANEL:DoRightClick()
end

function PANEL:OnMouseReleased(key)
	if (key == MOUSE_LEFT) then
		self:DoClick()
	elseif (key == MOUSE_RIGHT) then
		self:DoRightClick()
	end
end

function PANEL:Paint(width, height)
	if (!self.material) then
		return
	end

	surface.SetMaterial(self.material)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(0, 0, width, height)
end

function PANEL:Remove()
	if (self.id) then
		hook.Remove("SpawniconGenerated", self.id)
	end
end

vgui.Register("ixScoreboardIcon", PANEL, "Panel")

-- player row
PANEL = {}

AccessorFunc(PANEL, "paintFunction", "BackgroundPaintFunction")

function PANEL:Init()
	self:SetTall(SScaleMin(64 / 3))
	self.icon = self:Add("ixScoreboardIcon")
	self.icon:Dock(LEFT)
	self.icon:DockMargin(SScaleMin(20 / 3), SScaleMin(10 / 3), 0, SScaleMin(10 / 3))

	local topPushDown = SScaleMin(150 / 3)
	self.leftSideFrame = self:Add("Panel")
	self.leftSideFrame:SetWide((ScrW() - (topPushDown * 2)) * 0.5)
	self.leftSideFrame:Dock(LEFT)
	self.leftSideFrame.Paint = nil

	self.name = self.leftSideFrame:Add("DLabel")
	self.name:Dock(TOP)
	self.name:DockMargin(SScaleMin(20 / 3), SScaleMin(12 / 3), 0, 0)
	self.name:SetTextColor(color_white)
	self.name:SetFont("MenuFontBoldNoClamp")

	self.description = self.leftSideFrame:Add("DLabel")
	self.description:Dock(TOP)
	self.description:DockMargin(SScaleMin(21 / 3), 0, 0, 0)
	self.description:SetTextColor(Color(230, 230, 230, 255))
	self.description:SetFont("MenuFontNoClamp")

	self.rightSideFrame = self:Add("Panel")
	self.rightSideFrame:SetWide((ScrW() - (topPushDown * 2)) * 0.5)
	self.rightSideFrame:Dock(RIGHT)
	self.rightSideFrame.Paint = nil

	self.ping = self.rightSideFrame:Add("DLabel")
	self.ping:Dock(RIGHT)
	self.ping:DockMargin(SScaleMin(30 / 3), 0, SScaleMin(30 / 3), 0)
	self.ping:SetTextColor(color_white)
	self.ping:SetFont("ixSmallFont")

	self.pictureFrame = self.rightSideFrame:Add("Panel")
	self.pictureFrame:Dock(RIGHT)
	self.pictureFrame:DockMargin(SScaleMin(30 / 3), SScaleMin(8 / 3), 0, 0)
	self.pictureFrame:SetSize(SScaleMin(48 / 3), SScaleMin(32 / 3))
	self.pictureFrame.Paint = nil

	self.steamImage = self.pictureFrame:Add("AvatarImage")
	self.steamImage:SetSize( SScaleMin(48 / 3), SScaleMin(48 / 3) )
	self.steamImage.OnMouseReleased = function(pnl, key)
		if (key != MOUSE_RIGHT) then return end

		local client = self.player

		if (!IsValid(client)) then
			return
		end

		local menu = DermaMenu()

		menu:AddOption(L("viewProfile"), function()
			client:ShowProfile()
		end)

		menu:AddOption(L("copySteamID"), function()
			SetClipboardText(client:IsBot() and client:EntIndex() or client:SteamID())
		end)

		hook.Run("PopulateScoreboardPlayerMenu", client, menu)

		for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
			v:SetFont("MenuFontNoClamp")
		end

		menu:Open()
	end

	self.steamImage:SetHelixTooltip(function(tooltip)
		local client = self.player

		if (IsValid(self) and IsValid(client)) then
			ix.hud.PopulatePlayerTooltip(tooltip, client)
		end
	end)

	self.steamName = self.rightSideFrame:Add("DLabel")
	self.steamName:Dock(RIGHT)
	self.steamName:DockMargin(SScaleMin(30 / 3), 0, 0, 0)
	self.steamName:SetTextColor(color_white)
	self.steamName:SetFont("ixSmallFont")

	self.paintFunction = rowPaintFunctions[1]
	self.nextThink = CurTime() + 1
end

function PANEL:Update()
	local client = self.player
	local model = client:GetModel()
	local skin = client:GetSkin()
	local name = hook.Run("GetCharacterName", client, "scoreboard") or client:GetName()
	local steamName = client:SteamName()
	local ping = client:Ping()
	local description = hook.Run("GetCharacterDescription", client) or
		(client:GetCharacter() and client:GetCharacter():GetDescription()) or ""

	local bRecognize = false
	local localCharacter = LocalPlayer():GetCharacter()
	local character = IsValid(self.player) and self.player:GetCharacter()

	if (localCharacter and character) then
		bRecognize = hook.Run("IsCharacterRecognized", localCharacter, character:GetID())
			or hook.Run("IsPlayerRecognized", self.player)
	end

	self.icon:SetHidden(!bRecognize)

	if (!bRecognize) then
		self.icon.material = ix.util.GetMaterial("willardnetworks/tabmenu/scoreboard/question.png", "smooth nocull")
	end

	self:SetZPos(bRecognize and 1 or 2)

	if (bRecognize and (self.icon:GetModel() != model or self.icon:GetSkin() != skin)) then
		self.icon:SetModel(model, skin)
		self.icon:SetTooltip(nil)
	end

	-- no easy way to check bodygroups so we'll just set them anyway
	for _, v in pairs(client:GetBodyGroups()) do
		self.icon:SetBodygroup(v.id, client:GetBodygroup(v.id))
	end

	if (self.name:GetText() != name) then
		self.name:SetText(bRecognize and name or L("unknown"))
		self.name:SizeToContents()
	end

	if (self.description:GetText() != description) then
		if string.utf8len( description ) > 80 then
			local shortenedDesc = string.utf8sub(description, 1, 80)
			self.description:SetText(shortenedDesc.."...")
		else
			self.description:SetText(description)
		end

		self.description:SizeToContents()
	end

	if (self.ping:GetText() != ping) then
		self.ping:SetText(ping)
		self.ping:SizeToContents()
	end

	if (self.steamName:GetText() != steamName) then
		self.steamName:SetText(steamName)
		self.steamName:SizeToContents()
	end

	self.steamImage:SetPlayer( self.player, SScaleMin(54 / 3) )
end

function PANEL:Think()
	if (CurTime() >= self.nextThink) then
		self.nextThink = CurTime() + 1
		if (!IsValid(self.player)) then return end

		local client = self.player
		local team = client:Team()
		local hasActiveCombineSuit = client:GetNetVar("combineMaskEquipped")
		if team == FACTION_CP and !hasActiveCombineSuit then
			team = FACTION_CITIZEN
		end

		if (!IsValid(client) or !client:GetCharacter() or self.character != client:GetCharacter() or self.team != team) then
			if team == FACTION_CP and !hasActiveCombineSuit then
				return
			else
				self:Remove()
				self:GetParent():SizeToContents()
			end
		end
	end
end

function PANEL:SetPlayer(client)
	self.player = client
	self.team = client:Team()

	if self.team == FACTION_CP and !client:GetNetVar("combineMaskEquipped") then
		self.team = FACTION_CITIZEN
	end

	self.character = client:GetCharacter()

	self:Update()
end

function PANEL:Paint(width, height)
	self.paintFunction(width, height)
end

vgui.Register("ixScoreboardRow", PANEL, "EditablePanel")

-- faction grouping
PANEL = {}

AccessorFunc(PANEL, "faction", "Faction")

function PANEL:Init()
	self:DockMargin(0, 0, 0, 0)
	self:SetTall(SScaleMin(32 / 3))
	self:DockPadding(0, SScaleMin(31 / 3), 0, 0)

	self.nextThink = 0
end

function PANEL:AddPlayer(client, index)
	if (!IsValid(client) or !client:GetCharacter() or hook.Run("ShouldShowPlayerOnScoreboard", client, self) == false) then
		return false
	end

	local id = index == 0 and 1 or 2
	local panel = self:Add("ixScoreboardRow")
	panel:SetPlayer(client)
	panel:Dock(TOP)
	panel:SetZPos(2)
	panel:SetBackgroundPaintFunction(rowPaintFunctions[id])

	self:SizeToContents()
	client.ixScoreboardSlot = panel

	return true
end

function PANEL:SetFaction(faction)
	self:SetColor(faction.color)

	local scoreboardTitle = self:Add("DLabel")
	scoreboardTitle:SetText(L(faction.name))
	scoreboardTitle:SetFont("MenuFontLargerBoldNoFix")
	scoreboardTitle:SetPos(SScaleMin(50 / 3), SScaleMin(5 / 3))
	scoreboardTitle:SizeToContents()

	self.faction = faction

	self.Paint = function(this, w, h)
		surface.SetDrawColor(ColorAlpha(faction.color, 40))
		surface.DrawRect(1, 0, this:GetWide() - 2, SScaleMin(31 / 3))
	end
end

function PANEL:Update()
	local faction = self.faction
	local players = team.GetPlayers(faction.index)
	for _, v in pairs(player.GetAll()) do
		if faction.index == FACTION_CP then
			if !v:GetNetVar("combineMaskEquipped") and v:Team() == FACTION_CP then
				table.RemoveByValue(players, v)
			end

			if !ix.config.Get("ShowCPsOnScoreboard", false) then
				if LocalPlayer():Team() != FACTION_ADMIN and LocalPlayer():Team() != FACTION_SERVERADMIN and LocalPlayer():Team() != FACTION_MCP and !LocalPlayer():IsCombine() then
					table.RemoveByValue(players, v)
				end
			end
		end

		if faction.index == FACTION_CITIZEN then
			if !v:GetNetVar("combineMaskEquipped") and v:Team() == FACTION_CP then
				table.insert(players, v)
			end
		end
	end

	local ownChar = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
	for _, v in pairs(player.GetAll()) do
		local targetChar = v.GetCharacter and v:GetCharacter()
		if (targetChar) then
			local playerFaction = ix.faction.Get(v:Team())
			if !v:GetNetVar("combineMaskEquipped") and v:Team() == FACTION_CP then
				playerFaction = ix.faction.Get(FACTION_CITIZEN)
			end

			if playerFaction and playerFaction.index == FACTION_CP and !ix.config.Get("ShowCPsOnScoreboard", false) then
				if LocalPlayer():Team() != FACTION_ADMIN and LocalPlayer():Team() != FACTION_SERVERADMIN and LocalPlayer():Team() != FACTION_MCP and !LocalPlayer():IsCombine() then
					continue
				end
			end

			if !playerFaction then playerFaction = ix.faction.Get(FACTION_CITIZEN) end
			if !playerFaction then continue end

			local separateTab = playerFaction.separateUnknownTab

			if !ownChar then continue end
			local doesRecognizeTarget = ownChar.DoesRecognize and ownChar:DoesRecognize(targetChar)

			v.unknown = !separateTab and !doesRecognizeTarget

			if (self.unknown and v.unknown) then
				table.insert(players, v)
			end
		end
	end

	if (self.group) then
		players = {}

		for _, v in pairs(self.faction:GetOnlineMembers()) do
			if (v:GetCharacter() and LocalPlayer():GetCharacter():DoesRecognize(v:GetCharacter())) then
				v.group = faction
				table.insert(players, v)
			end
		end
	end

	if (table.IsEmpty(players) or (self.group and faction.hidden)) then
		self:SetVisible(false)
		self:GetParent():InvalidateLayout()
	else
		local bHasPlayers

		for k, v in ipairs(players) do
			if (!self.unknown and v.unknown) then continue end
			if (!self.group and v.group and !v.group.hidden and !faction.separateUnknownTab) then continue end

			if (!IsValid(v.ixScoreboardSlot)) then
				if (self:AddPlayer(v, k)) then
					bHasPlayers = true
				end
			else
				v.ixScoreboardSlot:Update()
				bHasPlayers = true
			end
		end

		self:SetVisible(bHasPlayers)
	end
end

vgui.Register("ixScoreboardFaction", PANEL, "ixCategoryPanel")

-- main scoreboard panel
PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.scoreboard)) then
		ix.gui.scoreboard:Remove()
	end

	local titlePushDown = SScaleMin(30 / 3)
	local topPushDown = SScaleMin(150 / 3)
	local scale780 = SScaleMin(780 / 3)
	local scale120 = SScaleMin(120 / 3)

	self:SetWide(ScrW() - (topPushDown * 2))

	local sizeXtitle, sizeYtitle = self:GetWide(), scale120
	local sizeXcontent, sizeYcontent = self:GetWide(), (scale780)

	self.titlePanel = self:Add("Panel")
	self.titlePanel:SetSize(sizeXtitle, sizeYtitle)
	self.titlePanel:SetPos(self:GetWide() * 0.5 - self.titlePanel:GetWide() * 0.5)

	self:CreateTitleText()

	self.contentFrame = self:Add("DScrollPanel")
	self.contentFrame:SetSize(sizeXcontent, sizeYcontent)
	self.contentFrame:SetPos(self:GetWide() * 0.5 - self.contentFrame:GetWide() * 0.5, titlePushDown)

	self:SetTall(scale120 + scale780 + titlePushDown)
	self:Center()

	self:Update()

	ix.gui.scoreboard = self
end

function PANEL:Update()
	self.contentFrame:Clear()

	self.factions = {}
	self.groups = {}
	self.nextThink = 0

	local groups = hook.Run("GetGroups")

	if (groups) then
		for _, v in pairs(groups) do
			if (self.groups[v:GetID()]) then continue end
			if (!v.active) then continue end

			local panel = self.contentFrame:Add("ixScoreboardFaction")
			panel:SetFaction(v)
			panel:Dock(TOP)
			panel.group = true

			table.insert(self.factions, panel)

			self.groups[v:GetID()] = true
		end
	end

	for i = 1, #ix.faction.indices do
		local faction = ix.faction.indices[i]

		local panel = self.contentFrame:Add("ixScoreboardFaction")
		panel:SetFaction(faction)
		panel:Dock(TOP)

		table.insert(self.factions, panel)
	end

	local unknownFaction = self.contentFrame:Add("ixScoreboardFaction")
	unknownFaction.unknown = true
	unknownFaction:SetFaction({
		color = Color(200, 200, 200),
		name = "unknown"
	})
	unknownFaction:Dock(TOP)

	table.insert(self.factions, unknownFaction)
end

function PANEL:CreateTitleText()
	local scoreboardIcon = self.titlePanel:Add("DImage")
	scoreboardIcon:SetImage("willardnetworks/tabmenu/navicons/scoreboard.png")
	scoreboardIcon:SetSize(SScaleMin(23 / 3), SScaleMin(17 / 3))

	local scoreboardTitle = self.titlePanel:Add("DLabel")
	scoreboardTitle:SetFont("TitlesFontNoClamp")
	scoreboardTitle:SetText("Scoreboard")
	scoreboardTitle:SizeToContents()
	scoreboardTitle:SetPos(SScaleMin(30 / 3), scoreboardIcon:GetTall() * 0.5 - scoreboardTitle:GetTall() * 0.5)
end

function PANEL:Think()
	if (CurTime() >= self.nextThink) then
		for _, v in pairs(self.factions) do
			v:Update()
		end

		self.nextThink = CurTime() + 0.5
	end
end

vgui.Register("ixScoreboard", PANEL, "EditablePanel")

hook.Add("CreateMenuButtons", "ixScoreboard", function(tabs)
	tabs["scoreboard"] = {

		RowNumber = 3,

		Width = 23,

		Height = 17,

		Icon = "willardnetworks/tabmenu/navicons/scoreboard.png",

		Create = function(info, container)
			container:Add("ixScoreboard")
		end
	}
end)
