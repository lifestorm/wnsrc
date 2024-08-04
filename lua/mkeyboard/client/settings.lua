--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

MKeyboard.settings = MKeyboard.settings or {
    layout = 1,
    instrument = 1,
    sheet = 0,
    velocity = 127,
    transpose = 0,
    midiTranspose = 0,
    drawKeyLabels = true,
    channelInstruments = {}
}

local function ValidateInteger( n, min, max )
    return math.Round( math.Clamp( tonumber( n ), min, max ) )
end

function MKeyboard:LoadSettings()
    local rawData = file.Read( self.SETTINGS_FILE, "DATA" )
    if not rawData then return end

    local data = util.JSONToTable( rawData ) or {}
    local instrumentCount = #self.instruments
    local settings = self.settings

    -- last layout that was used on the keyboard
    if data.layout then
        settings.layout = ValidateInteger( data.layout, 1, #self.layouts )
    end

    -- last instrument that was used on the keyboard
    if data.instrument then
        settings.instrument = ValidateInteger( data.instrument, 1, instrumentCount )
    end

    -- last selected sheet
    if data.sheet then
        settings.sheet = ValidateInteger( data.sheet, 0, #self.sheets )
    end

    -- last used velocity
    if data.velocity then
        settings.velocity = ValidateInteger( data.velocity, 1, 127 )
    end

    -- last used transpose
    if data.transpose then
        settings.transpose = ValidateInteger( data.transpose, -48, 48 )
    end

    -- last transpose that was used with midi
    if data.midiTranspose then
        settings.midiTranspose = ValidateInteger( data.midiTranspose, -48, 48 )
    end

    -- draw labels for keys
    settings.drawKeyLabels = Either( isbool( data.drawKeyLabels ), tobool( data.drawKeyLabels ), true )

    -- links between instruments and MIDI channels
    if data.channelInstruments and type( data.channelInstruments ) == "table" then
        for c, i in pairs( data.channelInstruments ) do
            local channel = ValidateInteger( c, 0, 15 )
            local instrument = ValidateInteger( i, 1, instrumentCount )

            settings.channelInstruments[channel] = instrument
        end
    end
end

function MKeyboard:SaveSettings()
    local settings = self.settings

    file.Write(
        self.SETTINGS_FILE,
        util.TableToJSON( {
            layout              = settings.layout,
            instrument          = settings.instrument,
            sheet               = settings.sheet,
            velocity            = settings.velocity,
            transpose           = settings.transpose,
            midiTranspose       = settings.midiTranspose,
            channelInstruments  = settings.channelInstruments,
            drawKeyLabels       = settings.drawKeyLabels
        }, true )
    )
end
