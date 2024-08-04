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

ATTACHMENT.Name = "PDW Stock"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+10% aiming speed", "-5% spread",
	TFA.AttachmentColors["-"], "+10% horizontal recoil",
}
ATTACHMENT.Icon = "entities/tfafas2pdwstk.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "PDW"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[5] = 2},
	["Bodygroups_W"] = {[2] = 2},
	["Primary"] = {
		["KickHorizontal"] = function( wep, stat ) return stat * 1.1 end,
		["Spread"] = function( wep, stat ) return stat * .95 end,
	},
	["BlowbackVector"] = Vector(0,-1.5,-.075),
	["IronSightTime"] = function( wep, stat ) return stat * 1.10 end,

}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
