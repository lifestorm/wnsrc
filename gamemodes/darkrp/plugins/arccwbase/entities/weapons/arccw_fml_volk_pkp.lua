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
SWEP.Category = "Willard - Special Weaponry" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Volk-ed PKP"
SWEP.Trivia_Class = "Energy Machine Gun"
SWEP.Trivia_Desc = "Belt-fed fully automatic energy weapon. Can not penetrate. Damage increase over long distance"
SWEP.Trivia_Manufacturer = "Some guy with a volk and pkp"
SWEP.Trivia_Calibre = "Energy Cells"
SWEP.Trivia_Mechanism = "Magic"
SWEP.Trivia_Country = "The Motherland"
SWEP.Trivia_Year = 2077

SWEP.CrouchPos = Vector(-1, 3, -0.5)
SWEP.CrouchAng = Angle(0, 0, -15)

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/fml/c_volked_pkp.mdl"
SWEP.WorldModel = "models/weapons/arccw/fml/w_volked_pkp.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "00000000"
SWEP.DefaultWMBodygroups = "00000000"

SWEP.Damage = 15
SWEP.DamageMin = 15
SWEP.Range = 500 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 900 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 120
SWEP.ReducedClipSize = 60

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.15
SWEP.RecoilRise = 0.75

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 0
    }
}

SWEP.CustomizePos = Vector(10, 2, -3)

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 80

SWEP.AccuracyMOA = 3.5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 700 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 220

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "m200b" -- the magazine pool this gun draws from

SWEP.ShootVol = 70 -- volume of shoot sound
SWEP.ShootPitch = 120 -- pitch of shoot sound

SWEP.ShootSound = "weapons/fml_pkp_volk/fire.wav"
SWEP.ShootSoundSilenced = "weapons/fml_pkp_volk/ak74_suppressed_fp.wav"
SWEP.DistantShootSound = "weapons/arccw/negev/negev-1-distant.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/weapons/arccw/fml/shell_volked_pkp.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.65
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.475

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    [6] = "Weapon_Bullet0",
    [5] = "Weapon_Bullet",
    [4] = "Weapon_Bullet2",
    [3] = "Weapon_Bullet3",
    [2] = "Weapon_Bullet4",
    [1] = "Weapon_Bullet5",
}

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-2.523, -3, 0.469),
    Ang = Angle(0, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.MeleeTime = 0.5
SWEP.MeleeAttackTime = 0.1

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 5, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(8, -2, -4.011)
SWEP.HolsterAng = Angle(1.898, 54.613, -10.113)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 32

SWEP.AttachmentElements = {
    ["bkrail"] = {
     VMElements = {
        {
            Model = "models/weapons/arccw/atts/backup_rail.mdl",
              Bone = "Weapon_Main",
             Offset = {
                 pos = Vector(0, -3.8, 12),
                ang = Angle(180, 90, 180),
           },
		 },
      }
    },	
}

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp", "optic"}, -- what kind of attachments can fit here, can be string or table
        Bone = "Weapon_Lid", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, -0.5, -1.5), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(7, 0.9, -6),
            wang = Angle(-9.738, -1, 180)
        },
        InstalledEles = {"nors"},
        CorrectiveAng = Angle(0, 0, 0),
		ExtraSightDist = 3		
    },
    {
        PrintName = "Backup Optic", -- print name
        Slot = {"optic_lp"}, -- what kind of attachments can fit here, can be string or table
        Bone = "Weapon_Main", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.6, -4.2, 12), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -45),
            wpos = Vector(3, 0.832, -2),
            wang = Angle(-10.393, 0, 180)
        },	
        InstalledEles = {"bkrail"},		
        KeepBaseIrons = true,
		ExtraSightDist = 12	
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "Weapon_Main",
        Offset = {
            vpos = Vector(0, -2, 22),
            vang = Angle(90, 0, -90),
            wpos = Vector(25, 0.825, -7.5),
            wang = Angle(-9.738, -1, 180)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl", "bipod"},
        Bone = "Weapon_Main",
        Offset = {
            vpos = Vector(0, -1, 14.738),
            vang = Angle(90, 0, -90),
            wpos = Vector(14.329, 0.602, -4.453),
            wang = Angle(-10.216, 0, 180)
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Weapon_Main",
        Offset = {
            vpos = Vector(-0.5, 0, 22), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(17, 2, -7),
            wang = Angle(-10.393, 0, -90)
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
        DefaultAttName = "None",
        Slot = {"charm", "fml_charm"},
        Bone = "Weapon_Main",
        Offset = {
            vpos = Vector(1, -2, 4),
            vang = Angle(90, 0, -90),
            wpos = Vector(8, 1, -3),
            wang = Angle(-9, 0, 180)
        },
		FreeSlot = true,
    },			
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 1
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.35,
        SoundTable = {{s = "weapons/arccw/m249/m249_draw.wav", t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = "deploy",
        Time = 1,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "fire",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "iron",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LastClip1OutTime = 95/60,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LastClip1OutTime = 95/60,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.5,
    },
    ["bash"] = {
        Source = {"melee"},
        Time = 30/60,
    },
}