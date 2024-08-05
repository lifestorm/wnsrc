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

SWEP.PrintName = "MP-153"
SWEP.TrueName = "MP-153"
SWEP.Trivia_Class = "Semi-automatic shotgun"
SWEP.Trivia_Desc = "Smoothbore multi-shot. MP-153 shotgun, produced by Izhmekh. Reliable and practical hunting and self-defence weapon."
SWEP.Trivia_Manufacturer = "Izhmekh"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Gas-operated Rotating bolt"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 2000

SWEP.Slot = 4

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/darsu_eft/c_mp153.mdl"
SWEP.WorldModel = "models/weapons/arccw/darsu_eft/c_mp153.mdl"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "000000000000"

SWEP.Num = 8 -- number of shots per trigger pull.
SWEP.Damage = 9
SWEP.DamageMin = 9 -- damage done at maximum range
SWEP.RangeMin  = 20 -- in METRES
SWEP.Range = 70 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 4 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8

SWEP.PhysBulletMuzzleVelocity = 415

SWEP.TriggerDelay = false

SWEP.ReloadInSights = true
SWEP.ReloadInSights_FOVMult = 1

SWEP.Recoil = 2.5
SWEP.RecoilSide = 2
SWEP.RecoilRise = 0.3
SWEP.RecoilPunch = 2.5
SWEP.VisualRecoilMult = 10
SWEP.RecoilPunchBackMax = 18
SWEP.RecoilPunchBackMaxSights = 19 -- may clip with scopes

SWEP.Delay = 60 / 120 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 60 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 350 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 300

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses
SWEP.MagID = "MP153" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = {"weapons/darsu_eft/mp153/mr153_fire_close1.wav", "weapons/darsu_eft/mp153/mr153_fire_close2.wav"}
SWEP.ShootSoundSilenced = "weapons/darsu_eft/mp153/mr133_fire_silenced_close.wav"
SWEP.DistantShootSound = {"weapons/darsu_eft/mp153/mr153_fire_distant1.wav", "weapons/darsu_eft/mp153/mr153_fire_distant2.wav"}

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/weapons/arccw/eft_shells/patron_12x70_shell.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.5*0.93

SWEP.IronSightStruct = {
    Pos = Vector(-4.281, -2, 0.681),
    Ang = Angle(0.25, 0.004, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.Jamming = false
SWEP.HeatCapacity = 9
SWEP.HeatDissipation = 0.3
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

SWEP.Malfunction = false
SWEP.MalfunctionJam = false -- After a malfunction happens, the gun will dryfire until reload is pressed. If unset, instead plays animation right after.
SWEP.MalfunctionTakeRound = false -- When malfunctioning, a bullet is consumed.
SWEP.MalfunctionWait = 0 -- The amount of time to wait before playing malfunction animation (or can reload)
SWEP.MalfunctionMean = 48 -- The mean number of shots between malfunctions, will be autocalculated if nil
SWEP.MalfunctionVariance = 0.2 -- The fraction of mean for variance. e.g. 0.2 means 20% variance
SWEP.MalfunctionSound = "weapons/arccw/malfunction.wav"

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0.2, -3.5, 0.7)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1.2, -4.5, 0.2)
SWEP.CrouchAng = Angle(0, 0, -6)

SWEP.HolsterPos = Vector(0.2, -3.5, 0.7)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)
SWEP.BarrelOffsetCrouch = Vector(0, 0, -2)

SWEP.CustomizePos = Vector(0.2, -3.5, 0.7)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 18

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    [1] = {"shellport", "patron_in_weapon"},
}

SWEP.AttachmentElements = {
	["sightmount"] = {VMBodygroups = {{ind = 4, bg = 1}},},
    ["bottommount"] = {VMBodygroups = {{ind = 5, bg = 1}},},

    ["b660"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        AttPosMods = {
            [3] = {
                vpos = Vector(0, 46, 1.8),
                vang = Angle(0, -90, 0),
            },
        },
    },
    ["b710"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        AttPosMods = {
            [3] = {
                vpos = Vector(0, 47.8, 1.8),
                vang = Angle(0, -90, 0),
            },
        },
    },

    ["b750"] = {
        VMBodygroups = {{ind = 1, bg = 3}},
        AttPosMods = {
            [3] = {
                vpos = Vector(0, 49.4, 1.8),
                vang = Angle(0, -90, 0),
            },
        },
    },
    ["m5"] = {VMBodygroups = {{ind = 3, bg = 1}},},
    ["m6"] = {VMBodygroups = {{ind = 3, bg = 2}},},
    ["m7"] = {VMBodygroups = {{ind = 3, bg = 3}},},
    ["m8"] = {VMBodygroups = {{ind = 3, bg = 4}},},

    ["swooden"] = {VMBodygroups = {{ind = 6, bg = 1}},},
    ["spistol"] = {VMBodygroups = {{ind = 6, bg = 2}},},

    ["12rip"] = {VMBodygroups = {{ind = 10, bg = 1}},},
    ["12fl"] = {VMBodygroups = {{ind = 10, bg = 2}},},
    ["12dss"] = {VMBodygroups = {{ind = 10, bg = 3}},},
    ["12bmg"] = {VMBodygroups = {{ind = 10, bg = 4}},},
    ["12ap20"] = {VMBodygroups = {{ind = 10, bg = 5}},},
    ["12ftx"] = {VMBodygroups = {{ind = 10, bg = 6}},},
    ["12g40"] = {VMBodygroups = {{ind = 10, bg = 7}},},
    ["12cop"] = {VMBodygroups = {{ind = 10, bg = 8}},},
    ["12p3"] = {VMBodygroups = {{ind = 10, bg = 9}},},
    ["12p6u"] = {VMBodygroups = {{ind = 10, bg = 10}},},
    ["12sfp"] = {VMBodygroups = {{ind = 10, bg = 11}},},

    ["12lead"] = {VMBodygroups = {{ind = 10, bg = 10}},},
}

SWEP.ExtraSightDist = 6
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-10, 5.5, -2),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.ShotgunReload = true
SWEP.Attachments = {
	{
        PrintName = "Optic", -- print name
        DefaultAttName = "None",
		//DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_sights_standard.png"),
        Slot = {"eft_optic_small", "eft_optic_medium", "eft_optic_large"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
		CorrectiveAng = Angle(0, 180, 0), 
        InstalledEles = {"sightmount"},
        Offset = {
            vpos = Vector(0, 17, 2.7),
            vang = Angle(0, -90, 0),
        },
    },
    {
        PrintName = "Barrel", -- print name
        DefaultAttName = "610mm barrel",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/mp153_b610.png"),
        Slot = "eft_mp153_barrel", -- what kind of attachments can fit here, can be string or table
    },
    {
        PrintName = "Muzzle Device",
        Slot = "eft_muzzle_12g",
        Bone = "weapon",
        DefaultAttName = "None",
        -- DefaultAttIcon = Material("vgui/entities/eft_attachments/att_scarl_muzzle_std.png"),
        Offset = {
            vpos = Vector(0, 44, 1.8),
            vang = Angle(90, -90, -90),
        },
    },
    {
        PrintName = "Magazine", -- print name
        DefaultAttName = "4-shell",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/mp153_m4.png"),
        Slot = "eft_mp153_mag", -- what kind of attachments can fit here, can be string or table
    },    
    {
        PrintName = "Stock", -- print name
        DefaultAttName = "Plastic stock",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/mp153_stock_std.png"),
        Slot = "eft_mp153_stock", -- what kind of attachments can fit here, can be string or table
    },
	{
        PrintName = "Left Tactical", -- print name
        DefaultAttName = "No Tactical",
        Slot = {"eft_tactical"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        InstalledEles = {"bottommount"},
        Offset = {
            vpos = Vector(1.3, 33.5, 1.35),
            vang = Angle(0, -90, 120),
        },
    },
    {
        PrintName = "Bottom Tactical", -- print name
        DefaultAttName = "No Tactical",
        Slot = {"eft_tactical"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        InstalledEles = {"bottommount"},
        Offset = {
            vpos = Vector(0, 33.5, -.9),
            vang = Angle(0, -90, 0),
        },
    },
    {
        PrintName = "Right Tactical", -- print name
        DefaultAttName = "No Tactical",
        Slot = {"eft_tactical"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        InstalledEles = {"bottommount"},
        Offset = {
            vpos = Vector(-1.3, 33.5, 1.35),
            vang = Angle(0, -90, 240),
        },
    },
	{
        PrintName = "Ammo",
		DefaultAttName = "12/70 7mm buckshot",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/ammo/12g_def.png"),
        Slot = "ammo_eft_12"
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },

    ["draw"] = {
        Source = "draw",
        Time = 1.2,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_draw.wav",  t = 0},
        },
    },

	["holster"] = {
        Source = "holster",
        Time = 1.2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_holster.wav",  t = 0},
        },
    },

    ["ready"] = {
        Source = {"ready0", "ready1", "ready2"},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_draw.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 0.4},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 0.8},
        },
    },

    ["fire"] = {
        Source = "fire",
        Time = 0.15,
        ShellEjectAt = 0.05,
        SoundTable = {
            {s = "eft_shared/weap_trigger_hammer.wav", t = 0.05}
        },
    },


    ["sgreload_start"] = {
        Source = "reload_start",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
        },
    },    
    ["sgreload_start_empty"] = {
        Source = "reload_start_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr133_shell_pickup.wav",  t = 0.15},
            {s = "weapons/darsu_eft/mp153/mr133_shell_in_port.wav",  t = 0.85},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 1.2},
        },
    },
    ["sgreload_insert"] = {
        Source = "reload_loop",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_shell_pickup.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr133_shell_in_mag2.wav",  t = 0.3},
        },
    },    
    ["sgreload_finish"] = {
        Source = "reload_end",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {s = "eft_shared/weap_handon.wav",  t = 0.1},
        },
    },

	["enter_inspect"] = {
		Source = "enter_inspect",
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
        },
	},

	["idle_inspect"] = {
		Source = "idle_inspect",
	},
	["exit_inspect"] = {
		Source = "exit_inspect",
        SoundTable = {
            {s = "weapons/darsu_eft/mp153/mr133_draw.wav",  t = 0.2},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 1.2},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 1.8},
        },
	},
	["unjam"] = {
		Source = {"jam0","jam1","jam2"},
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 0.8},
            {s = "weapons/darsu_eft/mp153/mr133_shell_out_mag.wav",  t = 1.2},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 1.52},
        },
	},
    ["fix"] = {
		Source = {"misfire0","misfire1","misfire2"},
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        -- ShellEjectAt = 0.8,
        SoundTable = {
            {s = "eft_shared/weap_handoff.wav",  t = 0},
            {s = "weapons/darsu_eft/mp153/mr153_slider_up.wav",  t = 0.7},
            {s = "weapons/darsu_eft/mp153/mr133_shell_out_mag.wav",  t = 0.75},
            {s = "weapons/darsu_eft/mp153/mr153_slider_down.wav",  t = 0.9},
        },
	},
}