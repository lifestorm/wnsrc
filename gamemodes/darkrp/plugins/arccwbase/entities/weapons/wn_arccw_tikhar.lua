--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Willard - Junk Weapons" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Tikhar"
SWEP.Trivia_Class = "Tikhar"
SWEP.Trivia_Desc = "A makeshift air gun, surprisingly silent and accurate. Overpressurizing its tank increases power, but the extra pressure vents before long."
SWEP.Trivia_Manufacturer = "Homemade"
SWEP.Trivia_Calibre = "Ball Bearings"
SWEP.Trivia_Mechanism = "Pneumatic"
SWEP.Trivia_Country = "Russia"

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_Tikhar.mdl"
SWEP.WorldModel = "models/weapons/c_Tikhar.mdl"
SWEP.ViewModelFOV = 65

SWEP.DefaultBodygroups = "00000"

SWEP.Damage = 25
SWEP.DamageMin = 25
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 200 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.AlwaysPhysBullet = true
SWEP.PhysTracerProfile = 0
SWEP.TracerNum = 1
SWEP.Tracer = "arccw_tracer"
SWEP.TracerCol = Color(38, 38, 38)

SWEP.CanFireUnderwater = true
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 15 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 30
SWEP.ReducedClipSize = 10

SWEP.Recoil = 0.9
SWEP.RecoilSide = 0.65
SWEP.RecoilRise = 1
SWEP.VisualRecoilMult = 1

SWEP.Delay = 60 / 180 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 3 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 110 -- pitch of shoot sound

SWEP.ShootSound = "Tikhar/Shoot.wav"
SWEP.DistantShootSound = "Tikhar/Shoot.wav"
SWEP.ShootSoundSilenced = "Tikhar/Shoot.wav"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 0 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.89
SWEP.SightedSpeedMult = 0.65

SWEP.RevolverReload = true

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {
    [1] = "Bullet16",
    [2] = "Bullet15",
    [3] = "Bullet14",
    [4] = "Bullet13",
    [5] = "Bullet12",
    [6] = "Bullet11",
    [7] = "Bullet10",
    [8] = "Bullet9",
    [9] = "Bullet8",
    [10] = "Bullet7",
    [11] = "Bullet6",
    [12] = "Bullet5",
    [13] = "Bullet4",
    [14] = "Bullet3",
    [15] = "Bullet2",
    [16] = "Bullet1",
}

SWEP.IronSightStruct = {
    Pos = Vector(-3.217, 0, 0.959),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 100

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(3.5, 2, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 27

SWEP.ShellRotateAngle = Angle(180, 180, 0)

SWEP.ExtraSightDist = 6

SWEP.MirrorVMWM = true

SWEP.WorldModelOffset = {
    pos = Vector(-13, 4, -4),
    ang = Angle(-10.52, 0, 180)
}


SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic", "optic_sniper", "optic_lp"}, -- what kind of attachments can fit here, can be string or table
        Bone = "Tikhar", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, -3.5, 14),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1.1, 1.1, 1.1),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "bipod"},
        Bone = "Tikhar",
        Offset = {
            vpos = Vector(0, 0.699, 7.791),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Tikhar",
        Offset = {
            vpos = Vector(0.6, -2.597, 15.064), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
    {
        PrintName = "Ammo Type",
        Slot = "ammo_bullet"
    },
    {
        PrintName = "Perk",
        Slot = "perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "Tikhar", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.7, -2.1, 5),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1, 1, 1),
    },
}

SWEP.BulletBones = {
    [1] = "Bullet16",
    [2] = "Bullet15",
    [3] = "Bullet14",
    [4] = "Bullet13",
    [5] = "Bullet12",
    [6] = "Bullet11",
    [7] = "Bullet10",
    [8] = "Bullet9",
    [9] = "Bullet8",
    [10] = "Bullet7",
    [11] = "Bullet6",
    [12] = "Bullet5",
    [13] = "Bullet4",
    [14] = "Bullet3",
    [15] = "Bullet2",
    [16] = "Bullet1",
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = "ready",
        Time = 1.5,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "shoot",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot",
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {24, 60},
        FrameRate = 30,
        Time = 4.2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        LastClip1OutTime = 2,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {24, 60, 102},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        LastClip1OutTime = 2,
    },
}