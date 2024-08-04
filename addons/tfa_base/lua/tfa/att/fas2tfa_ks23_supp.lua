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

ATTACHMENT.Name = "Suppressor"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Less firing noise", TFA.AttachmentColors["+"], "+10% vertical recoil", "-10% spread", TFA.AttachmentColors["-"], "-30% damage" }
ATTACHMENT.Icon = "entities/ins2_att_br_supp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SUPP"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["suppressor"] = {
			["active"] = true
		},
		["standard_barrel"] = {
			["active"] = false
		}
	},
	["WElements"] = {
		["suppressor"] = {
			["active"] = true
		},
		["standard_barrel"] = {
			["active"] = false
		}
	},
	["IronSightsPos"] = Vector(-2.7285, -7.035, 1.8975),
	["IronSightsAng"] = Vector(-.2, 0.015, 0),
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.7 end,
		["KickUp"] = function(wep,stat) return stat * 0.9 end,
		["KickDown"] = function(wep,stat) return stat * 0.9 end,
		["Spread"] = function(wep,stat) return stat * 0.9 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.9 end,
		["Sound"] = function(wep,stat) return wep.Primary.SilencedSound or stat end,
	},
	["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced",
	["MuzzleAttachmentMod"] = function(wep,stat) return wep.MuzzleAttachmentSilenced or stat end,
	["Silenced"] = true,
}

function ATTACHMENT:Attach(wep)
	wep.Silenced = true
	wep:SetSilenced(wep.Silenced)
end

function ATTACHMENT:Detach(wep)
	wep.Silenced = false
	wep:SetSilenced(wep.Silenced)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
