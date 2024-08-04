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
SWEP.Category = "Willard - Overwatch Weapons" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "OICW"
SWEP.TrueName = "Overwatch Tactical Issue" 

-- Technically you can omit all trivia info, but that's not fun! Do a bit of research and write some stuff in!
SWEP.Trivia_Class = "Assault Rifle"
SWEP.Trivia_Desc = "Fast firing battle rifle designed to replace the human MP7 in the Combine's arsenal, with an ever faster 5-round burst mode. Good for runnin' and gunnin'."
SWEP.Trivia_Manufacturer = "The Combine"
SWEP.Trivia_Calibre = "Light Pulse Capsule"
SWEP.Trivia_Mechanism = "Dark Energy Cyclotron"
SWEP.Trivia_Country = "Universal Union - Earth Overwatch"
SWEP.Trivia_Year = "Occupation Period 1, 201x"

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
    SWEP.Trivia_Manufacturer = "The Combine"
end

SWEP.UseHands = false

SWEP.ViewModel = "models/weapons/oicw/v_oicw.mdl" 
SWEP.WorldModel = "models/weapons/oicw/w_oicw.mdl"
SWEP.ViewModelFOV = 54

SWEP.Damage = 12
SWEP.DamageMin = 12
SWEP.Range = 350 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 600 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 45 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 60
SWEP.ReducedClipSize = 30

SWEP.Recoil = 0.53
SWEP.RecoilSide = 0.3
SWEP.RecoilRise = 0.1


SWEP.Delay = 60 / 600 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
	    {
        Mode = -5,
		Mult_RPM = 2,
		RunawayBurst = true,
		PostBurstDelay = 0.25
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_ar2"
SWEP.NPCWeight = 150

SWEP.AccuracyMOA = 12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 450 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "oicw2" -- the magazine pool this gun draws from

SWEP.ShootVol = 115 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/oicw/smg1_fire1.wav"
SWEP.ShootSoundSilenced = "weapons/arccw/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = "weapons/oicw/smg1_fire1.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = nil
SWEP.ShellScale = 0
SWEP.ShellMaterial = nil

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.7
SWEP.SightTime = 0.33
SWEP.VisualRecoilMult = 1
SWEP.RecoilRise = 1

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-10, 0, 0),
    Ang = Angle(-30, 0 ,0),
    Magnification = 2,
    SwitchToSound = "", -- sound that plays when switching to this sight
	CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-2, -6, 0)
SWEP.ActiveAng = Angle(2, 0, 0)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, 0)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 27

SWEP.AttachmentElements = {

	["optic"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{indc = 1, bg = 1}},
    },
	["optic_lp"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1, bg = 1}},
    },
}

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Integral Sight (2x)",
        Slot = {"optic_lp"}, -- what kind of attachments can fit here, can be string or table
        Bone = "Bip01 R Hand", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(10.438, -1.599, 11.939), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(6.099, 0.699, -6.301),
            wang = Angle(171.817, 180-1.17, 0),
        },

        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(2, 0, 0),
    },

    {
        PrintName = "Underbarrel",
        Slot = {"ubgl"},
        Bone = "Bip01 R Hand",
        Offset = {
            vpos = Vector(21.67, -2.573, 3.747),
            vang = Angle(0, 0, 0),
            wpos = Vector(17, 0.6, -4.676),
            wang = Angle(-10, 0, 180)
        },

    },
	
	 {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "Bip01 R Hand",
        Offset = {
            vpos = Vector(31.375, -2.731, 7.867),
            vang = Angle(-1.7, 0, 0),
            wpos = Vector(26.648, 0.782, -8.042),
            wang = Angle(-9.79, 0, 180)
        },
    },
	
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "Bip01 R Hand",
        Offset = {
            vpos = Vector(19.806, -4.776, 8.824), -- offset that the attachment will be relative to the bone
            vang = Angle(-2, 0, -90),
            wpos = Vector(15.625, -0.1, -6.298),
            wang = Angle(-8.829, -0.556, 90)
        },
    },
    {
        PrintName = "Grip",
        Slot = "grip",
        DefaultAttName = "Standard Grip"
    },
    {
        PrintName = "Stock",
        Slot = "stock",
        DefaultAttName = "Standard Stock"
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
    {
        PrintName = "Ammo Type",
        Slot = "ammo_bullet"
    },
    {
        PrintName = "Perk",
        Slot = "perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "Bip01 R Hand", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(12.66, -3.62, 9.439), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, 0),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.Animations = {
    ["idle"] = false,
	
    ["draw"] = {
        Source = "AR2_draw",
        Time = 0.4,
        SoundTable = {{s = "weapons/arccw/ak47/ak47_draw.wav", t = 0}},
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    
    ["fire"] = {
        Source = {"AR2_primary_fire3", "AR2_primary_fire4"},
        Time = 0.5,
    },
    ["fire_iron"] = {
        Source = "AR2_primary_dry",
        Time = 0.5,
    },
    ["reload"] = {
        Source = "AR2_reload",
        Time = 2.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 37,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
		SoundTable = {{s = "weapons/oicw/smg1_reload.wav", t = 0}},
    },
    ["reload_empty"] = {
        Source = "AR2_reload",
        Time = 2.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Framerate = 37,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
		SoundTable = {{s = "weapons/oicw/smg1_reload.wav", t = 0}},
    },
}