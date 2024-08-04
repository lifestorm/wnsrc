--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

PLUGIN.name = "EventManager"
PLUGIN.author = "Enistein"
PLUGIN.description = "Event related stuff."

ix.util.Include("sv_hooks.lua")

ix.command.Add("gravityevent", {
    description = "Manuel olarak yerçekimi eventini başlatır.",
    adminOnly = true,
    OnRun = function()
        startGravityEvent()
    end
})