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

ATTACHMENT.Name = "Legacy Reticle"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "Uses old SMG reticle.", TFA.AttachmentColors["-"], "Cannot be colored." }
ATTACHMENT.Icon = "entities/mmod_si_smg_ret.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "RET"

ATTACHMENT.WeaponTable = {
}

function ATTACHMENT:Attach(wep)
	wep.ViewModelKitOld = wep.ViewModelKitOld or wep.ViewModel
	wep.WorldModelKitOld = wep.WorldModelKitOld or wep.WorldModel
	wep.ViewModel = wep:GetStat("ViewModel_RET") or wep.ViewModel
	wep.WorldModel = wep:GetStat("WorldModel_RET") or wep.WorldModel
	if IsValid(wep.OwnerViewModel) then
		wep.OwnerViewModel:SetModel(wep.ViewModel)
		timer.Simple(0, function()
			wep:SendViewModelAnim(ACT_VM_IDLE)
		end)
	end
	wep:SetModel(wep.WorldModel)
end

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
