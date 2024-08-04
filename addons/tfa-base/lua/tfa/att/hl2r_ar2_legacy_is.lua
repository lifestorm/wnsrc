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

ATTACHMENT.Name = "Ironsight-less"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["-"], "Removes the ironsight on the AR2.", TFA.AttachmentColors["+"], "Appreciate all the intricate mechanisms of the AR2." }
ATTACHMENT.Icon = "entities/hl2r_ar2_legacy_is.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "LEGACY"

ATTACHMENT.WeaponTable = {
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_LEG or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_LEG or val end,
	["IronSightTime"] = function( wep, val ) return val * 1 end,
}
function ATTACHMENT:Attach(wep)
	local mag = wep:Clip1()
	wep.DrawCrosshairIS = true
	wep.ViewModelKitOld = wep.ViewModelKitOld or wep.ViewModel
	wep.ViewModel = wep:GetStat("ViewModel_LEG") or wep.ViewModel
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
end

function ATTACHMENT:Detach(wep)
	local mag = wep:Clip1()
	wep.DrawCrosshairIS = false
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
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
