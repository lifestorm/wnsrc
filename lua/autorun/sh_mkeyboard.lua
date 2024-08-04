--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

MKeyboard = {
    -- max. allowed number of notes per net event
    NET_MAX_NOTES = 31,

    -- players need to be within this distance to receive net events
    NET_BROADCAST_DISTANCE = 1500,

    -- name/location of the settings file
    SETTINGS_FILE = "musical_keyboard.json",

    -- URL for the midi installation guide
    URL_MIDI_GUIDE = "https://steamcommunity.com/workshop/filedetails/discussion/2656563609/3199240042192880687/"
}

if SERVER then
    include( "mkeyboard/server/init.lua" )

    AddCSLuaFile( "mkeyboard/client/init.lua" )
    AddCSLuaFile( "mkeyboard/client/settings.lua" )
    AddCSLuaFile( "mkeyboard/client/piano.lua" )
    AddCSLuaFile( "mkeyboard/client/interface.lua" )
    AddCSLuaFile( "mkeyboard/client/midi.lua" )
end

if CLIENT then
    include( "mkeyboard/client/init.lua" )
    include( "mkeyboard/client/settings.lua" )
    include( "mkeyboard/client/piano.lua" )
    include( "mkeyboard/client/interface.lua" )
    include( "mkeyboard/client/midi.lua" )
end

-- Find and include data files
do
    local dataDir = "mkeyboard/data/"
    local files = file.Find( dataDir .. "*.lua", "LUA" )

    if SERVER then
        for _, name in ipairs( files ) do
            AddCSLuaFile( dataDir .. name )
        end
    end

    if CLIENT then
        for _, name in ipairs( files ) do
            include( dataDir .. name )
        end
    end
end
