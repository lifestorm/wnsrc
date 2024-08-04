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

SWEP.PrintName = "AKS-74u"
SWEP.Trivia_Class = "Carbine"
SWEP.Trivia_Desc = "Reduced version of AKS-74 assault rifle, developed in the early 80s for combat vehicle crews and airborne troops, also became very popular with law enforcement and special forces for its compact size."
SWEP.Trivia_Manufacturer = "Kalashnikov"
SWEP.Trivia_Calibre = "5.45x39mm"
SWEP.Trivia_Mechanism = "blowback-operated"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 1979

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_aks74u/eft_aks74u/models/c_eft_aks74u.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 13
SWEP.DamageMin = 13 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 735  -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 30 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 735

SWEP.Recoil = 0.6
SWEP.RecoilSide = 0.24
SWEP.RecoilRise = 0.35
SWEP.RecoilPunch = 2

SWEP.Delay = 60 / 650 -- 60 / RPM.
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
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "ak74" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/arccw_eft_aks74u/ak74_raw_close.wav"
SWEP.ShootSoundSilenced = "weapons/arccw_eft_aks74u/ak74_silenced_close.wav"
SWEP.DistantShootSound = "weapons/arccw_eft_aks74u/ak74_raw_far1.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_mp5"
SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
     [0] = "patron_in_weapon",
     [1] = "patron_001",
	 [2] = "patron_002",
	 [3] = "patron_003"
}

SWEP.SpeedMult = 0.9
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-3.65, 3, 1.39),
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

SWEP.CrouchPos = Vector(-1, 3, 0.5)
SWEP.CrouchAng = Angle(0, 0, -5)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(0, 4, 0)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 27

SWEP.AttachmentElements = {
	["handguard"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
    },
    ["pgrip"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
    },
    ["magazine"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["Stock_Fold"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["Stock_Gone"] = {
        VMBodygroups = {{ind = 4, bg = 2}},
    },
    ["Mount_scopes"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
    ["No_Mount"] = {
        VMBodygroups = {{ind = 6, bg = 0}},
    },
    ["Remove_Receiver"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
    ["Rear_Mount"] = {
        --VMBodygroups = {{ind = 3, bg = 1}},
        AttPosMods = {
            [1] = {
                vpos = Vector(0, -5, 0.2),
                vang = Angle(90, -90, -90),
            }
        },
    },
    ["b11_handguard"] = {
        --VMBodygroups = {{ind = 3, bg = 1}},
        AttPosMods = {
            [5] = {
                vpos = Vector(0, 2.5, -1.3),
                vang = Angle(0, -90, 0),
            },
            [6] = {
                vpos = Vector(1, 3.65, -0.35),
                vang = Angle(90, -90, 0),
            },
            [7] = {
                vpos = Vector(-1, 3.65, -0.35),
                vang = Angle(-90, -90, 0),
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    pos = Vector(-4.3, 4.2, -8),
    ang = Angle(0, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
    scale = 1
}


SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        DefaultAttIcon = Material("vgui/entities/eft_aks74u/ironsight.png"),
        Slot = {"eft_optic_large", "eft_optic_medium", "eft_optic_small"}, -- what kind of attachments can fit here, can be string or table
        Bone = "mod_topmount", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.01, 0, 0.7),
            vang = Angle(90, -90, -90),
        },
		CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(0, 180, 180),
        ExcludeFlags = {"NoReceiver"},
        InstalledEles = {"Mount_scopes"},
    },
    {
        PrintName = "Dust Cover", -- print name
        DefaultAttName = "6P26 Dust Cover",
        DefaultAttIcon = Material("vgui/entities/eft_aks74u/receiver_std.png"),
        Slot = "eft_aks74u_receiever",
        Bone = "mod_reciever", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-0.0, 0, 0),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"Remove_Receiver"},
    },
	{
        PrintName = "Handguard",
		DefaultAttName = "6P26 Handguard",
		DefaultAttIcon = Material("vgui/entities/eft_aks74u/handguard_std.png"),
        InstalledEles = {"handguard"},
        Slot = "eftaks74u_handguard",
		Bone = "mod_handguard", -- relevant bone any attachments will be mostly referring to
        Offset = {
			vpos = Vector(0, 0, 0),
            vang = Angle(0, -90, 0),
        },
    },
    {
        PrintName = "Muzzle Device",
		DefaultAttName = "No Muzzle",
		--DefaultAttIcon = Material("vgui/entities/eft_aks74u/handguard_std.png"),
        Slot = "eft_muzzle_ak545",
		Bone = "mod_handguard", -- relevant bone any attachments will be mostly referring to
        Offset = {
			vpos = Vector(0, 5.8, -0.5),
            vang = Angle(0, -90, 0),
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = "eft_foregrip",
        Bone = "mod_handguard",
        DefaultAttName = "No Underbarrel",
        Offset = {
            vpos = Vector(0, 2.5, -1.7),
            vang = Angle(0, -90, 0)
        },
		RequireFlags = {"lowerrail"},
    },
    {
        PrintName = "Gadget - Left",
        Slot = "eft_tactical",
        Bone = "mod_handguard",
        DefaultAttName = "No Gadget",
        Offset = {
            vpos = Vector(1.1, 3.5, -0.5),
            vang = Angle(90, -90, 0)
        },
		RequireFlags = {"leftrail"},
    },
    {
        PrintName = "Gadget - Right",
        Slot = "eft_tactical",
        Bone = "mod_handguard",
        DefaultAttName = "No Gadget",
        Offset = {
            vpos = Vector(-1.1, 3.5, -0.5),
            vang = Angle(-90, -90, 0)
        },
		RequireFlags = {"rightrail"},
    },
    {
        PrintName = "Magazine",
        Slot = "eft_mag_ak545",
        Bone = "mod_magazine",
        DefaultAttName = "6L20 30-round magazine",
        DefaultAttIcon = Material("vgui/entities/eft_aks74u/mag_std.png"),
        Offset = {
            vpos = Vector(0, 0, -0),
            vang = Angle(0, -90, 0)
        },
        InstalledEles = {"magazine"},
    },
    {
        PrintName = "Pistol Grip",
        Slot = {"eft_ak_pgrip"},
        Bone = "mod_pistol_grip",
        DefaultAttIcon = Material("vgui/entities/eft_aks74u/pgrip_std.png"),
        DefaultAttName = "6P4 Texolite Grip",
        --DefaultAttIcon = Material("vgui/entities/eft_aks74u/stock_unfolded.png"),
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, -90, 0)
        },
        InstalledEles = {"pgrip"},
    },
    {
        PrintName = "Stock",
        Slot = {"eft_aks74u_stock", "eftaks_stock"},
        Bone = "mod_stock",
        DefaultAttName = "Unfolded Stock",
        DefaultAttIcon = Material("vgui/entities/eft_aks74u/stock_unfolded.png"),
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, 0, 0)
        },
        InstalledEles = {"Stock_Gone"},
    },
    {
        PrintName = "Caliber",
        Slot = {"eft_ammo_545x39"},
        Bone = "mod_stock",
        DefaultAttName = "5.45x39mm BP ammo",
        DefaultAttIcon = Material("vgui/entities/eft_attachments/762x51_icon.png"),
        Offset = {
            vpos = Vector(0, 0, 0),
            vang = Angle(0, 0, 0)
        },
    }
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = false,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
    ["holster"] = {
        Source = "holster",
        LHIK = false,
        LHIKIn = 0.5,
        LHIKOut = 0,
    },
    ["ready"] = {
        Source = {"ready_1", "ready_2", "ready_3"},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.8,
		SoundTable = {
            {
            s = "weapons/arccw_eft_aks74u/ak74_slider_up.wav",
            t = 0.6
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_slider_down.wav",
            t = 0.9
			}
        },
    },
    ["fire"] = {
        Source = "fire",
		Time = 0.1,
        FrameRate = 300,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire",
		Time = 0.1,
        FrameRate = 300,
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
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			}
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 1.7, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.2, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			},
			{
			s = "weapons/arccw_eft_aks74u/ak74_slider_up.wav",
			t = 4
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_slider_down.wav",
            t = 4.4
            }
        },
    },
    ["reload_saiga"] = {
        Source = "reload_saiga",
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
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			}
        },
    },
    ["reload_saiga_empty"] = {
        Source = "reload_saiga_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 1.7, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.2, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			},
			{
			s = "weapons/arccw_eft_aks74u/ak74_slider_up.wav",
			t = 4
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_slider_down.wav",
            t = 4.4
            }
        },
    },
    ["reload_6l31"] = {
        Source = "reload_6l31",
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
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			}
        },
    },
    ["reload_6l31_empty"] = {
        Source = "reload_6l31_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 1.7, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.2, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			},
			{
			s = "weapons/arccw_eft_aks74u/ak74_slider_up.wav",
			t = 4
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_slider_down.wav",
            t = 4.4
            }
        },
    },
    ["reload_drum"] = {
        Source = "reload_drum",
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
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			}
        },
    },
    ["reload_drum_empty"] = {
        Source = "reload_drum_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4, -- In/Out controls how long it takes to switch to regular animation.
		LHIKOut = 1.7, -- (not actually inverse kinematics)
		LHIKEaseIn = 0.4, -- how long LHIK eases in.
		LHIKEaseOut = 0.2, -- if no value is specified then ease = lhikin
		Checkpoints = { 0.8, 1.9 },
		SoundTable = {
            {
            s = "weapons/arccw_eft_aks74u/ak74_magrelease_button.wav",
            t = 0.55
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_magout_plastic.wav",
            t = 0.65
            },
			{
			s = "weapons/arccw_eft_aks74u/ak74_magin_plastic.wav",
			t = 2.6
			},
			{
			s = "weapons/arccw_eft_aks74u/ak74_slider_up.wav",
			t = 4
			},
            {
            s = "weapons/arccw_eft_aks74u/ak74_slider_down.wav",
            t = 4.4
            }
        },
    },
	["enter_inspect"] = {
		Source = "customize_begin",
	    LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0,
	},
	["idle_inspect"] = {
		Source = "customize_idle",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["exit_inspect"] = {
		Source = "customize_end",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
	},
}