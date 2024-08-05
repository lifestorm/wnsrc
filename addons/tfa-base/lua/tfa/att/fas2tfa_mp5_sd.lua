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

ATTACHMENT.Name = "MP5SD Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["-"], "Decreases RPM to 800",
	TFA.AttachmentColors["+"], "-15% recoil", 
}
ATTACHMENT.Icon = "entities/tfafas2mp5sd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SD"

ATTACHMENT.WeaponTable = {
	["ViewModelBoneMods"] = {
	["A_Suppressor"] = { scale = Vector(.75, 1, .75), pos = Vector(10.25, .82, 0), angle = Angle(180, -90, 0)  },
	["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(-1.5, 0, 0), angle = Angle(0, 0, 0)  },
	},
	["WorldModelBoneMods"] = {
	["ATTACH_Muzzle"] = { scale = Vector(.75, .75, .75), pos = Vector(-3, 0, -.29), angle = Angle(0, 0, 0)  },
},

	["Bodygroups_V"] = {[1] = 2, [3] = 1, [4] = 3},
	["Bodygroups_W"] = {[1] = 2},

	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * .85 end,
		["SilencedSound"] = function(wep,stat) return "FAS2TFA_MP5.3" or stat end,
		["RPM"] = function( wep, stat ) return stat - 50 end,
	},
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
