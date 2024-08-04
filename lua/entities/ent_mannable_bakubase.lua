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
AddCSLuaFile("includes/jakubbaku_utils.lua")
include("includes/jakubbaku_utils.lua")

ENT.Type = "anim"
ENT.PrintName = "Emplacement Base"
ENT.Category = "Jakub Baku"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.AutomaticFrameAdvance = true

/*
--------- DEV HELP README ---------

Mannable sentry/turret/whatever-you-gonna-call-it base, made by me - Jakub Baku / Geiger 21 / AwesomeGraczGie21 / karolek471 (I go by many names :P)
It's purpose is to facilitate the creation of new "mannables" for my addon, but I thought I can share my work with you.

How to use?
- Put the ent_mannable_bakubase.lua file in lua/entities
- Put the jakubbaku_utils.lua in lua/includes
- You can also put effects in lua/effects
- Create a new LUA file called along the lines of "entity_NAME" (make it unique) in lua/entities folder
- Add this "boiler plate" code:

AddCSLuaFile()

ENT.Base = "ent_mannable_bakubase" //important!
ENT.PrintName = "Your gun name"
ENT.Category = "Your category"
ENT.Spawnable = true //true if it's spawnable in the spawn menu
ENT.AdminOnly = false //true if it should be spawnable only for admins

Since we're working with a base we don't want to override default hooks like ENT:Initialize(), so please,
use only the ones provided by the base unless you know what you're doing.

(SHARED - accessible both on client and server
SERVER - serverside only
CLIENT - clientside only)

--------------- Hooks provided by the base (SIDE, name, return type): ---------------
SHARED ENT:DoInit() void
    Called when the entity is spawned

SHARED ENT:DoRemove() void
    Called when the entity is about to get removed

SHARED ENT:OnActivateGun() void
    Called when the user starts using the gun or enters the vehicle on which the gun is mounted

SHARED ENT:OnDeactivateGun() void
    Called when the user dies, gets too far from the gun, exits the vehicle etc.

SERVER ENT:OnStartShooting() void
    Called when the user starts firing

SERVER ENT:OnStopShooting() void
    Called when the user stops firing

SERVER ENT:DoShootThink() boolean
    Called everytime the user fires. Return true to override the default firing function

SERVER ENT:OnStartAttack() void
    Called when the user clicks the Left mouse button. Most of the time it's
    identical to OnStartShooting, but using this function you can delay the firing,
    for example in case of charging the gun or something

SERVER ENT:OnStopAttack() void
    Called when the user lets go of the left mouse button. Most of the time it's
    identical to OnStopShooting

SERVER ENT:DoShoot(direction) void
    Called when the user fires the gun, use the direction argument to direct your bullets, projectiles.
    direction is a normalized direction vector pointing in the aim direction

CLIENT ENT:DoNotification() void
    Called when the user starts using the gun. It's purpose is to
    display the help notification (ENT._Notification)

CLIENT ENT:DoDraw() void
    Called every frame. Used for drawing effects, models etc.

CLIENT ENT:DoThink() void
    Called every frame

--------------- Methods provided by the base ---------------
SERVER ENT:BakuRegisterMannable() void
    Registers the gun for use in vehicles. If you want your gun to be
    able to be mounted on the vehicle call this function, preferably in ENT:DoInit() hook.

SERVER ENT:BakuManned(manned (boolean)) void
    INTERNAL, DO NOT USE UNLESS YOU KNOW WHAT YOU'RE DOING
    Use this method to mark the user as "not manning the gun" (manned = false) or "manning the gun" (manned = true)

SERVER ENT:BakuIsManned(user) boolean
    INTERNAL, DO NOT USE UNLESS YOU KNOW WHAT YOU'RE DOING
    Tells whether the user is manning a gun

CLIENT ENT:SetupCustomModel(mdl (string), bone (number), rendergroup (RENDERGROUP_ enum)) CSEnt
    Facilitates the creation of ENT._CustomGunModel. Mdl is a path to model like "models/weapons/something.mdl",
    bone is a boneID of the bone used for positioning the model, rendergroup by default is RENDERGROUP_TRANSLUCENT

--------------- Important variables (type, name) ---------------
Please do not modify other base-specific variables than those specified there

number ENT.ShootDelay
    Used by default shooting code. Basically a delay between shots

number ENT._ShootTimer
    Internal, used for timing the shots. It's handy for charged attack, here's example

    function ENT:OnStartAttack()
        //when the user starts attacking

        local somechargetime = 1 //1 second charge time

        self:EmitSound("some/sound.wav") //we emit some sound
        self._ShootTimer = CurTime() + somechargetime

        //the CurTime() is really important here, because it's not a simple delay, it's a timestamp
        //of the next fire
    end

number ENT._Ammo
    If set to less than 0 (-1 for example) the gun has unlimited ammo.

boolean ENT._DoNetworking
    true by default. If set to false many shared hooks won't be called clientside

boolean ENT._IsShooting
    READ ONLY VARIABLE, do not modify unless you know what you're doing.
    Handy for determining whether the gun is firing or not

boolean ENT._Active
    READ ONLY VARIABLE, do not modify unless you know what you're doing.
    Tells whether the gun is actively manned / used

boolean ENT._DriveMode
    READ ONLY VARIABLE, do not modify unless you know what you're doing.
    Tells whether the gun is in drive mode (mounted to a vehicle)

boolean ENT._HideGunModel
    Set it in ENT:DoInit() to true to hide the original
    gun model

CSEnt ENT._CustomGunModel CLIENTSIDE ONLY
    A ClientsideModel representing the custom gun model.
    Set it in clientside ENT:DoInit() hook like that:
        self._CustomGunModel = ClientsideModel("path/to/model.mdl")
    Preferably use ENT:SetupCustomModel method

number ENT._CModelBone CLIENTSIDE ONLY
    Bone ID of a _CustomGunModel's bone used to change the position.
    Most of the times you should not touch it (it's 0 - ROOT_BONE by default)

VMatrix ENT._GunModelMatrix CLIENTSIDE ONLY
    Transformation matrix of a gun model. Used for positioning, changing
    the angles of a custom gun model. If not touched it's identity matrix,
    so no changes to the pos/ang/scale


Why don't I make accessor funcs for all those obscure variables? Well... I don't need them.
Real programming is when you can break all your code with just one missplaced variable ;)
This is base for smart people, cautious programmers. But no, seriously, it's because
I don't need it

--------/ DEV HELP README \--------
*/

hook.Add("InitPostEntity", "MannableBakuBaseDuplicator", function()
    local _base = scripted_ents.Get("ent_mannable_bakubase")

    local _regents = scripted_ents.GetList()
    for k, v in pairs(_regents) do
        if(v.Base == "ent_mannable_bakubase") then
            duplicator.RegisterEntityClass(v.t.ClassName, _base.BaseDupeFunction, "Data")
        end
    end
end)

function ENT:DoInit() end
function ENT:DoRemove() end
function ENT:DoSetupDataTables() end
function ENT.DupeFunction(ply, data) end

function ENT:RegisterDuplicator()
    
end

function ENT:SetupDataTables()
    if(self._CanAIControlled) then
        self:NetworkVar("Bool", 31, "_AIControlled", {KeyName = "aicontrolled", Edit = {title = "AI Controlled", category = "AI", type = "Boolean", order = 0}})

        if(SERVER) then
            self:Set_AIControlled(false)
        end

        self:NetworkVarNotify("_AIControlled", self.HandleAIVarChange)
    end

    self:DoSetupDataTables()
end

if (SERVER) then
    function ENT.BaseDupeFunction(ply, data)
        data._User = NULL
        data._Active = false
        data._ShootTimer = 0
        data._UseTimer = 0
        data._SequenceTimer = 0
        data._IsShooting = false

        local _func = scripted_ents.Get(data.Class).DupeFunction

        if(isfunction(_func)) then
            _func(ply, data)
        end

        return duplicator.GenericDuplicatorFunction(ply, data)
    end

    ENT._User = NULL
    ENT._UserPrevWeapon = NULL
    ENT._Active = false
    ENT._DriveMode = false
    ENT._Vehicle = NULL
    ENT.ShootDelay = 0.075
    ENT._Ammo = -1

    ENT._OldAim = Vector(0, 0, 0)

    ENT._ShootTimer = 0
    ENT._UseTimer = 0
    ENT._SequenceTimer = 0
    ENT._IsShooting = false
    ENT._HideGunModel = false
    ENT._Automatic = true
    ENT._DoNetworking = true
    ENT._PitchOffset = 0

    //AI
    ENT._AIControlled = false
    ENT._AIShooting = false
    ENT._AIAimPoint = Vector(0, 0, 0)
    ENT._AIEnemy = NULL

    local _varhandlers = {
        ["_AIControlled"] = function(self, old, new)
            self:InitAIControll()
        end,
    }

    function ENT:HandleAIVarChange(name, old, new)
        if(isfunction(_varhandlers[name])) then
            if(old != new) then
                _varhandlers[name](self, old, new)
            end
        end
    end

    function ENT:OnStartShooting() end
    function ENT:OnStopShooting() end
    function ENT:DoShootThink() return false end
    function ENT:OnStartAttack() end
    function ENT:OnStopAttack() end
    function ENT:OnDeactivateGun() end
    function ENT:OnActivateGun() end

    function ENT:BakuRegisterMannable()
        __BakuRegisteredMannableClasses = __BakuRegisteredMannableClasses or {}
        __BakuRegisteredMannableClasses[self:GetClass()] = true
    end

    function ENT:BakuManned(bool)
        if(bool) then
            __BakuManTableAR3[self._User:EntIndex()] = self
        else
            __BakuManTableAR3[self._User:EntIndex()] = nil
        end
    end

    function ENT:BakuIsManned(user)
        return IsValid(__BakuManTableAR3[user:EntIndex()])
    end

    function ENT:BakuRemoveFromVehicle()
        __BakuVehicleTableAR3[self._Vehicle:EntIndex()] = nil
    end

    function ENT:InitAIControll()
        self:AR3Deactivate()

        self._AIControlled = true
        self._User = NULL
        self._Active = false
    end

    function ENT:DoAIThink()
        if(!IsValid(self._AIEnemy)) then
            local enemy = player.GetAll()[1]

            self._AIEnemy = enemy

            if(IsValid(enemy) && enemy:Alive() && !self._Active) then
                self:AR3Activate()
            end
        else
            local tr = util.TraceLine({
                start = self:GetAttachment(1).Pos,
                endpos = self._AIEnemy:GetPos() + self._AIEnemy:OBBCenter(),
                filter = self
            })

            if(tr.Entity == self._AIEnemy) then
                self._AIAimPoint = tr.HitPos
                self._AIShooting = true
            end

            if(IsValid(self._AIEnemy) || !self._AIEnemy:Alive()) then
                //self:AR3Deactivate()
            end
        end
    end

    function ENT:Initialize()
        self._User = NULL
        self._UserPrevWeapon = NULL
        self._Active = false
        self._DriveMode = false
        self._Vehicle = NULL
        self.ShootDelay = 0.075
        self._Ammo = -1

        self._OldAim = Vector(0, 0, 0)

        self._ShootTimer = 0
        self._UseTimer = 0
        self._SequenceTimer = 0
        self._IsShooting = false
        self._HideGunModel = false
        self._Automatic = true
        self._DoNetworking = true
        self._PitchOffset = 0

        //AI
        self._AIControlled = false
        self._AIShooting = false
        self._AIAimPoint = Vector(0, 0, 0)
        self._AIEnemy = NULL

        self:DoInit()

        if(self._HideGunModel) then
            self:SetModel("models/props_combine/bunker_gun01_nogun.mdl")
        else
            self:SetModel("models/props_combine/bunker_gun01.mdl")
        end

        self:PhysicsInitBox(-Vector(8,8,0), Vector(8,8,8))

        local phys = self:GetPhysicsObject()
        if(IsValid(phys)) then
            phys:Wake()
        end

        self:SetUseType(USE_TOGGLE)
    end

    local usetime = 0.5

    function ENT:AR3Activate()
        self:ResetSequence(1)
        self._SequenceTimer = CurTime() + 0.5

        if(IsValid(self._User) && !self._AIControlled) then
            if(!self._DriveMode) then
                self._UserPrevWeapon = self._User:GetActiveWeapon()
                self._User:SetActiveWeapon(NULL)            
            end

            self:BakuManned(true)

            self:EmitSound("weapons/shotgun/shotgun_cock.wav")
        end
        self._Active = true

        self._OldAim = self:GetForward()
        self:OnActivateGun()

        if(self._DoNetworking) then
            self:SetNWBool("_active", true)
            self:SetNWBool("_drive", self._DriveMode)
            self:SetNWEntity("_user", self._User)
        end
    end

    function ENT:AR3Deactivate()
        self:ResetSequence(3)
        self._SequenceTimer = CurTime() + self:SequenceDuration()

        if(self._IsShooting) then
            self:OnStopShooting()
        end

        if(self._IsKeyDown) then
            self:OnStopAttack()
        end

        self._IsShooting = false
        self._IsKeyDown = false

        if(IsValid(self._User) && !self._AIControlled) then
            if(!self._DriveMode && IsValid(self._UserPrevWeapon)) then
                self._User:SelectWeapon(self._UserPrevWeapon:GetClass() or "weapon_crowbar")
            end

            self:BakuManned(false)
            self._Active = false

            self:EmitSound("weapons/shotgun/shotgun_cock.wav")
            self:OnDeactivateGun()
        end

        self._User = NULL

        if(self._DoNetworking) then
            self:SetNWBool("_active", false)
            self:SetNWBool("_drive", self._DriveMode)
            self:SetNWEntity("_user", self._User)
        end
    end

    function ENT:Use(act, caller, _type, _val)
        if(self._UseTimer > CurTime() || act:EyePos():DistToSqr(self:GetPos()) > 64 * 64 || self._AIControlled) then return end

        if(self._DriveMode) then
            if(IsValid(self._Vehicle) && IsValid(JBUFindTheEntInConstraints(self._Vehicle, "Weld", self:GetClass()))) then return
            else
                self:BakuRemoveFromVehicle()
                self._Vehicle = NULL
                self._DriveMode = false
            end
        end

        if(!IsValid(self._User) && !self:BakuIsManned(act)) then
            self._User = act

            self:AR3Activate()
        elseif(self._User == act) then
            self:AR3Deactivate()
        end

        self._UseTimer = CurTime() + usetime
    end
    
    function ENT:OnRemove()
        self:AR3Deactivate()
        self:DoRemove()
    end

    function ENT:DoShoot(dest)

    end

    function ENT:IsGunShooting()
        return (!self._AIControlled && IsValid(self._User) && self._User:KeyDown(IN_ATTACK)) || (self._AIControlled && self._AIShooting)
    end

    function ENT:Think()
        if(self._Active && (!self._AIControlled && IsValid(self._User))) then
            local aimpoint

            if(self._AIControlled) then
                aimpoint = self._AIAimPoint
            else
                if(IsValid(self._User)) then
                    local ply = self._User

                    if(ply:EyePos():DistToSqr(self:GetPos()) > 64 * 64 && !self._DriveMode || !ply:Alive()) then
                        self:AR3Deactivate()
                    end

                    local _filter_ = {self, ply}

                    if(ply:InVehicle()) then
                        table.insert(_filter_, ply:GetVehicle())
                    end

                    local tr = util.TraceLine({
                        start = ply:EyePos(),
                        endpos = ply:EyePos() + ply:GetAimVector() * 65535,
                        filter = _filter_ or self
                    })

                    aimpoint = tr.HitPos
                end
            end

            local transposed1 = JBUmatTranspose3x3(self:GetWorldTransformMatrix())
            local look = (aimpoint - self:GetBonePosition(4))
            local __dist = look:LengthSqr()
            look:Normalize()
            local mydestlook = JBUApproachVector(self._OldAim, look, 2 * FrameTime())

            self._OldAim = mydestlook
            local transformed = transposed1 * look
            local relang = transformed:Angle()

            if(relang.yaw > 180) then
                relang.yaw = relang.yaw - 360
            end

            if(relang.pitch > 180) then
                relang.pitch = relang.pitch - 360
            end
            
            if(__dist > 2000) then
                self:ClearPoseParameters()
                self:SetPoseParameter("aim_yaw", relang.yaw)
                self:SetPoseParameter("aim_pitch", relang.pitch + self._PitchOffset)
            end

            if(self:IsGunShooting()) then
                if(!self._IsKeyDown) then
                    self:OnStartAttack()
                    self._IsKeyDown = true
                end

                if(self._ShootTimer < CurTime() && (self._Automatic || !self._IsShooting)) then
                    if(self._Ammo > 0 || self._Ammo < 0) then
                        if(!self._IsShooting) then
                            self._IsShooting = true
                            self:OnStartShooting()
                        end
                        local dest = mydestlook

                        if(math.abs(relang.yaw) > 60 || relang.pitch < -35 || relang.pitch > 60) then
                            dest = self:GetAttachment(1).Ang:Forward()
                        end

                        if(!self:DoShootThink()) then
                            self:DoShoot(dest)
                            self._ShootTimer = CurTime() + self.ShootDelay

                            self:ResetSequence(2)
                            self._SequenceTimer = CurTime() + self:SequenceDuration()

                            if(self._Ammo > 0) then
                                self._Ammo = self._Ammo - 1
                            end
                        end
                    elseif(self._IsShooting) then
                        self:OnStopShooting()
                        self._IsShooting = false
                    end
                end
            else
                if(self._IsShooting) then
                    self:OnStopShooting()
                    self._IsShooting = false
                end

                if(self._IsKeyDown) then
                    self._IsKeyDown = false
                    self:OnStopAttack()
                end
            end
        end

        if(self._AIControlled) then
            self:DoAIThink()
        end

        if(self._SequenceTimer < CurTime() && self._Active) then
            self:ResetSequence(0)
            self._SequenceTimer = CurTime() + self:SequenceDuration()
        end

        self:NextThink(CurTime())
        return true
    end
else
    function ENT.BaseDupeFunction(ply, data)
        data._User = NULL
        data._Active = false

        scripted_ents.Get(data.Class).DupeFunction(ply, data)

        return duplicator.GenericDuplicatorFunction(ply, data)
    end

    function ENT:DoNotification()
        if(!IsValid(self._User) or self._User != LocalPlayer()) then return end
        
        local cookiename = self:GetClass() .. "_notifycookie"
        if(self._Notification && cookie.GetNumber(cookiename, 0) < os.time()) then
            cookie.Set(cookiename, tostring(os.time() + 7200))

            local notif = {}
            if(isstring(self._Notification)) then
                notif[1] = self._Notification
            elseif(istable(self._Notification)) then
                notif = self._Notification
            end

            local __i = 0
            for k, v in pairs(notif) do
                timer.Simple(__i * 0.6, function()
                    notification.AddLegacy( v, NOTIFY_HINT, 5 )
                    surface.PlaySound( "buttons/button15.wav" )
                end)
                
                __i = __i + 1
            end
        end
    end

    function ENT:SetupCustomModel(mdl, bone, rendergroup)
        if(IsValid(self._CustomGunModel)) then
            self._CustomGunModel:SetModel(mdl)
        else
            rendergroup = rendergroup or RENDERGROUP_OPAQUE
            self._CustomGunModel = ClientsideModel(mdl, rendergroup)
            self._CustomGunModel:SetNoDraw(true)
        end
        self._CModelBone = bone or self._CModelBone or 0

        return self._CustomGunModel
    end

    function ENT:OnDeactivateGun() end
    function ENT:OnActivateGun() end
    function ENT:DoDraw() end
    function ENT:DoThink() end

    function ENT:Initialize()
        local mins, maxs = self:GetModelBounds()
        self:SetRenderBounds(mins, maxs, Vector(1, 1, 1) * 30)

        self._CModelBone = 0
        self._Active = false
        self._User = NULL
        self._DriveMode = false

        self:DoInit()

        if(IsValid(self._CustomGunModel)) then
            self._GunModelMatrix = self._GunModelMatrix or Matrix()

            self._CustomGunModel:SetNoDraw(true)
        end
    end

    function ENT:Think()
        if(self._Active && !self:GetNWBool("_active")) then
            self:OnDeactivateGun()
            self._Active = false

            if(self._DriveMode && LocalPlayer() == self._User) then
                local mins, maxs = self:GetModelBounds()
                self:SetRenderBounds(mins, maxs, Vector(1, 1, 1) * 30)
            end

            self._User = NULL
            self._DriveMode = false
        elseif(!self._Active && self:GetNWBool("_active")) then
            self._User = self:GetNWEntity("_user")
            self._DriveMode = self:GetNWBool("_drive")
            self._Active = true
            self:OnActivateGun()
            self:DoNotification()

            if(self._DriveMode && LocalPlayer() == self._User) then
                local _x_y_z = Vector(65535, 65535, 65535)
                self:SetRenderBounds(-_x_y_z, _x_y_z)
            end
        end

        self:DoThink()
    end

    local chair = Material("sprites/hud/v_crosshair1")
    local flashlight = Material("sprites/glow03")
    local glow = Material("sprites/glow_test02")

    function ENT:DrawCustomGunModel()
        self._CustomGunModel:SetupBones()

        local mat2 = self:GetBoneMatrix(4) * self._GunModelMatrix

        self._CustomGunModel:SetPos(self:GetPos())
        self._CustomGunModel:SetBoneMatrix(self._CModelBone, mat2)
        self._CustomGunModel:DrawModel()
    end

    function ENT:Draw()
        self:DrawModel()
        self:DoDraw()

        if(IsValid(self._CustomGunModel)) then
            self:DrawCustomGunModel()
        end

        local ply = self._User

        if(self._DriveMode && ply == LocalPlayer()) then
            render.SetMaterial(chair)
            render.DrawSprite(ply:EyePos() + ply:GetAimVector() * 200, 8, 8, Color(255,255,0,255))
        end
    end

    function ENT:OnRemove()
        if(IsValid(self._CustomGunModel)) then
            self._CustomGunModel:Remove()
        end

        self:OnDeactivateGun()
        self:DoRemove()
    end
end