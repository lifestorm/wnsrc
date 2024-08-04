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

ATTACHMENT.Name = "Full-auto conversion"
ATTACHMENT.Description = {}
ATTACHMENT.Icon = nil --"entities/ins2_att_mag_ext_rifle_30rd.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "AUTO"

ATTACHMENT.WeaponTable = {
}

function ATTACHMENT:Attach(wep)
wep.Primary.Automatic = true
wep.Type		= "Automatic rifle, 7.62×39mm"
end

function ATTACHMENT:Detach(wep)
wep.Primary.Automatic = false
wep.Type		= "Semi-automatic rifle, 7.62×39mm"
end

if not TFA_ATTACHMENT_ISUPDATING then 
	TFAUpdateAttachments()
end
