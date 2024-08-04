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

PLUGIN.name = "VJ Spawner Disabler"
PLUGIN.author = "M!NT"
PLUGIN.description = "Disables the VJ NPC spawner."


if (SERVER) then
    ix.log.AddType("unprotectedVJNetCall", function(client)
        return string.format("%s is trying to abuse unprotected VJ net calls.", client:Name())
    end, FLAG_DANGER)

    timer.Simple(10, function()
        net.Receive("vj_npcspawner_sv_create", function(len, ply)
            ply:Kick("Nice try :)")
            ix.log.Add(ply, "unprotectedVJNetCall")
        end)
    end)
end

hook.Add("OnEntityCreated", "DisableVJSpawner", function( ent )
	if (ent:GetClass() == "obj_vj_spawner_base") then
        ent:Remove()
    end
end)

timer.Simple(10, function()
    concommand.Remove("vj_cleanup")
end)
