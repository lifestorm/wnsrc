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

ATTACHMENT.Name = "Extended Tube, 6rnd"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Increases internal magazine capacity", TFA.Attachments.Colors["-"],"Attaching & detaching empties magazine",
}
ATTACHMENT.Icon = "entities/ks23tube.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "+MAG"

ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[2] = 1},
	["Bodygroups_W"] = {[2] = 1},
	["Primary"] = {
		["ClipSize"] = function(wep, val)
			return wep.Primary.ClipSize_ExtRifle or 6
		end,
	},
}

function ATTACHMENT:Attach(wep)
	wep:Unload()
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
