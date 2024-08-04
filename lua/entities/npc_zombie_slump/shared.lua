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

ENT.Base = "npc_fastzombie_slump_a"
ENT.Type = "anim"

ENT.PrintName = "Slumped Zombie"

ENT.DebugModel = "models/maxofs2d/balloon_mossman.mdl"
ENT.DebugColor = Color( 255,255,0 )
ENT.AmbushDist = 256
ENT.MyClass = "npc_zombie_slump"
ENT.ModelToPrecache = "models/Zombie/Classic.mdl"
ENT.AmbusherClass = "npc_zombie"

ENT.Slump = "slump_a"
ENT.RiseStyle = { "slumprise_a", "slumprise_a2" }

ENT.HintSoundChance = 5
ENT.HintSounds = {
    "npc/zombie/zombie_pain3.wav",
    "npc/zombie/zombie_voice_idle3.wav",
    "npc/zombie/zombie_voice_idle4.wav",

}


function ENT:Ambush()
    if not IsValid( self.waking_sequence ) then return end
    self.waking_sequence:Fire( "BeginSequence", "", 0 )
    if self:GetIsSilent() then return end
    self.ambusher:EmitSound( "npc/zombie/zombie_alert" .. math.random( 1, 3 ) .. ".wav" )

end