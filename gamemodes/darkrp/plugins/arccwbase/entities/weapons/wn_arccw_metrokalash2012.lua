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

SWEP.PrintName = "Kalash2012"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "At the start of World War 3, this was the best assault rifle used by the army. It is extremely sought after in the Metro due to its great performance."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "5.45x39mm"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Russia"

SWEP.Slot = 2
SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_kalash2012.mdl"
SWEP.WorldModel = "models/weapons/c_kalash2012.mdl"
SWEP.ViewModelFOV = 80

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 8
SWEP.DamageMin = 8 -- damage done at maximum range
SWEP.Range = 500 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 50 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 1050

SWEP.Recoil = 0.42
SWEP.RecoilSide = 0.65
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 700 -- 60 / RPM.
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

SWEP.AccuracyMOA = 9 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 500 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "ak47" -- the magazine pool this gun draws from

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "2012/shoot.wav"
SWEP.ShootSoundSilenced = "2012/shoots.wav"
SWEP.DistantShootSound = "2012/shoot3.wav"
SWEP.DistantShootSoundSilenced = "2012/shoots.wav"

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
    Pos = Vector(-7.191, -7.5, 1.1),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
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

SWEP.BarrelLength = 18

SWEP.AttachmentElements = {
        ["lastlight2012"] = {
        VMSkin = 1,
        WMSkin = 1,
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-18, 8.2, -1),
    ang = Angle(-200, 180, 0)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "2012",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.1, -5.4, 9),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "2012",
        Offset = {
            vpos = Vector(1.3, -1.201, 11),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "2012",
        Offset = {
            vpos = Vector(0.05, -0.9, 26.9),
            vang = Angle(90, 0, -90),
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
        Slot = {"metro_skin2012"},
        DefaultAttName = "Metro 2033",
        FreeSlot = true
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "2012", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1.399, -1.3, 3.65), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
}

SWEP.BulletBones = {
    [5] = "Bullet1",
    [6] = "Bullet2",
    [7] = "Bullet3",
    [8] = "Bullet4",
    [9] = "Bullet5",
    [10] = "Bullet6",
    [11] = "Bullet7",
    [12] = "Bullet8",
    [13] = "Bullet9",
    [14] = "Bullet10",
    [15] = "Bullet11",
    [16] = "Bullet12",
    [17] = "Bullet13",
    [18] = "Bullet14",
    [19] = "Bullet15",
    [20] = "Bullet16",
    [21] = "Bullet17",
    [22] = "Bullet18",
    [23] = "Bullet19",
    [24] = "Bullet20",
    [25] = "Bullet21",
    [26] = "Bullet22",
    [27] = "Bullet23",
    [28] = "Bullet24",
    [29] = "Bullet25",
    [30] = "Bullet26",
    [31] = "Bullet27",
    [32] = "Bullet28",
    [33] = "Bullet29",
    [34] = "Bullet30",
    [35] = "Bullet31",
    [36] = "Bullet32",
    [37] = "Bullet33",
    [38] = "Bullet34",
    [39] = "Bullet35",
    [40] = "Bullet36",
    [41] = "Bullet37",
    [42] = "Bullet38",
    [43] = "Bullet39",
    [44] = "Bullet40",
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        Time = 0.5,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        Time = 1.5,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = {"shoot", "shoot1"},
        Time = 0.3,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 0.1,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Checkpoints = {16, 30},
        Time = 2.4,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        LHIKEaseOut = 0.25,
        LastClip1OutTime = 1,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Checkpoints = {16, 30, 55},
        Time = 2.6,
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
    name = "2012.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "2012/cliphit.wav"
})

sound.Add({
    name = "2012.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "2012/clipout.wav"
})

sound.Add({
    name = "2012.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "2012/clipin.wav"
})
