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

SWEP.PrintName = "Revolver"
SWEP.Trivia_Class = "Revolver"
SWEP.Trivia_Desc = "A simple and reliable weapon produced in the Metro. Has great stopping power but kicks like a mule."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = ".44 Magnum"
SWEP.Trivia_Mechanism = "Double Action"
SWEP.Trivia_Country = "Russia"

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_MetroRevolver.mdl"
SWEP.WorldModel = "models/weapons/c_MetroRevolver.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultSkin = 0

SWEP.Damage = 32
SWEP.DamageMin = 32
SWEP.Range = 40 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1230 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 6
SWEP.ReducedClipSize = 4

SWEP.Recoil = 2.5
SWEP.RecoilSide = 1
SWEP.RecoilRise = 1.8
SWEP.VisualRecoilMult = 0.5

SWEP.Delay = 60 / 180 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "DACT",
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.NPCWeaponType = {"weapon_pistol", "weapon_357"}
SWEP.NPCWeight = 75

SWEP.AccuracyMOA = 8 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses
SWEP.MagID = "ragingbull" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 95 -- pitch of shoot sound

SWEP.ShootSound = "Revolver/Shot.wav"
SWEP.ShootSoundSilenced = "Revolver/Shots.wav"
SWEP.DistantShootSound = "Revolver/Shot.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"

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
    Pos = Vector(-2.721, -2, 1.759),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER

SWEP.ActivePos = Vector(0, 0, 1)
SWEP.ActiveAng = Angle(0, 1, 0)

SWEP.CustomizePos = Vector(20, 5, -5)

SWEP.HolsterPos = Vector(0, -10, -10)
SWEP.HolsterAng = Angle(45, 0, 0)

SWEP.CrouchPos = Vector(-3, 0, 0)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.SprintPos = Vector(0, -10, -10)
SWEP.SprintAng = Angle(45, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.ExtraSightDist = 10

SWEP.AttachmentElements = {
    ["lastlightmr"] = {
        VMSkin = 1,
        WMSkin = 1,
    },
}

SWEP.WorldModelOffset = {
    pos = Vector(-19.2, 4.1, -2),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp", "optic"},
        Bone = "ValveBiped.Weapon_bone",
        Offset = {
            vpos = Vector(3, 0, 2.2),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(0.7, 0.7, 0.7),
        CorrectiveAng = nil --Angle(90, 0, -90)
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "ValveBiped.Weapon_bone",
        Offset = {
            vpos = Vector(8.699, 0, 1.75),
            vang = Angle(0, 0, 0),
            wpos = Vector(15.2, 1, -4.3),
            wang = Angle(0, 0, 0)
        },
                VMScale = Vector(0.7, 0.7, 0.7),
    },
    {
        PrintName = "Tactical",
        Slot = "tac_pistol",
        Bone = "ValveBiped.Weapon_bone",
        Offset = {
            vpos = Vector(7, 0, 1),
            vang = Angle(0, -1, 0),
            wpos = Vector(15, 1, -3.4),
            wang = Angle(0, 0, 180)
        }
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
        Slot = {"perk", "perk_revolver"}
    },
    {
        PrintName = "Skin",
        Slot = {"metro_skinmr"},
        DefaultAttName = "Metro 2033",
        FreeSlot = true
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "ValveBiped.Weapon_bone",
        Offset = {
            vpos = Vector(1.799, -0.301, -0.301), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
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
        Source = "draw",
        Time = 0.7,
    },
    ["ready"] = {
        Source = "ready",
    },
    ["fire"] = {
        Source = "shoot",
    },
    ["fire_iron"] = {
        Source = "shoot",
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        Time = 2.15,
        FrameRate = 30,
        LastClip1OutTime = 1.3,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        FrameRate = 30,
        LastClip1OutTime = 1.3,
    },
}

sound.Add({
    name = "MR.BI",
    channel = 16,
    volume = 1.0,
    sound = "Revolver/Bulletsin.wav"
})

sound.Add({
    name = "MR.BO",
    channel = 16,
    volume = 1.0,
    sound = "Revolver/Bulletsout.wav"
})

sound.Add({
    name = "MR.Close",
    channel = 16,
    volume = 1.0,
    sound = "Revolver/Close.wav"
})

sound.Add({
    name = "MR.Open",
    channel = 16,
    volume = 1.0,
    sound = "Revolver/Op.wav"
})

sound.Add({
    name = "MR.MT",
    channel = 16,
    volume = 1.0,
    sound = "Revolver/Mt.wav"
})