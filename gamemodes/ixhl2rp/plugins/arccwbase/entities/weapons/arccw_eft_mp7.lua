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
SWEP.Category = "Willard - Modern Weaponry" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP7A1"
SWEP.Trivia_Class = "PDW"
SWEP.Trivia_Desc = "The MP7 is extremely compact, lightweight, can be used in very confined spaces, and is practically recoil-free. It can be carried continuously, making it the ideal personal weapon for the soldier of today. Those who carry it will be suitably armed for the broadest range of operations."
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Calibre = "4.6x30mm"
SWEP.Trivia_Mechanism = "blowback-operated"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 2003

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_mp7/eft_mp7/models/c_eft_mp7.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 10
SWEP.DamageMin = 10 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050  -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 740

SWEP.Recoil = 0.39
SWEP.RecoilSide = 0.091
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 850 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
	{
        Mode = 0,
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 17 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "mp7" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/arccw_eft/mp7/eft_mp7_close.wav"
SWEP.ShootSoundSilenced = "weapons/arccw_eft/mp7/eft_mp7_surpressed.wav"
SWEP.DistantShootSound = "weapons/arccw_eft/mp7/eft_mp7_distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_mp5"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
     [0] = "patron_in_weapon",
     [1] = "patron_001",
	 [2] = "patron_002",
	 [3] = "patron_003",
	 [4] = "patron_004",
	 [5] = "patron_005"
}

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.85
SWEP.SightTime = 0.24

SWEP.IronSightStruct = {
    Pos = Vector(-3.673, 3, 1.06),
    Ang = Angle(0, 0.0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 4, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(0, 3, 0.6)
SWEP.CrouchAng = Angle(0, 0, 5)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(0, 3, 0)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
	["Flip_Sights"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
	["Mag"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
    },
	["Stock"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 6, -4),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-9, 5.5, -8.5),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}


SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
		DefaultAttIcon = Material("vgui/entities/eft_mp7/eft_mp7_sight.png"),
        Slot = {"eft_optic_large", "eft_optic_medium", "eft_optic_small"}, -- what kind of attachments can fit here, can be string or table
        Bone = "mod_sight_front", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vang = Angle(90, -90, -90),
        },
		CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 180),
        SlideAmount = { -- how far this attachment can slide in both directions.
            -- overrides Offset
            vmin = Vector(0, -4, 0),
            vmax = Vector(0, -6.5, 0),
        },
        InstalledEles = {"Flip_Sights"},
    },
	{
        PrintName = "Muzzle",
		DefaultAttName = "Standard Muzzle",
        Slot = "eft_mp7_surpressor",
        Bone = "mod_muzzle",
        Offset = {
            vpos = Vector(-0, 0.5, 0), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 0),
        },
    },
	{
        PrintName = "Tactical - Left",
        Slot = "eft_tactical",
        Bone = "mod_sight_front",
        Offset = {
            vpos = Vector(0.8, -1, -2), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 90),
        },
    },
	{
        PrintName = "Tactical - Right",
        Slot = "eft_tactical",
        Bone = "mod_sight_front",
        Offset = {
            vpos = Vector(-0.8, -1, -2), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, -90),
        },
    },
	{
        PrintName = "Stock",
		DefaultAttName = "Unfolded Stock",
        Slot = "eft_mp7_stock",
		DefaultAttIcon = Material("vgui/entities/eft_mp7/eft_mp7_StockUnFolded.png"),
		InstalledEles = {"Stock"},
    },
	{
        PrintName = "Magazine",
		DefaultAttName = "20-Round Mag",
		DefaultAttIcon = Material("vgui/entities/eft_mp7/eft_mp7_mag20.png"),
        InstalledEles = {"Magazine_20"},
        Slot = "eft_mag_mp7",
		Bone = "mod_magazine", -- relevant bone any attachments will be mostly referring to
        Offset = {
			vpos = Vector(0, 0, 0),
            vang = Angle(90, -90, -90),
        },
        InstalledEles = {"Mag"},
    },
	{
        PrintName = "Caliber",
		DefaultAttName = "4.6x30mm FMJ",
		DefaultAttIcon = Material("vgui/entities/eft_mp7/eft_mp7_bullet.png"),
        Slot = "ammo_eft_46x30"
    }
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["idle_empty"] = {
        Source = "idle_empty"
    },
	["idle_inspect"] = {
        Source = "inventory_idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = false,
        LHIKIn = 0,
        LHIKOut = 0.9,
    },
    ["holster"] = {
        Source = "holster",
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["ready"] = {
        Source = "draw_first", "draw_first2",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
		SoundTable = {
            {
            s = "weapons/arccw_eft/ump/mp5_weap_bolt_in_slap.wav",
            t = 0.8
			}
        },
    },
    ["fire"] = {
        Source = "fire",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire",
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload_short",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 0.4, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.4, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_release_button.wav",
            t = 0.5
			},
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_out.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_mag_in.wav",
			t = 1.85
			}
        },
    },
    ["reload_empty"] = {
        Source = "reload_short_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 0.8, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.4, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_release_button.wav",
            t = 0.5
			},
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_out.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_mag_in.wav",
			t = 1.85
			},
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_bolt_in_slap.wav",
			t = 3.1
			}
        },
    },
	["reload_extended"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 0.4, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.4, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_release_button.wav",
            t = 0.5
			},
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_out.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_mag_in.wav",
			t = 1.85
			}
        },
    },
    ["reload_extended_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 0.8, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.4, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_release_button.wav",
            t = 0.5
			},
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_out.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_mag_in.wav",
			t = 1.85
			},
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_bolt_in_slap.wav",
			t = 3.1
			}
        },
    },
	["reload_extended2"] = {
        Source = "reload_long",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 0.4, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.4, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_release_button.wav",
            t = 0.5
			},
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_out.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_mag_in.wav",
			t = 1.85
			}
        },
    },
    ["reload_extended2_empty"] = {
        Source = "reload_long_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 0.8, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.4, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_release_button.wav",
            t = 0.5
			},
            {
            s = "weapons/arccw_eft/mp7/mp5_weap_mag_out.wav",
            t = 0.55
            },
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_mag_in.wav",
			t = 1.85
			},
			{
			s = "weapons/arccw_eft/mp7/mp5_weap_bolt_in_slap.wav",
			t = 3.1
			}
        },
    },
	["0_to_1"] = {
		Source = "firemode_1",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["0_to_2"] = {
		Source = "firemode_1",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["1_to_2"] = {
		Source = "firemode_0",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["1_to_0"] = {
		Source = "firemode_0",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["2_to_1"] = {
		Source = "firemode_1",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["2_to_0"] = {
		Source = "firemode_1",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["enter_inspect"] = {
		Source = "inventory_begin",
	    LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0,
	},
	["idle_inspect"] = {
		Source = "inventory_idle",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["exit_inspect"] = {
		Source = "inventory_end",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
	},
}