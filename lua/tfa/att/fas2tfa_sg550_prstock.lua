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

ATTACHMENT.Name = "Precision Stock"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "-10% horizontal recoil",
	TFA.AttachmentColors["-"], "+25% aiming speed",
}
ATTACHMENT.Icon = "entities/sgstk2.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "+STK"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[1] = 1},
	["Bodygroups_W"] = {[2] = 1},
	["Primary"] = {
		["KickHorizontal"] = function(wep,stat) return stat * 0.88 end,
	},
	["IronSightTime"] = function( wep, stat ) return stat * 1.25 end,

}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
