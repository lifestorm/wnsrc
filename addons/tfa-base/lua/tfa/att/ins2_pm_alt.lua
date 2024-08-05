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

ATTACHMENT.Name = "Alternative Look"
ATTACHMENT.Description = {}
ATTACHMENT.Icon = "entities/tfa_ins2_pm_alt.png"
ATTACHMENT.ShortName = "ALT"

ATTACHMENT.WeaponTable = {
	["MaterialTable_V"] = {
		[1] = "models/weapons/tfa_ins2/pm/alt/pm",
	},
	["VElements"] = {
		["mag"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/alt/pm",
			}
		},
		["mag_ext"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/alt/pm",
			}
		}
	},
	["MaterialTable_W"] = {
		[1] = "models/weapons/tfa_ins2/pm/alt/pm",
	},
	["WElements"] = {
		["mag"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/alt/pm",
			}
		},
		["mag_ext"] = {
			["materials"] = {
				[1] = "models/weapons/tfa_ins2/pm/alt/pm",
			}
		}
	},
	["WepSelectIcon_Override"] = "vgui/hud/tfa_ins2_pm_alt"
}

local function resetMatCache(att, wep)
	wep:ClearMaterialCache()
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
