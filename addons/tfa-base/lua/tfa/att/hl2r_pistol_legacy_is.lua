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

ATTACHMENT.Name = "Ironsight-less"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "Changes the aim to look like MMOD", TFA.AttachmentColors["-"], "Doesn't use the sights." }
ATTACHMENT.Icon = "entities/hl2r_ar2_legacy_is.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "LEGACY"

ATTACHMENT.WeaponTable = {
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_LEG or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_LEG or val end,
	["IronSightTime"] = function( wep, val ) return val * 1 end,
}
function ATTACHMENT:Attach(wep)
	wep.DrawCrosshairIS = true
end

function ATTACHMENT:Detach(wep)
	wep.DrawCrosshairIS = false
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
