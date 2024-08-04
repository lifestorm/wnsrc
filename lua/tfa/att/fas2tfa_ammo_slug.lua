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

ATTACHMENT.Name = "Slug Shells"
ATTACHMENT.ShortName = "SLUG" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Increases accuracy", "Standard with the KS23's rifled barrel", TFA.Attachments.Colors["-"], "-20% total damage", "-9 pellets"  }
ATTACHMENT.Icon = "entities/tfa_ammo_slug.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return wep.Primary.NumShots * stat * 0.8 end,
		["PenetrationMultiplier"] = function( wep, stat ) return wep.Primary.NumShots * stat * 3 end,
		["NumShots"] = function( wep, stat ) return 1, true end,
		["Spread"] = function( wep, stat ) return stat - 0.025 end,
		["IronAccuracy"] = function( wep, stat ) return stat - 0.04 end,
		["Range"] = function( wep, stat ) return stat + 100 * 39.370 end
	},
	["MuzzleFlashEffect"] = "tfa_muzzleflash_generic",
}

function ATTACHMENT:Attach(wep)
wep.Type		= "Pump-action carbine, 23×75mmR"
end

function ATTACHMENT:Detach(wep)
wep.Type		= "Pump-action shotgun, 23×75mmR"
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
