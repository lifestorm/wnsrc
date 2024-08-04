--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local shortcuts = {
    [KEY_TAB] =	function()
        if IsValid( MKeyboard.entity ) then
            RunConsoleCommand( "musical_keyboard_leave", MKeyboard.entity:EntIndex() )
        end
    end,

    [KEY_SPACE] = function()
        MKeyboard:ToggleMenu()
    end,

    [KEY_LEFT] = function()
        MKeyboard:SwitchInstrument( -1 )
    end,

    [KEY_RIGHT] = function()
        MKeyboard:SwitchInstrument( 1 )
    end,

    [KEY_UP] = function()
        MKeyboard:SetTranspose( MKeyboard.settings.transpose + 1 )
    end,

    [KEY_DOWN] = function()
        MKeyboard:SetTranspose( MKeyboard.settings.transpose - 1 )
    end
}

local dontBlockBinds = {
    ["+attack"] = true,
    ["+attack2"] = true,
    ["+duck"] = true
}

local transmitQueue = {}
local queueTimer, queueStart

MKeyboard.layoutName = ""
MKeyboard.isMenuOpen = false
MKeyboard.lastNoteWasAutomated = false

function MKeyboard:Init( ent )
    self.entity = ent
    self.blockInputTimer = RealTime() + 0.3

    self:LoadSettings()
    self:OpenInterface()

    self:SetInstrument()
    self:SetTranspose()
    self:SetLayoutByIndex()

    self.piano.OnNoteOn = function( note, velocity, instrument, automated )
        instrument = instrument or self.settings.instrument

        local data = self.instruments[instrument] or self.instruments[1]
        if note < data.noteMin or note > data.noteMax then return end

        self.entity:EmitNote( note, velocity, instrument, automated )
        self.lastNoteWasAutomated = automated

        -- Remember when we started putting notes
        -- on the queue, and when we should send them
        local t = SysTime()

        if not queueTimer then
            queueTimer = t + 0.4
            queueStart = t
        end

        -- Add notes to the queue unless the limit was reached
        local noteCount = #transmitQueue
        if noteCount < self.NET_MAX_NOTES then
            transmitQueue[noteCount + 1] = {
                note, velocity, instrument, t - queueStart
            }
        end
    end

    hook.Add( "Think", "MKeyboard.ProcessLocalKeyboard", function()
        if not IsValid( self.entity ) then
            self:Shutdown()

            return
        end

        local t = SysTime()

        -- If the queued notes are ready to be sent...
        if queueTimer and t > queueTimer then
            net.Start( "mkeyboard.notes", false )
            net.WriteEntity( self.entity )
            net.WriteBool( self.lastNoteWasAutomated )
            net.WriteUInt( #transmitQueue, 5 )

            for _, params in ipairs( transmitQueue ) do
                net.WriteUInt( params[1], 7 ) -- note
                net.WriteUInt( params[2], 7 ) -- velocity
                net.WriteUInt( params[3], 6 ) -- instrument
                net.WriteFloat( params[4] )   -- time offset
            end

            net.SendToServer()

            table.Empty( transmitQueue )
            queueTimer = nil
        end
    end )

    hook.Add( "PlayerButtonDown", "MKeyboard.DetectButtonPress", function( ply, button )
        if ply == LocalPlayer() and IsFirstTimePredicted() then
            self:OnButtonPress( button )
        end
    end )

    hook.Add( "PlayerButtonUp", "MKeyboard.DetectButtonRelease", function( ply, button )
        if ply == LocalPlayer() and IsFirstTimePredicted() then
            self:OnButtonRelease( button )
        end
    end )

    hook.Add( "PlayerBindPress", "MKeyboard.BlockBinds", function( _, bind )
        if not dontBlockBinds[bind] then return true end
    end )

    -- Custom Chat compatibility
    hook.Add( "CustomChatBlockInput", "MKeyboard.PreventOpeningChat", function()
        return true
    end )

    if not self.isMIDIAvailable then return end

    timer.Create( "MKeyboard.CheckMIDI", 1, 0, function()
        self:CheckMIDI()
    end )
end

function MKeyboard:Shutdown()
    self.entity = nil

    transmitQueue = {}
    queueTimer = nil

    self:CloseInterface()

    timer.Remove( "MKeyboard.CheckMIDI" )

    if self.isMIDIAvailable then
        self:CloseMIDI()
    end

    hook.Remove( "Think", "MKeyboard.ProcessLocalKeyboard" )
    hook.Remove( "PlayerButtonDown", "MKeyboard.DetectButtonPress" )
    hook.Remove( "PlayerButtonUp", "MKeyboard.DetectButtonRelease" )
    hook.Remove( "PlayerBindPress", "MKeyboard.BlockBinds" )
    hook.Remove( "CustomChatBlockInput", "MKeyboard.PreventOpeningChat" )
end

local settings = MKeyboard.settings
local colors = MKeyboard.colors

function MKeyboard:OnButtonPress( button )
    if RealTime() > self.blockInputTimer then
        self.lastNoteWasAutomated = false
        self.piano:PressButton( button, settings.velocity, settings.instrument, colors.manual )
    end
end

function MKeyboard:OnButtonRelease( button )
    if shortcuts[button] then
        shortcuts[button]()

        return
    end

    self.piano:ReleaseButton( button )
end

function MKeyboard:SetInstrument( index )
    index = index or settings.instrument

    local instrument = self.instruments[index]

    if instrument then
        self.piano:SetNoteRange( instrument.noteMin, instrument.noteMax )
        settings.instrument = index
    end
end

function MKeyboard:SetTranspose( transpose )
    transpose = transpose or settings.transpose

    self.piano:ReleaseAllNotes()
    self.piano.transpose = transpose
    settings.transpose = transpose
end

function MKeyboard:SetLayoutByIndex( index )
    index = index or settings.layout

    if self.layouts[index] then
        settings.layout = index

        local layout = self.layouts[index]

        self.piano:SetLayout( layout.keys )
        self.layoutName = language.GetPhrase( layout.label )
        self:UpdateSheetsList()
    end
end

function MKeyboard:SwitchInstrument( to )
    local newInstrument = settings.instrument + to

    if newInstrument < 1 then
        newInstrument = #self.instruments

    elseif newInstrument > #self.instruments then
        newInstrument = 1
    end

    self:SetInstrument( newInstrument )

    local line = self.instrumentList:GetLine( newInstrument )

    self.instrumentList:ClearSelection()
    self.instrumentList:SelectItem( line )
    self.instrumentList.VBar:AnimateTo( line:GetY() - self.instrumentList:GetTall() * 0.5, 0.25, 0, -1 )

    self:SaveSettings()
end

function MKeyboard:CloseInterface()
    self.isMenuOpen = false

    if IsValid( self.frame ) then
        self.frame:Close()
    end

    if IsValid( self.frameDevices ) then
        self.frameDevices:Close()
    end

    if IsValid( self.frameChannels ) then
        self.frameChannels:Close()
    end
end

function MKeyboard:ToggleMenu()
    self.isMenuOpen = not self.isMenuOpen

    -- I might have found a bug here. Basically, cant get the panel position
    -- after calling LerpPositions without playing the animation first
    -- local x = self.frame:GetX()

    local x = ( ScrW() - ScrW() * 0.7 ) * 0.5
    local tall = self.frame:GetTall()

    if self.isMenuOpen then
        self.frame:SetPos( x, ScrH() - tall )
        self.frame:MakePopup()
    else
        self.frame:SetPos( x, ScrH() - tall * 0.49 )
        self.frame:SetMouseInputEnabled( false )
        self.frame:SetKeyboardInputEnabled( false )
    end
end

local function CreatePanel( title, parent, dock, wide, help )
    local panel = vgui.Create( "DPanel", parent )
    panel:DockPadding( 8, 8, 8, 8 )
    panel:DockMargin( 4, 0, 4, 0 )
    panel:Dock( dock )
    panel:SetBackgroundColor( colors.panel )

    if wide then
        panel:SetWide( wide )
    end

    local panelHeader = vgui.Create( "DPanel", panel )
    panelHeader:Dock( TOP )
    panelHeader:SetPaintBackground( false )

    local labelTitle = vgui.Create( "DLabel", panelHeader )
    labelTitle:SetFont( "MKeyboard_Key" )
    labelTitle:SetText( language.GetPhrase( title ) )
    labelTitle:SizeToContents()
    labelTitle:Dock( LEFT )
    labelTitle:SetTextColor( colors.white )

    if help then
        local labelHelp = vgui.Create( "DLabel", panelHeader )
        labelHelp:SetFont( "MKeyboard_Key" )
        labelHelp:SetText( language.GetPhrase( help ) )
        labelHelp:SizeToContents()
        labelHelp:Dock( RIGHT )
        labelHelp:SetTextColor( colors.white )
    end

    return panel
end

local SetColor = surface.SetDrawColor
local DrawRect = surface.DrawRect
local DrawText = draw.SimpleText

local Ceil = math.ceil

local function DrawSheet( index, x, y )
    local data = MKeyboard.sheets[index]
    if not data then return end

    local borderSize = Ceil( ScrW() * 0.002 )
    local titleBarSize = ScrH() * 0.028

    surface.SetFont( "MKeyboard_Sheet" )

    local sheetW, sheetH = surface.GetTextSize( data.sequence )
    local w, h = math.max( ScrW() * 0.3, sheetW + borderSize * 2 ), sheetH + titleBarSize * 0.5
    local oldClipping = DisableClipping( true )

    x = x - w * 0.5
    y = y - h

    SetColor( 0, 0, 0, 254 )
    DrawRect( x, y, w, h )

    draw.DrawText( data.sequence, "MKeyboard_Sheet", x + w * 0.5, y + titleBarSize, nil, TEXT_ALIGN_CENTER )
    DrawText( data.title, "MKeyboard_Title", x + w * 0.5, y + borderSize, colors.white, TEXT_ALIGN_CENTER )

    DisableClipping( oldClipping )
end

function MKeyboard:OpenInterface()
    if not self.selectedMIDIPort then
        self:ShowDevicesDialog()
    end

    local wide = ScrW() * 0.7
    local tall = ScrH() * 0.5

    self.frame = vgui.Create( "DFrame" )
    self.frame:SetPos( ( ScrW() - wide ) * 0.5, ScrH() - tall * 0.5 )
    self.frame:SetSize( wide, tall )
    self.frame:SetTitle( "" )
    self.frame:SetDeleteOnClose( true )
    self.frame:SetDraggable( false )
    self.frame:SetSizable( false )
    self.frame:ShowCloseButton( false )
    self.frame:LerpPositions( 1, true )

    -- Passthrough button events while this panel is focused
    self.frame.OnKeyCodePressed = function( _, key )
        self:OnButtonPress( key )
    end

    self.frame.OnKeyCodeReleased = function( _, key )
        self:OnButtonRelease( key )
    end

    local helpMessage = {
        [false] = language.GetPhrase( "musicalk.help.open" ),
        [true] = language.GetPhrase( "musicalk.help.close" )
    }

    self.frame.Paint = function( _, w, h )
        draw.RoundedBoxEx( 8, 0, h * 0.4, w, h * 0.6, colors.frame, true, true, false, false )

        if self.midiPortName then
            DrawText( self.midiPortName, "MKeyboard_Title", w - ( w * 0.01 ), h * 0.43,
                colors.white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP )

            DrawText( helpMessage[self.isMenuOpen], "MKeyboard_Title", w * 0.01, h * 0.43,
                colors.white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
        else
            DrawText( helpMessage[self.isMenuOpen], "MKeyboard_Title", w * 0.5, h * 0.43,
                colors.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
        end

        if settings.sheet > 0 then
            DrawSheet( settings.sheet, w * 0.5, 0 )
        end

        local pianoW = self.piano.w
        local pianoH = h * 0.3

        local x = ( w * 0.5 ) - ( pianoW * 0.5 )
        local y = 6

        draw.RoundedBox( 4, x - 6, y - 6, pianoW + 12, pianoH + 12, colors.panel )

        -- Draw layout, instrument name & transpose
        local transpose = settings.transpose
        local offset = 0

        DrawText( self.layoutName, "MKeyboard_Key", x, y, colors.white )

        if transpose ~= 0 then
            offset = DrawText(
                transpose > 0 and "+" .. transpose or transpose,
                "MKeyboard_Key",
                x + pianoW, y, colors.manual,
                TEXT_ALIGN_RIGHT
            )

            offset = offset + 6
        end

        local data = self.instruments[settings.instrument]
        local _, th = DrawText( data.name, "MKeyboard_Key", x + pianoW - offset, y, colors.white, TEXT_ALIGN_RIGHT )

        th = th + 4

        self.piano:Draw( x, y + th, pianoH - th )
    end

    local mainPanel = vgui.Create( "DPanel", self.frame )
    mainPanel:SetPos( wide * 0.01, tall * 0.52 )
    mainPanel:SetSize( wide * 0.98, tall * 0.45 )
    mainPanel:DockPadding( 0, 0, 0, 0 )
    mainPanel:SetPaintBackground( false )

    ---------- Settings panel ----------

    local panelSettings = CreatePanel( "musicalk.settings", mainPanel, LEFT, wide * 0.3 )

    local settingsScroll = vgui.Create( "DScrollPanel", panelSettings )
    settingsScroll:Dock( FILL )
    settingsScroll:DockMargin( 0, 8, 0, 0 )

    local function AddRow( text, propertyClass )
        local parent = vgui.Create( "DPanel", settingsScroll )
        parent:SetWide( wide * 0.3 )
        parent:SetTall( 28 )
        parent:DockPadding( 4, 4, 4, 4 )
        parent:DockMargin( 0, 0, 0, 2 )
        parent:Dock( TOP )
        parent:SetBackgroundColor( colors.white )

        local label = vgui.Create( "DLabel", parent )
        label:SetText( language.GetPhrase( text ) )
        label:SetTextColor( colors.black )
        label:SetWide( parent:GetWide() )
        label:Dock( FILL )

        if not propertyClass then
            label:SetTextColor( colors.white )
            label:SetContentAlignment( 5 )

            parent:SetBackgroundColor( colors.black )
            parent:SetTall( 28 )

            return
        end

        local property = vgui.Create( propertyClass, parent )

        if propertyClass == "DNumSlider" then
            property.TextArea:SetWide( 30 )

            function property:PerformLayout()
                self.Label:SetWide( 0 )
            end
        end

        property:Dock( RIGHT )
        property:SetWide( 150 )

        return property
    end

    AddRow( "musicalk.vkeys" )

    -- Layouts list
    local rowLayouts = AddRow( "musicalk.layout", "DComboBox" )

    for i, v in ipairs( self.layouts ) do
        rowLayouts:AddChoice( language.GetPhrase( v.label ), nil, i == settings.layout )
    end

    rowLayouts.OnSelect = function( _, index )
        settings.sheet = 0
        self:SetLayoutByIndex( index )
        self:SaveSettings()
    end

    -- Should draw labels?
    local rowDrawLabels = AddRow( "musicalk.vkeys.labels", "DImageButton" )
    rowDrawLabels:SetImage( settings.drawKeyLabels and "icon16/accept.png" or "icon16/cancel.png" )
    rowDrawLabels:SetStretchToFit( false )
    rowDrawLabels:SetPaintBackground( true )

    rowDrawLabels.DoClick = function()
        settings.drawKeyLabels = not settings.drawKeyLabels
        self:SaveSettings()

        rowDrawLabels:SetIcon( settings.drawKeyLabels and "icon16/accept.png" or "icon16/cancel.png" )
    end

    -- Velocity
    local rowVelocity = AddRow( "musicalk.vkeys.velocity", "DNumSlider" )
    rowVelocity:SetMin( 0 )
    rowVelocity:SetMax( 127 )
    rowVelocity:SetDecimals( 0 )
    rowVelocity:SetValue( settings.velocity )
    rowVelocity.Label:SetTextColor( colors.black )

    rowVelocity.OnValueChanged = function( _, value )
        settings.velocity = Ceil( value )
    end

    -- Transpose
    local rowTranspose = AddRow( "musicalk.vkeys.transpose", "DNumSlider" )
    rowTranspose:SetMin( -24 )
    rowTranspose:SetMax( 42 )
    rowTranspose:SetDecimals( 0 )
    rowTranspose:SetValue( settings.transpose )
    rowTranspose.Label:SetTextColor( colors.black )
    rowTranspose.Label:SetWide( 30 )
    rowTranspose.Slider:SetWide( 300 )

    self.rowTranspose = rowTranspose

    rowTranspose.OnValueChanged = function( _, value )
        if value < 0 then
            value = Ceil( value )
        else
            value = math.floor( value )
        end

        self:SetTranspose( value )
        self:SaveSettings()
    end

    AddRow( "MIDI" )

    -- MIDI devices
    local rowDevices = AddRow( "musicalk.midi.device", "DButton" )
    rowDevices:SetText( language.GetPhrase( "musicalk.midi.device.choose" ) )

    if self.isMIDIAvailable then
        if table.Count( midi.GetPorts() ) == 0 then
            rowDevices:SetText( language.GetPhrase( "musicalk.midi.nodevices" ) )
            rowDevices:SetEnabled( false )
        end

        rowDevices.DoClick = function()
            self:ShowDevicesDialog()
        end

        local rowChannels = AddRow( "musicalk.midi.channels", "DButton" )
        rowChannels:SetText( language.GetPhrase( "musicalk.midi.channels.setup" ) )

        rowChannels.DoClick = function()
            self:ShowChannelsDialog()
        end

        local rowMIDITranspose = AddRow( "musicalk.vkeys.transpose", "DNumSlider" )
        rowMIDITranspose:SetMin( -48 )
        rowMIDITranspose:SetMax( 48 )
        rowMIDITranspose:SetDecimals( 0 )
        rowMIDITranspose:SetValue( settings.midiTranspose )
        rowMIDITranspose.Label:SetTextColor( colors.black )
        rowMIDITranspose.Label:SetWide( 30 )
        rowMIDITranspose.Slider:SetWide( 300 )

        rowMIDITranspose.OnValueChanged = function( _, value )
            if value < 0 then
                settings.midiTranspose = Ceil( value )
            else
                settings.midiTranspose = math.floor( value )
            end

            self:SaveSettings()
            self.piano:ReleaseAllNotes()
        end
    else
        rowDevices:SetText( language.GetPhrase( "musicalk.midi.nomodule" ) )
        rowDevices:SetEnabled( false )

        local rowInstallHelp = AddRow( "musicalk.midi.guide", "DButton" )
        rowInstallHelp:SetText( language.GetPhrase( "musicalk.midi.guide" ) )

        rowInstallHelp.DoClick = function()
            gui.OpenURL( self.URL_MIDI_GUIDE )
            self:ToggleMenu()
        end
    end

    ---------- Instruments panel ----------

    local panelInstruments = CreatePanel( "musicalk.instruments", mainPanel, FILL, nil, "musicalk.instruments.help" )

    self.instrumentList = vgui.Create( "DListView", panelInstruments )
    self.instrumentList:Dock( FILL )
    self.instrumentList:DockMargin( 0, 8, 0, 0 )
    self.instrumentList:AddColumn( language.GetPhrase( "musicalk.instruments" ) )
    self.instrumentList:SetMultiSelect( false )
    self.instrumentList:SetHideHeaders( true )
    self.instrumentList:SetSortable( false )

    for i, v in ipairs( self.instruments ) do
        self.instrumentList:AddLine( i .. " - " .. v.name )
    end

    self.instrumentList:SelectItem( self.instrumentList:GetLine( settings.instrument ) )

    self.instrumentList.OnRowSelected = function( _, index )
        self:SetInstrument( index )
        self:SaveSettings()
    end

    ---------- Layouts Panel ----------

    local panelSheets = CreatePanel( "musicalk.sheets", mainPanel, RIGHT, wide * 0.3 )

    self.sheetList = vgui.Create( "DListView", panelSheets )
    self.sheetList:Dock( FILL )
    self.sheetList:DockMargin( 0, 8, 0, 0 )
    self.sheetList:AddColumn( language.GetPhrase( "musicalk.sheets" ) )
    self.sheetList:SetMultiSelect( false )
    self.sheetList:SetHideHeaders( true )
    self.sheetList:SetSortable( false )

    self:UpdateSheetsList()

    self.sheetList.OnRowSelected = function( _, _, line )
        settings.sheet = line._sheetIndex
        self:SaveSettings()
    end
end

function MKeyboard:UpdateSheetsList()
    local layoutId = self.layouts[settings.layout].id

    self.sheetList:Clear()

    local selectedItem = self.sheetList:AddLine( language.GetPhrase( "musicalk.sheets.hidden" ) )
    selectedItem._sheetIndex = 0

    for i, v in ipairs( self.sheets ) do
        if v.layout == layoutId then
            local line = self.sheetList:AddLine( v.title )
            line._sheetIndex = i

            if i == settings.sheet then
                selectedItem = line
            end
        end
    end

    self.sheetList:SelectItem( selectedItem )
end

function MKeyboard:ShowDevicesDialog()
    if IsValid( self.frameDevices ) then
        self.frameDevices:Close()
    end

    if not self.isMIDIAvailable then return end

    local midiPorts = midi.GetPorts()
    if table.Count( midiPorts ) == 0 then return end

    if midi.IsOpened() then
        self:CloseMIDI()
    end

    self.selectedMIDIPort = nil

    self.frameDevices = vgui.Create( "DFrame" )
    self.frameDevices:SetSize( 300, 130 )
    self.frameDevices:SetTitle( language.GetPhrase( "musicalk.midi.device.choose" ) )
    self.frameDevices:SetVisible( true )
    self.frameDevices:SetDraggable( true )
    self.frameDevices:ShowCloseButton( true )
    self.frameDevices:SetDeleteOnClose( true )
    self.frameDevices:Center()
    self.frameDevices:MakePopup()

    local startTime = SysTime()
    local oldPaint = self.frameDevices.Paint

    self.frameDevices.Paint = function( s, w, h )
        Derma_DrawBackgroundBlur( s, startTime )
        oldPaint( s, w, h )
    end

    local labelHelp = vgui.Create( "DLabel", self.frameDevices )
    labelHelp:SetPos( 10, 40 )
    labelHelp:SetSize( 280, 40 )

    labelHelp:SetText( string.format(
        language.GetPhrase( "musicalk.midi.found" ),
        tostring( table.Count( midiPorts ) )
    ) )

    local comboDevices = vgui.Create( "DComboBox", self.frameDevices )
    comboDevices:SetPos( 10, 90 )
    comboDevices:SetSize( 280, 20 )
    comboDevices:SetValue( language.GetPhrase( "musicalk.midi.select" ) )

    for k, v in pairs( midiPorts ) do
        comboDevices:AddChoice( "[" .. k .. "] " .. v )
    end

    comboDevices.OnSelect = function( _, index )
        self.selectedMIDIPort = index - 1
        self.frameDevices:Close()
    end
end

function MKeyboard:ShowChannelsDialog()
    if IsValid( self.frameChannels ) then
        self.frameChannels:Close()

        return
    end

    local tall = math.min( 610, ScrH() * 0.6 )

    self.frameChannels = vgui.Create( "DFrame" )
    self.frameChannels:SetSize( 400, tall )
    self.frameChannels:SetTitle( language.GetPhrase( "musicalk.channels" ) )
    self.frameChannels:SetVisible( true )
    self.frameChannels:SetSizable( true )
    self.frameChannels:SetDraggable( true )
    self.frameChannels:ShowCloseButton( true )
    self.frameChannels:SetDeleteOnClose( true )
    self.frameChannels:SetPos( ScrW() - self.frameChannels:GetWide(), 0 )
    self.frameChannels:MakePopup()

    -- Passthrough button events while this panel is focused
    self.frameChannels.OnKeyCodePressed = function( _, key )
        self:OnButtonPress( key )
    end

    self.frameChannels.OnKeyCodeReleased = function( _, key )
        self:OnButtonRelease( key )
    end

    local scrollChannels = vgui.Create( "DScrollPanel", self.frameChannels )
    scrollChannels:Dock( FILL )

    local function PaintChannel( s, w, h )
        SetColor( 0, 0, 0, 255 )
        DrawRect( 0, 0, w, h )

        SetColor( 50, 50, 50, 255 )
        DrawRect( 4, 4, 8, h - 8 )

        self.channelState[s.channel] = Lerp( FrameTime() * 8, self.channelState[s.channel], 0 )

        SetColor( colors.automated.r, colors.automated.g, colors.automated.b, 255 * self.channelState[s.channel] )
        DrawRect( 4, 4, 8, h - 8 )
    end

    local function OnSelectInstrument( s, _, _, idx )
        if idx == -1 then
            settings.channelInstruments[s.channel] = nil
        else
            settings.channelInstruments[s.channel] = idx
        end

        self:SaveSettings()
    end

    for i = 0, 15 do
        self.channelState[i] = 0

        local panelChannel = vgui.Create( "DPanel", scrollChannels )
        panelChannel:SetSize( wide, 32 )
        panelChannel:Dock( TOP )
        panelChannel:DockMargin( 0, 0, 0, 4 )

        panelChannel.channel = i
        panelChannel.Paint = PaintChannel

        local labelIndex = vgui.Create( "DLabel", panelChannel )
        labelIndex:SetFont( "Trebuchet24" )
        labelIndex:SetTextColor( colors.white )
        labelIndex:SetText( "#" .. ( i + 1 ) )
        labelIndex:SetWide( 50 )
        labelIndex:Dock( LEFT )
        labelIndex:DockMargin( 20, 0, 0, 0 )

        local combo = vgui.Create( "DComboBox", panelChannel )
        combo:SetSortItems( false )
        combo:AddChoice( language.GetPhrase( "musicalk.channels.usecurrent" ), -1, true )
        combo:AddChoice( language.GetPhrase( "musicalk.channels.mute" ), 0 )
        combo:AddSpacer()
        combo:Dock( FILL )

        local myInstrument = settings.channelInstruments[i] or -1

        for idx, v in ipairs( self.instruments ) do
            combo:AddChoice( v.name, idx, idx == myInstrument )
        end

        combo.channel = i
        combo.OnSelect = OnSelectInstrument
    end
end
