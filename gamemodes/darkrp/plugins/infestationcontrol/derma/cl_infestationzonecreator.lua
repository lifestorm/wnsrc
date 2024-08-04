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

function PANEL:Init()
	if (IsValid(ix.gui.infestationEdit)) then
		ix.gui.infestationEdit:Remove()
	end

	ix.gui.infestationEdit = self
	self.list = {}
	self.properties = {}

	self:SetDeleteOnClose(true)
	self:MakePopup()
	self:SetTitle(L("infestationNew"))

	-- scroll panel
	self.canvas = self:Add("DScrollPanel")
	self.canvas:Dock(FILL)

	-- name entry
	self.nameEntry = vgui.Create("ixTextEntry")
	self.nameEntry:SetFont("ixMenuButtonFont")
	self.nameEntry:SetText(L("infestationNew"))

	local listRow = self.canvas:Add("ixListRow")
	listRow:SetList(self.list)
	listRow:SetLabelText(L("infestationName"))
	listRow:SetRightPanel(self.nameEntry)
	listRow:Dock(TOP)
	listRow:SizeToContents()
	listRow:SetLabelWidth(200)

	-- type entry
	self.typeEntry = self.canvas:Add("DComboBox")
	self.typeEntry:Dock(RIGHT)
	self.typeEntry:SetFont("ixMenuButtonFont")
	self.typeEntry:SetTextColor(color_white)
	self.typeEntry.OnSelect = function(panel)
		panel:SizeToContents()
		panel:SetWide(panel:GetWide() + 12) -- padding for arrow (nice)
	end

	for id, data in pairs(ix.infestation.types) do
		self.typeEntry:AddChoice(data.name, id, id == "erebus")
	end

	listRow = self.canvas:Add("ixListRow")
	listRow:SetList(self.list)
	listRow:SetLabelText(L("infestationType"))
	listRow:SetRightPanel(self.typeEntry)
	listRow:Dock(TOP)
	listRow:SizeToContents()

	self.spreadEntry = vgui.Create("ixTextEntry")
	self.spreadEntry:SetFont("ixMenuButtonFont")
	self.spreadEntry:SetText("30")
	self.spreadEntry.realGetValue = self.spreadEntry.GetValue
	self.spreadEntry.GetValue = function()
		return tonumber(self.spreadEntry:realGetValue()) or 30
	end

	listRow = self.canvas:Add("ixListRow")
	listRow:SetList(self.list)
	listRow:SetLabelText(L("infestationSpread"))
	listRow:SetRightPanel(self.spreadEntry)
	listRow:Dock(TOP)
	listRow:SizeToContents()

	-- save button
	self.saveButton = self:Add("DButton")
	self.saveButton:SetText(L("infestationSave"))
	self.saveButton:SizeToContents()
	self.saveButton:Dock(BOTTOM)
	self.saveButton.DoClick = function()
		self:Submit()
	end

	self:SizeToContents()
	self:SetWide(ScrW() / 3)
	self:Center()
end

function PANEL:SizeToContents()
	local width = 64
	local height = 50

	for _, v in ipairs(self.canvas:GetCanvas():GetChildren()) do
		width = math.max(width, v:GetLabelWidth())
		height = height + v:GetTall()
	end

	self:SetWide(width + 200)
	self:SetTall(height + self.saveButton:GetTall())
end

function PANEL:Submit()
	local name = self.nameEntry:GetValue()

	if (ix.infestation.stored[name]) then
		LocalPlayer():Notify(L("infestationExists"))

		return
	end

	local _, type = self.typeEntry:GetSelected()
	local spread = self.spreadEntry:GetFloat()

	if (spread and isnumber(spread)) then
		spread = math.Round(spread)

		if (spread <= 0) then
			LocalPlayer():Notify(L("invalidSpread"))
			
			return
		end
	else
		LocalPlayer():Notify(L("invalidSpread"))
		
		return
	end

	local coreFound = false
	local infestationProps = {}

	for _, entity in pairs(ents.FindByClass("prop_physics")) do
		if (entity:GetNetVar("infestationProp") and entity:GetNetVar("infestationProp") == LocalPlayer():SteamID()) then
			infestationProps[#infestationProps + 1] = true -- Just using it to count.

			if (entity:GetNetVar("infestationCore")) then
				coreFound = true
			end
		end
	end

	if (#infestationProps < 2) then
		LocalPlayer():Notify(L("notEnoughProps"))

		return
	end

	if (!coreFound) then
		LocalPlayer():Notify(L("missingCore"))

		return
	end

	net.Start("ixInfestationZoneCreate")
		net.WriteString(name)
		net.WriteString(type)
		net.WriteFloat(spread)
	net.SendToServer()

	self:Remove()
end

vgui.Register("ixInfestationZoneCreate", PANEL, "DFrame")

if (IsValid(ix.gui.infestationEdit)) then
	ix.gui.infestationEdit:Remove()
end
