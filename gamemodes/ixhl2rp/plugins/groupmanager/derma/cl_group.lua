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

local boxPattern = Material("willardnetworks/tabmenu/crafting/box_pattern.png", "noclamp")

-- Shared frame painting function between two VGUI registrations
local function PaintFrames(self, w, h, bCustom)
	local value = 100
	if bCustom then value = 200 end
	if isnumber(bCustom) then value = bCustom end
	local color
	if !isnumber(bCustom) then
		color = Color(0, 0, 0, value)
	else
		color = Color(25, 25, 25, value)
	end

	surface.SetDrawColor(color)
	surface.DrawRect(0, 0, w, h)

	if bCustom then
		surface.SetDrawColor(ColorAlpha(color_white, 30))
		surface.SetMaterial(boxPattern)
		surface.DrawTexturedRectUV( 0, 0, w, h, 0, 0, w / SScaleMin(414 / 3), h / SScaleMin(677 / 3) )
	end

	surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
end

function PANEL:Init()
	ix.gui.group = self

	local titlePushDown = SScaleMin(30 / 3)
	local padding = SScaleMin(30 / 3)
	local margin = SScaleMin(10 / 3)
	local iconSize = SScaleMin(18 / 3)
	local topPushDown = SScaleMin(150 / 3)
	local scale780 = SScaleMin(780 / 3)
	local scale120 = SScaleMin(120 / 3)

	self:SetWide(ScrW() - (topPushDown * 2))

	local sizeXtitle, sizeYtitle = self:GetWide(), scale120
	local sizeXcontent, sizeYcontent = self:GetWide(), (scale780)

	self.titlePanel = self:Add("Panel")
	self.titlePanel:SetSize(sizeXtitle, sizeYtitle)
	self.titlePanel:SetPos(self:GetWide() * 0.5 - self.titlePanel:GetWide() * 0.5)
	self.titlePanel.noRemove = true

	self:CreateTitleText()

	self.padding = SScaleMin(15 / 3)

	self.contentFrame = self:Add("Panel")
	self.contentFrame:SetSize(sizeXcontent, sizeYcontent)
	self.contentFrame:SetPos(self:GetWide() * 0.5 - self.contentFrame:GetWide() * 0.5, titlePushDown)
	self.contentFrame.noRemove = true
	self.contentFrame.Paint = function(self, w, h)
		PaintFrames(self, w, h)
	end

	self:SetTall(scale120 + scale780 + titlePushDown)
	self:Center()

	self.receivedMembers = nil

	self:Rebuild()
end

function PANEL:CreateTitleText()
	local groupTitleIcon = self.titlePanel:Add("DImage")
	groupTitleIcon:SetImage("willardnetworks/tabmenu/charmenu/faction.png")
	groupTitleIcon:SetSize(SScaleMin(23 / 3), SScaleMin(17 / 3))

	self.groupTitle = self.titlePanel:Add("DLabel")
	self.groupTitle:SetFont("TitlesFontNoClamp")
	self.groupTitle:SetText("Group")
	self.groupTitle:SizeToContents()
	self.groupTitle:SetPos(SScaleMin(33 / 3), SScaleMin(16 / 3) * 0.5 - self.groupTitle:GetTall() * 0.5)
end

function PANEL:Rebuild()
	self.contentFrame:Clear()
	self.buttonlist = {}

	local character = LocalPlayer():GetCharacter()
	local group = character:GetGroup()

	if (group) then
		if (group.active) then
			self:CreateActiveGroupPanel(group, character)
		else
			self:CreateNonActiveGroupPanel(group)
		end
	else
		self:CreateCreationPanel()
	end
end

-- The creation panel of groups
function PANEL:CreateCreationPanel()
	self:CreateLogo(0.21)

	-- Create group creation title
	local title = self.contentFrame:Add("DLabel")
	self:CreateTitleLabel(title, string.utf8upper("group creation"))

	-- Create info text
	local infoText = self.contentFrame:Add("DLabel")
	self:CreateLabel(infoText, "This tool grants you access to assemble players together in a group. You'll have access to a info\n tab, members list, lore tab and customizable roles. You cannot be in multiple groups, only one.", Color(230, 230, 230, 255))

	-- Create warning text
	local warningText = self.contentFrame:Add("DLabel")
	self:CreateLabel(warningText, "Keep in mind, non-lore friendly names will be changed and may result in a ban.", Color(255, 78, 69, 255), true)

	-- Create textentry
	self.textEntry = self.contentFrame:Add("DTextEntry")
	self:CreateTextEntry(self.textEntry, true, infoText:GetTall(), false, false, false, "Write your group name here...")

	-- Create sign up amount requirement text
	local yellowText = self.contentFrame:Add("DLabel")
	self:CreateWarningText(yellowText, "At least 3 players must sign up to create a group.")

	-- Create creation button
	self.createButton = self.contentFrame:Add("DButton")
	self:CreateButton(self.createButton, "Create group", Color(111, 111, 136, 255), function()
		if string.utf8len(self.textEntry:GetValue()) <= 2 then
			LocalPlayer():NotifyLocalized("Your group name needs to be a minimum of 3 characters!")
			return
		end

		netstream.Start("ixGroupCreate", self.textEntry:GetValue())
	end)
end

-- The non active waiting for 4 players panel
function PANEL:CreateNonActiveGroupPanel(group)
	self:CreateLogo(0.25)

	-- Create group title
	local title = self.contentFrame:Add("DLabel")
	self:CreateTitleLabel(title, group.name or "error")

	-- Create pending text
	local text = self.contentFrame:Add("DLabel")
	self:CreateLabel(text, "This group is still pending, requiring more members to be made official.", Color(230, 230, 230, 255))

	-- Create text continuation to center properly
	local text2 = self.contentFrame:Add("DLabel")
	self:CreateLabel(text2, "Once the group is official, you'll have access to the group interface.", Color(230, 230, 230, 255), false, true)

	-- Create sign up player requirement text
	local warning = self.contentFrame:Add("DLabel")
	self:CreateWarningText(warning, "At least 3 players must sign up to create a group.")

	-- Create acceptance number text
	local count = group:GetMembersCount() - 1
	self.label = self.contentFrame:Add("DLabel")
	self:CreateWarningText(self.label, count.."/3 players accepted", true)

	-- Create leave button
	self:CreateLeaveButton()
end

-- The panel when the group is active after inviting 3 players
function PANEL:CreateActiveGroupPanel(group, character)
	local role = group:GetRole(character:GetID())
	self.contentFrame.Paint = nil
	self.groupTitle:SetText(group.name or "error")
	self.groupTitle:SizeToContents()

	-- Create left and right panels for main group panel
	self:CreateActiveGroupMainPanels()

	-- Create left panel buttons
	self:CreateLeftSideButtons(group, role, character)
end

-- Create left and right panels for active group panel
function PANEL:CreateActiveGroupMainPanels()
	self.leftSide = self.contentFrame:Add("Panel")
	self.leftSide:Dock(LEFT)
	self.leftSide:SetWide(self.contentFrame:GetWide() * 0.20)
	self.leftSide:DockMargin(0, 0, self.padding, 0)

	self.rightSide = self.contentFrame:Add("Panel")
	self.rightSide:Dock(RIGHT)
	self.rightSide:SetWide(self.contentFrame:GetWide() * 0.80 - self.padding)
end

-- Create left side buttons for active group panel
function PANEL:CreateLeftSideButtons(group, role, character)
	self.buttonlist = {}

	local infoButton = self.leftSide:Add("DButton")
	self:CreateLeftSideButton(infoButton, "Info", "willardnetworks/tabmenu/group/group_info.png", function()
		self:CreateRightSideTopBar("willardnetworks/tabmenu/group/group_info.png", "info", function()
			self.groupUpdater = self:Add("ixGroupUpdater")
			self.groupUpdater.textEntry:SetText(group.info)
			self.groupUpdater.callback = function()
				netstream.Start("ixGroupEditInfo", group:GetID(), self.groupUpdater.textEntry:GetText())
			end
		end, role, {GROUP_LEAD, GROUP_MOD})

		self:CreateRightSideMain(group)
		self:CreateTabLabel(group, group.info)
	end)

	if !self.lastSelected then
		infoButton.DoClick()
	end

	local membersButton = self.leftSide:Add("DButton")
	self:CreateLeftSideButton(membersButton, "Members", "willardnetworks/tabmenu/group/group_members.png", function()
		self:CreateRightSideTopBar("willardnetworks/tabmenu/group/group_members.png", "members")

		self:CreateRightSideMain(group, true)
		self.rightSideMain.Paint = nil
		self:CreateMembers(role, group, character)
	end)

	local loreButton = self.leftSide:Add("DButton")
	self:CreateLeftSideButton(loreButton, "Lore", "willardnetworks/tabmenu/group/group_lore.png", function()
		self:CreateRightSideTopBar("willardnetworks/tabmenu/group/group_lore.png", "lore", function()
			self.groupUpdater = self:Add("ixGroupUpdater")
			self.groupUpdater.textEntry:SetText(group.lore)
			self.groupUpdater.callback = function()
				netstream.Start("ixGroupEditLore", group:GetID(), self.groupUpdater.textEntry:GetText())
			end
		end, role, {GROUP_LEAD, GROUP_MOD})

		self:CreateRightSideMain(group)
		self:CreateTabLabel(group, group.lore)
	end)

	local forumsButton = self.leftSide:Add("DButton")
	self:CreateLeftSideButton(forumsButton, "Forums", "willardnetworks/tabmenu/group/group_forums.png", function()
		self:CreateRightSideTopBar("willardnetworks/tabmenu/group/group_forums.png", "forum link", function()
			self.groupUpdater = self:Add("ixGroupUpdater")
			self.groupUpdater.textEntry:SetText(group.forum)
			self.groupUpdater.callback = function()
				netstream.Start("ixGroupEditForum", group:GetID(), self.groupUpdater.textEntry:GetText())
			end
		end, role, GROUP_LEAD)

		self:CreateRightSideMain(group, true, true, true)
		self:CreateDHTMLPanel(group.forum)
	end)

	if role then
		if role.id then
			if role.id == GROUP_LEAD then
				local leaderButton = self.leftSide:Add("DButton")
				self:CreateLeftSideButton(leaderButton, "Administration", "willardnetworks/tabmenu/group/group_lead.png", function()
					self:CreateRightSideTopBar("willardnetworks/tabmenu/group/group_lead.png", "administration")

					self:CreateRightSideMain(group, true, true)
					self:CreateGroupAdminConfigs(role, group, character)
				end)
			end
		end
	end

	local leaveButton = self.leftSide:Add("DButton")
	self:CreateLeftSideButton(leaveButton, "Leave Group", "willardnetworks/tabmenu/group/group_leave.png", function()
		if role and role.id != GROUP_LEAD then
			self.groupTitle:SetText("Group")
			self.groupTitle:SizeToContents()
		end

		netstream.Start("ixGroupLeave")
	end, true)
end

-- Helper paint function for outlined rectangles
local function PaintStandard(self, w, h, alpha)
	surface.SetDrawColor(Color(0, 0, 0, alpha))
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
	surface.DrawOutlinedRect(0, 0, w, h)
end

-- A function to create a left side button for active group panel
function PANEL:CreateLeftSideButton(parent, text, icon, callback, bLeave)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(35 / 3))
	parent:SetText(text)
	parent:SetFont("MenuFontNoClamp")
	parent:DockMargin(0, !bLeave and 0 or SScaleMin(12 / 3), 0, SScaleMin(2 / 3))
	parent:SetContentAlignment(4)
	parent:SetTextInset(SScaleMin(40 / 3), 0)
	parent.icon = icon

	parent.Paint = function(self, w, h)
		PaintStandard(self, w, h, 100)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material(self.icon))
		surface.DrawTexturedRect(SScaleMin(14 / 3), parent:GetTall() * 0.5 - SScaleMin(16 / 3) * 0.5, SScaleMin(16 / 3), SScaleMin(16 / 3))
	end

	parent.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		if !bLeave then
			self:SetSelected(parent)
			self.rightSide:Clear()
		end

		callback()
	end

	table.insert(self.buttonlist, parent)
end

-- A function to create a DHTML panel
function PANEL:CreateDHTMLPanel(link)
	local html = self.rightSideMain:Add("DHTML")
	html:Dock(FILL)
	html:OpenURL(link)
end

-- A function to set a left side button as selected
function PANEL:SetSelected(button)
	for k, v in pairs(self.buttonlist) do
		if v != button then
			v.Paint = function(self, w, h)
				PaintStandard(self, w, h, 100)

				surface.SetDrawColor(color_white)
				surface.SetMaterial(Material(self.icon))
				surface.DrawTexturedRect(SScaleMin(14 / 3), button:GetTall() * 0.5 - SScaleMin(16 / 3) * 0.5, SScaleMin(16 / 3), SScaleMin(16 / 3))
			end
		else
			self.lastSelected = k
		end
	end

	button.Paint = function(self, w, h)
		surface.SetDrawColor(Color(164, 54, 56, 255))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(color_white)
		surface.SetMaterial(Material(self.icon))
		surface.DrawTexturedRect(SScaleMin(14 / 3), button:GetTall() * 0.5 - SScaleMin(16 / 3) * 0.5, SScaleMin(16 / 3), SScaleMin(16 / 3))
	end
end

-- Creates a right side panel underneath top bar
function PANEL:CreateRightSideMain(group, bNoTitle, bNoScrollPanel, bNoPadding)
	self.rightSideMain = self.rightSide:Add(!bNoTitle and "Panel" or !bNoScrollPanel and "DScrollPanel" or "Panel")
	self.rightSideMain:Dock(FILL)

	if !bNoPadding then
		self.rightSideMain:DockPadding(50, 30, 50, 50)
	end

	self.rightSideMain.Paint = function(self, w, h)
		PaintFrames(self, w, h)
	end

	if !bNoTitle then
		local title = self.rightSideMain:Add("DLabel")
		title:Dock(TOP)
		title:SetContentAlignment(4)
		title:SetFont("LargerTitlesFontNoClamp")
		title:SetText(group.name or "error")
		title:SizeToContents()
		title:DockMargin(0, 0, 0, SScaleMin(20 / 3))
	end
end

-- Creates the label(s) of the tabs
function PANEL:CreateTabLabel(group, label)
	self.label = self.rightSideMain:Add("DLabel")
	self.label:SetWrap(true)
	self.label:SetFont("MenuFontNoClamp")
	self.label:Dock(TOP)
	if label == "" or label == nil then
		self.label:SetText("Nothing here yet...")
	else
		self.label:SetText(label)
	end

	self.label:SetAutoStretchVertical( true )
end

-- Creates a right side top bar
function PANEL:CreateRightSideTopBar(iconImage, name, editButtonCallback, role, permissions)
	self.topbar = self.rightSide:Add("Panel")
	self.topbar:SetTall(SScaleMin(35 / 3))
	self.topbar:Dock(TOP)
	self.topbar:DockMargin(0, 0, 0, SScaleMin(2 / 3))
	self.topbar.Paint = function(self, w, h)
		surface.SetDrawColor(Color(164, 54, 56, 255))
		surface.DrawRect(0, 0, w, h)
	end

	local icon = self.topbar:Add("DImage")
	icon:Dock(LEFT)
	icon:SetWide(SScaleMin(16 / 3))
	icon:SetImage(iconImage)
	icon:DockMargin(SScaleMin(50 / 3), self.topbar:GetTall() * 0.5 - SScaleMin(16 / 3) * 0.5, 0, self.topbar:GetTall() * 0.5 - SScaleMin(16 / 3) * 0.5)

	local title = self.topbar:Add("DLabel")
	title:Dock(LEFT)
	title:DockMargin(SScaleMin(6 / 3), 0, 0, 0)
	title:SetText(string.utf8upper(name))
	title:SetFont("MenuFontBoldNoClamp")
	title:SizeToContents()

	local hasAccess = false

	if permissions then
		if istable(permissions) then
			if role then
				if (role.id == permissions[1] or role.id == permissions[2]) then
					hasAccess = true
				end
			end
		else
			if role then
				if role.id == permissions then
					hasAccess = true
				end
			end
		end
	else
		hasAccess = true
	end

	if editButtonCallback and hasAccess then
		self.topbar.button = self.topbar:Add("DButton")
		self.topbar.button:Dock(RIGHT)
		self.topbar.button:SetWide(SScaleMin(100 / 3))
		self.topbar.button:SetText("Edit "..name)
		self.topbar.button:SetFont("MenuFontNoClamp")
		self.topbar.button:DockMargin(0, SScaleMin(5 / 3), SScaleMin(50 / 3), SScaleMin(5 / 3))
		self.topbar.button.Paint = function(self, w, h)
			PaintStandard(self, w, h, 200)
		end
		self.topbar.button.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			editButtonCallback()
		end
	end
end

local function CreateDivider(parent, bDockLeft)
	local divider = parent:Add("DShape")
	divider:SetType("Rect")
	divider:Dock(bDockLeft and LEFT or RIGHT)
	divider:SetWide(1)
	divider:SetColor(Color(111, 111, 136, (255 / 100 * 30)))
	divider:DockMargin(0, SScaleMin(4 / 3), 0, SScaleMin(4 / 3))
end

-- Creates a member row
function PANEL:CreateMemberRow(memberData, role, group, character)
	local row = self.rightSideMain:Add("Panel")
	row:Dock(TOP)
	row:SetTall(SScaleMin(50 / 3))
	row:DockPadding(SScaleMin(50 / 3), SScaleMin(3 / 3), SScaleMin(50 / 3), SScaleMin(3 / 3))
	row.Paint = function(self, w, h)
		PaintFrames(self, w, h)
	end

	local client = !isstring(memberData.player) and memberData.player or false
	local model, skin = "models/error.mdl", 0

	if memberData.id then
		if ix.char.loaded[memberData.id] then
			model = ix.char.loaded[memberData.id]:GetModel()
			skin = ix.char.loaded[memberData.id]:GetData("skin")
		end
	end

	self.icon = row:Add("ixScoreboardIcon")
	self.icon:Dock(LEFT)
	self.icon:DockMargin(0, SScaleMin(4 / 3), SScaleMin(10 / 3), SScaleMin(4 / 3))
	self.icon:SetWide(self.icon:GetWide() - SScaleMin(8 / 3))

	local bRecognize = false
	local localCharacter = LocalPlayer():GetCharacter()

	character = player.GetBySteamID64(memberData.steamid) and ix.char.loaded[memberData.id] or "bot"
	if (localCharacter and !isstring(character)) then
		bRecognize = localCharacter:DoesRecognize(character:GetID())
	end

	self.icon:SetHidden(!bRecognize)

	if (!bRecognize) then
		self.icon.material = ix.util.GetMaterial("willardnetworks/tabmenu/scoreboard/question.png", "smooth nocull")
	end

	if (bRecognize and (self.icon:GetModel() != model or self.icon:GetSkin() != skin)) then
		self.icon:SetModel(model, skin)
		self.icon:SetTooltip(nil)
	end

	if client and ix.char.loaded[memberData.id]:GetData("groups") then
		for k, v in pairs(ix.char.loaded[memberData.id]:GetData("groups")) do
			self.icon:SetBodygroup(k, v)
		end
	end

	if (role and (role.id == GROUP_LEAD or role.id == GROUP_MOD)) then
		self.icon.OnMouseReleased = function(pnl, key)
			if (key != MOUSE_RIGHT) then return end

			if (memberData.id == localCharacter:GetID()) then return end
			if !memberData.role then memberData.role = {} end
			if !memberData.role.id then memberData.role.id = GROUP_MEMBER end

			local dmenu = DermaMenu()
			dmenu:MakePopup()
			dmenu:SetPos(input.GetCursorPos())
			if (memberData.role.id > role.id) then
				dmenu:AddOption("Kick", function()
					netstream.Start("ixGroupKick", group.id, memberData.id)
				end)
			end

			local subMenu = dmenu:AddSubMenu("Set Role")

			for k, v in pairs(group:GetRoles()) do
				if (role.id == GROUP_LEAD or (role.id == GROUP_MOD and role.id < v.id)) then
					subMenu:AddOption(v.name, function()
						netstream.Start("ixGroupSetRole", group.id, memberData.id, v.id)
						netstream.Start("ixGroupRequestMembers", group:GetID())
						self.buttonlist[2].DoClick()
					end)
				end
			end

			for _, v in pairs(dmenu:GetChildren()[1]:GetChildren()) do
				if v:GetClassName() == "Label" then
					v:SetFont("MenuFontNoClamp")
				end
			end

			for _, v in pairs(subMenu:GetChildren()[1]:GetChildren()) do
				if v:GetClassName() == "Label" then
					v:SetFont("MenuFontNoClamp")
				end
			end
		end
	end

	local namedescPanel = row:Add("Panel")
	namedescPanel:Dock(FILL)

	local name = namedescPanel:Add("DLabel")
	name:Dock(TOP)
	name:SetFont("MenuFontLargerNoClamp")
	name:SetContentAlignment(4)
	name:SetText(memberData.name or "Unknown")
	name:SizeToContents()
	name:DockMargin(0, SScaleMin(2 / 3), 0, 0)

	local description = "Unknown"
	if !isstring(character) then
		description = localCharacter:DoesRecognize(character:GetID()) and memberData.description or "Unknown"
	end

	local desc = namedescPanel:Add("DLabel")
	desc:Dock(TOP)
	desc:SetFont("MenuFontNoClamp")
	desc:SetTextColor(Color(220, 220, 220, 255))
	desc:SetContentAlignment(4)
	desc:SetText(description)
	desc:SizeToContents()

	local steamImage = row:Add("AvatarImage")
	steamImage:Dock(RIGHT)
	steamImage:SetWide(SScaleMin(36 / 3))
	steamImage:DockMargin(SScaleMin(10 / 3), SScaleMin(4 / 3), 0, SScaleMin(4 / 3))
	steamImage.OnMouseReleased = function(pnl, key)
		if (key != MOUSE_RIGHT) then return end
		if (!client) then return end

		local menu = DermaMenu()

		menu:AddOption(L("viewProfile"), function()
			local url = "http://steamcommunity.com/profiles/"..memberData.steamid

			gui.OpenURL(url)
		end)

		menu:AddOption(L("copySteamID"), function()
			SetClipboardText(client:IsBot() and client:EntIndex() or memberData.steamid)
		end)

		menu:Open()

		for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
			if v:GetClassName() == "Label" then
				v:SetFont("MenuFontNoClamp")
			end
		end
	end

	steamImage:SetSteamID( memberData.steamid, 54 )

	steamworks.RequestPlayerInfo( memberData.steamid, function(steamName)
		local steamname = row:Add("DLabel")
		steamname:SetText(steamName)
		steamname:Dock(RIGHT)
		steamname:SetFont("MenuFontNoClamp")
		steamname:SizeToContents()
		steamname:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	end)

	CreateDivider(row)

	local role = row:Add("DLabel")
	role:SetText(memberData.role and memberData.role.name or group:GetRoleData(GROUP_MEMBER).name)
	role:Dock(RIGHT)
	role:SetFont("MenuFontNoClamp")
	role:SizeToContents()
	role:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)

	CreateDivider(row)

	local lastOnline = !memberData.online and os.date("%d.%m.%Y", memberData.last_join_time) or "N/A"
	local lastOnlineLabel = row:Add("DLabel")
	lastOnlineLabel:SetText(memberData.online and "Online" or lastOnline)
	lastOnlineLabel:Dock(RIGHT)
	lastOnlineLabel:SetFont("MenuFontNoClamp")
	lastOnlineLabel:SizeToContents()
	lastOnlineLabel:DockMargin(0, 0, SScaleMin(10 / 3), 0)
end

-- Create members function
function PANEL:CreateMembers(role, group, character)
	if (self.receivedMembers) then
		for k, v in pairs(self.receivedMembers) do
			self:CreateMemberRow(v, role, group, character)
		end
	else
		netstream.Start("ixGroupRequestMembers", group:GetID())
	end
end

-- A function to create an admin config row
function PANEL:CreateAdminConfigRow(labelText, currentConfig, callback, bColor, group, bRole, roleID)
	local row = bRole and self.rowPanel:Add("Panel") or self.rightSideMain:Add("Panel")
	row:Dock(TOP)
	row:SetTall(bRole and SScaleMin(40 / 3) or SScaleMin(50 / 3))
	row:DockPadding(0, SScaleMin(5 / 3), 0, SScaleMin(5 / 3))
	row:DockMargin(0, 0, 0, bColor and SScaleMin(50 / 3) or SScaleMin(10 / 3))
	row.Paint = function(self, w, h)
		PaintFrames(self, w, h)
	end

	local label = row:Add("DLabel")
	label:Dock(LEFT)
	label:SetContentAlignment(4)
	label:SetText(string.utf8upper(labelText)..":")
	label:SetFont("MenuFontLargerBoldNoFix")
	label:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)
	label:SizeToContents()

	if currentConfig then
		local currentText = row:Add("DLabel")
		currentText:Dock(LEFT)
		currentText:SetContentAlignment(4)
		currentText:SetText(currentConfig)
		currentText:SetFont("MenuFontNoClamp")
		currentText:SetTextColor(Color(220, 220, 220, 255))
		currentText:DockMargin(0, 0, SScaleMin(10 / 3), 0)
		currentText:SizeToContents()
	end

	if bColor then
		local color = row:Add("DShape")
		color:Dock(LEFT)
		color:DockMargin(0, SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
		color:SetType("Rect")
		color:SetWide(SScaleMin(50 / 3))
		color:SetColor(group.color)
	end

	if roleID and (roleID != GROUP_MOD and roleID != GROUP_LEAD) then
		local delete = row:Add("DImageButton")
		delete:Dock(RIGHT)
		delete:SetImage("willardnetworks/tabmenu/navicons/exit.png")
		delete:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
		delete:DockMargin(0, SScaleMin(5 / 3), SScaleMin(10 / 3), SScaleMin(5 / 3))
		delete.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			netstream.Start("ixGroupDeleteRole", group:GetID(), roleID)
		end
	end

	if callback then
		local rightSideButton = row:Add("DButton")
		rightSideButton:Dock(RIGHT)
		rightSideButton:SetWide(bRole and SScaleMin(120 / 3) or SScaleMin(200 / 3))
		rightSideButton:SetFont("MenuFontNoClamp")
		rightSideButton:SetText(bRole and "Edit role name" or "Edit "..labelText)
		rightSideButton:DockMargin(SScaleMin(10 / 3), 0, SScaleMin(10 / 3), 0)
		rightSideButton.Paint = function(self, w, h)
			PaintStandard(self, w, h, 100)
		end

		rightSideButton.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")
			callback()
		end
	end
end

-- A function to create the admin configs on the active group panel
function PANEL:CreateGroupAdminConfigs(role, group, character)
	if (role.id == GROUP_LEAD) then

		self.rowPanel = self.rightSideMain:Add("DScrollPanel")
		self.rowPanel:Dock(FILL)

		self:CreateAdminConfigRow("group name", group.name, function()
			Derma_StringRequest("Edit Group Name", "Enter group name", group.name, function(text)
				netstream.Start("ixGroupEditName", group:GetID(), text)
			end)
		end)

		self:CreateAdminConfigRow("group color", nil, function()
			self.colorMixer = self:Add("ixSettingsRowColorPicker")
			self.colorMixer:SetPos(gui.MousePos())
			self.colorMixer:SetValue(group.color)
			self.colorMixer.OnValueChanged = function()
				netstream.Start("ixGroupEditColor", group:GetID(), self.colorMixer:GetValue())
			end
		end, true, group)

		local defaultRoles = {
			[GROUP_LEAD] = true,
			[GROUP_MOD] = true,
			[GROUP_MEMBER] = true
		}

		for k, v in SortedPairsByMemberValue(group:GetRoles(), "id") do
			if v.id == GROUP_MEMBER then
				break
			end

			local standard = false
			local standardName = false
			if (defaultRoles[v.id]) then
				standardName = "GROUP MOD"
				if v.id == GROUP_LEAD then
					standardName = "GROUP LEAD"
				end

				standard = true
			end

			self:CreateAdminConfigRow(standard and standardName or "ROLE #"..v.id, v.name, function()
				Derma_StringRequest("Edit Name", "Enter name", v.name, function(text)
					netstream.Start("ixGroupEditRoleName", group:GetID(), v.id, text)
				end)
			end, false, group, true, v.id)
		end

		local bottomPanel = self.rightSideMain:Add("Panel")
		bottomPanel:Dock(BOTTOM)
		bottomPanel:SetTall(SScaleMin(30 / 3))
		bottomPanel:DockMargin(0, SScaleMin(10 / 3), 0, 0)

		self.addRole = bottomPanel:Add("DButton")
		self.addRole:SetText("Add Role")
		self.addRole:SetFont("MenuFontNoClamp")
		self.addRole:Dock(LEFT)
		self.addRole:SetSize(SScaleMin(80 / 3), SScaleMin(30 / 3))
		self.addRole.Paint = function(self, w, h)
			PaintStandard(self, w, h, 100)
		end

		self.addRole.DoClick = function(btn)
			surface.PlaySound("helix/ui/press.wav")
			netstream.Start("ixGroupAddRole", group:GetID())
		end

		self.deleteGroup = bottomPanel:Add("DButton")
		self.deleteGroup:SetText("Delete Group")
		self.deleteGroup:Dock(RIGHT)
		self.deleteGroup:SetFont("MenuFontNoClamp")
		self.deleteGroup:SetWide(SScaleMin(110 / 3))
		self.deleteGroup:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
		self.deleteGroup.DoClick = function(btn)
			surface.PlaySound("helix/ui/press.wav")
			Derma_Query("Are you sure you want to delete this group?", "Group Deletion", "Yes", function()
				netstream.Start("ixGroupDelete", group:GetID())
			end, "No")
		end

		self.deleteGroup.Paint = function(self, w, h)
			PaintStandard(self, w, h, 100)
		end

		self.hidden = bottomPanel:Add("DCheckBoxLabel")
		self.hidden:SetText("Hide separate scoreboard tab")
		self.hidden:SetFont("MenuFontNoClamp")
		self.hidden:Dock(RIGHT)
		self.hidden:SetWide(SScaleMin(230 / 3))
		self.hidden:SetValue(group.hidden)
		self.hidden.OnChange = function(checkbox, value)
			netstream.Start("ixGroupHidden", group:GetID(), value)
		end

		self.hidden.PerformLayout = function(self)
			local x = self.m_iIndent || 0

			self.Button:SetSize( SScaleMin(15 / 3), SScaleMin(15 / 3) )
			self.Button:SetPos( x, math.floor( ( self:GetTall() - self.Button:GetTall() ) / 2 ) )

			self.Label:SizeToContents()
			self.Label:SetPos( x + self.Button:GetWide() + SScaleMin(9 / 3), SScaleMin(5 / 3) )
		end
	end
end

-- Misc helper functions
-- A function to create a leave button
function PANEL:CreateLeaveButton()
	self.leaveButton = self.contentFrame:Add("DButton")
	self:CreateButton(self.leaveButton, "Leave group", Color(205, 114, 114, 255), function()
		netstream.Start("ixGroupLeave")
	end)
end

-- Creates a text entry
function PANEL:CreateTextEntry(parent, bDockTop, height, bMultiline, bScrollbar, bEnter, placeholderText)
	parent:SetPlaceholderText(placeholderText)
	parent:Dock(TOP)
	parent:SetTall(height)
	parent:SetMultiline( bMultiline )
	parent:SetVerticalScrollbarEnabled( bScrollbar )
	parent:SetEnterAllowed( bEnter )
	parent:SetTextColor(Color(200, 200, 200, 255))
	parent:SetCursorColor(Color(200, 200, 200, 255))
	parent:SetFont("MenuFontNoClamp")
	parent:SetPlaceholderColor( Color(200, 200, 200, 200) )

	if bDockTop then
		parent:DockMargin(self.contentFrame:GetWide() * 0.4, 0, self.contentFrame:GetWide() * 0.4, 0)
	end

	parent.Paint = function(self, w, h)
		if bMultiline then
			surface.SetDrawColor(Color(25, 25, 25, 255))
		else
			surface.SetDrawColor(Color(0, 0, 0, 100))
		end

		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)

		if ( self.GetPlaceholderText && self.GetPlaceholderColor && self:GetPlaceholderText() && self:GetPlaceholderText():Trim() != "" && self:GetPlaceholderColor() && ( !self:GetText() || self:GetText() == "" ) ) then

			local oldText = self:GetText()

			local str = self:GetPlaceholderText()
			if ( str:StartWith( "#" ) ) then str = str:utf8sub( 2 ) end
			str = language.GetPhrase( str )

			self:SetText( str )
			self:DrawTextEntryText( self:GetPlaceholderColor(), self:GetHighlightColor(), self:GetCursorColor() )
			self:SetText( oldText )

			return
		end

		self:DrawTextEntryText( self:GetTextColor(), self:GetHighlightColor(), self:GetCursorColor() )
	end
end

-- A function to create a label
function PANEL:CreateLabel(parent, text, color, bDoublePadding, bNoPadding)
	parent:SetText(text)
	parent:SetFont("MenuFontNoClamp")
	parent:SetTextColor(color)
	parent:SizeToContents()
	parent:SetContentAlignment(5)
	if bNoPadding then
		parent:DockMargin(0, 0 - SScaleMin(15 / 3), 0, 0)
	else
		parent:DockMargin(0, 0, 0, bDoublePadding and (self.padding * 2) or self.padding)
	end

	parent:Dock(TOP)
end

-- A function to create the menu logo in frame
function PANEL:CreateLogo(topMarginMultiplier)
	local logoPanel = self.contentFrame:Add("Panel")
	logoPanel:Dock(TOP)
	logoPanel:SetTall(SScaleMin(17 / 3))
	logoPanel:DockMargin(0, self.contentFrame:GetTall() * topMarginMultiplier, 0, self.padding)

	local logo = logoPanel:Add("DImage")
	logo:SetSize(SScaleMin(23 / 3), SScaleMin(17 / 3))
	logo:SetPos(self.contentFrame:GetWide() * 0.5 - logo:GetWide() * 0.5, 0)
	logo:SetImage("willardnetworks/tabmenu/charmenu/faction.png")
end

-- A function to create primary titles
function PANEL:CreateTitleLabel(parent, text)
	parent:SetFont("LargerTitlesFontNoClamp")
	parent:Dock(TOP)
	parent:SetText(text)
	parent:SizeToContents()
	parent:SetContentAlignment(5)
	parent:DockMargin(0, 0, 0, self.padding)
end

-- A function to create yellow "warning" text
function PANEL:CreateWarningText(parent, text, bBold)
	parent:SetText(text)
	parent:SetFont(bBold and "WNBackFontBoldNoClamp" or "WNBackFontNoClamp")
	parent:SizeToContents()
	parent:SetTextColor(Color(255, 204, 0, 255))
	parent:Dock(TOP)
	parent:DockMargin(0, self.padding * 2, 0, 0)
	parent:SetContentAlignment(5)
end

-- A function to create a button
function PANEL:CreateButton(parent, text, outlineColor, callback)
	parent:SetText(text)
	parent:Dock(TOP)
	parent:SetTall(SScaleMin(25 / 3))
	parent:DockMargin(self.contentFrame:GetWide() * 0.45, self.padding * 2, self.contentFrame:GetWide() * 0.45, 0)
	parent:SetFont("WNBackFontNoClamp")
	parent:SetContentAlignment(5)
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(ColorAlpha(outlineColor, (255 / 100 * 30)))
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	parent.DoClick = function(btn)
		surface.PlaySound("helix/ui/press.wav")
		if callback then
			callback()
		end
	end
end

vgui.Register("ixGroup", PANEL, "EditablePanel")

-- Group invite panel
local PANEL = {}

function PANEL:Init()
	self:SetSize(SScaleMin(550 / 3), SScaleMin(250 / 3))
	self:Center()
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self:MakePopup()
	self.Paint = function(self, w, h)
		PaintFrames(self, w, h, true)
	end

	timer.Simple(0.25, function()
		self.nameText = self.nameText or "error"
		self.whoInvited = self.whoInvited or "error"
		self.groupID = self.groupID or LocalPlayer():NotifyLocalized("error")

		local title = self:Add("DLabel")
		self:CreateLabel(title, "LargerTitlesFontFixed", color_white, string.utf8upper("group invitation"), true)

		local name = self:Add("DLabel")
		self:CreateLabel(name, "TitlesFontFixed", Color(230, 230, 230, 255), "'"..self.nameText.."'")

		local whoInvited = self:Add("DLabel")
		self:CreateLabel(whoInvited, "MenuFontFixed", Color(230, 230, 230, 255), "Invited by "..self.whoInvited)

		local buttonPanel = self:Add("Panel")
		buttonPanel:Dock(TOP)
		buttonPanel:DockMargin(self:GetWide() * 0.5 - (SScaleMin(80 / 3) + SScaleMin(10 / 3)), SScaleMin(20 / 3), self:GetWide() * 0.5 - (SScaleMin(80 / 3) + SScaleMin(10 / 3)), 0)
		buttonPanel:SetTall(SScaleMin(30 / 3))

		local accept = buttonPanel:Add("DButton")
		self:CreateButton(accept, "Accept", Color(96, 125, 68, 255), true, function()
			netstream.Start("ixGroupInvite", self.groupID)
			self:Remove()
		end)

		local decline = buttonPanel:Add("DButton")
		self:CreateButton(decline, "Decline", Color(125, 68, 68, 255), false, function()
			self:Remove()
		end)
	end)
end

function PANEL:CreateLabel(parent, font, color, text, bFirstLabel)
	parent:Dock(TOP)
	parent:DockMargin(0, bFirstLabel and SScaleMin(40 / 3) or SScaleMin(20 / 3), 0, 0)
	parent:SetText(text)
	parent:SetFont(font)
	parent:SetTextColor(color)
	parent:SizeToContents()
	parent:SetContentAlignment(5)
end

function PANEL:CreateButton(parent, text, color, bDockLeft, callback)
	parent:Dock(bDockLeft and LEFT or RIGHT)
	parent:SetText(text)
	parent:SetWide(SScaleMin(80 / 3))
	parent:SetFont("MenuFontNoClamp")
	parent.Paint = function(self, w, h)
		surface.SetDrawColor(Color(0, 0, 0, 100))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(color)
		surface.DrawOutlinedRect(0, 0, w, h)
	end

	parent.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		callback()
	end
end

vgui.Register("ixGroupInvite", PANEL, "EditablePanel")

local PANEL = {}

function PANEL:Init()
	self:SetSize(SScaleMin(550 / 3), SScaleMin(550 / 3))
	self:Center()
	self:MakePopup()
	self.Paint = function(self, w, h)
		PaintFrames(self, w, h, 255)
	end

	local title = self:Add("DLabel")
	title:SetFont("LargerTitlesFontNoClamp")
	title:SetText("Update Content")
	title:SizeToContents()

	title:SetPos(SScaleMin(20 / 3), SScaleMin(40 / 3) * 0.5 - title:GetTall() * 0.5)

	local close = self:Add("DImageButton")
	close:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	close:SetPos(self:GetWide() - close:GetWide() - SScaleMin(10 / 3), SScaleMin(10 / 3))
	close:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	close.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		self:Remove()
	end

	local parent = self:GetParent()

	self.textEntry = self:Add("DTextEntry")
	if parent.CreateTextEntry then
		parent:CreateTextEntry(self.textEntry, false, 0, true, true, true, "Write your updated content here...")
	end
	self.textEntry:Dock(FILL)

	self.textEntry:DockMargin(0, SScaleMin(40 / 3), 0, 0)

	local save = self:Add("DButton")
	save:Dock(BOTTOM)
	save:SetTall(SScaleMin(50 / 3))
	save:SetText("Save")
	save:SetFont("LargerTitlesFontNoClamp")
	save.Paint = nil
	save.DoClick = function()
		self.callback()

		timer.Simple(0.1, function()
			if parent.lastSelected then
				for k, v in pairs(parent.buttonlist) do
					if k == parent.lastSelected then
						v.DoClick()
					end
				end
			end
		end)

		self:Remove()
	end
end

function PANEL:Think()
	if !IsValid(ix.gui.group) then
		self:Remove()
	end

	self:MoveToFront()
end

vgui.Register("ixGroupUpdater", PANEL, "EditablePanel")
