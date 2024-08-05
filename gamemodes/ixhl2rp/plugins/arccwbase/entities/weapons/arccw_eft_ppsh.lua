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

SWEP.PrintName = "PPSH-41"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "The PPSh-41 (pistolet-pulemyot Shpagina; Russian: Пистолет-пулемёт Шпагина; Shpagin machine pistol ) is a Soviet submachine gun designed by Georgy Shpagin as a cheap, reliable, and simplified alternative to the PPD-40."
SWEP.Trivia_Manufacturer = "Numerous"
SWEP.Trivia_Calibre = "	7.62x25mm Tokarev"
SWEP.Trivia_Mechanism = "Open Bolt"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 1941

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_ppsh/c_eft_ppsh/models/c_eft_ppsh.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 8
SWEP.DamageMin = 8 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 900  -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 35 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 400

SWEP.Recoil = 0.34
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 900 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 20 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 450 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "ppsh" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/arccw_eft/ppsh/tt_fire_indoor_close.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "weapons/arccw_eft/ppsh/tt_fire_indoor_distant.wav"

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

SWEP.SpeedMult = 0.98
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.3

SWEP.IronSightStruct = {
    Pos = Vector(-3.6425, 3, 1.32),
    Ang = Angle(0.75, 0.05, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(0, 3, 0.6)
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
    ["magazine"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
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
    pos = Vector(-6, 4, -7),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}


SWEP.Attachments = {
    {
        PrintName = "Magazine",
        Slot = "eft_ppsh_magazine",
        DefaultAttName = "41-round PPSH magazine",
		Bone = "mod_magazine",
		Offset = {
            vpos = Vector(-0.0, -0, 0),
            vang = Angle(90, 0, -90),
			wpos = Vector(0, 0, 0),
			wang = Angle(-0, 0, 0),
        }
    },
	{
        PrintName = "Caliber",
		DefaultAttName = "7.62x25 - FMJ",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/9x19_Icon.png"),
        Slot = "ammo_eft_762x25"
    }
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
    },
    ["holster"] = {
        Source = "Holster",
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "fire",
        Time = 0.05,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire",
        Time = 0.05,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
		SoundTable = {
			{
            s = "weapons/arccw_eft/ppsh/kedr_magrelease_button.wav",
            t = 0.8
			},
            {
            s = "weapons/arccw_eft/ppsh/kedr_magout.wav",
            t = 0.9
			},
			{
			s = "weapons/arccw_eft/ppsh/kedr_magin.wav",
			t = 2.6
			}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
		SoundTable = {
			{
            s = "weapons/arccw_eft/ppsh/kedr_magrelease_button.wav",
            t = 0.8
			},
            {
            s = "weapons/arccw_eft/ppsh/kedr_magout.wav",
            t = 0.9
			},
			{
			s = "weapons/arccw_eft/ppsh/kedr_magin.wav",
			t = 2.6
			},
			{
			s = "weapons/arccw_eft/ppsh/kedr_slider_jam.wav",
			t = 4.3
			}
        },
    },
    ["reload_extended"] = {
        Source = "reload_extended",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
		SoundTable = {
			{
            s = "weapons/arccw_eft/ppsh/kedr_magrelease_button.wav",
            t = 0.8
			},
            {
            s = "weapons/arccw_eft/ppsh/kedr_magout.wav",
            t = 0.9
			},
			{
			s = "weapons/arccw_eft/ppsh/kedr_magin.wav",
			t = 2.6
			}
        },
    },
    ["reload_extended_empty"] = {
        Source = "reload_extended_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
		SoundTable = {
			{
            s = "weapons/arccw_eft/ppsh/kedr_magrelease_button.wav",
            t = 0.8
			},
            {
            s = "weapons/arccw_eft/ppsh/kedr_magout.wav",
            t = 0.9
			},
			{
			s = "weapons/arccw_eft/ppsh/kedr_magin.wav",
			t = 2.6
			},
			{
			s = "weapons/arccw_eft/ppsh/kedr_slider_jam.wav",
			t = 4.3
			}
        },
    },
	["1_to_2"] = {
		Source = "firemode",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["2_to_1"] = {
		Source = "firemode_alt",
	    LHIK = false,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
	},
	["enter_inspect"] = {
		Source = "inspect_begin",
	    LHIK = true,
        LHIKIn = 1,
        LHIKOut = 0,
	},
	["idle_inspect"] = {
		Source = "inspect_idle",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["exit_inspect"] = {
		Source = "inspect_end",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
	},
}

sound.Add({
    name = "ARCCW_GO_MP5.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_Slideback.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Slideforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_Slideforward.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_MP5.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mp5/mp5_cliphit.wav"
})