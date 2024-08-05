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

SWEP.PrintName = "UMP-45"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "Heckler & Koch UMP - submachine gun, designed by German company Heckler & Koch in the 1990s as a lighter and cheaper analog of the MP5. This version is designed to fire a .45 ACP cartridge and has a reduced to 600 rpm rate of fire."
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "blowback-operated"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 2000

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_ump/eft_ump/models/c_eft_ump.mdl"
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 12
SWEP.DamageMin = 12 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 700  -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 400

SWEP.Recoil = 0.275
SWEP.RecoilSide = 0.125
SWEP.RecoilRise = 0.1
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
        Mode = 0,
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 14 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 300 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "ppsh" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/arccw_eft/ump/gyrza_close1.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "weapons/arccw_eft/ump/gyrza_distant1.wav"

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
	 [5] = "patron_005",
	 [6] = "patron_006",
	 [7] = "patron_007",
	 [8] = "patron_008",
	 [9] = "patron_009",
	 [10] = "patron_010",
	 [11] = "patron_011",
	 [12] = "patron_012",
	 [13] = "patron_013",
     [14] = "patron_014",
	 [15] = "patron_015",
	 [16] = "patron_016",
	 [17] = "patron_017",
	 [18] = "patron_018",
	 [19] = "patron_019",
	 [20] = "patron_020",
	 [21] = "patron_021",
	 [22] = "patron_022",
	 [23] = "patron_023",
	 [24] = "patron_024",
	 [25] = "patron_025"
}

SWEP.SpeedMult = 0.96
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.3

SWEP.IronSightStruct = {
    Pos = Vector(-3.6425, 3, 1.7),
    Ang = Angle(0, 0.0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

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

SWEP.BarrelLength = 30

SWEP.AttachmentElements = {

}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 6, -4),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-6, 4, -8.5),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}


SWEP.Attachments = {
	{
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
		DefaultAttIcon = Material("vgui/entities/eft_ump/eft_ump_iron.png"),
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
            vmin = Vector(0, -4.5, 3),
            vmax = Vector(0, -1, 3),
        },
    },
	{
        PrintName = "Tactical - Left",
        Slot = "eft_tactical",
        Bone = "mod_reciever",
        Offset = {
            vpos = Vector(1, 4, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 90),
        },
    },
	{
        PrintName = "Tactical - Right",
        Slot = "eft_tactical",
        Bone = "mod_reciever",
        Offset = {
            vpos = Vector(-1.1, 4, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, -90),
        },
    },
	{
        PrintName = "Underbarrel",
        Slot = "eft_foregrip",
        Bone = "mod_reciever",
        DefaultAttName = "No Underbarrel",
        Offset = {
            vpos = Vector(0, 5, 0.1),
            vang = Angle(90, -90, -90),
        },
    },
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
            s = "weapons/arccw_eft/ump/mp5_weap_mag_release_button.wav",
            t = 0.35
			},
            {
            s = "weapons/arccw_eft/ump/mp5_weap_mag_out.wav",
            t = 0.4
            },
			{
			s = "weapons/arccw_eft/ump/mp5_weap_mag_in.wav",
			t = 2
			}
        },
    },
    ["reload_empty"] = {
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
            s = "weapons/arccw_eft/ump/mp5_weap_mag_release_button.wav",
            t = 0.35
			},
            {
            s = "weapons/arccw_eft/ump/mp5_weap_mag_out.wav",
            t = 0.4
            },
			{
			s = "weapons/arccw_eft/ump/mp5_weap_mag_in.wav",
			t = 2
			},
			{
			s = "weapons/arccw_eft/ump/mp5_weap_bolt_in_slap.wav",
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