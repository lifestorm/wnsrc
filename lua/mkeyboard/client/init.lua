--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

surface.CreateFont( "MKeyboard_Title", {
    size = ScrH() * 0.025, weight = 300, antialias = true, font = "Coolvetica"
} )

surface.CreateFont( "MKeyboard_Key", {
    size = ScrH() * 0.02, weight = 300, antialias = true, font = "Coolvetica"
} )

surface.CreateFont( "MKeyboard_Sheet", {
    size = ScrH() * 0.022, antialias = true, font = "Roboto"
} )

MKeyboard.colors = {
    manual = Color( 245, 163, 108 ),
    automated = Color( 196, 0, 226 ),

    white = Color( 255, 255, 255, 255 ),
    black = Color( 0, 0, 0, 255 ),
    frame = Color( 0, 0, 0, 220 ),
    panel = Color( 30, 30, 30, 255 )
}

MKeyboard.instruments = MKeyboard.instruments or {}
MKeyboard.layouts = MKeyboard.layouts or {}
MKeyboard.sheets = MKeyboard.sheets or {}

function MKeyboard:RegisterInstrument( name, path, noteMin, noteMax )
    self.instruments[#self.instruments + 1] = {
        name = name,
        path = path,
        noteMin = noteMin,
        noteMax = noteMax
    }
end

function MKeyboard:RegisterLayout( id, label, keys )
    self.layouts[#self.layouts + 1] = {
        id = id,
        label = label,
        keys = keys
    }
end

function MKeyboard:RegisterSheet( title, layout, sequence )
    self.sheets[#self.sheets + 1] = {
        title = title,
        layout = layout,
        sequence = sequence
    }
end

net.Receive( "mkeyboard.set_current_keyboard", function()
    local ent = net.ReadEntity()

    MKeyboard:Shutdown()

    if IsValid( ent ) then
        MKeyboard:Init( ent )
    end
end )

-- Receiver for the button hooks that only run serverside on single-player
if game.SinglePlayer() then
    net.Receive( "mkeyboard.key", function()
        local button = net.ReadUInt( 8 )
        local pressed = net.ReadBool()

        if IsValid( MKeyboard.entity ) then
            if pressed then
                MKeyboard:OnButtonPress( button )
            else
                MKeyboard:OnButtonRelease( button )
            end
        end
    end )
end

-- Play notes received from the network,
-- while keeping the original timings
local queue = {}
local SysTime = SysTime
local GetKeys = table.GetKeys

hook.Add( "Think", "MKeyboard.ProcessReproductionQueue", function()
    local now = SysTime()
    local timestamps = GetKeys( queue )

    for _, t in ipairs( timestamps ) do
        if now > t then
            local n = queue[t]

            if IsValid( n[1] ) then
                n[1]:EmitNote( n[2], n[3], n[4], n[5] )
            end

            queue[t] = nil
        end
    end
end )

net.Receive( "mkeyboard.notes", function()
    local ent = net.ReadEntity()
    if not IsValid( ent ) or not ent.EmitNote then return end

    local automated = net.ReadBool()
    local noteCount = net.ReadUInt( 5 )
    local note, velocity, instrument, timeOffset
    local t = SysTime()

    for i = 1, noteCount do
        note = net.ReadUInt( 7 )
        velocity = net.ReadUInt( 7 )
        instrument = net.ReadUInt( 6 )
        timeOffset = net.ReadFloat()

        -- i * 0.01 to prevent overriding stuff already on the queue
        queue[t + timeOffset + ( i * 0.01 )] = { ent, note, velocity, instrument, automated }
    end
end )
