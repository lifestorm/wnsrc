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

SWEP.PrintName = "Pickaxe"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_pickaxe.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_pickaxe.mdl" --Viewmodel path
SWEP.HoldType = "melee2"
SWEP.DefaultHoldType = "melee2"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4.7,
        Right = 1,
        Forward = 0.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.0
}

SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(4.84, 1.424, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.Primary.Damage = 65
SWEP.Secondary.BashDelay = 0.3