--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "CQB Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+10% movement speed",
	TFA.AttachmentColors["-"], "+20% recoil", "-20% accuracy"
}
ATTACHMENT.Icon = "entities/tfafas2g3barcqb.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "CQB"

ATTACHMENT.WeaponTable = {
	["ViewModelBoneMods"] = {
["A_Suppressor"] = { scale = Vector(.8, .8, .8), pos = Vector(-14.75, .85, .41), angle = Angle(-90, 90, 0)  },
["A_Underbarrel"] = { scale = Vector(.6, .6, .6), pos = Vector(-12.5, .85, 3.41), angle = Angle(-90, 90, 0)  },
["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(9, 0, 0), angle = Angle(0, 0, 0)  },
["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(6.5, 0, 0), angle = Angle(0, 0, 0)  },
["Left Polex Phalange1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12, 1, 25)  },
},
	["Bodygroups_V"] = {[1] = 1},
	["Bodygroups_W"] = {[1] = 1},
	["IronSightsPos"] = Vector(-2.658, -5, -.022),
	["IronSightsAng"] = Vector(0.515, 0.002, 0),
	["Primary"] = {
		["IronAccuracy"] = function( wep, stat ) return stat * 1.15 end,
		["Spread"] = function( wep, stat ) return stat * 1.2 end,
		["KickUp"] = function( wep, stat ) return stat * 1.2 end,
		["Sound"] = function(wep,stat) return "FAS2TFA_G3.2" or stat end,
		["SilencedSound"] = function(wep,stat) return "FAS2TFA_G3.4" or stat end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsSensitivity"] = function( wep, stat ) return stat * 0.9 end,

}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
