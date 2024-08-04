--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- plugin manager
PANEL = {}

function PANEL:Init()
	self:Dock(FILL)
	self:SetSearchEnabled(true)

	self.loadedCategory = L("loadedPlugins")
	self.unloadedCategory = L("unloadedPlugins")

	if (!ix.gui.bReceivedUnloadedPlugins) then
		net.Start("ixConfigRequestUnloadedList")
		net.SendToServer()
	end

	self:Populate()
end

function PANEL:OnPluginToggled(uniqueID, bEnabled)
	net.Start("ixConfigPluginToggle")
		net.WriteString(uniqueID)
		net.WriteBool(bEnabled)
	net.SendToServer()
end

function PANEL:Populate()
	self:AddCategory(self.loadedCategory)
	self:AddCategory(self.unloadedCategory)

	-- add loaded plugins
	for k, v in SortedPairsByMemberValue(ix.plugin.list, "name") do
		local row = self:AddRow(ix.type.bool, self.loadedCategory)
		row.id = k

		row.setting:SizeToContents()

		-- if this plugin is not in the unloaded list currently, then it's queued for an unload
		row:SetValue(!ix.plugin.unloaded[k], true)
		row:SetText(v.name)

		row.OnValueChanged = function(panel, bEnabled)
			self:OnPluginToggled(k, bEnabled)
		end

		row:GetLabel():SetHelixTooltip(function(tooltip)
			local title = tooltip:AddRow("name")
			title:SetImportant()
			title:SetText(v.name)
			title:SizeToContents()
			title:SetMaxWidth(math.max(title:GetMaxWidth(), ScrW() * 0.5))

			local description = tooltip:AddRow("description")
			description:SetText(v.description)
			description:SizeToContents()
		end)
	end

	self:UpdateUnloaded(true)
	self:SizeToContents()
end

function PANEL:UpdatePlugin(uniqueID, bEnabled)
	for _, v in pairs(self:GetRows()) do
		if (v.id == uniqueID) then
			v:SetValue(bEnabled, true)
		end
	end
end

-- called from Populate and from the ixConfigUnloadedList net message
function PANEL:UpdateUnloaded(bNoSizeToContents)
	for _, v in pairs(self:GetRows()) do
		if (ix.plugin.unloaded[v.id]) then
			v:SetValue(false, true)
		end
	end

	for k, _ in SortedPairs(ix.plugin.unloaded) do
		if (ix.plugin.list[k]) then
			-- if this plugin is in the loaded plugins list then it's queued for an unload - don't display it in this category
			continue
		end

		local row = self:AddRow(ix.type.bool, self.unloadedCategory)
		row:SetText(k)
		row:SetValue(false, true)

		row.OnValueChanged = function(panel, bEnabled)
			self:OnPluginToggled(k, bEnabled)
		end
	end

	if (!bNoSizeToContents) then
		self:SizeToContents()
	end
end

vgui.Register("ixPluginManager", PANEL, "ixSettings")
