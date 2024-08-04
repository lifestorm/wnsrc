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

ENT.PrintName = "Burrowed Antlion Worker"

ENT.DebugModel = "models/maxofs2d/companion_doll.mdl"
ENT.DebugColor = Color( 0, 255, 0 )
ENT.AmbushDist = 512
ENT.MyClass = "npc_antlionworker_burrowed"
ENT.ModelToPrecache = "models/antlion_worker.mdl"
ENT.AmbusherClass = "npc_antlion"

function ENT:InitializeAmbusher()
    local ambusher = ents.Create( self.AmbusherClass )
    ambusher:SetPos( self:GetPos() )
    ambusher:SetAngles( self:GetAngles() )
    ambusher:SetKeyValue( "spawnflags", "262660" )
    ambusher:SetKeyValue( "startburrowed", "1" )
    ambusher:Spawn()
    ambusher:Activate()

    return ambusher

end

function ENT:Ambush()
    self.ambusher:Fire( "unburrow", "", 0.1 )

end