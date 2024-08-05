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

VyHub = VyHub or {}
VyHub.Config = VyHub.Config or {}
VyHub.Lib = VyHub.Lib or {}
VyHub.ready = false

local vyhub_root = "vyhub"

local color_warn = Color(211, 120, 0)
local color_err = Color(255, 0, 0)
local color_green = Color(0, 255, 0)

function VyHub:msg(message, type)
    type = type or "neutral"

    // Remove color tags
    message = string.gsub(message, "<([%l]+)>([^<]+)</%1>", "%2")

	if type == "success" then
		MsgC("[VyHub] ", color_green, message .. "\n")
	elseif type == "error" then
		MsgC("[VyHub] [ERROR] ", color_err, message .. "\n")
	elseif type == "neutral" then
		MsgC("[VyHub] ", color_white, message .. "\n")
    elseif type == "warning" then
		MsgC("[VyHub] [WARN] ", color_warn, message .. "\n")
    elseif type == "debug" and VyHub.Config.debug then
		MsgC("[VyHub] [Debug] ", color_white, message .. "\n")
	end
end

VyHub:msg("Initializing...")

if SERVER then
    addon_incomplete = false

    if file.Exists( vyhub_root .. '/lang/en.json', "LUA") then
        if file.Exists( vyhub_root .. '/config/sv_config.lua', "LUA") then
            hook.Run("vyhub_loading_start")

            -- libs
            VyHub:msg("Loading lib files...")
            local files = file.Find( vyhub_root .."/lib/*.lua", "LUA" )
            for _, file in ipairs( files ) do
                AddCSLuaFile( vyhub_root .. "/lib/" .. file )
                include( vyhub_root .. "/lib/" .. file )
            end

            -- Shared Config
            include( vyhub_root .. '/config/sh_config.lua' )
            AddCSLuaFile( vyhub_root .. "/config/sh_config.lua" )

            -- Language
            VyHub:msg('Loading ' .. VyHub.Config.lang .. ' language...')
            include( vyhub_root .. '/shared/sh_lang.lua' )

            -- Config Files
            VyHub:msg("Loading config files...")
            include( vyhub_root .. '/config/sv_config.lua' )

            -- Shared Files
            VyHub:msg("Loading shared files...")
            local files = file.Find( vyhub_root .."/shared/*.lua", "LUA" )
            for _, file in ipairs( files ) do
                AddCSLuaFile( vyhub_root .. "/shared/" .. file )
                include( vyhub_root .. "/shared/" .. file )
            end
            
            -- Client Files
            VyHub:msg("Loading client files...")
            local files = file.Find( vyhub_root .."/client/*.lua", "LUA" )
            for _, file in ipairs( files ) do
                AddCSLuaFile( vyhub_root .."/client/" .. file )
            end

            -- Server Files
            VyHub:msg("Loading server files...")
            local files = file.Find( vyhub_root .. "/server/*.lua", "LUA" )
            for _, file in ipairs( files ) do
                include( vyhub_root .. "/server/" .. file )
            end

            game.ConsoleCommand("sv_hibernate_think 1\n")

            file.CreateDir("vyhub")

            VyHub.Config:load_cache_config()

            timer.Simple(2, function()
                hook.Run("vyhub_loading_finish")
            end)
            
            VyHub:msg("Finished loading!")
        else
            VyHub:msg("Could not find lua/vyhub/config/sv_config.lua. Please make sure it exists.", "error")
        end
    else
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("Could not find language files!!! Please make sure to download a correct vyhub-gmod release here: https://github.com/matbyte-com/vyhub-gmod/releases", "error")
        VyHub:msg("Cannot proceed with initialization.", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
    end
end


if CLIENT then
    if file.Exists( vyhub_root .. '/shared/sh_lang.lua', "LUA") then
        hook.Run("vyhub_loading_start")
        
        -- libs
        VyHub:msg("Loading lib files...")
        local files = file.Find( vyhub_root .."/lib/*.lua", "LUA" )
        for _, file in ipairs( files ) do
            include( vyhub_root .. "/lib/" .. file )
        end

        -- Language
        VyHub:msg('Loading language...')
        include( vyhub_root .. '/shared/sh_lang.lua' )

        -- Config Files
        VyHub:msg("Loading config files...")
        local files = file.Find( vyhub_root .."/config/*.lua", "LUA" )
        for _, file in ipairs( files ) do
            if not string.StartWith(file, 'sv_') then
                include( vyhub_root .. "/config/" .. file )
            end
        end

        -- Shared Files
        VyHub:msg("Loading shared files...")
        local files = file.Find( vyhub_root .."/shared/*.lua", "LUA" )
        for _, file in ipairs( files ) do
            include( vyhub_root .. "/shared/" .. file )
        end

        -- Client Files
        VyHub:msg("Loading client files...")
        local files = file.Find( vyhub_root .."/client/*.lua", "LUA" )
        for _, file in ipairs( files ) do
            include( vyhub_root .."/client/" .. file )
        end

        timer.Simple(2, function()
            hook.Run("vyhub_loading_finish")
        end)
        
        VyHub:msg("Finished loading!")
    else
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("VyHub not correctly loaded. Please check the server log.", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
        VyHub:msg("!!!", "error")
    end
end
