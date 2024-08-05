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

SWEP.PrintName = "Cleaver"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_cleaver.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_cleaver.mdl" --Viewmodel path
SWEP.HoldType = "melee"
SWEP.DefaultHoldType = "melee"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 0.5,
        Forward = -0.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.2
}

SWEP.Primary.Sound = Sound("Weapon_Melee.HatchetLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.HatchetHeavy")

SWEP.MoveSpeed = 0.975
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(3.874, -13.436, 3.969)
SWEP.InspectAng = Vector(-7.27, 41.632, 4.92)

SWEP.Primary.Blunt = false
SWEP.Primary.Damage = 60
SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 100
SWEP.Primary.SoundDelay = 0.15
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2

SWEP.Secondary.Blunt = false
SWEP.Secondary.RPM = 80 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 100
SWEP.Secondary.Reach = 45	
SWEP.Secondary.SoundDelay = 0.1
SWEP.Secondary.Delay = 0.3

SWEP.Secondary.BashDamage = 20
SWEP.Secondary.BashDelay = 0.2
SWEP.Secondary.BashLength = 50