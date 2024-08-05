--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local f = string.format
local json = VyHub.Lib.json

VyHub.Lang = VyHub.Lang or {}
VyHub.lang = VyHub.lang or nil

if SERVER then
    util.AddNetworkString("vyhub_lang")

    VyHub.Lang.compressed = VyHub.Lang.compressed or nil 

    function VyHub.Lang:load()
        local f_en = file.Open("vyhub/lang/en.json", "r", "LUA")

        if f_en == nil then
            VyHub:msg("Missing language file en.json!!! PLEASE MAKE SURE TO DOWNLOAD VYHUB-GMOD ON THE GITHUB RELESES PAGE! https://github.com/matbyte-com/vyhub-gmod/releases", "error")
            return
        end

        local en = json.decode(f_en:Read())
        f_en:Close()

        if not istable(en) then
            VyHub:msg("Could not load language file en.json!", "error")
            return
        end

        VyHub.lang = en

        VyHub:msg("Loaded language en.")

        if VyHub.Config.lang != 'en' then
            local f_custom = file.Open(f("vyhub/lang/%s.json", VyHub.Config.lang), "r", "LUA")

            if f_custom != nil then 
                local custom = json.decode(f_custom:Read())
                f_custom:Close()

                if istable(custom) then
                    table.Merge(VyHub.lang, custom)
                    VyHub:msg(f("Loaded language %s.", VyHub.Config.lang))
                else
                    VyHub:msg(f("Could not load language file %s.json!", VyHub.Config.lang), "warning")
                end
            else
                VyHub:msg(f("Missing language file %s.json.", VyHub.Config.lang), "warning")
            end
        end     
        
        VyHub.Lang.compressed = util.Compress(json.encode(VyHub.lang))
    end

    if VyHub.lang == nil then
        VyHub.Lang:load()
    end

    net.Receive("vyhub_lang", function(_, ply)
        if not IsValid(ply) then return end
        if not VyHub.Lang.compressed then return end

        local len = #VyHub.Lang.compressed

        net.Start("vyhub_lang")
            net.WriteUInt(len, 16)
            net.WriteData(VyHub.Lang.compressed, len)
        net.Send(ply)
    end)
end

if CLIENT then
    function VyHub.Lang:load()
        net.Start("vyhub_lang")
        net.SendToServer()
    end

    net.Receive("vyhub_lang", function()
        timer.Remove("vyhub_lang_load")

        local len = net.ReadUInt(16)
        local lang_compr = net.ReadData(len)

        VyHub.lang = json.decode(util.Decompress(lang_compr))

        VyHub:msg("Loaded language.")
        
        hook.Run("vyhub_lang_loaded")
    end)

    hook.Add("Initialize", "vyhub_lang_Initialize", function ()
        VyHub.Lang:load()

        timer.Create("vyhub_lang_load", 5, 5, function ()
            if VyHub.lang == nil then
                VyHub.Lang:load()
            else
                timer.Remove("vyhub_lang_load")
            end
        end)
    end)
end
