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

ATTACHMENT.Name = "KS23M Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+10% movement speed",
	TFA.AttachmentColors["-"], "+35% recoil", "+170% spread",
}
ATTACHMENT.Icon = "entities/ks23short.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SBS"

ATTACHMENT.WeaponTable = {
	["ViewModelBoneMods"] = {
	["A_Suppressor"] = { scale = Vector(.85, .85, .85), pos = Vector(13.75, 13.55, 4.27), angle = Angle(180, -90, 90)  },
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(-9, 0, 0), angle = Angle(0, 0, 0)  },
	["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(-5, 0, 0), angle = Angle(0, 0, 0)  },	},
	["WorldModelBoneMods"] = {
	["ATTACH_Muzzle"] = { scale = Vector(.9, .9, .9), pos = Vector(0, 8.25, 0), angle = Angle(0, 0, 0)  },
},
	["VElements"] = {
		["short"] = {
			["active"] = true
		},
	},
	["IronSightsPos"] = Vector(-2.7285, -7.035, 1.847),
	["IronSightsAng"] = Vector(1.05, 0.015, 0),
	["Bodygroups_V"] = {[1] = 1},
	["Bodygroups_W"] = {[1] = 1},
	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * 1.15 end,
		["Spread"] = function(wep,stat) return stat * 1.7 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 1.7 end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsSensitivity"] = function( wep, stat ) return stat * 0.9 end,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
