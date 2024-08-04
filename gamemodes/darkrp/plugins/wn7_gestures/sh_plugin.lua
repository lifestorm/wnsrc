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

PLUGIN.name = "Dialogue Gestures & Hand Signals"
PLUGIN.author = "Naast & Aspect™"
PLUGIN.description = "Adds dialogue gestures & hand signals."

ix.util.Include("meta/sv_player.lua")
ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_options.lua")
ix.util.Include("sv_hooks.lua")

PLUGIN.availableAnimClasses = {
    ["metrocop"] = true,
    ["citizen_male"] = true,
    ["citizen_female"] = true,
    ["overwatch"] = true
}

ix.command.Add("Handsignals", {
    description = "Open the handsignals menu!",
    OnRun = function(self, client)
        if not PLUGIN.availableAnimClasses[ix.anim.GetModelClass(client:GetModel())] then return client:NotifyLocalized("Your model is not supported") end
		net.Start("ixOpenHandSignalMenu")
		net.Send(client)
    end
})