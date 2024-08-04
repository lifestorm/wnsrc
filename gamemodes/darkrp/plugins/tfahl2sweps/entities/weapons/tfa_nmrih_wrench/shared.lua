--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "Willard Melee Weapons"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Pipe Wrench"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_wrench.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_wrench.mdl" --Viewmodel path
SWEP.HoldType = "knife"
SWEP.DefaultHoldType = "knife"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 2,
        Right = 2,
        Forward = 0,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.0
}

SWEP.Primary.Sound = Sound("Weapon_Melee.Wrench")
SWEP.Secondary.Sound = Sound("Weapon_Melee.Wrench")

SWEP.MoveSpeed = 0.97
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(-2.5, -12.58, 1.769)
SWEP.InspectAng = Vector(-6.19, 26.36, -4.468)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 65
SWEP.Primary.Reach = 60
SWEP.Primary.RPM = 60
SWEP.Primary.SoundDelay = 0.2
SWEP.Primary.Delay = 0.4
SWEP.Primary.Window = 0.2

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 100
SWEP.Secondary.Reach = 60	
SWEP.Secondary.SoundDelay = 0.1
SWEP.Secondary.Delay = 0.3

SWEP.Secondary.BashDamage = 50
SWEP.Secondary.BashDelay = 0.35
SWEP.Secondary.BashLength = 50

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.254, 0.09), angle = Angle(15.968, -11.193, 1.437) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.552, 4.526, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6, 0, 0) },
--	["Maglite"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, -30), angle = Angle(0, 0, 0) }
}