--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:PopulateEntityInfo(entity, container)
	if (entity:GetClass() != "prop_physics") then return end

	local propDescription = entity:GetNetVar("description")

	if (!propDescription or !istable(propDescription) or #propDescription != 2) then return end

	local titleLabel = container:AddRow("title")
	titleLabel:SetText(propDescription[1])
	titleLabel:SetImportant()
	titleLabel:SetBackgroundColor(Color(255, 255, 255, 255))
	titleLabel:SizeToContents()

	local descriptionLabel = container:AddRow("description")
	descriptionLabel:SetText(propDescription[2])
	descriptionLabel:SetBackgroundColor(Color(255, 255, 255, 255))
	descriptionLabel:SizeToContents()
end
