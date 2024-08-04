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

SWEP.PrintName = "HK USP .45"
SWEP.TrueName = "HK USP .45"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "The HK USP (Universelle Selbstladepistole - Universal Self-loading Pistol) pistol is a further replacement of the HK P7 series pistols. Internationally accepted as an accurate and ultra-reliable handgun. Using a modified Browning-type action with a special patented recoil reduction system, the USP recoil reduction system reduces recoil effects on pistol components and also lowers the recoil forces felt by the shooter. This particular variant is chambered in .45 ACP. Manufactured by Heckler & Koch."
SWEP.Trivia_Manufacturer = "Heckler & Koch"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Short Recoil"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1989

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc_eft_usp/c_eft_usp.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_m9.mdl"
SWEP.ViewModelFOV = 70

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 15
SWEP.DamageMin = 15 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 17 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 24

SWEP.PhysBulletMuzzleVelocity = 200

SWEP.TriggerDelay = false

SWEP.ReloadInSights = true
SWEP.ReloadInSights_FOVMult = 1

SWEP.Recoil = 1.0
SWEP.RecoilSide = 0.5
SWEP.RecoilRise = 0.24
SWEP.RecoilPunch = 2.5
SWEP.VisualRecoilMult = 12
SWEP.RecoilPunchBackMax = 15
SWEP.RecoilPunchBackMaxSights = 15 -- may clip with scopes

SWEP.Delay = 60 / 450 -- 60 / RPM.
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
SWEP.JumpDispersion = 1000

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "USP" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 110 -- pitch of shoot sound

SWEP.ShootSound = "arc_eft_usp/usp_fire_close_alt.wav"
SWEP.ShootSoundSilenced = "arc_eft_usp/usp_fire_surpressed_alt.wav"
SWEP.DistantShootSound = "arc_eft_usp/usp_fire_distant_alt.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.75
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.SpeedMult = 0.98
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.2

SWEP.IronSightStruct = {
    Pos = Vector(-3.65, 5, 2.17),
    Ang = Angle(0, 0, 0),
    Magnification = 1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.Jamming = false
SWEP.HeatCapacity = 32
SWEP.HeatDissipation = 1
SWEP.HeatLockout = true -- overheating means you cannot fire until heat has been fully depleted
SWEP.HeatFix = true -- when the "fix" animation is played, all heat is restored.

SWEP.Malfunction = false
SWEP.MalfunctionJam = false -- After a malfunction happens, the gun will dryfire until reload is pressed. If unset, instead plays animation right after.
SWEP.MalfunctionTakeRound = false -- When malfunctioning, a bullet is consumed.
SWEP.MalfunctionWait = 0 -- The amount of time to wait before playing malfunction animation (or can reload)
SWEP.MalfunctionMean = 64 -- The mean number of shots between malfunctions, will be autocalculated if nil
SWEP.MalfunctionVariance = 0.2 -- The fraction of mean for variance. e.g. 0.2 means 20% variance
SWEP.MalfunctionSound = "weapons/arccw/malfunction.wav"

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, 2, 1.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-1, -1, 1.4)
SWEP.CrouchAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)
SWEP.BarrelOffsetCrouch = Vector(0, 0, -2)

SWEP.CustomizePos = Vector(0, 2, 0.5)
SWEP.CustomizeAng = Angle(0, 0, 0)

SWEP.BarrelLength = 18

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    [1] = {"shellport", "patron_in_weapon"},
    [2] = "patron_001",
    [3] = "patron_002",
	[4] = "patron_003",
    [5] = "patron_004",
	[6] = "patron_005",
    [7] = "patron_006",
	[8] = "patron_007",
    [9] = "patron_008",
	[10] = "patron_009",
    [11] = "patron_010",
	[12] = "patron_011",
    [13] = "patron_012",
}

SWEP.AttachmentElements = {
	["hidereceiver"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
    },
    ["showmount"] = {
        VMBodygroups = {{ind = 9, bg = 1}},
    },
    ["hidemount"] = {
        VMBodygroups = {{ind = 9, bg = 0}},
    },
    ["hidesights"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
    },
	["sightmount"] = {
        VMBodygroups = {{ind = 6, bg = 2}},
    },
    ["hidebarrel"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["45_AP"] = {
        VMBodygroups = {{ind = 8, bg = 1}},
    },
	["45_RIP"] = {
        VMBodygroups = {{ind = 8, bg = 2}},
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12.6, 5.5, -7),
    ang = Angle(-0, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
	{
        PrintName = "Optic", -- print name
        DefaultAttName = "None",
		//DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_sights_standard.png"),
        Slot = "eft_optic_small", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_reciever", -- relevant bone any attachments will be mostly referring to
		CorrectiveAng = Angle(0, 180, 0), 
        InstalledEles = {"sightmount"},
		GivesFlags = {"opticattached"},
        Offset = {
            vpos = Vector(0, -2, 0.9),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
    },
	{
        PrintName = "Iron Sights", -- print name
        DefaultAttName = "Iron Sights",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_sights_standard.png"),
        Slot = "eft_usp_sights", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_reciever", -- relevant bone any attachments will be mostly referring to
		CorrectiveAng = Angle(0, 180, 0),
        InstalledEles = {"hidesights"},
		ExcludeFlags = {"opticattached"},
        Offset = {
            vpos = Vector(0, -2.4, 0.75),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Slide", -- print name
        DefaultAttName = "Standard Slide",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_slide_default.png"),
        Slot = "eft_usp_slide", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_reciever", -- relevant bone any attachments will be mostly referring to
		InstalledEles = {"hidereceiver"},
        Offset = {
            vpos = Vector(0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Compensator", -- print name
        DefaultAttName = "No Compensator",
		//DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_barrel_match.png"),
        Slot = "eft_usp_compensator", -- what kind of attachments can fit here, can be string or table
        GivesFlags = {"Compensator"},
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 23.7, -0.45),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Barrel", -- print name
        DefaultAttName = "Standard Barrel",
		DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_barrel_match.png"),
        Slot = "eft_usp_barrel", -- what kind of attachments can fit here, can be string or table
        Bone = "mod_barrel", -- relevant bone any attachments will be mostly referring to
		InstalledEles = {"hidebarrel"},
        Offset = {
            vpos = Vector(0, 0, -0),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Muzzle", -- print name
        DefaultAttName = "No Muzzle Device",
		//DefaultAttIcon = Material("vgui/entities/eft_attachments/usp_barrel_match.png"),
        Slot = "eft_muzzle_1911", -- what kind of attachments can fit here, can be string or table
        ExcludeFlags = {"Compensator"},
        RequireFlags = {"threadedbarrel"},
        Bone = "mod_barrel", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0, 3.7, 0.45),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
    },
	{
        PrintName = "Tactical", -- print name
        DefaultAttName = "No Tactical",
        //ExcludeFlags = {"Compensator"},
        Slot = {"eft_tactical", "eft_usp_mount"}, -- what kind of attachments can fit here, can be string or table
        Bone = "weapon", -- relevant bone any attachments will be mostly referring to
        InstalledEles = {"showmount"},
        Offset = {
            vpos = Vector(0, 23.7, -0.45),
            vang = Angle(0, -90, 0),
			wpos = Vector(0, 0, 0),
			wang = Angle(0, 0, 0),
        },
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
        Time = 1.2,
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
        Time = 1.2,
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
        Time = 1.2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {
            s = "eft_shared/weap_out.wav",
            t = 0
			}
        },
    },
	["holster_empty"] = {
        Source = "holster_empty",
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {
            s = "eft_shared/weap_out.wav",
            t = 0
			}
        },
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
        SoundTable = {
            {
            s = "eft_shared/weap_pistol_use.wav",
            t = 0.45
			},
            {
            s = "arc_eft_usp/usp_slider_in.wav",
            t = 0.8
            }
        },
    },
    ["trigger"] = {
        Source = "trigger",
        Time = 0.1,
    },
    ["fire"] = {
        Source = "fire_new",
        Time = 0.2,
        ShellEjectAt = 0,
        SoundTable = {
            {
            s = "eft_shared/weap_trigger_hammer.wav",
            t = 0.05
			}
        },
    },
    ["fire_iron"] = {
        Source = "fire_new",
        Time = 0.2,
        ShellEjectAt = 0.05,
        SoundTable = {
            {
            s = "eft_shared/weap_trigger_hammer.wav",
            t = 0
			}
        },
    },
    ["fire_iron_empty"] = {
        Source = "fire_dry",
        Time = 0.0,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "fire_dry",
        Time = 0.0,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LastClip1OutTime = 2, -- when should the belt visually replenish on a belt fed
        SoundTable = {
            {
            s = "eft_shared/weapon_generic_pistol_spin1.wav",
            t = 0.1
            },
            {
            s = "eft_shared/weap_magrelease_button.wav",
            t = 0.6
			},
            {
            s = "arc_eft_usp/usp_mag_out.wav",
            t = 0.7
            },
            {
            s = "arc_eft_usp/usp_mag_pullout.wav",
            t = 0.75
            },
            {
            s = "eft_shared/weap_magin_rig.wav",
            t = 1.3
            },
            {
            s = "eft_shared/weap_mag_pullout.wav",
            t = 1.9
            },
            {
            s = "arc_eft_usp/usp_mag_pullin.wav",
            t = 3
            },
            {
            s = "arc_eft_usp/usp_mag_in.wav",
            t = 3.1
            }
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LastClip1OutTime = 2, -- when should the belt visually replenish on a belt fed
        SoundTable = {
                {
                s = "eft_shared/weapon_generic_pistol_spin1.wav",
                t = 0.1
                },
                {
                s = "eft_shared/weap_magrelease_button.wav",
                t = 0.6
                },
                {
                s = "arc_eft_usp/usp_mag_out.wav",
                t = 0.7
                },
                {
                s = "arc_eft_usp/usp_mag_pullout.wav",
                t = 0.75
                },
                {
                s = "eft_shared/weap_magin_rig.wav",
                t = 1.3
                },
                {
                s = "eft_shared/weap_mag_pullout.wav",
                t = 1.9
                },
                {
                s = "arc_eft_usp/usp_mag_pullin.wav",
                t = 3
                },
                {
                s = "arc_eft_usp/usp_mag_in.wav",
                t = 3.1
                },
                {
                 s = "eft_shared/weap_bolt_catch_button.wav",
                t = 4.1
                },
                {
                s = "eft_shared/weap_pistol_use.wav",
                t = 4.125
                },
                {
                s = "arc_eft_usp/usp_slider_in.wav",
                t = 4.3
                }
        },
    },
	["enter_inspect"] = {
		Source = "inventory_start",
	    LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {
            s = "eft_shared/weap_handoff.wav",
            t = 0
			},
            {
            s = "eft_shared/weapon_generic_pistol_spin1.wav",
            t = 0.1
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin3.wav",
            t = 0.5
            }
        },
	},
	["enter_inspect_empty"] = {
		Source = "inventory_start_empty",
	    LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {
            s = "eft_shared/weap_handoff.wav",
            t = 0
			},
            {
            s = "eft_shared/weapon_generic_pistol_spin1.wav",
            t = 0.1
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin3.wav",
            t = 0.5
            }
        },
	},
	["idle_inspect"] = {
		Source = "inventory",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["idle_inspect_empty"] = {
		Source = "inventory_empty",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
	},
	["exit_inspect"] = {
		Source = "inventory_end_alt",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
        SoundTable = {
                {
                s = "eft_shared/weapon_generic_pistol_spin1.wav",
                t = 0.1
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin3.wav",
                t = 0.5
                },
                {
                s = "eft_shared/weap_magrelease_button.wav",
                t = 1
                },
                {
                s = "arc_eft_usp/usp_mag_out.wav",
                t = 1.2
                },
                {
                s = "arc_eft_usp/usp_mag_pullout.wav",
                t = 1.1
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin2.wav",
                t = 2
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin4.wav",
                t = 2.4
                },
                {
                s = "arc_eft_usp/usp_mag_pullin.wav",
                t = 3.45
                },
                {
                s = "arc_eft_usp/usp_mag_in.wav",
                t = 3.55
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin4.wav",
                t = 3.9
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin4.wav",
                t = 4.2
                },
                {
                s = "eft_shared/weap_pistol_use.wav",
                t = 5.1
                },
                {
                s = "arc_eft_usp/usp_slider_in.wav",
                t = 6
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin2.wav",
                t = 6.2
                },
                {
                s = "eft_shared/weapon_generic_pistol_spin4.wav",
                t = 6.3
                }
        },
	},
	["exit_inspect_empty"] = {
		Source = "inventory_end_new_empty",
		LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.3,
        SoundTable = {
            {
            s = "eft_shared/weapon_generic_pistol_spin1.wav",
            t = 0.1
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin3.wav",
            t = 0.5
            },
            {
            s = "eft_shared/weap_magrelease_button.wav",
            t = 1
            },
            {
            s = "arc_eft_usp/usp_mag_out.wav",
            t = 1.2
            },
            {
            s = "arc_eft_usp/usp_mag_pullout.wav",
            t = 1.1
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin2.wav",
            t = 2
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin4.wav",
            t = 2.4
            },
            {
            s = "arc_eft_usp/usp_mag_pullin.wav",
            t = 3.45
            },
            {
            s = "arc_eft_usp/usp_mag_in.wav",
            t = 3.55
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin4.wav",
            t = 3.9
            },
            {
            s = "eft_shared/weapon_generic_pistol_spin4.wav",
            t = 4.2
            }
    },
	},
	["fix"] = {
		Source = {"jam_soft"},
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        SoundTable = {
            {
            s = "eft_shared/weap_pistol_use.wav",
            t = 0.75
			},
            {
            s = "eft_shared/weap_round_out.wav",
            t = 0.9
            },
            {
            s = "arc_eft_usp/usp_slider_in.wav",
            t = 1.2
            }
        },
	},
	["unjam"] = {
		Source = {"jam_feed", "jam_shell"},
		TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
		LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.3,
        SoundTable = {
            {
            s = "eft_shared/weap_round_out.wav",
            t = 2.3
			},
            {
            s = "arc_eft_usp/usp_slider_in.wav",
            t = 2.6
            }
        },
	},
}