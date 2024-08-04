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

netstream.Hook("SetDatafileLoyaltyPoints", function(target, amount)
	netstream.Start("SetDatafileLoyaltyPointsServer", target, amount)
end)

netstream.Hook("OpenDatafileCl", function(table)
	if !PLUGIN.contentSubframe then return end
	if !IsValid(PLUGIN.contentSubframe) then return end

	PLUGIN.file = table

	if !PLUGIN.file or PLUGIN.file and istable(PLUGIN.file) and !PLUGIN.file.genericdata then
		if !PLUGIN.file then return end
		if istable(PLUGIN.file) and PLUGIN.file["charID"] then
			if CAMI.PlayerHasAccess(LocalPlayer(), "Helix - Basic Admin Commands") then
				Derma_Query("Something went wrong with the datafile of this individual", "Do you want to reset the datafile of charID: "..PLUGIN.file["charID"].."?",
				"Confirm Operation", function()
					netstream.Start("ResetDatafileToDefault", PLUGIN.file["charID"])
				end, "Cancel")
			end
		end
		
		return
	end
	
	for _, v in pairs(PLUGIN.contentSubframe:GetChildren()) do
		v:SetVisible(false)
	end

	PLUGIN.datafileInfo = vgui.Create("ixDatafileInfo", PLUGIN.contentSubframe)
	PLUGIN.datafileFunctions = vgui.Create("ixDatafileFunctions", PLUGIN.contentSubframe)
end)