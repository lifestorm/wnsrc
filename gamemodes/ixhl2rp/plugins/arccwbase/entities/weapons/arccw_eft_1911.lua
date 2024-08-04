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

SWEP.PrintName = "M1911"
SWEP.TrueName = "M1911"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Commonly known simply as Colt, the M1911 is one of the most famous handguns on the planet. It went through both World War's as a standard-issue US Army pistol, and despite that it was replaced in 1986, its further variations are still a sidearm of choice in different US Special Forces. M1911A1 is the further generation of a M1911 pistol, after World War I, the military's Model 1911 went through various changes including shorter trigger with frame cuts, improved sights, an arched mainspring housing and a redesigned grip safety."
SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Short Recoil"
SWEP.Trivia_Country = "Italy"
SWEP.Trivia_Year = 1911

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_1911/c_eft_1911/models/c_eft_1911.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 13
SWEP.DamageMin = 13 -- damage done at maximum range
SWEP.Range = 100 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 12 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 17

SWEP.PhysBulletMuzzleVelocity = 200

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.Recoil = 1.0
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.3
SWEP.RecoilPunch = -2

SWEP.Delay = 60 / 350 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "1911" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "weapons/m1911/m1911_fp.wav"
SWEP.ShootSound = "weapons/m1911/m1911_fp.wav"
SWEP.ShootSoundSilenced = "weapons/m1911/m1911_silenced_fp.wav"
SWEP.DistantShootSound = "weapons/m1911/m1911_dist.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.75
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.99
SWEP.SightedSpeedMult = 0.85
SWEP.SightTime = 0.2

SWEP.IronSightStruct = {
    Pos = Vector(-3.725, 2.5, 2.025),
    Ang = Angle(1, 0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 2, 1.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)
SWEP.BarrelOffsetCrouch = Vector(0, 0, -2)

SWEP.CustomizePos = Vector(0, 2, 0.5)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 26

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    [1] = "patron_001",
    [2] = "patron_002"
}

SWEP.AttachmentElements = {
    ["default_barrel"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
    ["optic_mount"] = {
        VMBodygroups = {{ind = 10, bg = 1}},
    },
    ["trigger_mount"] = {
        VMBodygroups = {{ind = 9, bg = 1}},
    },
    ["default_mag"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
    },
    ["default_hammer"] = {
        VMBodygroups = {{ind = 7, bg = 1}},
    },
    ["default_trigger"] = {
        VMBodygroups = {{ind = 8, bg = 1}},
    },
    ["default_grip"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["default_catch"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
}

SWEP.ExtraSightDist = 20
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12.5, 4, -2.5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = "eft_optic_small", -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.075, 21, 1.5),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        SlideAmount = { -- how far this attachment can slide in both directions.
            -- overrides Offset
            vmin = Vector(-0.075, 20, 1.5),
            vmax = Vector(-0.075, 22, 1.5),
            wmin = Vector(5.5, 0.5, -5.8),
            wmax = Vector(6.5, 0.5, -5.9),
        },
		CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 0),
        InstalledEles = {"optic_mount"},
		ExcludeFlags = {"triggermountattached"},
		GivesFlags = {"opticmountattached"},
    },
    {
        PrintName = "Barrel", -- print name
        DefaultAttName = "Standard Barrel",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/1911_barrel_icon.png"),
        Slot = "eft_barrel_1911", -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.0734, 20.82208, -0.1864),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        InstalledEles = {"default_barrel"},
    },
    {
        PrintName = "Muzzle Device", -- print name
        DefaultAttName = "No Muzzle Device",
        Slot = "eft_muzzle_1911", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_muzzle", -- relevant bone any attachments will be mostly referring to
		RequireFlags = {"barrelthread"},
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
    },
    {
        PrintName = "Catch", -- print name
        DefaultAttName = "Standard Catch",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/1911_catch_icon.png"),
        Slot = "eft_catch_1911", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_catch", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        InstalledEles = {"default_catch"},
	},
    {
        PrintName = "Hammer", -- print name
        DefaultAttName = "Standard Hammer",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/1911_hammer_icon.png"),
        Slot = "eft_hammer_1911", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_hammer", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        InstalledEles = {"default_hammer"},
	},
    {
        PrintName = "Trigger", -- print name
        DefaultAttName = "Standard Trigger",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/1911_trigger_icon.png"),
        Slot = "eft_trigger_1911", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_trigger", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        InstalledEles = {"default_trigger"},
	},
    {
        PrintName = "Grip", -- print name
        DefaultAttName = "Standard Grip",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/1911_grip_icon.png"),
        Slot = "eft_grip_1911", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_pistol_grip", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        InstalledEles = {"default_grip"},
	},
    {
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Tactical",
        Slot = "eft_tactical", -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 23.3, -0.5),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        InstalledEles = {"trigger_mount"},
		ExcludeFlags = {"opticmountattached"},
		GivesFlags = {"triggermountattached"},
    },
    {
        PrintName = "Magazine",
		DefaultAttName = "7-round Mag",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/1911_mag_icon.png"),
        InstalledEles = {"default_mag"},
        Bone = "mod_magazine",
        Offset = {
            vpos = Vector(0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(-5, 0, 0),
        },
        Slot = "eft1911_mag"
    },
    {
        PrintName = "Caliber",
		DefaultAttName = ".45 ACP FMJ",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/9x19_Icon.png"),
        Slot = "ammo_eft_45"
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["idle_empty"] = {
        Source = "idle_empty"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "eft_shared/weap_in.wav",
            t = 0
			}
        },
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "eft_shared/weap_in.wav",
            t = 0
			}
        },
    },
    ["holster"] = {
        Source = "holster",
        LHIK = true,
		Time = 0.5,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "eft_shared/weap_out.wav",
            t = 0
			}
        },
    },
    ["holster_empty"] = {
        Source = "holster_Empty",
        LHIK = true,
		Time = 0.5,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "eft_shared/weap_out.wav",
            t = 0
			}
        },
    },
    ["ready"] = {
        Source = "draw_first",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "weapons/eft_shared/grach_catch_slider.wav",
            t = 0.65
			},
            {
            s = "weapons/eft_shared/grach_catch_slider.wav",
            t = 0.8
			}
        },
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.2,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot",
        Time = 0.2,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_dry",
        Time = 0.1,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_dry",
        Time = 0.1,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        SoundTable = {
            {
            s = "weapons/eft_shared/grach_mag_button.wav",
            t = 0.35
			},
            {
            s = "weapons/eft_shared/grach_mag_out.wav",
            t = 0.37
            },
			{
			s = "weapons/eft_shared/grach_mag_pullout.wav",
			t = 0.4
			},
			{
			s = "weapons/eft_shared/grach_mag_pullin.wav",
			t = 1.9
			},
			{
			s = "weapons/eft_shared/grach_mag_in.wav",
			t = 2
			}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		LastClip1OutTime = 1, -- when should the belt visually replenish on a belt fed
		Time = 3.7,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        SoundTable = {
            {
            s = "weapons/eft_shared/grach_mag_button.wav",
            t = 0.35
			},
            {
            s = "weapons/eft_shared/grach_mag_out.wav",
            t = 0.37
            },
			{
			s = "weapons/eft_shared/grach_mag_pullout.wav",
			t = 0.4
			},
			{
			s = "weapons/eft_shared/grach_mag_pullin.wav",
			t = 2.1
			},
			{
			s = "weapons/eft_shared/grach_mag_in.wav",
			t = 2.2
			},
			{
			s = "weapons/eft_shared/grach_catch_button.wav",
			t = 2.9
			},
			{
			s = "weapons/eft_shared/grach_catch_slider.wav",
			t = 3
			}
        },
    },
    ["reload_long"] = {
        Source = "reload_extended",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		Time = 3,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        SoundTable = {
            {
            s = "weapons/eft_shared/grach_mag_button.wav",
            t = 0.35
			},
            {
            s = "weapons/eft_shared/grach_mag_out.wav",
            t = 0.37
            },
			{
			s = "weapons/eft_shared/grach_mag_pullout.wav",
			t = 0.4
			},
			{
			s = "weapons/eft_shared/grach_mag_pullin.wav",
			t = 2
			},
			{
			s = "weapons/eft_shared/grach_mag_in.wav",
			t = 2.1
			}
        },
    },
    ["reload_long_empty"] = {
        Source = "reload_empty_extended",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		Time = 3.7,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        SoundTable = {
            {
            s = "weapons/eft_shared/grach_mag_button.wav",
            t = 0.35
			},
            {
            s = "weapons/eft_shared/grach_mag_out.wav",
            t = 0.37
            },
			{
			s = "weapons/eft_shared/grach_mag_pullout.wav",
			t = 0.4
			},
			{
			s = "weapons/eft_shared/grach_mag_pullin.wav",
			t = 2.1
			},
			{
			s = "weapons/eft_shared/grach_mag_in.wav",
			t = 2.2
			},
			{
			s = "weapons/eft_shared/grach_catch_button.wav",
			t = 2.9
			},
			{
			s = "weapons/eft_shared/grach_catch_slider.wav",
			t = 3
			}
        },
    },
	["enter_inspect"] = {
		Source = "customise_begin",
	    LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
	},
	["enter_inspect_empty"] = {
		Source = "customise_begin_empty",
	    LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
	},
	["idle_inspect"] = {
		Source = "customise_idle",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["idle_inspect_empty"] = {
		Source = "customise_idle_empty",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["exit_inspect"] = {
		Source = "customise_end",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
	},
	["exit_inspect_empty"] = {
		Source = "customise_end_empty",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
	},
}