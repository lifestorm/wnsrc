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

ATTACHMENT.Name = "M16 Stock"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "70% less vertical recoil", "30% less horizontal recoil", TFA.AttachmentColors["-"], "Somewhat slower movespeed" }
ATTACHMENT.Icon = "entities/ar15_att_m16_s.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "M16S"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["basestock"] = {
			["active"] = false
		},
		["m16stock"] = {
			["active"] = true
		}
	},
	["Bodygroups_W"] = {
		[1] = 1
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.3 end,
		["KickDown"] = function(wep,stat) return stat * 0.3 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.7 end
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.95 end,
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