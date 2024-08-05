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

ATTACHMENT.Name = "SBR Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+10% movement speed",
	TFA.AttachmentColors["-"], "+20% recoil", "-30% accuracy", "-5% damage"
}
ATTACHMENT.Icon = "entities/tfafas2svdsbr.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SBR"

ATTACHMENT.WeaponTable = {
["ViewModelBoneMods"] = {
	["A_Suppressor"] = { scale = Vector(.8, .8, .8), pos = Vector(9, .5, 0), angle = Angle(0, -90, 0)  },
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(-13.8, 0, 0), angle = Angle(0, 0, 0)  },
	["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(-10.5, 0, 0), angle = Angle(0, 0, 0)  },
},
["WorldModelBoneMods"] = {
	["ATTACH_Muzzle"] = { scale = Vector(.9, .9, .9), pos = Vector(-14, .2, 0), angle = Angle(0, 0, 0)  },
},
	["Bodygroups_V"] = {[2] = 1},
	["Bodygroups_W"] = {[1] = 1},
	["Primary"] = {
		["IronAccuracy"] = function( wep, stat ) return stat * 1.3 end,
		["Damage"] = function( wep, stat ) return stat * .95 end,
		["Spread"] = function( wep, stat ) return stat * 1.3 end,
		["KickUp"] = function( wep, stat ) return stat * 1.2 end,
		["Sound"] = function(wep,stat) return "FAS2TFA_SVD.3" or stat end,
		["SilencedSound"] = function(wep,stat) return "FAS2TFA_SVD.4" or stat end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsSensitivity"] = function( wep, stat ) return stat * 0.9 end,
	["MuzzleFlashEffect"] = "tfa_muzzleflash_generic",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
