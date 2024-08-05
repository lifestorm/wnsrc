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
SWEP.Category = "Willard - Overwatch Weapons" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "AR2"
SWEP.TrueName = "OSIPR"
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "Dark Energy powered assault rifle manufactured by the Combine. The OSIPR is essentially a Combine variant of current assault rifles, commonly issued to Overwatch Soldiers and Overwatch Elites."
SWEP.Trivia_Manufacturer = "The Combine"
SWEP.Trivia_Calibre = "Dark Energy"
SWEP.Trivia_Mechanism = "Thumper and Capsules"
SWEP.Trivia_Country = "Bulgaria"
SWEP.Trivia_Year = 2020

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
    SWEP.Trivia_Manufacturer = "Overwatch"
end

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/ArcCW/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/ArcCW/w_irifle.mdl"
SWEP.ViewModelFOV = 60

SWEP.Damage = 20
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 250 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1100 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.Tracer = AR2Tracer -- override tracer effect
SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 45
SWEP.ReducedClipSize = 15

SWEP.Recoil = 0.45
SWEP.RecoilSide = 0.55
SWEP.RecoilRise = 1
SWEP.RecoilPunch = 2.5

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

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 95 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 225

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "type2" -- the magazine pool this gun draws from

SWEP.ShootVol = 115 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/ArcCW/fire1.wav"
SWEP.ShootSoundSilenced = "weapons/arccw/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "weapons/arccw/ak47/ak47-1-distant.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = "models/weapons/arccw/irifleshell.mdl"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.94
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.33
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 1

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-5.131, -9.03, 2.267),
    Ang = Angle(-0.066, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 3, 0)
SWEP.ActiveAng = Angle(2, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 27

SWEP.AttachmentElements = {
    ["extendedmag"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
    ["reducedmag"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        WMBodygroups = {{ind = 1, bg = 2}},
    },
    ["mount"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw/atts/mount_ak.mdl",
                Bone = "ar2_weapon",
                Scale = Vector(-1, -1, 1),
                Offset = {
                    pos = Vector(4, 3.75, 0),
                    ang = Angle(180, 180, -90)
                }
            }
        },
        WMElements = {
            {
                Model = "models/weapons/arccw/atts/mount_ak.mdl",
                Scale = Vector(-1, -1, 1),
                Offset = {
                    pos = Vector(5.714, 0.73, -6),
                    ang = Angle(171, 0, -1)
                }
            }
        },
    },
    ["fcg_semi"] = {
        TrueNameChange = "Vepr-KM",
        NameChange = "Wasp-2",
    }
}

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic", "optic_lp"}, -- what kind of attachments can fit here, can be string or table
        Bone = "ar2_weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 3.75, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(180, 180, -90),
            wpos = Vector(7, 0, -7), -- offset that the attachment will be relative to the bone
            wang = Angle(170, 180, 0),
        },
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Stock",
        Slot = "stock",
        DefaultAttName = "Standard Stock"
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "ar2_weapon",
        Offset = {
            vpos = Vector(15, 0, 0.5), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(15.625, -0.1, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"ubgl", "foregrip"},
        Bone = "ar2_weapon",
        Offset = {
            vpos = Vector(-5, 1, 1),
            vang = Angle(180, 180, -40),
            wpos = Vector(5, 1.1, -6.298),
            wang = Angle(-8.829, -0.556, -90)
        },
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
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.4,
        SoundTable = {{s = "weapons/arccw/ak47/ak47_draw.wav", t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = "draw",
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = {"fire1", "fire2", "fire3", "fire4"},
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire1", "fire2", "fire3", "fire4"},
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        SoundTable = {{s = "weapons/ArcCW/npc_ar2_reload.wav", t = 0}},
        Time = 2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 37,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reloadempty",
        SoundTable = {{s = "weapons/ArcCW/npc_ar2_reload.wav", t = 0}},
        Time = 2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 37,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
}