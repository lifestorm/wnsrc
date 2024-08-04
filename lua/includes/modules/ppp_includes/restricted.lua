--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()
local restricted

if SERVER then
    util.AddNetworkString("pk_pill_restricted")

    -- rename old file
    if file.Exists("pill_config/restrictions.txt", "DATA") then
        file.Rename("pill_config/restrictions.txt", "pill_config/restricted.txt")
    end

    -- load restrictions
    restricted = {}

    for k, v in pairs(("\n"):Explode(file.Read("pill_config/restricted.txt") or "")) do
        restricted[v] = true
    end

    pk_pills._restricted = restricted

    concommand.Add("pk_pill_restrict", function(ply, cmd, args, str)
        if not ply:IsSuperAdmin() then return end
        local pill = args[1]
        local a = args[2]

        if a == "on" then
            restricted[pill] = true
        elseif a == "off" then
            restricted[pill] = false
        end

        local write_str = ""

        for k, v in pairs(restricted) do
            if write_str ~= "" then
                write_str = write_str .. "\n"
            end

            write_str = write_str .. k
        end

        file.Write("pill_config/restricted.txt", write_str)
        net.Start("pk_pill_restricted")
        net.WriteTable(restricted)
        net.Broadcast()
    end)

    hook.Add("PlayerInitialSpawn", "pk_pill_transmit_restricted", function(ply)
        net.Start("pk_pill_restricted")
        net.WriteTable(restricted)
        net.Send(ply)
    end)
else
    pk_pills._restricted = {}

    net.Receive("pk_pill_restricted", function(len, pl)
        restricted = net.ReadTable()
        pk_pills._restricted = restricted
    end)
end
