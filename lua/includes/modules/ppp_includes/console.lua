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
-- Convars
pk_pills.convars = {}
-- Admin vars
pk_pills.convars.admin_restrict = CreateConVar("pk_pill_admin_restrict", game.IsDedicated() and 1 or 0, FCVAR_REPLICATED + FCVAR_NOTIFY, "Restrict morphing to admins.")
pk_pills.convars.admin_anyweapons = CreateConVar("pk_pill_admin_anyweapons", 0, FCVAR_REPLICATED, "Allow use of any weapon when morphed.")
pk_pills.convars.preserve = CreateConVar("pk_pill_preserve", 0, FCVAR_REPLICATED, "Makes player spit out pills when they unmorph or die.")

-- Client vars
if CLIENT then
    pk_pills.convars.cl_thirdperson = CreateClientConVar("pk_pill_cl_thirdperson", 1)
    pk_pills.convars.cl_hidehud = CreateClientConVar("pk_pill_cl_hidehud", 0)
end

-- Admin var setter command.
if SERVER then
    local function admin_set(ply, cmd, args)
        if not ply then
            print("If you are using the server console, you should set the variables directly!")

            return
        end

        if not ply:IsSuperAdmin() then
            ply:PrintMessage(HUD_PRINTCONSOLE, "You must be a super admin to use this command.")

            return
        end

        local var = args[1]
        local value = args[2]

        if not var then
            if ply then
                ply:PrintMessage(HUD_PRINTCONSOLE, "Please supply a valid convar name. Do not include 'pk_pill_admin_'.")
            end

            return
        elseif not ConVarExists("pk_pill_admin_" .. var) then
            ply:PrintMessage(HUD_PRINTCONSOLE, "Convar 'pk_pill_admin_" .. var .. "' does not exist. Please supply a valid convar name. Do not include 'pk_pill_admin_'.")

            return
        end

        if not value then
            ply:PrintMessage(HUD_PRINTCONSOLE, "Please supply a value to set the convar to.")

            return
        end

        RunConsoleCommand("pk_pill_admin_" .. var, value)
    end

    concommand.Add("pk_pill_admin_set", admin_set, nil, "Helper command for setting Morph Mod admin convars. Available to super admins.")
end
