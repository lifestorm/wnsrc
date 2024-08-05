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

ENT.PrintName = "Burrowed Headcrab"

ENT.DebugModel = "models/headcrabclassic.mdl"
ENT.DebugColor = Color( 100, 100, 0 )
ENT.AmbushDist = 256
ENT.MyClass = "npc_headcrab_burrowed"
ENT.ModelToPrecache = "models/headcrabclassic.mdl"
ENT.AmbusherClass = "npc_headcrab"

ENT.HintSoundChance = 8
ENT.HintSounds = {
    "npc/headcrab/idle1.wav",
    "npc/headcrab/idle2.wav",
    "npc/headcrab/idle2.wav",

}

-- same as fastzombie slump a
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

function ENT:InitializeAmbusher()
    local ambusher = ents.Create( self.AmbusherClass )
    ambusher:SetPos( self:GetPos() )
    ambusher:SetAngles( self:GetAngles() )
    ambusher:SetKeyValue( "spawnflags", "4" )
    ambusher:SetKeyValue( "startburrowed", "1" )
    ambusher:Spawn()
    ambusher:Activate()

    return ambusher

end

function ENT:Ambush()
    self.ambusher:Fire( "unburrow", "", 0.1 )

end