--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include( "shared.lua" )

local blackKeys = {
    [1] = true, [3] = true, [6] = true, [8] = true, [10] = true
}

local keyColors = {
    default = Color( 255, 148, 77 ),
    automated = Color( 171, 0, 197 )
}

local keyOffsets = {
    [2] = 0.2,
    [4] = 0.4,
    [5] = -0.1,
    [7] = 0.1,
    [9] = 0.4,
    [11] = 0.6
}

local Remap = math.Remap
local RealTime = RealTime

function ENT:Initialize()
    self.drawNotes = {}
end

function ENT:EmitNote( note, velocity, instrument, automated )
    local data = MKeyboard.instruments[instrument]

    if not data then return end
    if note < data.noteMin or note > data.noteMax then return end

    sound.Play( string.format( data.path, note ), self:GetPos(), 80, 100, velocity / 127 )

    local idx = note % 12
    local len = 8
    local height = -0.2
    local width = 1.6
    local x = -1.1

    if blackKeys[idx] then
        len = 5
        height = 0.1
        width = 1
        x = -0.6
    end

    if keyOffsets[idx] then
        x = x + keyOffsets[idx]
    end

    self.drawNotes[note] = {
        x = Remap( note, 21, 108, -37, 36.7 ),
        t = RealTime() + 0.2,
        min = Vector( x, -1.5, -1 ),
        max = Vector( x + width, len, height ),
        color = keyColors[automated and "automated" or "default"]
    }
end

function ENT:Draw()
    self:DrawModel()

    local t = RealTime()
    local ang = self:GetAngles()

    render.SetColorMaterial()

    for note, p in pairs( self.drawNotes ) do
        if t > p.t then
            self.drawNotes[note] = nil
        else
            local color = p.color
            local alpha = 255 * ( ( p.t - t ) / 0.2 )

            render.DrawBox(
                self:LocalToWorld( Vector( -p.x, 0, 0 ) ),
                ang, p.min, p.max,
                Color( color.r, color.g, color.b, alpha )
            )
        end
    end
end
