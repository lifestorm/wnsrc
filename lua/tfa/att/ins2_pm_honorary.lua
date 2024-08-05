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

ATTACHMENT.Name = "Honorary"
ATTACHMENT.Description = {
	"«For succesful execution of highly dangerous state orders,",
	"as well as valor and courage shown in the line of duty.»"
}
ATTACHMENT.Icon = "entities/tfa_ins2_pm_honorary.png"
ATTACHMENT.ShortName = "HONOR"

ATTACHMENT.WeaponTable = {
	["MaterialTable_V"] = {
		[1] = "models/weapons/tfa_ins2/pm/honorary/pm",
	},
	["VElements"] = {
		["mag"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/honorary/pm",
			}
		},
		["mag_ext"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/honorary/pm",
			}
		}
	},
	["MaterialTable_W"] = {
		[1] = "models/weapons/tfa_ins2/pm/honorary/pm",
	},
	["WElements"] = {
		["mag"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/honorary/pm",
			}
		},
		["mag_ext"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/honorary/pm",
			}
		}
	},
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_pm_honorary"
}

local function resetMatCache(att, wep)
	wep:ClearMaterialCache()
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
