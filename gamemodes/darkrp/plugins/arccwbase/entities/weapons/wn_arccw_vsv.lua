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

SWEP.PrintName = "VSV"
SWEP.TrueName = "VSK-94"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "An accurate and powerful assault rifle good for medium-range combat. Its somewhat low muzzle velocity translates into lower noise and faster bullet drop."
SWEP.Trivia_Manufacturer = "Konstruktorskoe Buro Priborostroeniya"
SWEP.Trivia_Calibre = "5.45x39mm"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 1994

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then SWEP.PrintName = SWEP.TrueName end

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_VSV.mdl"
SWEP.WorldModel = "models/weapons/c_VSV.mdl"
SWEP.ViewModelFOV = 65

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 14
SWEP.DamageMin = 14
SWEP.Range = 400 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 270 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 270

SWEP.Recoil = 0.62
SWEP.RecoilSide = 0.255
SWEP.RecoilRise = 0.2
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 600 -- 60 / RPM.
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
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 9 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 650 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "stanag" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "VSV/shoot.wav"
SWEP.DistantShootSound = "VSV/shoot2.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.30

SWEP.IronSightStruct = {
    Pos = Vector(-6.281, -5, 1.879),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, 0)
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
    ["lastlightvsv"] = {
        VMSkin = 1,
        WMSkin = 1,
    },
}
SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12, 7, -3.5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "VSV",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.05, -3.1, 3.635),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1, 1, 1),
        InstalledEles = {"rs_none", "fs_down"},
        CorrectiveAng = Angle(0, 0, 0),
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "VSV",
        Offset = {
            vpos = Vector(0, -1, 11),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "VSV",
        Offset = {
            vpos = Vector(0, -0.7, 15),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
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
        Slot = {"metro_skinvsv"},
        DefaultAttName = "Metro 2033",
        FreeSlot = true
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "VSV", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -1.601, 0.4), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.BulletBones = {
    [1] = "Bullet20",
    [2] = "Bullet19",
    [3] = "Bullet18",
    [4] = "Bullet17",
    [5] = "Bullet16",
    [6] = "Bullet15",
    [7] = "Bullet14",
    [8] = "Bullet13",
    [9] = "Bullet12",
    [10] = "Bullet11",
    [11] = "Bullet10",
    [12] = "Bullet9",
    [13] = "Bullet8",
    [14] = "Bullet7",
    [15] = "Bullet6",
    [16] = "Bullet5",
    [17] = "Bullet4",
    [18] = "Bullet3",
    [19] = "Bullet2",
    [20] = "Bullet1",
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        Time = 1.7,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reloadpart",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        Time = 2.3,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKEaseIn = 0.2,
        LHIKOut = 0.2,
        LHIKEaseOut = 0.2,
        LastClip1OutTime = 1,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        Time = 3,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        LHIKEaseOut = 0.2,
        LastClip1OutTime = 1,
    },
    ["enter_inspect"] = {
        LHIK = false,
    },
    ["idle_inspect"] = {
        LHIK = false,
    },
    ["exit_inspect"] = {
        LHIK = false,
    },
}

sound.Add({
    name = "Weapon_VSV.CA",
    channel = 16,
    volume = 1.0,
    sound = "VSV/VSVCA.wav"
})

sound.Add({
    name = "Weapon_VSV.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "VSV/VSVClipout.wav"
})

sound.Add({
    name = "Weapon_VSV.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "VSV/VSVClipin.wav"
})

sound.Add({
    name = "VSV.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "VSV/cliphit.wav"
})