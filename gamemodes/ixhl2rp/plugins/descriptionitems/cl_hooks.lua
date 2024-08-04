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
	local visibileItems = client:GetNetVar("visibleItems", {})
	
	for itemName, _ in pairs(visibileItems) do
		itemName = L(itemName)

		local row = tooltip:AddRow("visibileItem_" .. itemName)
		row:SetBackgroundColor(color_white)
		row:SetText("They are carrying " .. (itemName[#itemName]:lower() == "s" and "" or itemName:match("^[aeiouAEIOU]") and "an " or "a ") .. itemName .. ".")
		row:SizeToContents()
	end
end
