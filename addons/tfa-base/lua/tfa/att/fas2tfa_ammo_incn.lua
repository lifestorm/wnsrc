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

ATTACHMENT.Name = "Pyro Shells"
ATTACHMENT.ShortName = "PYRO" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Ignites flammable objects", "Fun with VFire", "+7 pellets", "-35% overall recoil", TFA.Attachments.Colors["-"], "+200% spread", "-55% total damage" }
ATTACHMENT.Icon = "entities/tfa_ammo_incenshell.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * .65 end,
		["KickDown"] = function( wep, stat ) return stat * .65 end,
		["KickHorizontal"] = function( wep, stat ) return stat * .65 end,
		["StaticRecoilFactor"] = function( wep, stat ) return stat * .8 end,
		["DamageType"] = function(wep,stat) return bit.bor( stat or 0, DMG_BURN ) end,
		["Spread"] = function(wep,stat) return stat * 2 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 3 end,
		["Damage"] = function(wep,stat) return stat / 2.55 end,
		["NumShots"] = function(wep,stat) return stat * 1.7 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
