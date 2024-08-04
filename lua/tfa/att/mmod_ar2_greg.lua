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

ATTACHMENT.Name = "HD AR2"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "Overhauled textures."}
ATTACHMENT.Icon = "entities/mmod_ar2_greg.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "HD"

ATTACHMENT.WeaponTable = {
}

ATTACHMENT.MaterialTable = {
}

function ATTACHMENT:Attach(wep)
	local mag = wep:Clip1()
	wep.ViewModelKitOld = wep.ViewModelKitOld or wep.ViewModel
	wep.WorldModelKitOld = wep.WorldModelKitOld or wep.WorldModel
	wep.ViewModel = wep:GetStat("ViewModel_HD") or wep.ViewModel
	wep.WorldModel = wep:GetStat("WorldModel_HD") or wep.WorldModel
	if IsValid(wep.OwnerViewModel) then
		wep.OwnerViewModel:SetModel(wep.ViewModel)
		timer.Simple(0, function()
			if mag == 0 then
				wep:SendViewModelAnim(ACT_VM_IDLE_EMPTY)
			elseif mag == 1 then
				wep:SendViewModelSeq("idle_midempty")
			else
				wep:SendViewModelAnim(ACT_VM_IDLE)
			end
		end)
	end
	wep:SetModel(wep.WorldModel)
	wep.MaterialTable = wep.MaterialTable or {}
	wep.MaterialTable[2] = self.MaterialTable[2]
end

function ATTACHMENT:Detach(wep)
	local mag = wep:Clip1()
	if wep.ViewModelKitOld then
		wep.ViewModel = wep.ViewModelKitOld
		if IsValid(wep.OwnerViewModel) then
			wep.OwnerViewModel:SetModel(wep.ViewModel)
			timer.Simple(0, function()
			if mag == 0 then
				wep:SendViewModelAnim(ACT_VM_IDLE_EMPTY)
			elseif mag == 1 then
				wep:SendViewModelSeq("idle_midempty")
			else
				wep:SendViewModelAnim(ACT_VM_IDLE)
			end
			end)
		end
		wep.ViewModelKitOld = nil
	end
	if wep.WorldModelKitOld then
		wep.WorldModel = wep.WorldModelKitOld
		wep:SetModel(wep.WorldModel)
		wep.ViewModelKitOld = nil
	end
	wep.MaterialTable = wep.MaterialTable or {}
	wep.MaterialTable[2] = nil
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
