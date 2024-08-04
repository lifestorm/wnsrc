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

SWEP.PrintName = "Duplet"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "The 12-gauge shotgun is one of the best close combat weapons ever. A blast from both of its barrels can kill almost any mutant on the spot."
SWEP.Trivia_Manufacturer = "Unknown"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Break-Action"

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_duplet.mdl"
SWEP.WorldModel = "models/weapons/c_duplet.mdl"
SWEP.ViewModelFOV = 60

SWEP.Damage = 7
SWEP.DamageMin = 7 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1100 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 2 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 2
SWEP.ReducedClipSize = 1

SWEP.Recoil = 2.5
SWEP.RecoilSide = 1
SWEP.MaxRecoilBlowback = 2

SWEP.AccuracyMOA = 45 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 600 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Delay = 60 / 600 -- 60 / RPM.
SWEP.Num = 8 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        PrintName = "SNGL",
        Mode = 1,
    },
    {
        PrintName = "BOTH",
        Mode = -2,
        RunawayBurst = true,
        Override_ShotRecoilTable = {
            [1] = 0.25
        }
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {"weapon_annabelle", "weapon_shotgun"}
SWEP.NPCWeight = 100

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "Duplet/Shoot.wav"
SWEP.ShootSound = "Duplet/Shoot1.wav"
SWEP.DistantShootSound = "Duplet/Shoot.wav"

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.94
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.30

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.RevolverReload = true

SWEP.BulletBones = {
    [1] = "Buckshot1",
    [2] = "Buckshot2"
}

SWEP.CaseBones = {
    [1] = "Buckshot1",
    [2] = "Buckshot2"
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(1, 12, -2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-3, 3, 0)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3.5, 2, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.WorldModelOffset = {
    pos = Vector(-5, 7.5, -4),
    ang = Angle(-15, 0, -180)
}

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.AttachmentElements = {
        ["lastlightd"] = {
        VMSkin = 1,
        WMSkin = 1,
    },
}

SWEP.ShootVol = 130 -- volume of shoot sound

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.80
SWEP.SightTime = 0.225

SWEP.BarrelLength = 24

SWEP.IronSightStruct = {
    Pos = Vector(-7.591, -4.824, 2),
    Ang = Angle(-0.704, -3, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp", "optic"}, -- what kind of attachments can fit here, can be string or table
        Bone = "Optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 0.2, 2), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(13.762, 0.5, -6.102),
            wang = Angle(-15, 0, 180)
        },
    },
    {
        PrintName = "Choke",
        DefaultAttName = "Standard Choke",
        Slot = "choke",
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "style_pistol"},
        Bone = "Optic",
        Offset = {
            vpos = Vector(0, 3.635, 3.635),
            vang = Angle(90, 0, -90),
            wpos = Vector(14.329, 0.8, -4.453),
            wang = Angle(-15, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Optic",
        Offset = {
            vpos = Vector(-1.5, 0.8, 3.6), -- offset that the attachment will be relative to the bone
            vang = Angle(92, 0, 180),
            wpos = Vector(20, -0.6, -7.5),
            wang = Angle(-15, -3, 90)
        },
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Ammo Type",
        Slot = "ammo_shotgun"
    },
    {
        PrintName = "Perk",
        Slot = "perk",
        DefaultAttName = "None"
    },
    {
        PrintName = "Skin",
        Slot = {"metro_skind"},
        DefaultAttName = "Metro 2033",
        FreeSlot = true
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "Optic", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.42, 2.3, 7.8), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(18, 1.3, -5.7),
            wang = Angle(-15, 0, 180)
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.5,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
        SoundTable = {{s = "weapons/arccw/nova/nova_draw.wav", t = 0}},
    },
    ["ready"] = {
        Source = "ready",
        Time = 3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
        SoundTable = {{s = "weapons/arccw/nova/nova_draw.wav", t = 0}},
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.4,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 0.4,
    },
    ["reload"] = {
        Source = "reload_part",
        Time = 2.15,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        Checkpoints = {28, 64, 102},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        LastClip1OutTime = 0.4,
    },
    ["reload_empty"] = {
        Source = "reload",
        Time = 2.6,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        Checkpoints = {28, 64, 102},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        LastClip1OutTime = 0.4,
    },
}

sound.Add({
    name = "Weapon_Duplet.Lever",
    channel = 16,
    volume = 1.0,
    sound = "Duplet/Lever.wav"
})

sound.Add({
    name = "Weapon_Duplet.Load",
    channel = 16,
    volume = 1.0,
    sound = "Duplet/Load.wav"
})

sound.Add({
    name = "Weapon_Duplet.In",
    channel = 16,
    volume = 1.0,
    sound = "Duplet/In.wav"
})

sound.Add({
    name = "Weapon_Duplet.Out",
    channel = 16,
    volume = 1.0,
    sound = "Duplet/Out.wav"
})