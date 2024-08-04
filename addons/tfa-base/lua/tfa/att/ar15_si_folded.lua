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

ATTACHMENT.Name = "Folded Sights"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Easier to aim", TFA.AttachmentColors["-"], "5% higher zoom time" }
ATTACHMENT.Icon = "entities/ins2_att_fsi.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FSI"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["sights_folded"] = {
			["active"] = false
		},
		["sight_fsi"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["sights_folded"] = {
			["active"] = false
		},
		["sight_fsi"] = {
			["active"] = true
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng end,
	["IronSightTime"] = function( wep, val ) return val * 1.05 end
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
