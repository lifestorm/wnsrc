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

ATTACHMENT.Name = "Magnum Shells"
ATTACHMENT.ShortName = "MGNM" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.Attachments.Colors["+"], "Increases critical damage", "+60% damage", TFA.Attachments.Colors["-"], "Decreases hit chance at range", "-5 pellets" }
ATTACHMENT.Icon = "entities/tfa_ammo_fragshell.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["StaticRecoilFactor"] = function( wep, stat ) return stat * 1.15 end,
		["PenetrationMultiplier"] = function( wep, stat ) return wep.Primary.NumShots * stat * 1 end,
		["Damage"] = function(wep,stat) return stat * 1.60 end,
		["NumShots"] = function(wep,stat) return stat / 2 end
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
