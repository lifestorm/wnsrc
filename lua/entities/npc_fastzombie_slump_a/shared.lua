--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Base = "npc_antlion_burrowed"
ENT.Type = "anim"

ENT.PrintName = "Sleeping Fastzombie A"

ENT.DebugModel = "models/balloons/balloon_dog.mdl"
ENT.DebugColor = Color( 50,0,0 )
ENT.AmbushDist = 256
ENT.MyClass = "npc_fastzombie_slump_a"
ENT.ModelToPrecache = "models/Zombie/Fast.mdl"
ENT.AmbusherClass = "npc_fastzombie"

ENT.Slump = "slump_a"
ENT.RiseStyle = "slumprise_a"

ENT.HintSoundChance = 9
ENT.HintSounds = {
    "npc/fast_zombie/idle1.wav",
    "npc/fast_zombie/idle3.wav",
    "npc/fast_zombie/idle3.wav",

}

ENT.TeammateSleepers = {
    "npc_fastzombie_slump_a",
    "npc_fastzombie_slump_b",
    "npc_fastzombie_slump_c",
    "npc_headcrab_burrowed",
    "npc_zombie_prone",
    "npc_zombie_slump",
    "npc_zombie_slump_attack",
    "npc_zombine_prone",
    "npc_zombine_slump",
    "npc_zombine_slump_attack",

}

util.PrecacheModel( "models/zombie/fast_standup.mdl" )

local doneStuff = {}

function ENT:InitializeAmbusher()
    doneStuff[self:GetCreationID()] = true

    local ambusher = ents.Create( self.AmbusherClass )
    ambusher:SetPos( self:GetPos() )
    ambusher:SetKeyValue( "spawnflags", "646" )
    ambusher:Spawn()
    ambusher:Activate()

    local fastzombie_name = "sleeping_zomb" .. ambusher:GetCreationID()
    local wakeSeqName = fastzombie_name .. "_wake_seq"

    ambusher:SetName( fastzombie_name )
    ambusher.sleepingNpcs_SourceEnt = self

    local riseStyle = self.RiseStyle
    if istable( riseStyle ) then
        riseStyle = table.Random( riseStyle )

    end

    self.waking_sequence = ents.Create( "scripted_sequence" )
    self.waking_sequence:SetName( wakeSeqName )
    self.waking_sequence:SetKeyValue( "spawnflags", "624" )
    self.waking_sequence:SetKeyValue( "m_fMoveTo", "4" ) -- tp to start of sequence
    self.waking_sequence:SetKeyValue( "m_iszEntity", fastzombie_name )
    self.waking_sequence:SetKeyValue( "m_iszIdle", self.Slump )
    self.waking_sequence:SetKeyValue( "m_iszPlay", riseStyle )

    self.waking_sequence:SetPos( self:GetPos() )
    self.waking_sequence:Spawn()
    self.waking_sequence:Activate()
    self.waking_sequence:SetParent( ambusher )

    timer.Simple( 0, function()
        self.waking_sequence:SetAngles( self:GetAngles() )
        ambusher:SetAngles( self:GetAngles() )

    end )

    return ambusher

end

hook.Add( "EntityTakeDamage", "sleepingnpcs_wakeupon_dmg", function( damaged, damageInfo )
    if not IsValid( damaged.sleepingNpcs_SourceEnt ) then return end
    damaged.sleepingNpcs_SourceEnt:NextThink( CurTime() + 0.05 )
    damaged.sleepingNpcs_SourceEnt.forcedAmbush = CurTime()
    damaged.sleepingNpcs_SourceEnt.instantWake = true

end )

local meleeMaxs = Vector( 20, 20, 5 )
local meleeMins = -meleeMaxs

ENT.MeleeDelay = nil
ENT.MeleeDamage = nil
ENT.MeleeHitSound = nil

function ENT:MeleeAttack()
    if not self.MeleeDamage then return end
    local start = self.ambusher:EyePos()
    local endpos = start + self.ambusher:GetForward() * 30

    local stuff = ents.FindAlongRay( start, endpos, meleeMins, meleeMaxs )

    local hit = nil

    for _, toHit in ipairs( stuff ) do
        if toHit == self or toHit == self.ambusher then continue end
        hit = true

        local damageInfo = DamageInfo()
        damageInfo:SetAttacker( self.ambusher )
        damageInfo:SetInflictor( self.ambusher )
        damageInfo:SetDamageType( DMG_SLASH )
        damageInfo:SetDamageForce( self.ambusher:GetForward() * 15000 )
        damageInfo:SetDamage( self.MeleeDamage )

        toHit:TakeDamageInfo( damageInfo )

    end
    if hit and self.MeleeHitSound then
        self:EmitSound( self.MeleeHitSound )

    end
end

function ENT:Ambush()
    if not IsValid( self.waking_sequence ) then return end
    self.waking_sequence:Fire( "BeginSequence", "", 0 )

    if self:GetIsSilent() then return end
    self.ambusher:EmitSound( "npc/fast_zombie/wake1.wav", 75, 100 )

end

function ENT:DoHintSound()
    if self:GetIsSilent() then return end
    local sounds = self.HintSounds

    local theSound = sounds[ math.random( 1, #sounds ) ]
    self:EmitSound( theSound, 75, 100 + math.Rand( -5, 5 ), 0.7, CHAN_STATIC )

end

function ENT:PostInitialized( ambusher )
    ambusher:SetNPCState( NPC_STATE_SCRIPT )

end