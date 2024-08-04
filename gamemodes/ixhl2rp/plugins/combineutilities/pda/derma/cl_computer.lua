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
	
	ix.gui.medicalComputer = self:Add("MedicalComputerBase")
end

function PANEL:Think()
	if !IsValid(ix.gui.medicalComputer) then
		self:Remove()
	end
	
	if IsValid(ix.gui.medicalComputer.functionsPanel) then
		if IsValid(ix.gui.medicalComputer.functionsPanel.medicalButton) then
			ix.gui.medicalComputer.functionsPanel.medicalButton:Remove()
		end
	end
end

vgui.Register("CitizenComputer", PANEL, "EditablePanel")