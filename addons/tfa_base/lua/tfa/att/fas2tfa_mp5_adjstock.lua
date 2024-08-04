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

ATTACHMENT.Name = "Retractable Stock"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+5% aiming speed", "-15% spread"
}
ATTACHMENT.Icon = "entities/tfafas2adjstk.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RETR"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[5] = 1},
	["Bodygroups_W"] = {[2] = 1},
	["Primary"] = {
		["Spread"] = function(wep,stat) return stat * .85 end,
	},
	["BlowbackVector"] = Vector(0,-1.5,-.075),
	["IronSightTime"] = function( wep, stat ) return stat * 1.05 end,

}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
