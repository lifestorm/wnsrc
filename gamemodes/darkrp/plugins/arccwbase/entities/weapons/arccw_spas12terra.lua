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
SWEP.Category = "New Frontiers" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SPAS-12"
SWEP.TrueName = "SPAS-12"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "12 gauge pistol grip pump shotgun."
SWEP.Trivia_Manufacturer = "Franchi"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "Italy"
SWEP.Trivia_Year = 1979

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then SWEP.PrintName = SWEP.TrueName end

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/fml/c_fleshy_spas.mdl"
SWEP.WorldModel = "models/weapons/tnmmod/w_shotgun.mdl"
SWEP.ViewModelFOV = 55

SWEP.Damage = 16
SWEP.DamageMin = 8 -- damage done at maximum range
SWEP.Range = 25 -- in METRES
SWEP.Penetration = 10
SWEP.DamageType = DMG_BUCKSHOT
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 150 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 8
SWEP.ReducedClipSize = 4

SWEP.Recoil = 6
SWEP.RecoilSide = 1
SWEP.MaxRecoilBlowback = 2

SWEP.ShotgunReload = true
SWEP.ManualAction = true

SWEP.Delay = 60 / 80 -- 60 / RPM.
SWEP.Num = 8 -- number of shots per trigger pull.
SWEP.RunawayBurst = false
SWEP.Firemodes = {
    {
        PrintName = "PUMP",
        Mode = 1,
    },
}

SWEP.NPCWeaponType = "weapon_shotgun"
SWEP.NPCWeight = 200

SWEP.AccuracyMOA = 80 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 150

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/tnweapons/shotgun/shotgun_dbl_fire.wav"
SWEP.DistantShootSound = "weapons/tnweapons/shotgun/shotgun_fire.wav"

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.27

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-2.431, 2, 0.8),
    Ang = Angle(0.202, 0.017, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}


SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(1, 5, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.M3_PARENT",
        Offset = {
            vpos = Vector(0.954, -4.086, -5.138), -- offset that the attachment will be relative to the bone
            vang = Angle(-90, 0, 180),
            wpos = Vector(28.148, 1, -5),
            wang = Angle(-6, 0, -180)
        },
    },
}

-- draw
-- holster
-- reload
-- fire
-- cycle (for bolt actions)
-- append _empty for empty variation

SWEP.Animations = {
    ["draw"] = {
        Source = "draw",
        Time = 0.4,
    },
    ["fire"] = {
        Source = "shoot1",
        Time = 0.4,
    },
    ["slam"] = {
        Source = "slam",
        Time = 0.75,
        ShellEjectAt = 0.3,
    },
    ["cycle"] = {
        Source = {"pump_1", "pump_2"},
        Time = 0.75,
        ShellEjectAt = 0.3,
		SoundTable = {
			{s = "weapons/tnweapons/shotgun/shotgun_cock_back.wav", t = 0},
			{s = "weapons/tnweapons/shotgun/shotgun_cock_forward.wav", t = 0.3},
			},
    },
    ["cycle_iron"] = {
        Source = "pump_iron",
        Time = 1,
        ShellEjectAt = 0.3,
		SoundTable = {
			{s = "weapons/tnweapons/shotgun/shotgun_cock_back.wav", t = 0},
			{s = "weapons/tnweapons/shotgun/shotgun_cock_forward.wav", t = 0.3},
			},
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 1,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 1.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/tfa_ins2/m590/m590_shell.wav", t = 0.35},
        },
    },
    ["sgreload_start_empty"] = {
        Source = "reload_start_dry",
        Time = 2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/tfa_ins2/m590/m590_shell.wav", t = 0.35},
            {s = "weapons/tfa_ins2/m590/m590_boltback.wav", t = 1.3},
            {s = "weapons/tfa_ins2/m590/m590_boltrelease.wav", t = 1.5},
        },
    },
    ["sgreload_insert"] = {
        Source = "reload",
        Time = 0.75,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
        SoundTable = {
            {s = "weapons/tfa_ins2/m590/m590_shell.wav", t = 0.35},
        },
    },
    ["sgreload_finish"] = {
        Source = "reload_finish",
        Time = 0.7,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.4,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_finish",
        Time = 0.7,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
    },
}