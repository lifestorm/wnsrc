--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ix = ix
local bit = bit
local net = net

local PLUGIN = PLUGIN

PLUGIN.name = "Bodygroup Manager"
PLUGIN.author = "Gary Tate"
PLUGIN.description = "Allows players and administration to have an easier time customising bodygroups."

ix.lang.AddTable("english", {
    cmdEditBodygroup = "Customise the bodygroups of a target."
})

ix.lang.AddTable("spanish", {
	cmdEditBodygroup = "Personalizar los bodygroups de un objetivo."
})

ix.command.Add("CharEditBodygroup", {
    description = "cmdEditBodygroup",
    adminOnly = true,
    arguments = {
        bit.bor(ix.type.player, ix.type.optional)
    },
    OnRun = function(self, client, target)
        net.Start("ixBodygroupView")
            net.WriteEntity(target or client)
            net.WriteTable(target:GetCharacter():GetProxyColors() or {})
        net.Send(client)
    end
})

ix.util.Include("sv_hooks.lua")
ix.util.Include("cl_hooks.lua")
