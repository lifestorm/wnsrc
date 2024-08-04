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

ENT.PrintName = "Sleeping Fastzombie C"

ENT.DebugModel = "models/balloons/balloon_dog.mdl"
ENT.DebugColor = Color( 255,0,0 )
ENT.AmbushDist = 256
ENT.MyClass = "npc_fastzombie_slump_c"
ENT.AmbusherClass = "npc_fastzombie"

ENT.Slump = "slump_a"
ENT.RiseStyle = "slumprise_c"

function ENT:Ambush()
    if not IsValid( self.waking_sequence ) then return end
    self.waking_sequence:Fire( "BeginSequence", "", 0 )
    if self:GetIsSilent() then return end
    self.ambusher:EmitSound( "npc/fast_zombie/wake1.wav", 75, 100 )

end