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

ENT.PrintName = "Burrowed Antlionguard"

ENT.DebugModel = "models/maxofs2d/balloon_gman.mdl"
ENT.DebugColor = Color( 0, 50, 0 )
ENT.AmbushDist = 1000
ENT.MyClass = "npc_antlionguard_burrowed"
ENT.ModelToPrecache = "models/antlion_guard.mdl"
ENT.AmbusherClass = "npc_antlionguard"
ENT.HintSoundChance = 10

function ENT:InitializeAmbusher()
    local ambusher = ents.Create( self.AmbusherClass )
    ambusher:SetPos( self:GetPos() )
    ambusher:SetAngles( self:GetAngles() )
    ambusher:SetKeyValue( "spawnflags", "4" )
    ambusher:SetKeyValue( "startburrowed", "1" )
    ambusher:SetKeyValue( "allowbark", "1" )
    ambusher:Spawn()
    ambusher:Activate()

    return ambusher

end

function ENT:Ambush()
    self.ambusher:Fire( "unburrow", "", 0.1 )

end

function ENT:PostSetupData()
    self:SetWakeNearTeammates( true )

end