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
ENT.Author = "Chocofrolik + Straw W Wagen"

ENT.PrintName = "Slumped Zombine"

ENT.DebugModel = "models/maxofs2d/balloon_mossman.mdl"
ENT.DebugColor = Color( 150,150,0 )
ENT.AmbushDist = 256
ENT.MyClass = "npc_zombine_slump"
ENT.ModelToPrecache = "models/zombie/zombie_soldier.mdl"
ENT.AmbusherClass = "npc_zombine"

ENT.Slump = "slump_a"
ENT.RiseStyle = { "slumprise_a", "slumprise_a2" }

ENT.HintSoundChance = 2
ENT.HintSounds = {
    "npc/zombine/zombine_idle3.wav",
    "npc/zombine/zombine_idle2.wav",
    "npc/zombine/zombine_idle1.wav",

}

function ENT:Ambush()
    if not IsValid( self.waking_sequence ) then return end
    self.waking_sequence:Fire( "BeginSequence", "", 0 )

end