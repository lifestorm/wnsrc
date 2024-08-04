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
SWEP.Category = "Willard - Oldie Weaponry" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Regiment-SD 9mm"
SWEP.TrueName = "MP5SD"
SWEP.Trivia_Class = "Submachine-Gun"
SWEP.Trivia_Desc = "HK MP5 9x19 submachinegun with Navy 3 Round Burst firing mechanism version, which features three-round cutoff. Widely acclaimed model of a submachinegun, primarily known as weapon of GSG9 and similar forces of the world, and famous through frequent appearance in movies and video games."
SWEP.Trivia_Manufacturer = "Heckler and Koch"
SWEP.Trivia_Calibre = "9x19mm"
SWEP.Trivia_Mechanism = "Gas-Operated"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1966

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then SWEP.PrintName = SWEP.TrueName end

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_mp5/c_eft_mp5/models/c_eft_mp5.mdl"
SWEP.WorldModel = "models/weapons/arc_eft_mp5/w_eft_mp5/models/w_eft_mp5.mdl"
SWEP.ViewModelFOV = 54

SWEP.Damage = 10
SWEP.DamageMin = 10 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 400 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.CanFireUnderwater = false

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 50
SWEP.ReducedClipSize = 20

SWEP.Recoil = .36
SWEP.RecoilSide = 0.125
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 800 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -3,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 150

SWEP.AccuracyMOA = 15 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "eft_mp5" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 110 -- pitch of shoot sound

SWEP.FirstShootSound = "weapons/arccw_eft/mp5k/mp5k_suppressed_fp.wav"
SWEP.ShootSound = "weapons/arccw_eft/mp5k/mp5k_suppressed_fp.wav"
SWEP.ShootSoundSilenced = "weapons/arccw_eft/mp5k/mp5k_suppressed_fp.wav"
SWEP.DistantShootSound = "weapons/arccw_eft/mp5k/mp5k_suppressed_tp.wav"

SWEP.GMMuzzleEffect = true
SWEP.MuzzleEffect = ""
SWEP.NoFlash = true
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.SightTime = 0.275

SWEP.SpeedMult = 0.94
SWEP.SightedSpeedMult = 0.75

SWEP.BarrelLength = 24

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = true
SWEP.ProceduralIronFire = true

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-3.642, -2, 2.05),
    Ang = Angle(-0.0, 0.0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG

SWEP.ActivePos = Vector(-1, 0, 2)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(4, -2, 1)
SWEP.HolsterAng = Angle(0, 50, -15)

SWEP.CustomizePos = Vector(-1.2	, 0, 1)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
    ["Mount_scopes"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["Gadget_Mount"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
		WMBodygroups = {{ind = 3, bg = 1}},
    },
    ["Default_Stock"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
		WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["Magazine_30"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
		WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["Magazine_20"] = {
        VMBodygroups = {{ind = 5, bg = 3}},
		WMBodygroups = {{ind = 5, bg = 3}},
    },
    ["extendedmag"] = {
        VMBodygroups = {{ind = 5, bg = 2}},
		WMBodygroups = {{ind = 5, bg = 2}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"eft_optic_large", "eft_optic_medium", "eft_optic_small"}, -- what kind of attachments can fit here, can be string or table
        Bone = "mod_reciever", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vang = Angle(90, -90, -90),
            wang = Angle(-5, 0, 180)
        },
		CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 180),
        SlideAmount = { -- how far this attachment can slide in both directions.
            -- overrides Offset
            vmin = Vector(0, 0.5, 3.65),
            vmax = Vector(0, -1.6, 3.7),
            wmin = Vector(5.5, 0.5, -5.8),
            wmax = Vector(6.5, 0.5, -5.9),
        },
        InstalledEles = {"Mount_scopes"},
    },
    {
        PrintName = "Tactical",
        Slot = "eft_tactical",
        Bone = "mod_reciever",
        Offset = {
            vpos = Vector(0, 10, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 0),
            wpos = Vector(16.65, 0.5, -4),
            wang = Angle(-5, 0, 180),
        },
        InstalledEles = {"Gadget_Mount"},
    },
    {
        PrintName = "Stock",
        Slot = "eftmp5_stock",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/A2_StockIcon.png"),
        Bone = "mod_stock",
		DefaultAttName = "A2 Stock",
        Offset = {
            vpos = Vector(0, 0, 0), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 0),
            wpos = Vector(2, 0.5, -3),
            wang = Angle(-5, 0, 180)
        },
        InstalledEles = {"Default_Stock"},
    },
    {
        PrintName = "Magazine",
		DefaultAttName = "30-Round Mag",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/MP5_30Mag_Icon.png"),
        InstalledEles = {"Magazine_30"},
        Slot = "eftmp5_mag"
    },
    {
        PrintName = "Caliber",
		DefaultAttName = "9x19 Pst Gzh",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/9x19_Icon.png"),
        Slot = "ammo_eft_9x19"
    }
}

SWEP.Animations = {
    ["idle"] = {
		Source = false
	},
    ["ready"] = {
        Source = "draw_first",
        Time = 1.5,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltback.wav",
            t = 0.3
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltrelease.wav",
            t = 0.
			}
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_dry",
        Time = 1,
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 1,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_dry",
        Time = 1,
    },
    ["reload"] = {
        Source = "reload",
        Time = 3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        FrameRate = 24,
        LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_magrelease.wav",
            t = 0.35
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_magout.wav",
            t = 0.4
            },
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magin.wav",
			t = 1.8
			}
        },
    },
    ["reload_long"] = {
        Source = "reload_extended",
        Time = 3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        FrameRate = 24,
        LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_magrelease.wav",
            t = 0.35
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_magout.wav",
            t = 0.4
            },
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magin.wav",
			t = 1.8
			}
        },
    },
    ["reload_short"] = {
        Source = "reload_decreased",
        Time = 3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        FrameRate = 24,
        LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_magrelease.wav",
            t = 0.35
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_magout.wav",
            t = 0.4
            },
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magin.wav",
			t = 1.8
			}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 4,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        FrameRate = 24,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltback.wav",
            t = 0.45
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltlock.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magout.wav",
			t = 1.1
			},
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magin.wav",
			t = 2.5
			},
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_boltrelease.wav",
			t = 3.5
			}
        },
        LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.6,
    },
    ["reload_long_empty"] = {
        Source = "reload_empty_extended",
        Time = 4,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        FrameRate = 24,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltback.wav",
            t = 0.45
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltlock.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magout.wav",
			t = 1.1
			},
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magin.wav",
			t = 2.5
			},
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_boltrelease.wav",
			t = 3.5
			}
        },
        LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.6,
    },
    ["reload_short_empty"] = {
        Source = "reload_empty_decreased",
        Time = 4,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        FrameRate = 24,
        SoundTable = {
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltback.wav",
            t = 0.45
			},
            {
            s = "weapons/arccw_eft/mp5k/handling/mp5k_boltlock.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magout.wav",
			t = 1.1
			},
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_magin.wav",
			t = 2.5
			},
			{
			s = "weapons/arccw_eft/mp5k/handling/mp5k_boltrelease.wav",
			t = 3.5
			}
        },
        LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.6,
    },
	["enter_inspect"] = {
		Source = "customise_begin",
	    LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.6,
	},
	["idle_inspect"] = {
		Source = "customise_idle",
		LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.6,
	},
	["exit_inspect"] = {
		Source = "customise_end",
		LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0.6,
	},
}