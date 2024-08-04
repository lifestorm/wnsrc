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

ATTACHMENT.Name = "550-1 Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "-15% vertical recoil", "+35% aiming accuracy",
}
ATTACHMENT.Icon = "entities/ins2_att_br_heavy.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HBAR"

ATTACHMENT.WeaponTable = {
	["ViewModelBoneMods"] = {
	["A_Suppressor"] = { scale = Vector(.88, 1, .88), pos = Vector(1.672, -24.5, 2.825), angle = Angle(180, 0, 180)  },
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(5, 0, 0), angle = Angle(0, 0, 0)  },
	["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(10, 0, 0), angle = Angle(0, 0, 0)  },
	},
	
		["WorldModelBoneMods"] = {
	["ATTACH_Muzzle"] = { scale = Vector(.9, .9, .9), pos = Vector(5, .05, -.1), angle = Angle(0, 0, 0)  },
	},
	
	["Bodygroups_V"] = {[4] = 1},
	["Bodygroups_W"] = {[3] = 1},
	["Primary"] = {
		["IronAccuracy"] = function( wep, stat ) return stat * 1.35 end,
		["IronRecoilMultiplier"] = function( wep, stat ) return stat * 1.35 end,
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["KickDown"] = function( wep, stat ) return stat * 0.9 end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 0.95 end,
	["MuzzleFlashEffect"] = "tfa_muzzleflash_generic",
}

function ATTACHMENT:Attach(wep)
wep.Type		= "Select-fire sniper rifle, 5.56×45mm"
end

function ATTACHMENT:Detach(wep)
wep.Type		= "Assault rifle, 5.56×45mm"
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
