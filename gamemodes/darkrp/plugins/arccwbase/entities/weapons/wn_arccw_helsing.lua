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

SWEP.PrintName = "Helsing"
SWEP.Trivia_Class = "Helsing"
SWEP.Trivia_Desc = "A silent, revolving air gun that shoots metal bolts. Overpressurizing its tank increases power, but the extra pressure vents before long."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "Helsing Bolt"
SWEP.Trivia_Mechanism = "Pneumatic"
SWEP.Trivia_Country = "Russia"

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_Helsing.mdl"
SWEP.WorldModel = "models/weapons/c_Helsing.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0

SWEP.Damage = 29
SWEP.DamageMin = 29
SWEP.Range = 40 -- in METRES
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
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8
SWEP.ReducedClipSize = 6

SWEP.Recoil = 1
SWEP.RecoilSide = 1
SWEP.RecoilRise = 1
SWEP.VisualRecoilMult = 0.5

SWEP.Delay = 60 / 180 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.NPCWeaponType = {"weapon_ar2"}
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 3 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 95 -- pitch of shoot sound

SWEP.ShootSound = "Helsing/Shoot.mp3"
SWEP.ShootSoundSilenced = "Helsing/Shoot.mp3"
SWEP.DistantShootSound = "Helsing/Shoot.mp3"

SWEP.MuzzleEffect = nil

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 0 -- which attachment to put the case effect on

SWEP.RevolverReload = true

SWEP.SightTime = 0.28

SWEP.SpeedMult = 0.975
SWEP.SightedSpeedMult = 0.75

SWEP.BarrelLength = 18

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {
    [1] = "Bullet1",
    [2] = "Bullet2",
    [3] = "Bullet3",
    [4] = "Bullet4",
    [5] = "Bullet5",
    [6] = "Bullet6",
}


SWEP.IronSightStruct = {
    Pos = Vector(-5.881, 0, 2.184),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.HolsterPos = Vector(5, 0, 0)
SWEP.HolsterAng = Angle(-4, 30.016, 0)

SWEP.CrouchPos = Vector(-3, 0, 0)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.ExtraSightDist = 10

SWEP.WorldModelOffset = {
    pos = Vector(-16.105, 7, -5.715),
    ang = Angle(-10.52, 0, 180)
}

SWEP.GuaranteeLaser = false

SWEP.MirrorVMWM = true

SWEP.BulletBones = {
    [1] = "Arrow1",
    [2] = "Arrow2",
    [3] = "Arrow3",
    [4] = "Arrow4",
    [5] = "Arrow5",
    [6] = "Arrow6",
    [7] = "Arrow7",
    [8] = "Arrow8",
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp", "optic"},
        Bone = "Helsing",
        Offset = {
            vpos = Vector(0, -3.8, 3.5),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Helsing",
        Offset = {
            vpos = Vector(-0.5, -0.601, 17.7),
            vang = Angle(89.7, 0.4, 180),
        },
                VMScale = Vector(0.7, 0.7, 0.7),
                WMScale = Vector(0.7, 0.7, 0.7),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "Helsing",
        Offset = {
            vpos = Vector(0, 2.599, 19),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Ammo Type",
        Slot = "ammo_bullet",
    },
    {
        PrintName = "Perk",
        Slot = {"perk"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "Helsing",
        Offset = {
            vpos = Vector(0.37, -0.7, 2.7), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(10, 1.25, -4),
            wang = Angle(0, -4.211, 180)
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw"
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
    },
    ["fire_iron"] = {
        Source = "shoot",
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        Time = 2.4,
        LastClip1OutTime = 1.3,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LastClip1OutTime = 1.3,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.5,
    },
}

sound.Add({
    name = "HS.Reload",
    channel = 16,
    volume = 1.0,
    sound = "Helsing/helsingrl1.wav"
})

sound.Add({
    name = "HS.Reload2",
    channel = 16,
    volume = 1.0,
    sound = "Helsing/helsingrl2.wav"
})

