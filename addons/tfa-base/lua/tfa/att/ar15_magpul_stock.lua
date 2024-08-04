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

ATTACHMENT.Name = "Magpul Stock"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "30% less vertical recoil", "10% less horizontal recoil" }
ATTACHMENT.Icon = "entities/ar15_att_moe_s.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MOE"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["basestock"] = {
			["active"] = false
		},
		["magpulstock"] = {
			["active"] = true
		}
	},
	["Bodygroups_W"] = {
		[1] = 2
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.7 end,
		["KickDown"] = function(wep,stat) return stat * 0.7 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.9 end
	},
}

function ATTACHMENT:Attach( wep )
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

function ATTACHMENT:Detach( wep )
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end