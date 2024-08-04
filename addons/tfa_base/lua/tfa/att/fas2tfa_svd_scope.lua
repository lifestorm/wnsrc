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

ATTACHMENT.Name = "PSO-1 Scope"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "4x zoom", TFA.AttachmentColors["-"], "30% higher zoom time",  TFA.AttachmentColors["-"], "15% slower aimed walking" }
ATTACHMENT.Icon = "entities/ins2_si_mx4.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "PSO-1"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["Bodygroups_V"] = {[1] = 1},
	["BlowbackVector"] = Vector(0,-1,0),
	["VElements"] = {
		["rail_sights"] = {
			["active"] = false,},
		["pso1_lens"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_mx4"] = {
			["active"] = true
		}
	},
	["Secondary"] = {
	
		["ScopeZoom"] = function(wep, val) return 4 end
	},
	["INS2_SightSuffix"] = "PSO"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end