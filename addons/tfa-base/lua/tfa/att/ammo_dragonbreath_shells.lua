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

ATTACHMENT.Name = "Dragon's Breath Shells"
ATTACHMENT.ShortName = "Fire"                        -- Abbreviation, 5 chars or less please
ATTACHMENT.Icon = "entities/dragon_breach_shell.png" -- Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.Description = { 
TFA.Attachments.Colors["+"], "Ignites enemies or objects", 
TFA.Attachments.Colors["+"], "Stun enemies with fire", 
TFA.Attachments.Colors["+"], "+8 Pellets", 
TFA.Attachments.Colors["-"], "+100% Spread", "-50% Damage" }

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["DamageType"] = function(wep,stat) return bit.bor( stat or 0, DMG_BURN ) end,
        ["NumShots"] = function( wep, stat ) return stat + 8 end,
		["Spread"] = function(wep,stat) return stat * 2 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 1.5 end,
		["Damage"] = function(wep,stat) return stat * 0.5 end,
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
