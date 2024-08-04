--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- Piano renderer
local Piano = {
    keys = {},
    whiteCount = 0,
    transpose = 0,

    noteMin = 0,
    noteMax = 128,

    w = 16,
    keyW = 22
}

MKeyboard.piano = Piano

local keyNameOverride = {
    [KEY_SEMICOLON] = ";"
}

local function GetButtonName( button )
    return language.GetPhrase( keyNameOverride[button] or input.GetKeyName( button ) or "NONE" )
end

function Piano:SetLayout( layout )
    self.keys = {}
    self.whiteCount = 0

    for _, key in ipairs( layout ) do
        self.keys[#self.keys + 1] = {
            button = key[1],
            altButton = key[5],
            label = GetButtonName( key[1] ),
            note = key[2],
            isBlack = key[3],
            needsShift = key[4],
            isPressed = false
        }

        if not key[3] then
            self.whiteCount = self.whiteCount + 1
        end
    end

    self.w = self.keyW * self.whiteCount
end

--- Set the note limits. Keys with notes
--- outside this range will be grayed out.
function Piano:SetNoteRange( min, max )
    self.noteMin, self.noteMax = min, max
end

--- Find the normal and shifted keys linked to this button.
function Piano:FindKeys( button )
    local normal, shifted

    for _, key in ipairs( self.keys ) do
        if key.button == button or key.altButton == button then
            if key.needsShift then
                shifted = key
            else
                normal = key
            end
        end
    end

    return normal, shifted
end

--- Find the key linked to this note.
function Piano:FindKeyByNote( note )
    for _, key in ipairs( self.keys ) do
        if key.note == note then
            return key
        end
    end
end

--- Press the key linked to this note.
function Piano:PressNote( note, velocity, instrument, color, automated )
    local key = self:FindKeyByNote( note )

    if key then
        key.color = color
        key.isPressed = true
    end

    self.OnNoteOn( note, velocity, instrument, automated )
end

--- Release the key linked to this note.
function Piano:ReleaseNote( note )
    local key = self:FindKeyByNote( note )

    if key then
        key.color = nil
        key.isPressed = false
    end
end

--- Releases all notes.
function Piano:ReleaseAllNotes()
    for _, key in ipairs( self.keys ) do
        key.color = nil
        key.isPressed = false
    end
end

--- Press the key linked to this button.
function Piano:PressButton( button, velocity, instrument, color )
    velocity = velocity or 127

    local normal, shifted = self:FindKeys( button )

    if input.IsShiftDown() then
        if shifted then
            shifted.color = color
            shifted.isPressed = true
            self.OnNoteOn( shifted.note + self.transpose, velocity, instrument )
        end
    else
        if normal then
            normal.color = color
            normal.isPressed = true
            self.OnNoteOn( normal.note + self.transpose, velocity, instrument )
        end
    end
end

--- Release the key linked to this button.
function Piano:ReleaseButton( button )
    -- Always release both normal and shifted keys, to handle a key that was
    -- pressed with shift previously but does not have shift pressed now.
    local normal, shifted = self:FindKeys( button )

    if normal and normal.isPressed then
        normal.color = nil
        normal.isPressed = false
    end

    if shifted and shifted.isPressed then
        shifted.color = nil
        shifted.isPressed = false
    end
end

local SetColor = surface.SetDrawColor
local DrawRect = surface.DrawRect
local DrawRoundedBox = draw.RoundedBoxEx
local DrawText = draw.SimpleText

local COLOR_WHITE = Color( 255, 255, 255 )
local COLOR_BLACK = Color( 0, 0, 0 )

local ALIGN_CENTER = TEXT_ALIGN_CENTER
local ALIGN_BOTTOM = TEXT_ALIGN_BOTTOM

local settings = MKeyboard.settings

function Piano:Draw( x, y, h )
    local min, max = self.noteMin, self.noteMax
    local transpose = self.transpose
    local labels = settings.drawKeyLabels
    local w = self.keyW

    local labelY = y + h - 4
    local blackLabelY = y + ( h * 0.6 ) - 4
    local blackW = w * 0.7

    local note, deferKey

    for _, key in ipairs( self.keys ) do
        note = key.note + transpose

        if note < min or note > max then
            -- empty space
            if not key.isBlack then
                x = x + w
            end

        elseif key.isBlack then
            -- draw it on top of the next one
            deferKey = key
        else
            SetColor( key.color or COLOR_WHITE )
            DrawRect( x, y, w - 1, h )

            if labels then
                DrawText( key.label, "MKeyboard_Key", x + w * 0.5, labelY, COLOR_BLACK, ALIGN_CENTER, ALIGN_BOTTOM )
            end

            if deferKey then
                DrawRoundedBox( 4, x - blackW * 0.5, y, blackW, h * 0.6, deferKey.color or COLOR_BLACK, false, false, true, true )

                if labels then
                    DrawText( deferKey.label, "MKeyboard_Key", x, blackLabelY, COLOR_WHITE, ALIGN_CENTER, ALIGN_BOTTOM )
                end

                deferKey = nil
            end

            x = x + w
        end
    end
end

