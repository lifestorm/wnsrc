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

ATTACHMENT.Name = "M16 Handguard"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "60% less vertical recoil", "20% less horizontal recoil", TFA.AttachmentColors["-"], "10% lower base accuracy", "Somewhat slower movespeed" }
ATTACHMENT.Icon = "entities/ar15_att_m16_b.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "M16B"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["basebarrel"] = {
			["active"] = false
		},
		["m16barrel"] = {
			["active"] = true
		}
	},
	["Bodygroups_W"] = {
		[2] = 3
	},
	["ViewModelBoneMods"] = {
		["A_Suppressor"] = { scale = Vector(1.1, 1.1, 1.1), pos = Vector(0, -13, -0.1), angle = Angle(0, 180, 0) },
	},
	["WorldModelBoneMods"] = {
		["ATTACH_Muzzle"] = { scale = Vector(0.7, 0.7, 0.7), pos = Vector(14, -1.4, 0.75), angle = Angle(0, 180, 0) },
	},
	["Primary"] = {
		["Spread"] = function(wep,stat) return stat * 1.2 end,
		["IronAccuracy"] = function(wep,stat) return stat * 0.9 end,
	},
	["MoveSpeed"] = function(wep,stat) return stat * 0.95 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.95 end,
}

function ATTACHMENT:Detach(wep)
	if wep.ViewModelKitOld then
		wep.ViewModel = wep.ViewModelKitOld
		if IsValid(wep.OwnerViewModel) then
			wep.OwnerViewModel:SetModel(wep.ViewModel)
			timer.Simple(0, function()
				wep:SendViewModelAnim(ACT_VM_IDLE)
			end)
		end
		wep.ViewModelKitOld = nil
	end
	if wep.WorldModelKitOld then
		wep.WorldModel = wep.WorldModelKitOld
		wep:SetModel(wep.WorldModel)
		wep.ViewModelKitOld = nil
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end