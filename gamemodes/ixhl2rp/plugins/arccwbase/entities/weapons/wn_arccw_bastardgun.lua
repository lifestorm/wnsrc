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

SWEP.PrintName = "Bastard Gun"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "Submachinegun, 5.45 caliber. It's got poor accuracy and overheats like hell. That's why they call it a Bastard gun, hahah."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "5.45x39mm"
SWEP.Trivia_Mechanism = "Russian Magic"
SWEP.Trivia_Country = "Russia"

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_BastardGun.mdl"
SWEP.WorldModel = "models/weapons/c_BastardGun.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 9
SWEP.DamageMin = 9 -- damage done at maximum range
SWEP.Range = 75 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 250 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 300

SWEP.Recoil = 0.200
SWEP.RecoilSide = 0.100
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 650 -- 60 / RPM.
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

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 14 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 325 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "ump" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "BastardGun/Shoot.wav"
SWEP.ShootSound = "BastardGun/Shoot.wav"
SWEP.ShootSoundSilenced = "BastardGun/Shoots.wav"
SWEP.DistantShootSound = "BastardGun/Shoot.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.300

SWEP.IronSightStruct = {
    Pos = Vector(-7.7, -9.849, 1.6),
    Ang = Angle(-0.201, -0.851, -1.4),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, -1)
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
    ["lastlightpete"] = {
        VMSkin = 1,
        WMSkin = 1,
    },
}

SWEP.ExtraSightDist = 10

SWEP.WorldModelOffset = {
    pos = Vector(-15, 8, -4),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "BastardGun",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -3.4, 14),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"rail"},
        VMScale = Vector(1.25, 1.25, 1.25),
        CorrectiveAng = Angle(-0.5, 0, 0),
        CorrectivePos = Vector(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "BastardGun",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, 0, 14),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "BastardGun",
        Offset = {
            vpos = Vector(-1.201, -2.3, 18),
            vang = Angle(90.5, 0, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "BastardGun",
        Offset = {
            vpos = Vector(0, -2.25, 24),
            vang = Angle(90, 0, -90),
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
        Slot = {"metro_skinpete"},
        DefaultAttName = "Metro 2033",
        FreeSlot = true
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "BastardGun", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.8, -1.3, 0), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
    },
}

SWEP.Jamming = true
SWEP.HeatCapacity = 65
SWEP.HeatDissipation = 12
SWEP.HeatLockout = true
SWEP.HeatDelayTime = 3.5
SWEP.HeatFix = true

SWEP.BulletBones = {
    [1] = "Bullet1",
    [2] = "Bullet2",
    [3] = "Bullet3",
    [4] = "Bullet4",
    [5] = "Bullet5",
    [6] = "Bullet6",
    [7] = "Bullet7",
    [8] = "Bullet8",
    [9] = "Bullet9",
    [10] = "Bullet10",
    [11] = "Bullet11",
    [12] = "Bullet12",
    [13] = "Bullet13",
    [14] = "Bullet14",
    [15] = "Bullet15",
    [16] = "Bullet16",
    [17] = "Bullet17",
    [18] = "Bullet18",
    [19] = "Bullet19",
    [20] = "Bullet20",
    [21] = "Bullet21",
    [22] = "Bullet22",
    [23] = "Bullet23",
    [24] = "Bullet24",
    [25] = "Bullet25",
    [26] = "Bullet26",
    [27] = "Bullet27",
    [28] = "Bullet28",
    [29] = "Bullet29",
    [30] = "Bullet30",
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fix"] = {
        Source = "fix",
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.25,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reloadpartial",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 2.1,
        LHIKEaseOut = 0.3,
        LastClip1OutTime = 1,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 2.5,
        LHIKEaseOut = 0.3,
        LastClip1OutTime = 1,
    },
}

sound.Add({
    name = "BG.BoltPull",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/BoltPull.wav"
})

sound.Add({
    name = "BG.Clip",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/Clip.wav"
})

sound.Add({
    name = "BG.Hit",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/Hit.wav"
})

sound.Add({
    name = "BG.ClipIn",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/ClipIn.wav"
})

sound.Add({
    name = "BG.ClipIn2",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/ClipIn2.wav"
})

sound.Add({
    name = "BG.ClipOut",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/ClipOut.wav"
})

sound.Add({
    name = "BG.ClipOut1",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/ClipOut1.wav"
})

sound.Add({
    name = "BG.ClipOut2",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/ClipOut2.wav"
})

sound.Add({
    name = "BG.Fix",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/Fix.wav"
})

sound.Add({
    name = "BG.Fix1",
    channel = 16,
    volume = 1.0,
    sound = "BastardGun/Fix1.wav"
})