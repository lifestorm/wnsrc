--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if util.IsBinaryModuleInstalled( "midi" ) then
    require( "midi" )
end

if not midi then return end

MKeyboard.isMIDIAvailable = true
MKeyboard.channelState = {}

function MKeyboard:SetMIDIPortName( name )
    self.midiPortName = nil

    if not name then return end

    if string.len( name ) > 28 then
        name = string.sub( name, 1, 25 ) .. "..."
    end

    self.midiPortName = string.format( language.GetPhrase( "musicalk.midi.connected" ), name )
end

function MKeyboard:OpenMIDI( port )
    if midi.IsOpened() then
        self:CloseMIDI()
    end

    local portName = midi.GetPorts()[port]
    if not portName then
        print( "Could not find MIDI port: " .. port )

        return
    end

    print( "Opening MIDI port: " .. portName )

    local success, err = pcall( midi.Open, port )
    if success then
        self:SetMIDIPortName( portName )
    else
        print( "Failed to open MIDI port: " .. err )
    end
end

function MKeyboard:CloseMIDI()
    self:SetMIDIPortName()

    if midi and midi.IsOpened() then
        print( "Closing MIDI port." )
        midi.Close()
    end
end

function MKeyboard:CheckMIDI()
    if midi.IsOpened() then
        if self.selectedMIDIPort and not midi.GetPorts()[self.selectedMIDIPort] then
            print( "MIDI port no longer exists." )
            self.selectedMIDIPort = nil
            self:CloseMIDI()
        end

    elseif self.selectedMIDIPort then
        self:OpenMIDI( self.selectedMIDIPort )
    end
end

function MKeyboard:OnMIDIEvent( code, p1, p2 )
    local cmd = midi.GetCommandName( code )
    local transpose = self.settings.midiTranspose

    if cmd == "NOTE_ON" and p2 > 0 then
        local channel = midi.GetCommandChannel( code )
        local instrument = self.settings.channelInstruments[channel]

        self.lastNoteWasAutomated = true
        self.piano:PressNote( p1 + transpose, p2, instrument, self.colors.automated, true )
        self.channelState[channel] = 1

    elseif cmd == "NOTE_OFF" then
        self.piano:ReleaseNote( p1 + transpose )
    end
end

hook.Add( "MIDI", "MKeyboard.CaptureMIDIEvents", function( _, code, p1, p2 )
    if code and IsValid( MKeyboard.entity ) then
        MKeyboard:OnMIDIEvent( code, p1, p2 )
    end
end )
