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

ATTACHMENT.Name = "Full Stock"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "+20% accuracy", "-20% overall recoil", "-70% aim recoil", 
	TFA.AttachmentColors["-"], "-10% aim speed",
}
ATTACHMENT.Icon = "entities/tfafas2g3fulstk.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "FULL"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[2] = 2},
	["Bodygroups_W"] = {[2] = 1},
	["Primary"] = {
		["IronAccuracy"] = function( wep, stat ) return stat * 0.5 end,
		["KickUp"] = function( wep, stat ) return stat * 0.8 end,
		["KickDown"] = function( wep, stat ) return stat * 0.8 end,
		["KickHorizontal"] = function( wep, stat ) return stat * 0.8 end,
		["IronRecoilMultiplier"] = function( wep, stat ) return stat * 0.3 end,
		["StaticRecoilFactor"] = function( wep, stat ) return stat * 0.9 end,
	},
	["BlowbackVector"] = Vector(0,-2.25,.005),
	["IronSightTime"] = function( wep, stat ) return stat * 0.9 end,
	["MoveSpeed"] = function( wep, stat ) return stat * 0.975 end,
	["IronSightsSensitivity"] = function( wep, stat ) return stat * 1.1 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 0.9 end,

}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
