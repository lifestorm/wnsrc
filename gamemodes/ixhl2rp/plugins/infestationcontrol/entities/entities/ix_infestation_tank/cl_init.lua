--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include("shared.lua")

ENT.PopulateEntityInfo = true

function ENT:OnPopulateEntityInfo(container)
	local name = container:AddRow("name")
	name:SetImportant()
	name:SetText(L("infestationTank"))
	name:SizeToContents()

	local milk = self:GetChemicalVolume()
	local success = derma.GetColor("Success", container)
	local warning = derma.GetColor("Warning", container)

	if (milk >= 75) then
		backgroundColor = success
	elseif (milk >= 50) then
		backgroundColor = Color(75, 119, 190)
	elseif (milk >= 25) then
		backgroundColor = warning
	else
		backgroundColor = derma.GetColor("Error", container)
	end

	local tank = container:AddRow("tank")
	tank:SetText(L("infestationTankVolume") .. milk .. "%")
	tank:SetBackgroundColor(backgroundColor)
	tank:SizeToContents()

	local hoseAttached = self:GetHoseAttached() or self:GetHoseConnected()

	local hose = container:AddRow("hose")
	hose:SetText(hoseAttached and L("hoseAttached") or L("hoseDetached"))
	hose:SetBackgroundColor(hoseAttached and success or warning)
	hose:SizeToContents()

	local applicatorAttached = self:GetApplicatorAttached()

	local applicator = container:AddRow("applicator")
	applicator:SetText(applicatorAttached and L("applicatorAttached") or L("applicatorDetached"))
	applicator:SetBackgroundColor(applicatorAttached and success or warning)
	applicator:SizeToContents()
end
