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

SWEP.PrintName = "Kalash"
SWEP.TrueName = "AK-74M"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "The classic pre-war assault rifle. Despite being very common, it is held in very high regard in the Metro due to its reliability and performance."
SWEP.Trivia_Manufacturer = "Izhmash"
SWEP.Trivia_Calibre = "5.45x39mm"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 1991

SWEP.Slot = 2
SWEP.UseHands = true

if GetConVar("arccw_truenames"):GetBool() then SWEP.PrintName = SWEP.TrueName end

SWEP.ViewModel = "models/weapons/c_kalash.mdl"
SWEP.WorldModel = "models/weapons/c_kalash.mdl"
SWEP.ViewModelFOV = 90

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 13
SWEP.DamageMin = 13 -- damage done at maximum range
SWEP.Range = 500 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 880 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 880

SWEP.Recoil = 0.93
SWEP.RecoilSide = 0.65
SWEP.RecoilRise = 0.3
SWEP.RecoilPunch = 2

SWEP.Delay = 60 / 550 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 200

SWEP.AccuracyMOA = 10 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 750 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "ak47" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "Kalash/Shoot.wav"
SWEP.ShootSoundSilenced = "2012/shoots.wav"
SWEP.DistantShootSound = "Kalash/Shoot.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_ak47"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.91
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-7.9, -7.437, 1.759),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["lastlightk"] = {
        VMSkin = 1,
        WMSkin = 1,
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-10, 8.6, -5),
    ang = Angle(-190, 180, 0)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "AK",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -5.2, 11),
            vang = Angle(-90, -180, 90),
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl"},
        Bone = "AK",
        Offset = {
            vpos = Vector(-0, -1.601, 17),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "AK",
        Offset = {
            vpos = Vector(-0.601, -2.701, 12),
            vang = Angle(-90, 180, 0),
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "AK",
        Offset = {
            vpos = Vector(0.1, -2.651, 28.6),
            vang = Angle(-90, 180, 0),
        },
        InstalledEles = {"no_fh"}
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Skin",
        Slot = {"metro_skink"},
        DefaultAttName = "Metro 2033",
        FreeSlot = true
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "AK", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.759, -2.401, 9), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
}

SWEP.BulletBones = {
    [1] = "Bullet30",
    [2] = "Bullet29",
    [3] = "Bullet28",
    [4] = "Bullet27",
    [5] = "Bullet26",
    [6] = "Bullet25",
    [7] = "Bullet24",
    [8] = "Bullet23",
    [9] = "Bullet22",
    [10] = "Bullet21",
    [11] = "Bullet20",
    [12] = "Bullet19",
    [13] = "Bullet18",
    [14] = "Bullet17",
    [15] = "Bullet16",
    [16] = "Bullet15",
    [17] = "Bullet14",
    [18] = "Bullet13",
    [19] = "Bullet12",
    [20] = "Bullet11",
    [21] = "Bullet10",
    [22] = "Bullet9",
    [23] = "Bullet8",
    [24] = "Bullet7",
    [25] = "Bullet6",
    [26] = "Bullet5",
    [27] = "Bullet4",
    [28] = "Bullet3",
    [29] = "Bullet2",
    [30] = "Bullet1",
}

SWEP.Animations = {
    ["idle"] = {
        Source = "ak47_idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "drawfirst",
        Time = 1.5,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = {"shoot"},
        Time = 0.3,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shootis",
        Time = 0.1,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Checkpoints = {16, 30},
        Time = 2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        LHIKEaseOut = 0.25,
        LastClip1OutTime = 1,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Checkpoints = {16, 30, 55},
        Time = 3,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        LHIKEaseOut = 0.25,
        LastClip1OutTime = 1,
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "Kalash.Bolt",
    channel = 16,
    volume = 1.0,
    sound = "Kalash/Bolt.wav"
})

sound.Add({
    name = "Kalash.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "Kalash/Clipout.wav"
})

sound.Add({
    name = "Kalash.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "Kalash/Clipin.wav"
})
