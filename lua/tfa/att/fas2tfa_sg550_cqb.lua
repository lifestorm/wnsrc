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

ATTACHMENT.Name = "553 Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+5% movement speed",
	TFA.AttachmentColors["-"], "+15% overall recoil",
}
ATTACHMENT.Icon = "entities/sgshort.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "CQB"

ATTACHMENT.WeaponTable = {
	["ViewModelBoneMods"] = {
	["A_Suppressor"] = { scale = Vector(.86, 1, .86), pos = Vector(1.672, -7.25, 2.825), angle = Angle(180, 0, 180)  },
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(-11, 0, 0), angle = Angle(0, 0, 0)  },
	["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(-9, 0, 0), angle = Angle(0, 0, 0)  },
},

	["WorldModelBoneMods"] = {
	["ATTACH_Muzzle"] = { scale = Vector(.9, .9, .9), pos = Vector(-13, .05, -.1), angle = Angle(0, 0, 0)  },
	},
	
	["VElements"] = { ["cqb"] = { ["active"] = true},
	
	},
	["IronSightsPos"] = Vector(-2.3012, -2.5, .956),
	["IronSightsAng"] = Vector(-.15, 0.008, 0),
	["Bodygroups_V"] = {[3] = 1, [4] = 2, [8] = 1, [7] = 1},
	["Bodygroups_W"] = {[1] = 1, [3] = 2, [4] = 1},
	
	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * 1.15 end,
		["KickDown"] = function( wep, stat ) return stat * 1.15 end,
		["KickHorizontal"] = function( wep, stat ) return stat * 1.15 end,
		["StaticRecoilFactor"] = function( wep, stat ) return stat * 1.05 end,
		["Sound"] = function(wep,stat) return "FAS2TFA_SG550.3" or stat end,
		["SilencedSound"] = function(wep,stat) return "FAS2TFA_SG550.4" or stat end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 1.4 end,
	["IronSightsSensitivity"] = function( wep, stat ) return stat * 0.6 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
