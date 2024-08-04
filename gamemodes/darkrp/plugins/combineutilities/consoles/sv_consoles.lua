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

netstream.Hook("SetLinkedUpdate", function(client, console, update)
    if (IsValid(console) and console:GetClass() == "ix_console" and console.user == client) then
        local character = client:GetCharacter()
        if (character:GetClass() != CLASS_CP_CMD and character:GetClass() != CLASS_CP_CPT and character:GetClass() != CLASS_CP_RL and character:GetClass() != CLASS_OVERSEER) then
            return
        end
        ix.data.Set("CameraConsoleLinkedUpdate", update)
        netstream.Start(client, "SetLinkedUpdateCL", update)
    end
end)

netstream.Hook("GetLinkedUpdate", function(client)
	if !client:GetActiveCombineSuit() then
		return false
	end
	
    local update = ix.data.Get("CameraConsoleLinkedUpdate", {})
    netstream.Start(client, "SetLinkedUpdateCL", update)
end)

-- Netstream Hooks
netstream.Hook("CloseConsole", function(client, console)
    if (IsValid(console) and console:GetClass() == "ix_console" and console.user == client) then
        console:CloseConsole()
    end
end)

netstream.Hook("SetConsoleCameraPos", function(client, console, entity)
	if !client:GetActiveCombineSuit() then
		return false
	end
	
    if (IsValid(console) and console:GetClass() == "ix_console" and console.user == client) then
        client.currentCamera = entity
    end
end)

netstream.Hook("GetConsoleUpdates", function(client)
    local character = client:GetCharacter()
    local class = character:GetClass()
    if (class == CLASS_CP_CPT or class == CLASS_OVERSEER or class == CLASS_OW_SCANNER) then
        PLUGIN:GetConsoleUpdates(client)
        timer.Simple(0.05, function()
            netstream.Start(client, "SetConsoleUpdates", PLUGIN.updatelist)
        end)
    end
end)

local function CloseConsole(client)
	if (IsValid(client.ixConsole)) then
        client.ixConsole:CloseConsole()
        netstream.Start(client, "CloseConsole")
	end
end
hook.Add("PlayerDisconnected", "ixConsoleCloseOnDisconnect", CloseConsole)
hook.Add("PlayerLoadedCharacter", "ixConsoleCloseOnCharSwap", CloseConsole)
hook.Add("PlayerDeath", "ixConsoleCloseOnDeath", CloseConsole)