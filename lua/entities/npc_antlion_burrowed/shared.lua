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

-- classic wiremod jank right here
if WireLib then
    ENT.Base = "base_wire_entity"

else
    ENT.Base = "base_entity" -- :(

end

ENT.Type = "anim"

ENT.PrintName = "Burrowed Antlion"
ENT.Author = "Silverlan + Straw W Wagen"
ENT.Contact = "Silverlan@gmx.de"
ENT.Category        = "Other"

ENT.Editable = true
ENT.Spawnable = false

ENT.AutomaticFrameAdvance = false

-- modifiable vars

ENT.DebugModel = "models/balloons/balloon_dog.mdl"
ENT.DebugColor = Color( 0, 255, 0 )
ENT.AmbushDist = 384 --128 * 3
ENT.MyClass = "npc_antlion_burrowed"
ENT.ModelToPrecache = "models/AntLion.mdl"
ENT.AmbusherClass = "npc_antlion"
ENT.HintSoundChance = 3

ENT.HintSounds = {
    "ambient/levels/coast/antlion_hill_ambient1.wav",
    "ambient/levels/coast/antlion_hill_ambient2.wav",
    "ambient/levels/coast/antlion_hill_ambient4.wav",

}

ENT.TeammateSleepers = {
    "npc_antlion_burrowed",
    "npc_antlionworker_burrowed",
    "npc_antlionguard_burrowed",
    "npc_caveguard_burrowed",

}

-- end modifiable vars

function ENT:SetupDataTables()
    self:NetworkVar( "Int",    0, "AmbushDistance",             { KeyName = "ambushdistance",           Edit = { order = 1, type = "Int", min = 1, max = 1000 } } )
    self:NetworkVar( "Int",    1, "TeammateWakeDist",           { KeyName = "teammatewakedist",         Edit = { order = 2, type = "Int", min = -1, max = 1000 } } )
    self:NetworkVar( "Float",  0, "WakeDelay",                  { KeyName = "wakeDelay",                Edit = { order = 3, type = "Float", min = 0, max = 30 } } )
    self:NetworkVar( "Bool",   0, "WakeNearTeammates",          { KeyName = "wakenearteammates",        Edit = { order = 4, type = "Bool" } } )
    self:NetworkVar( "Bool",   1, "CanChainWakeTeammates",      { KeyName = "canchainwaketeammates",    Edit = { order = 5, type = "Bool" } } )
    self:NetworkVar( "Bool",   2, "IsSilent",                   { KeyName = "issilent",                 Edit = { order = 6, type = "Bool" } } )
    self:NetworkVar( "Bool",   3, "ForceWake",                  { KeyName = "forcewake",                Edit = { readonly = true } } )

    self:SetAmbushDistance( self.AmbushDist )
    self:SetTeammateWakeDist( self.AmbushDist )
    self:SetWakeDelay( 0 )
    self:SetWakeNearTeammates( false )
    self:SetCanChainWakeTeammates( false )
    self:SetIsSilent( false )
    self:SetForceWake( false )

    self:PostSetupData()

end

function ENT:PostSetupData()
end

if CLIENT then
    function ENT:Draw()
        if saveents_IsEditing() or not saveents_EnabledAi() then
            if not saveents_CanBeUgly() then return end
            self:DrawModel()

        end
    end
end

if not SERVER then return end

function ENT:Initialize()
    self:SetModel( self.DebugModel )
    self:SetColor( self.DebugColor )
    self:DrawShadow( false )

    if self.ModelToPrecache then
        util.PrecacheModel( self.ModelToPrecache )

    end

    if saveents_EnabledAi() then
        self:CreateAmbusher()
    end

    if not WireLib then return end

    self.Inputs = Wire_CreateInputs( self, { "ForceWake" } )
    self.Outputs = WireLib.CreateSpecialOutputs( self, { "Awake", "Sleeper" }, { "NORMAL", "ENTITY" } )

end

function ENT:TriggerInput( iname, value )
    if iname == "ForceWake" and value >= 1 then
        self:SetForceWake( true )

    else
        self:SetForceWake( false )

    end
end

-- if player is moving slower than this, we only wake up if they're REALLY close!
local speedToWakeUp = 65^2

function ENT:Think()
    if self.ambushed then
        -- all done!
        if not IsValid( self.ambusher ) or self.ambusher:Health() <= 0 then
            SafeRemoveEntity( self )

        -- it's still alive, think slow!
        else
            self:NextThink( CurTime() + 2 )
            return true

        end
    end
    -- let them physgun us!
    if not saveents_EnabledAi() then
        if not IsValid( self:GetPhysicsObject() ) then
            self:SetMoveType( MOVETYPE_VPHYSICS )
            self:PhysicsInit( SOLID_VPHYSICS )
            self:SetCollisionGroup( COLLISION_GROUP_WORLD ) -- npcs can see through?

            self:GetPhysicsObject():EnableMotion( false )

            self.hasPhysics = true

            SafeRemoveEntity( self.ambusher )

            if self.hadNoPhysics then
                self:EmitSound( "physics/concrete/rock_impact_hard2.wav", 68, math.random( 90, 110 ) )
                local frozen = EffectData()
                frozen:SetEntity( self )
                util.Effect( "phys_freeze", frozen )

            end
        end
        -- restart from scratch for this think call
        return

    elseif not self.hadNoPhysics then
        self.hadNoPhysics = true

    end
    -- no more physgunning, and more importantly, no more catching stray bullets!
    if self.hasPhysics and IsValid( self:GetPhysicsObject() ) then
        self:PhysicsInit( SOLID_NONE )
        self.hasPhysics = nil

        if not IsValid( self.ambusher ) then
            self:CreateAmbusher()


        end
        if IsValid( self.ambusher ) then
            self.ambusher.DoNotDuplicate = true

        end
        -- ditto
        return

    end

    -- let people watch
    if self.ambushed then return end

    local doAmbush = nil
    local myPos = self:GetPos()
    local ambushDist = self:GetAmbushDistance()
    local wayTooCloseDist = math.min( ambushDist / 4, 50 ) ^ 2
    local belowMeCutoff = myPos.z
    if IsValid( self.ambusher ) then
        belowMeCutoff = self.ambusher:GetPos().z

    end

    belowMeCutoff = belowMeCutoff + -15

    --debugoverlay.Sphere( myPos, ambushDist, 5, color_white, true )

    -- search for plys very close to ent, very often
    if not saveents_IgnoringPlayers() then
        for _, thing in pairs( ents.FindInSphere( myPos, ambushDist ) ) do

            if thing and IsValid( thing ) and thing:IsPlayer() then
                local thingPos = thing:GetPos()
                -- if ents are below me dont wake up!
                local thingIsOnSameLevelAsMe = thingPos.z > belowMeCutoff
                local thingIsMoving = thing:GetVelocity():LengthSqr() > speedToWakeUp
                local thingIsReallyClose = thingPos:DistToSqr( myPos ) < wayTooCloseDist
                if ( thingIsMoving or thingIsReallyClose ) and thingIsOnSameLevelAsMe then
                    doAmbush = true
                    break

                end
            end
        end
    end

    if self.forcedAmbush and self.forcedAmbush < CurTime() then
        doAmbush = true

    end

    if self:GetForceWake() then
        doAmbush = true

    end

    if doAmbush then
        self.ambushed = true
        if not IsValid( self.ambusher ) then return end
        if self.ambusher:GetMaxHealth() > 0 and self.ambusher:Health() <= 0 then return end
        self:AwakenTeammates()
        self.ambusher.DoNotDuplicate = true
        local delay = self:GetWakeDelay()
        if self.instantWake then
            delay = 0

        end
        timer.Simple( delay, function()
            if not IsValid( self ) then return end
            if not IsValid( self.ambusher ) then return end
            self:Ambush()
            self:PostAmbushed( self.ambusher )
            if not WireLib then return end
            Wire_TriggerOutput( self, "Awake", 1 )

        end )
        return
    elseif not self.ambushed and IsValid( self.ambusher ) then
        -- strong :think() frequency optimisations below
        local farEnoughToSleepDist = ambushDist * 8
        farEnoughToSleepDist = math.Clamp( farEnoughToSleepDist, 0, 2500 )

        local tooClosePlayer = self.tooClosePlayer

        -- look for a player anywhere near us, if no player then we hibernate with long thinks, if player then we think fast
        if not IsValid( tooClosePlayer ) then
            for _, ply in ipairs( ents.FindByClass( "player" ) ) do
                local closeEnough = ply:GetPos():DistToSqr( myPos ) < farEnoughToSleepDist^2
                if closeEnough then
                    tooClosePlayer = ply
                    self.tooClosePlayer = tooClosePlayer
                    break

                end
            end
        end
        local timeToCheck
        -- we either found someone close, or have someone close
        if IsValid( tooClosePlayer ) and tooClosePlayer:GetPos():DistToSqr( myPos ) < farEnoughToSleepDist^2 and self.ambusher:Health() > 0 then
            timeToCheck = self:GetAmbushDistance() / 300
            if math.random( 0, 100 ) < self.HintSoundChance then
                self:DoHintSound()

            end

        else
            if IsValid( tooClosePlayer ) then
                -- they just left the area! there could be another person nearby, think fast!
                timeToCheck = self:GetAmbushDistance() / 300

            else
                -- they either disconnected, or we didn't have anyone in the first place, think slow 
                timeToCheck = self:GetAmbushDistance() / 40

            end
            self.tooClosePlayer = nil

        end
        self:NextThink( CurTime() + timeToCheck + math.Rand( -timeToCheck / 10, timeToCheck / 10 ) )
        return true

    end
end

function ENT:OnRemove()
    SafeRemoveEntity( self.ambusher )

end

function ENT:AwakenTeammates()

    if self:GetWakeNearTeammates() ~= true then return end
    if self.wakenByTeammate and self:GetCanChainWakeTeammates() ~= true then return end

    local stuff = {}

    for _, classToWake in ipairs( self.TeammateSleepers ) do
        local found = ents.FindByClass( classToWake )
        table.Add( stuff, found )

    end

    local cutoff = self:GetTeammateWakeDist() ^ 2
    local myPos = self:GetPos()

    for _, toAwaken in ipairs( stuff ) do
        if toAwaken == self then continue end
        if toAwaken.ambushed then continue end
        if myPos:DistToSqr( toAwaken:GetPos() ) > cutoff then continue end
        local offset = math.Rand( 0.5, 2 )
        toAwaken.forcedAmbush = CurTime() + offset
        toAwaken.wakenByTeammate = true -- this stops endless chains!

    end
end

function ENT:CreateAmbusher()
    self.ambusher = self:InitializeAmbusher()

    if not IsValid( self.ambusher ) then return end
    self.ambusher.DoNotDuplicate = true
    timer.Simple( 0, function()
        if not IsValid( self ) then return end
        if not IsValid( self.ambusher ) then return end
        self:PostInitialized( self.ambusher )

    end )

    if not WireLib then return end
    Wire_TriggerOutput( self, "Sleeper", self.ambusher )

end

-- modifiable funcs below

function ENT:InitializeAmbusher()
    local ambusher = ents.Create( self.AmbusherClass )
    ambusher:SetPos( self:GetPos() )
    ambusher:SetAngles( self:GetAngles() )
    ambusher:SetKeyValue( "spawnflags", "516" )
    ambusher:SetKeyValue( "startburrowed", "1" )
    ambusher:Spawn()
    ambusher:Activate()

    return ambusher

end

function ENT:Ambush()
    self.ambusher:Fire( "unburrow", "", 0 )

end

function ENT:PostInitialized()
end

function ENT:PostAmbushed()
end

function ENT:DoHintSound()
    if self:GetIsSilent() then return end

    local sounds = self.HintSounds

    local theSound = sounds[ math.random( 1, #sounds ) ]
    local randOffset = VectorRand()
    randOffset.z = 0
    randOffset:Normalize()
    randOffset = randOffset * 50

    sound.Play( theSound, self:GetPos() + randOffset, 75, math.random( 90, 110 ), 1 )

end