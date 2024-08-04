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

ATTACHMENT.Name = "Unfolded Bayonet"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {
		TFA.AttachmentColors["="], "Use with suitzoom bind (+zoom)",
	TFA.AttachmentColors["+"], "+75% melee damage",
}
ATTACHMENT.Icon = "entities/tfafas2sksunfld.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "UNFLD"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[1] = 2},
	["Bodygroups_W"] = {[2] = 3},
	["Secondary"] = {
	["BashDamage"] = function( wep, stat ) return stat * 1.75 end,
	},
}


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
