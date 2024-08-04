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

SWEP.PrintName = "T-5000"
SWEP.Trivia_Class = "Bolt-Action Sniper"
SWEP.Trivia_Desc = "High-accuracy ORSIS T-5000 rifle is an outstanding result of our company designers' efforts. This model was created in cooperation with professional shooters and has the properties required for a customer in the Russian market. T-5000 model is a hand-reloaded repeater with sliding breech bolt and two front locking lugs. It is a multi-purpose weapon. Its specifications provide high-accuracy long-range shots (up to 1500m), high level of shooter's convenience while preparatory, firing and recoil phases, swift sighting line recovery, excellent reliability and ergonomics."
SWEP.Trivia_Manufacturer = "ORSIS"
SWEP.Trivia_Calibre = "7.62x51mm NATO"
SWEP.Trivia_Mechanism = "bolt-Action"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 2011

SWEP.Slot = 3

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_t5000/eft_t5000/models/c_eft_t5000.mdl"
SWEP.WorldModel = "models/weapons/w_snip_scout.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-9, 5.5, -8.5),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "0000000000"

SWEP.Damage = 70
SWEP.DamageMin = 70 -- damage done at maximum range
SWEP.Range = 150 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 826 -- projectile or phys bullet muzzle velocity

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 5 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 10

SWEP.Recoil = 6
SWEP.RecoilSide = 1.5
SWEP.RecoilRise = 4
SWEP.VisualRecoilMult = 1

SWEP.Delay = 60 / 45-- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = {
    "weapon_ar2",
    "weapon_crossbow",
}
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 650 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses
SWEP.MagID = "T5000" -- the magazine pool this gun draws from

SWEP.ShootVol = 115 -- volume of shoot sound

SWEP.ShootSound = "weapons/arccw_eft_t5000/sv98_fire_close.wav"
SWEP.ShootSoundSilenced = "weapons/arccw_eft_t5000/rsass_indoor_close_silenced1.wav"
SWEP.DistantShootSound = "weapons/arccw_eft_t5000/sv98_fire_far.wav"

SWEP.MuzzleEffect = "muzzleflash_4"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewBobAttachment = 1
SWEP.CamAttachment = 3

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.6
SWEP.SightTime = 0.24

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
     [0] = "patron_in_weapon",
     [1] = "patron_001",
	 [2] = "patron_002",
	 [3] = "patron_003"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false
SWEP.ShotgunReload = false

SWEP.ManualAction = true -- pump/bolt action
SWEP.NoLastCycle = true -- do not cycle on last shot

SWEP.CaseBones = {
}

SWEP.IronSightStruct = {
    Pos = Vector(-3.6, -3, 2.75),
    Ang = Angle(0.1, -0.05, 0),
    Magnification = 1.25,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-0, 0, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(5, -2, -2)
SWEP.SprintAng = Angle(0, 30, 0)

SWEP.CustomizePos = Vector(0, 0, 0)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(3, 0, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(0, 0, 0)

SWEP.BarrelLength = 30

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
	["Muzzle"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
}

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"eft_optic_large", "eft_optic_medium", "eft_optic_small"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vang = Angle(90, -90, -90),
        },
		CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 180),
        SlideAmount = { -- how far this attachment can slide in both directions.
            -- overrides Offset
            vmin = Vector(0, 18.5, 0.75),
            vmax = Vector(0, 20, 0.75),
        },
    },
	{
        PrintName = "Muzzle Device", -- print name
        DefaultAttName = "Standard Muzzle Device",
		DefaultAttIcon = Material("vgui/entities/eft_t5000/muzzle_t5000_icon.png"),
        Slot = "eft_muzzle_762x51", -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 47.5, -0.25),
            vang = Angle(0, -90, 0),
        },
		InstalledEles = {"Muzzle"},
    },
	{
        PrintName = "Tactical - Right",
        Slot = "eft_tactical",
        Bone = "weapon",
        Offset = {
            vpos = Vector(-1.45, 33, -0.45), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, -90),
        },
    },
    {
        PrintName = "Tactical - Left",
        Slot = "eft_tactical",
        Bone = "weapon",
        Offset = {
            vpos = Vector(1.45, 33, -0.45), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 90),
        },
    },
    {
        PrintName = "Tactical - Top",
        Slot = "eft_tactical_big",
        Bone = "weapon",
        Offset = {
            vpos = Vector(0, 33, 1), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 180),
        },
    },
    {
        PrintName = "Tactical - Bottom",
        Slot = "eft_tactical",
        Bone = "weapon",
        Offset = {
            vpos = Vector(0, 31.8, -1.85), -- offset that the attachment will be relative to the bone
            vang = Angle(0, -90, 0),
        },
    },
	{
        PrintName = "Caliber",
		DefaultAttName = "7.62x51mm M80",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/762x51_icon.png"),
        Slot = "ammo_eft_762x51"
    }
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["holster"] = {
        Source = "holster",
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["ready"] = {
        Source = {"ready_1", "ready_2", "ready_3"},
        LHIK = false,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
		SoundTable = {
		{
            s = "weapons/arccw_eft_t5000/t5000_bolt_1.wav",
            t = 0.9
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_2.wav",
            t = 1
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_3.wav",
            t = 1.1
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_4.wav",
            t = 1.2
			}
		}
    },
    ["fire"] = {
        Source = {"fire"},
    },
    ["cycle"] = {
        Source = {"chamber_1", "chamber_2", "chamber_3"},
        ShellEjectAt = 20 / 30,
		SoundTable = {
		{
            s = "weapons/arccw_eft_t5000/t5000_bolt_1.wav",
            t = 0.4
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_2.wav",
            t = 0.5
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_3.wav",
            t = 0.6
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_4.wav",
            t = 0.7
			}
		}
    },
    ["fire_iron"] = {
        Source = {"fire"},
    },
    ["cycle_ads"] = {
        Source = {"chamber_1", "chamber_2", "chamber_3"},
        ShellEjectAt = 20 / 30,
		SoundTable = {
		{
            s = "weapons/arccw_eft_t5000/t5000_bolt_1.wav",
            t = 0.4
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_2.wav",
            t = 0.5
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_3.wav",
            t = 0.6
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_4.wav",
            t = 0.7
			}
		}
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 30,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
		SoundTable = {
			{
            s = "weapons/arccw_eft_t5000/t5000_magbutton.wav",
            t = 0.6
			},
            {
            s = "weapons/arccw_eft_t5000/t5000_mag_out.wav",
            t = 0.75
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_mag_in.wav",
            t = 2.8
			}
        },
    },
	["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 30,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
		SoundTable = {
            {
            s = "weapons/arccw_eft_t5000/t5000_mag_out.wav",
            t = 0.7
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_mag_in.wav",
            t = 2.3
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_1.wav",
            t = 3.5
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_2.wav",
            t = 3.6
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_3.wav",
            t = 3.7
			},
			{
            s = "weapons/arccw_eft_t5000/t5000_bolt_4.wav",
            t = 3.8
			}
        },
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