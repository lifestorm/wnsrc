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

	self.rows = {}

	self.innerContent = self:Add("EditablePanel")
	self.innerContent:SetSize(SScaleMin(700 / 3), SScaleMin(600 / 2.5))
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
	titleText:SetText("Custom Item Creator")
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

	local itemBases = {"No Base"}

	for base, _ in pairs(ix.item.base) do
		itemBases[#itemBases + 1] = base
	end

	-- VGUI Class | VGUI Identifier | Name | Description | Default | Additional Data
	self:AddRow("ixSettingsRowArray", "rowBase", "Base", "The base item that this item should be based off of.", 1, {populate = function() return itemBases end})
	self:AddRow("ixSettingsRowString", "rowID", "Unique ID", "The unique identifier of the item. Should be unique and not contain spaces.", "custom_item")
	self:AddRow("ixSettingsRowString", "rowName", "Name", "The name of the item.", "An Item")
	self:AddRow("ixSettingsRowString", "rowDesc", "Description", "The description of the item.", "A custom item.")
	self:AddRow("ixSettingsRowString", "rowModel", "Model", "The model of the item.", "models/props_junk/PopCan01a.mdl")
	self:AddRow("ixSettingsRowNumber", "rowSkin", "Skin", "The skin of the item.", 0, {min = 0, max = 10})
	self:AddRow("ixSettingsRowString", "rowCategory", "Category", "The category this item falls under.", "Custom Items")

	-- Doing this one manually because it's a little more complicated.
	self.rowCam = self.innerContent:Add("ixSettingsRowString")
	self.rowCam:Dock(TOP)
	self.rowCam:DockMargin(0, 0, 6, 0)
	self.rowCam:SetText("Icon Position")

	self.rowCam.OnResetClicked = function()
		self.rowCam:SetShowReset(false)
		self.rowCam:SetValue("", true)
	end
	self.rowCam.OnValueChanged = function()
		local newValue = self.rowCam:GetValue()

		self.rowCam:SetShowReset(newValue != "", "Icon Position", "")
	end
	self.rowCam:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText("Icon Position")
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local desc = tooltip:AddRow("description")
		desc:SetText("The position, angles, and FOV of this item's inventory icon. Leave blank for default settings.")
		desc:SizeToContents()
	end)

	self.rowCam.rowCamButton = self.rowCam:Add("DButton")
	self.rowCam.rowCamButton:Dock(RIGHT)
	self.rowCam.rowCamButton:SetFont("ixGenericFont")
	self.rowCam.rowCamButton:SetColor(ix.config.Get("color", Color(255, 255, 255)))
	self.rowCam.rowCamButton:SetText("CHANGE")
	self.rowCam.rowCamButton.DoClick = function()
		local iconEditor = vgui.Create("ix_icon_editor")

		iconEditor.modelPath:SetValue(self["rowModel"]:GetValue())
		iconEditor.model:SetModel(self["rowModel"]:GetValue())
		iconEditor.width:SetValue(self["rowWidth"]:GetValue())
		iconEditor.height:SetValue(self["rowHeight"]:GetValue())

		iconEditor.best:DoClick()

		iconEditor.copy:SetText("F")
		iconEditor.copy:SetTooltip("Confirm")
		iconEditor.copy.DoClick = function()
			local camPos = iconEditor.model:GetCamPos()
			local camAng = iconEditor.model:GetLookAng()
			local iconCam = {
				pos = Vector(math.Round(camPos.x, 2), math.Round(camPos.y, 2), math.Round(camPos.z, 2)),
				ang = Angle(math.Round(camAng.p, 2), math.Round(camAng.y, 2), math.Round(camAng.r, 2)),
				fov = math.Round(iconEditor.model:GetFOV(), 2)
			}

			self.rowCam:SetValue(util.TableToJSON(iconCam))
			iconEditor:Remove()
		end
	end

	self.rowCam.setting:Remove()

	self.rowCam.setting = self.rowCam:Add("ixTextEntry")
	self.rowCam.setting:Dock(RIGHT)
	self.rowCam.setting:DockMargin(0, 0, 8, 0)
	self.rowCam.setting:SetFont("TitlesFontNoBoldNoClamp")
	self.rowCam.setting:SetBackgroundColor(derma.GetColor("DarkerBackground", self.rowCam))
	self.rowCam.setting.OnEnter = function()
		self.rowCam:OnValueChanged(self.rowCam:GetValue())
	end
	self.rowCam:SetValue("")

	self.rowCam.PerformLayout = function(this, width, height)
		this.setting:SetWide(width * 0.34)
		this.rowCamButton:SetWide(width * 0.15)
	end

	self.rows[#self.rows + 1] = self.rowCam

	self:AddRow("ixSettingsRowString", "rowMaterial", "Material", "The material of the item.", "")
	self:AddRow("ixSettingsRowNumber", "rowWidth", "Width", "The physical width of the item.", 1, {min = 1, max = 10})
	self:AddRow("ixSettingsRowNumber", "rowHeight", "Height", "The physical height of the item.", 1, {min = 1, max = 10})
	self:AddRow("ixSettingsRowColor", "rowColor", "Color", "The color of the item.", Color(255, 255, 255))
	self:AddRow("ixSettingsRowBool", "rowRotating", "Rotating", "Whether the item's icon should rotate in the inventory.", false)
	self:AddRow("ixSettingsRowNumber", "rowStack", "Max Stack", "The maximum stack of this item, if supported by the item base.", 1, {min = 1, max = 100})
	self:AddRow("ixSettingsRowNumber", "rowHunger", "Hunger Restoration", "The amount of hunger to restore once this item is used, if supported by the item base.", 0, {min = 0, max = 100})
	self:AddRow("ixSettingsRowNumber", "rowThirst", "Thirst Restoration", "The amount of thirst to restore once this item is used, if supported by the item base.", 0, {min = 0, max = 100})
	self:AddRow("ixSettingsRowNumber", "rowSpoil", "Spoil Time", "The time, in days, until the item spoils, if supported by the item base.", 14, {min = 1, max = 30})
	self:AddRow("ixSettingsRowNumber", "rowDamage", "Damage", "The amount of damage to deal once this item is used, if supported by the item base.", 0, {min = 0, max = 100})
	self:AddRow("ixSettingsRowNumber", "rowHealth", "Health", "The amount of health to restore once this item is used, if supported by the item base.", 0, {min = 0, max = 100})
	self:AddRow("ixSettingsRowNumber", "rowCredits", "Credits", "The amount of Credits to award once this item is used, if supported by the item base.", 0, {min = 0, max = 50})

	self.createItem = self.innerContent:Add("DButton")
	self.createItem:Dock(BOTTOM)
	self.createItem:DockMargin(10, 10, 10, 10)
	self.createItem:SetTall(SScaleMin(60 / 4))
	self.createItem:SetFont("ixMediumFont")
	self.createItem:SetColor(ix.config.Get("color", Color(255, 255, 255)))
	self.createItem:SetText("CREATE ITEM")
	self.createItem.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		local uniqueID = string.Trim(self["rowID"]:GetValue())

		if (uniqueID == "") then
			LocalPlayer():Notify("That is not a valid Unique ID!")

			return
		end

		if (ix.item.list[uniqueID]) then 
			LocalPlayer():Notify("That item already exists!")
			
			return
		end

		net.Start("ixCreateCustomItem")
			net.WriteString(select(1, self["rowBase"].setting:GetSelected()))
			net.WriteString(self["rowID"]:GetValue())
			net.WriteString(self["rowName"]:GetValue())
			net.WriteString(self["rowDesc"]:GetValue())
			net.WriteString(self["rowModel"]:GetValue())
			net.WriteUInt(self["rowSkin"]:GetValue(), 5)
			net.WriteString(self["rowCategory"]:GetValue())
			net.WriteString(self.rowCam:GetValue())
			net.WriteString(self["rowMaterial"]:GetValue())
			net.WriteUInt(self["rowWidth"]:GetValue(), 5)
			net.WriteUInt(self["rowHeight"]:GetValue(), 5)
			net.WriteColor(Color(self["rowColor"]:GetValue().r, self["rowColor"]:GetValue().g, self["rowColor"]:GetValue().b))
			net.WriteBool(self["rowRotating"]:GetValue())
			net.WriteUInt(self["rowStack"]:GetValue(), 8)
			net.WriteUInt(self["rowHunger"]:GetValue(), 8)
			net.WriteUInt(self["rowThirst"]:GetValue(), 8)
			net.WriteUInt(self["rowSpoil"]:GetValue(), 6)
			net.WriteUInt(self["rowDamage"]:GetValue(), 8)
			net.WriteUInt(self["rowHealth"]:GetValue(), 8)
			net.WriteUInt(self["rowCredits"]:GetValue(), 7)
		net.SendToServer()
		
		self:Remove()
	end
end

function PANEL:AddRow(class, uniqueID, name, description, default, data)
	data = data or {}

	self[uniqueID] = self.innerContent:Add(class)
	self[uniqueID]:Dock(TOP)
	self[uniqueID]:DockMargin(0, 0, 6, 0)
	self[uniqueID]:SetText(name)
	
	if (data.min) then
		self[uniqueID]:SetMin(data.min)
	end
	
	if (data.max) then
		self[uniqueID]:SetMax(data.max)
	end

	if (data.populate) then
		self[uniqueID]:Populate(nil, data)
	end

	self[uniqueID]:SetValue(default)

	self[uniqueID].OnResetClicked = function()
		self[uniqueID]:SetShowReset(false)
		self[uniqueID]:SetValue(default, true)
	end
	self[uniqueID].OnValueChanged = function()
		local newValue = self[uniqueID]:GetValue()

		self[uniqueID]:SetShowReset(newValue != default, name, default)
	end
	self[uniqueID]:GetLabel():SetHelixTooltip(function(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText(name)
		title:SizeToContents()
		title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

		local desc = tooltip:AddRow("description")
		desc:SetText(description)
		desc:SizeToContents()
	end)

	self.rows[#self.rows + 1] = self[uniqueID]
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(Color(63, 58, 115, 220))
	surface.DrawRect(0, 0, width, height)

	Derma_DrawBackgroundBlur(self, 1)
end

vgui.Register("ixCustomItemCreator", PANEL, "EditablePanel")
