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

ATTACHMENT.Name = "Colorable Stock"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Corresponds with your gmod physgun color",
}
ATTACHMENT.Icon = "entities/ks23plrstock.png"
ATTACHMENT.ShortName = "RGB"

ATTACHMENT.WeaponTable = {
	["Skin"] = 1,
}

function ATTACHMENT:Attach(wep)
	wep:SetSkin(1)
end

function ATTACHMENT:Detach(wep)
	wep:SetSkin(0)
end


if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end