--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local MAX_USE_DISTANCE = 300 * 300

local function MakeKeyboardSpawner( ply, data )
    if IsValid( ply ) and not ply:CheckLimit( "musical_keyboards" ) then return end

    local ent = ents.Create( data.Class )
    if not IsValid( ent ) then return end

    ent:SetPos( data.Pos )
    ent:SetAngles( data.Angle )
    ent:Spawn()
    ent:Activate()

    ply:AddCount( "musical_keyboards", ent )

    return ent
end

duplicator.RegisterEntityClass( "ent_musical_keyboard", MakeKeyboardSpawner, "Data" )

function ENT:SpawnFunction( ply, tr )
    if tr.Hit then
        return MakeKeyboardSpawner( ply, {
            Pos = tr.HitPos,
            Angle = Angle( 0, ply:EyeAngles().y + 90, 0 ),
            Class = self.ClassName
        } )
    end
end

function ENT:Initialize()
    self:SetModel( "models/styledstrike/musical_keyboard.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType( SIMPLE_USE )
    self:DrawShadow( true )

    local phys = self:GetPhysicsObject()
    if IsValid( phys ) then phys:Wake() end

    if WireLib then
        WireLib.CreateSpecialOutputs( self, { "NotePlayed" }, { "ARRAY" }, {
            [[Triggered when the user played a note.
This array contains:
[1] Note number,
[2] Note velocity
[3] Instrument index (The number near each name on the instruments list)]]
        } )

        WireLib.CreateSpecialInputs( self, { "PlayNote" }, { "ARRAY" }, {
            [[Changing this input will play a note.
The array should contain:
[1] Note number (1-127)
[2] Note velocity (1-127)
[3] Instrument index (The number near each name on the instruments list)]]
        } )

        self.reproduceQueue = {}
        self.transmitQueue = {}
    end
end

function ENT:Use( ply )
    self:SetPlayer( ply )
end

function ENT:SetPlayer( ply )
    if IsValid( self.Ply ) and not self.Ply:Alive() then
        self.Ply = nil
    end

    if not IsValid( self.Ply ) and ply:Alive() then
        net.Start( "mkeyboard.set_current_keyboard", false )
        net.WriteEntity( self )
        net.Send( ply )

        self.Ply = ply
    end
end

function ENT:RemovePlayer()
    if IsValid( self.Ply ) then
        net.Start( "mkeyboard.set_current_keyboard", false )
        net.WriteEntity( nil )
        net.Send( self.Ply )
    end

    self.Ply = nil
end

function ENT:Think()
    self:NextThink( CurTime() )
    self:UpdateNotes()

    if IsValid( self.Ply ) and (
        not self.Ply:Alive() or
        self.Ply:GetPos():DistToSqr( self:GetPos() ) > MAX_USE_DISTANCE
    ) then
        self:RemovePlayer()
    end

    return true
end

if not WireLib then
    function ENT:UpdateNotes() end
    function ENT:OnReceiveNotes() end
    return
end

local function ValidateNumber( v, default, min, max )
    return math.Clamp( math.Round( tonumber( v ) or default ), min, max )
end

function ENT:TriggerInput( name, value )
    if name ~= "PlayNote" then return end
    if not isnumber( value[1] ) then return end

    local note = ValidateNumber( value[1], 0, 0, 127 )
    if note == 0 then return end

    local velocity = ValidateNumber( value[2], 127, 1, 127 )
    local instrument = ValidateNumber( value[3], 1, 1, 127 ) -- Max. value is based on net.WriteUInt( 7 )

    local queue = self.transmitQueue

    -- Remember when we started putting notes
    -- on the queue, and when we should send them
    local t = SysTime()

    if not self.queueTimer then
        self.queueTimer = t + 0.4
        self.queueStart = t
    end

    -- Add notes to the queue unless the limit was reached
    local noteCount = #queue

    if noteCount < MKeyboard.NET_MAX_NOTES then
        queue[noteCount + 1] = {
            note, velocity, instrument, t - self.queueStart
        }
    end
end

local SysTime = SysTime

function ENT:OnReceiveNotes( notes )
    local t = SysTime()
    local queue = self.reproduceQueue

    for i, n in ipairs( notes ) do
        -- i * 0.01 to prevent overriding stuff already on the queue
        queue[t + n[4] + ( i * 0.01 )] = { n[1], n[2], n[3] }
    end
end

local GetKeys = table.GetKeys

function ENT:UpdateNotes()
    local now = SysTime()

    -- If the queued notes are ready to be sent...
    if self.queueTimer and now > self.queueTimer then
        MKeyboard.BroadcastNotes( self.transmitQueue, self, true )

        table.Empty( self.transmitQueue )
        self.queueTimer = nil
    end

    -- Trigger the wire outputs while taking the time offsets into account
    local queue = self.reproduceQueue
    local timestamps = GetKeys( queue )

    for _, t in ipairs( timestamps ) do
        if now > t then
            local n = queue[t]
            WireLib.TriggerOutput( self, "NotePlayed", { n[1], n[2], n[3] } )
            queue[t] = nil
        end
    end
end
