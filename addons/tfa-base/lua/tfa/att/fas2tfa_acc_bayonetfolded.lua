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

ATTACHMENT.Name = "Folded Bayonet"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = {}
ATTACHMENT.Icon = "entities/tfafas2sksfld.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FOLD"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[1] = 1},
	["Bodygroups_W"] = {[2] = 1},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
