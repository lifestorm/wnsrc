--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local DATAFILEPLUGIN = ix.plugin.Get("combineutilities")

local PANEL = {}

local materialMainframe = ix.util.GetMaterial("willardnetworks/datafile/mainframe.png")
local materialGadgetlight = ix.util.GetMaterial("willardnetworks/datafile/gadgetlight.png")

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:MakePopup()
	Schema:AllowMessage(self)

	local mainFrame = self:Add("EditablePanel")
	mainFrame:SetSize(SScaleMin(645 / 3), SScaleMin(850 / 3))
	mainFrame:Center()
	mainFrame.Paint = function(this, with, height)
		surface.SetDrawColor(color_white:Unpack())
		surface.SetMaterial(materialMainframe)
		surface.DrawTexturedRect(0, 0, with, height)
	end

	local close = self:Add("DButton")
	close:SetSize(SScaleMin(107 / 3), SScaleMin(105 / 3))
	close:SetPos(self:GetWide() * 0.5 + mainFrame:GetWide() * 0.5 - close:GetWide() * 0.6, self:GetTall() * 0.5 - mainFrame:GetTall() * 0.5 - close:GetTall() * 0.4)
	close:SetText("")
	close.Paint = function(this, with, height)
		if (this:IsHovered()) then
			surface.SetDrawColor(ColorAlpha(color_white, 50))
			surface.SetMaterial(materialGadgetlight)
			surface.DrawTexturedRect(0, 0, with, height)
		end
	end
	close.DoClick = function()
		surface.PlaySound("willardnetworks/datapad/close.wav")
		self:Remove()
	end

	self.subFrame = self:Add("EditablePanel")
	self.subFrame:SetSize(mainFrame:GetWide() * 0.8, mainFrame:GetTall() * 0.75)
	self.subFrame:Center()
	self.subFrame:SetTall(mainFrame:GetTall() * 0.8)

	self.searchPanel = self.subFrame:Add("ixDatapadSearchProfiles")
	self.searchPanel:Dock(TOP)
	self.searchPanel:DockMargin(0, 0, 0, 0)
	self.searchPanel:SetTall(150)

	self.searchPanel.back:Remove()
	self.searchPanel.topDivider:Remove()
	self.searchPanel.name.OnEnter = function()
		if (ix.config.Get("datafileNoConnection")) then
			LocalPlayer():NotifyLocalized("Error: no connection!")
			surface.PlaySound("hl1/fvox/buzz.wav")
			self.searchPanel.noConnection2:SetVisible(true)
			self.searchPanel:SetTall(250)
			return
		end

		self.searchPanel:SetTall(150)

		surface.PlaySound("willardnetworks/datapad/navigate.wav")

		net.Start("ixDataFilePDA_CMU_RequestData")
			net.WriteString(self.searchPanel.name:GetText())
		net.SendToServer()
	end
	self.searchPanel.search.DoClick = function()
		if (ix.config.Get("datafileNoConnection")) then
			LocalPlayer():NotifyLocalized("Error: no connection!")
			surface.PlaySound("hl1/fvox/buzz.wav")
			self.searchPanel.noConnection2:SetVisible(true)
			return
		end

		surface.PlaySound("willardnetworks/datapad/navigate.wav")

		net.Start("ixDataFilePDA_CMU_RequestData")
			net.WriteString(self.searchPanel.name:GetText())
		net.SendToServer()
	end

	self.output = self.subFrame:Add("DPanel")
	self.output:Dock(FILL)
	self.output.Populate = function(this, data)
		this:Clear()

		if (!data or !istable(data) or table.IsEmpty(data)) then return end

		local name = this:Add("EditablePanel")
		if (!data.genericData.cohesionPoints) then
			DATAFILEPLUGIN:CreateRow(name, "name", data.genericData.name, nil, true, false)
		else
			DATAFILEPLUGIN:CreateRow(name, "collar id", data.genericData.collarID, nil, true, false)
		end

		local cid = this:Add("EditablePanel")
		DATAFILEPLUGIN:CreateRow(cid, "cid", data.genericData.cid, nil, false, false)

		local socialCredits = this:Add("EditablePanel")
		if (!data.genericData.cohesionPoints) then
			DATAFILEPLUGIN:CreateRow(socialCredits, data.genericData.socialCredits and "social credits", math.Clamp(tonumber(data.genericData.socialCredits), 0, 200), (isnumber(data.genericData.socialCreditsDate) and os.date("%d/%m/%Y", data.genericData.socialCreditsDate) or data.genericData.socialCredits), true, true)
		else
			DATAFILEPLUGIN:CreateRow(socialCredits, data.genericData.cohesionPoints and "cohesion points", math.Clamp(tonumber(data.genericData.cohesionPoints), 0, 200), (isnumber(data.genericData.cohesionPointsDate) and os.date("%d/%m/%Y", data.genericData.cohesionPointsDate) or data.genericData.cohesionPointsDate), true, true)
		end

		local geneticDescription = this:Add("EditablePanel")
		DATAFILEPLUGIN:CreateRow(geneticDescription, "genetic description", data.genericData.geneticDesc, nil, false, false)

		local occupation = this:Add("EditablePanel")
		DATAFILEPLUGIN:CreateRow(occupation, "occupation", string.Left(data.genericData.occupation, 38), data.genericData.occupationDate, true, true)

		local designatedStatus = this:Add("EditablePanel")
		DATAFILEPLUGIN:CreateRow(designatedStatus, "designated status", string.Left(data.genericData.designatedStatus, 38), data.genericData.designatedStatusDate, false, true)
		designatedStatus:DockMargin(0, 0, 0, 15)

		local records = this:Add("ixDatafileMedicalRecords")
		records:Dock(TOP)
		records:DockMargin(0, 0, 0, 0)
		records:SetTall(this:GetTall() - name:GetTall() - cid:GetTall() - socialCredits:GetTall() - geneticDescription:GetTall() - occupation:GetTall() - designatedStatus:GetTall() - 15) -- I'm sorry, FILL didn't work. I don't know why.
		records.back:Remove()
		records.topDivider:Remove()
		records.contentSubframe = this
		records.medicalRecords = data.medicalRecords
		records.genericData = data.genericData
		records.cmuPDA = true
		records.recordsFrame:SetTall(this:GetTall() - name:GetTall() - cid:GetTall() - socialCredits:GetTall() - geneticDescription:GetTall() - occupation:GetTall() - designatedStatus:GetTall() - 15 - SScaleMin(2 / 3) - SScaleMin(11 / 3) - 20)
		records.OnSaveRecord = function()
			timer.Simple(0.1, function()
				net.Start("ixDataFilePDA_CMU_RequestData")
					net.WriteString(self.searchPanel.name:GetText())
					net.WriteBool(true)
				net.SendToServer()
			end)
		end
		records:Populate(data.medicalRecords)
	end
	self.output.Paint = nil

	net.Receive("ixDataFilePDA_CMU_CheckData", function(_, client)
		local length = net.ReadUInt(32)
		local data = net.ReadData(length)
		local uncompressed = util.Decompress(data)

		if (!uncompressed) then return end

		local output = util.JSONToTable(uncompressed)

		self.output:Populate(output)
	end)
end

vgui.Register("ixDatafilePDA_CMU", PANEL, "EditablePanel")

net.Receive("ixDataFilePDA_CMU_Open", function(length, client)
	local character = LocalPlayer():GetCharacter()

	if (LocalPlayer():Team() == FACTION_MEDICAL or character:IsVortigaunt() and character:GetBioticPDA() == "CMU" ) then
		if IsValid(ix.gui.menu) then
			ix.gui.menu:Remove()
		end

		surface.PlaySound("willardnetworks/datapad/open.wav")
		vgui.Create("ixDatafilePDA_CMU")
	end
end)
