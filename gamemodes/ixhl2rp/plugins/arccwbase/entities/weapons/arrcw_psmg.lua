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

SWEP.PrintName = "Pulse SMG"
SWEP.TrueName = "Pulse SMG"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "A predecessor to the Pulse Rifle, commonly used by Combine Grunts."
SWEP.Trivia_Manufacturer = "The Combine"
SWEP.Trivia_Calibre = "Dark Energy"
SWEP.Trivia_Mechanism = "Thumper and Capsules"
SWEP.Trivia_Country = "Bulgaria"
SWEP.Trivia_Year = 2015

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
    SWEP.Trivia_Manufacturer = "Overwatch"
end

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_ipistol.mdl"
SWEP.WorldModel = "models/weapons/w_ipistol.mdl"
SWEP.ViewModelFOV = 60

SWEP.MirrorVMWM = nil -- Copy the viewmodel, along with all its attachments, to the worldmodel. Super convenient!
SWEP.MirrorWorldModel = nil -- Use this to set the mirrored viewmodel to a different model, without any floating speedloaders or cartridges you may have. Needs MirrorVMWM
SWEP.HideViewmodel = nil
SWEP.WorldModelOffset = {
    pos = Vector(3, 0, 0),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}

SWEP.Damage = 15
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.Range = 160 -- in METRES
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
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 45
SWEP.ReducedClipSize = 15

SWEP.Recoil = 0.1
SWEP.RecoilSide = 0.45
SWEP.RecoilRise = 1

SWEP.Delay = 60 / 600
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

SWEP.AccuracyMOA = 14 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 350

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "type2" -- the magazine pool this gun draws from

SWEP.ShootVol = 103 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "psmg_fire.wav"
SWEP.ShootSoundSilenced = "weapons/arccw/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "weapons/arccw/ak47/ak47-1-distant.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = "models/weapons/arccw/irifleshell.mdl"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.94
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.25
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
    Pos = Vector(-4.651, -5.829, -0.551),
    Ang = Angle(-0.066, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(3.216, 0.402, -3.82)
SWEP.HolsterAng = Vector(-9.146, 20.402, -26.734)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 27

SWEP.AttachmentElements = {
}

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
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
        Bone = "ipistol",
        Offset = {
            vpos = Vector(0.5, 3, -6), -- offset that the attachment will be relative to the bone
            vang = Angle(-90, 0, 0),
            wpos = Vector(21, 1.1, -2),
            wang = Angle(-8.829, -0.556, 90)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"ubgl", "foregrip"},
        Bone = "ipistol",
        Offset = {
            vpos = Vector(-0, 2, -6),
            vang = Angle(270, 0, -90),
            wpos = Vector(17, 1.1, -3),
            wang = Angle(90, 90, -90)
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
        Time = 1.3,
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
        Source = {"attack1"},
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
        SoundTable = {{s = "psmg_reload.wav", t = 0}},
        Time = 1.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 37,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reload",
        SoundTable = {{s = "psmg_reload.wav", t = 0}},
        Time = 1.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 37,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
}