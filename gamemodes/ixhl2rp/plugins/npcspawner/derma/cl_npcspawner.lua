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
	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)

	self.innerContent = self:Add("EditablePanel")
	self.innerContent:SetSize(SScaleMin(700 / 3), SScaleMin(240 / 2.5))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local topbar = self.innerContent:Add("Panel")
	topbar:SetHeight(SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function(self, width, height)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, width, height)
	end
	
	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("NPC Spawner Editor")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()
	
	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		if (self.ExitCallback) then
			self.ExitCallback()
		end
		
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local divider = topbar:Add("Panel")
	divider:SetSize(1, topbar:GetTall())
	divider:Dock(RIGHT)
	divider:DockMargin(0, SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	divider.Paint = function(self, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, 0, h)
	end

	self.rowEnabled = self.innerContent:Add("ixSettingsRowBool")
	self.rowEnabled:Dock(TOP)
	self.rowEnabled:DockMargin(0, 0, 6, 0)
	self.rowEnabled:SetText("Enabled")
	self.rowEnabled.OnResetClicked = function()
		self.rowEnabled:SetShowReset(false)
		self.rowEnabled:SetValue(false, true)
	end
	self.rowEnabled.OnValueChanged = function()
		local newValue = self.rowEnabled:GetValue()

		self.rowEnabled:SetShowReset(newValue != false, "Spawn Range", false)
	end
	self.rowEnabled:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText("Enabled")
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local description = tooltip:AddRow("description")
		description:SetText("Whether the NPC Spawner is enabled.")
		description:SizeToContents()
	end)

	self.rowClass = self.innerContent:Add("ixSettingsRowString")
	self.rowClass:Dock(TOP)
	self.rowClass:DockMargin(0, 0, 6, 0)
	self.rowClass:SetText("NPC Class")
	self.rowClass:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText("NPC Class")
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local description = tooltip:AddRow("description")
		description:SetText("The NPC Class that the spawner will spawn.")
		description:SizeToContents()
	end)

	self.rowNoSpawnRange = self.innerContent:Add("ixSettingsRowNumber")
	self.rowNoSpawnRange:Dock(TOP)
	self.rowNoSpawnRange:DockMargin(0, 0, 6, 0)
	self.rowNoSpawnRange:SetText("Player No-Spawn Range")
	self.rowNoSpawnRange:SetMin(0)
	self.rowNoSpawnRange:SetMax(5000)
	self.rowNoSpawnRange.OnResetClicked = function()
		self.rowNoSpawnRange:SetShowReset(false)
		self.rowNoSpawnRange:SetValue(1000, true)
	end
	self.rowNoSpawnRange.OnValueChanged = function()
		local newValue = self.rowNoSpawnRange:GetValue()

		self.rowNoSpawnRange:SetShowReset(newValue != 1000, "Player No-Spawn Range", 1000)
	end
	self.rowNoSpawnRange:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText("PLayer No-Spawn Range")
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local description = tooltip:AddRow("description")
		description:SetText("The range around the spawner at which it will stop spawning NPCs if a player is within.")
		description:SizeToContents()
	end)

	self.rowMaxNPCs = self.innerContent:Add("ixSettingsRowNumber")
	self.rowMaxNPCs:Dock(TOP)
	self.rowMaxNPCs:DockMargin(0, 0, 6, 0)
	self.rowMaxNPCs:SetText("Maxiumum NPCs")
	self.rowMaxNPCs:SetMin(1)
	self.rowMaxNPCs:SetMax(10)
	self.rowMaxNPCs.OnResetClicked = function()
		self.rowMaxNPCs:SetShowReset(false)
		self.rowMaxNPCs:SetValue(5, true)
	end
	self.rowMaxNPCs.OnValueChanged = function()
		local newValue = self.rowMaxNPCs:GetValue()

		self.rowMaxNPCs:SetShowReset(newValue != 5, "Maxiumum NPCs", 5)
	end
	self.rowMaxNPCs:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText("Maximum NPCs")
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local description = tooltip:AddRow("description")
		description:SetText("The maximum amount of NPCs that the spawner can spawn at any one time.")
		description:SizeToContents()
	end)

	self.rowSpawnInterval = self.innerContent:Add("ixSettingsRowNumber")
	self.rowSpawnInterval:Dock(TOP)
	self.rowSpawnInterval:DockMargin(0, 0, 6, 0)
	self.rowSpawnInterval:SetText("Spawn Interval")
	self.rowSpawnInterval:SetMin(1)
	self.rowSpawnInterval:SetMax(1800)
	self.rowSpawnInterval.OnResetClicked = function()
		self.rowSpawnInterval:SetShowReset(false)
		self.rowSpawnInterval:SetValue(300, true)
	end
	self.rowSpawnInterval.OnValueChanged = function()
		local newValue = self.rowSpawnInterval:GetValue()

		self.rowSpawnInterval:SetShowReset(newValue != 300, "Spawn Interval", 300)
	end
	self.rowSpawnInterval:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText("Spawn Interval")
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local description = tooltip:AddRow("description")
		description:SetText("How often the spawner will attempt to spawn an NPC, in seconds.")
		description:SizeToContents()
	end)

	self.saveChanges = self.innerContent:Add("DButton")
	self.saveChanges:Dock(BOTTOM)
	self.saveChanges:DockMargin(10, 10, 10, 10)
	self.saveChanges:SetTall(SScaleMin(60 / 4))
	self.saveChanges:SetFont("ixMediumFont")
	self.saveChanges:SetColor(ix.config.Get("color", Color(255, 255, 255)))
	self.saveChanges:SetText("SAVE CHANGES")
	self.saveChanges.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		net.Start("NPCSpawner_Edit")
			net.WriteEntity(self.entity)
			net.WriteBool(self.rowEnabled:GetValue())
			net.WriteString(self.rowClass:GetValue())
			net.WriteFloat(self.rowNoSpawnRange:GetValue())
			net.WriteFloat(self.rowMaxNPCs:GetValue())
			net.WriteFloat(self.rowSpawnInterval:GetValue())
		net.SendToServer()
		
		self:Remove()
	end
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(Color(63, 58, 115, 220))
	surface.DrawRect(0, 0, width, height)

	Derma_DrawBackgroundBlur(self, 1)
end

function PANEL:Populate(spawner, bEnabled, sClass, fPlayerNoSpawnRange, fMaxNPCs, fSpawnInterval)
	self.entity = spawner

	self.rowEnabled:SetValue(bEnabled, true)
	self.rowClass:SetValue(sClass, true)
	self.rowNoSpawnRange:SetValue(fPlayerNoSpawnRange)
	self.rowMaxNPCs:SetValue(fMaxNPCs)
	self.rowSpawnInterval:SetValue(fSpawnInterval)
end

vgui.Register("ixNPCSpawnerEditor", PANEL, "EditablePanel")
