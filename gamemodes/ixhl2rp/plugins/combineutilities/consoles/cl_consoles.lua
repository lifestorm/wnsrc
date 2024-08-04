--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


netstream.Hook("SetLinkedUpdateCL", function(update)
	ix.data.Set("CameraConsoleLinkedUpdate", update)
end)

netstream.Hook("SetConsoleUpdates", function(updates)
	if (IsValid(ix.gui.consolePanel)) then
		ix.gui.consolePanel.updates = updates
	end
end)

netstream.Hook("CloseConsole", function(updates)
	if (IsValid(ix.gui.consolePanel)) then
		ix.gui.consolePanel:TurnOff()
		ix.gui.consolePanel:Remove()
	end
end)
