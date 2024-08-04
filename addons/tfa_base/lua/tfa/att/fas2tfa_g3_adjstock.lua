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

ATTACHMENT.Name = "Adjustable Stock"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "-10% overall recoil", "-30% aim recoil",
}
ATTACHMENT.Icon = "entities/tfafas2adjstk.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "ADJ."

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[2] = 1},
	["Bodygroups_W"] = {[2] = 2},
	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["KickDown"] = function( wep, stat ) return stat * 0.9 end,
		["KickHorizontal"] = function( wep, stat ) return stat * 0.9 end,
		["IronRecoilMultiplier"] = function( wep, stat ) return stat * 0.7 end,
		["StaticRecoilFactor"] = function( wep, stat ) return stat * 0.9 end,
	},
	["BlowbackVector"] = Vector(0,-3,-.02),
	--["IronSightsSensitivity"] = function( wep, stat ) return stat * 0.975 end,
	--["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 0.85 end,

}


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end