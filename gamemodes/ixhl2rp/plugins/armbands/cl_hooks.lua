--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:PopulateCharacterInfo(client, character, tooltip)
	local armbandData = client:GetNetVar("armbands", {})
	
	for armband, color in pairs(armbandData) do
		local panel = tooltip:AddRow("armband")
		panel:SetBackgroundColor(color)
		panel:SetText("They are wearing a " .. armband)
		panel:SizeToContents()
	end
end
