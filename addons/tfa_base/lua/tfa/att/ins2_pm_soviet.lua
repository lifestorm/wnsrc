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

ATTACHMENT.Name = "Classic Soviet Vintage"
ATTACHMENT.Description = {}
ATTACHMENT.Icon = "entities/tfa_ins2_pm_soviet.png"
ATTACHMENT.ShortName = "OLD"

ATTACHMENT.WeaponTable = {
	["MaterialTable_V"] = {
		[1] = "models/weapons/tfa_ins2/pm/soviet/pm",
	},
	["VElements"] = {
		["mag"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/soviet/pm",
			}
		},
		["mag_ext"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/soviet/pm",
			}
		}
	},
	["MaterialTable_W"] = {
		[1] = "models/weapons/tfa_ins2/pm/soviet/pm",
	},
	["WElements"] = {
		["mag"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/soviet/pm",
			}
		},
		["mag_ext"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/soviet/pm",
			}
		}
	},
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_pm_soviet"
}

local function resetMatCache(att, wep)
	wep:ClearMaterialCache()
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
