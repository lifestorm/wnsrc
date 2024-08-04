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

ATTACHMENT.Name = "MP5K Barrel"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Increases RPM to 975", "+5% movement speed",
	TFA.AttachmentColors["-"], "+20% recoil",
}
ATTACHMENT.Icon = "entities/tfafas2mp5k.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "PDW"

ATTACHMENT.WeaponTable = {
	["ViewModelBoneMods"] = {
	["A_Suppressor"] = { scale = Vector(.75, 1, .75), pos = Vector(10.25, .82, 0), angle = Angle(180, -90, 0)  },
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(-3.75, 0, 0), angle = Angle(0, 0, 0)  },
	["A_MuzzleSupp"] = { scale = Vector(1, 1, 1), pos = Vector(-2, 0, 0), angle = Angle(0, 0, 0)  },
	},
	["WorldModelBoneMods"] = {
	["ATTACH_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(-4, 0, -.29), angle = Angle(0, 0, 0)  },
},

	["Bodygroups_V"] = {[1] = 1, [3] = 1, [4] = 2},
	["Bodygroups_W"] = {[1] = 1},

	["Animations"] = {
		["draw"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_deploy"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["holster"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_holster"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["idle"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_idle"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["idle_empty"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_idle"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["shoot1"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_shoot"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["reload"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_reload"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
		["reload_empty"] = function(wep, _val)
			local val = table.Copy(_val)
			if val.type == TFA.Enum.ANIMATION_SEQ then
				val.value = val.value .. "mp5k_"
			else
				val.type = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val.value = "mp5k_reload_empty"
			end
			return (wep:CheckVMSequence(val.value) and val or _val), true, true
		end,
	},

	["Primary"] = {
		["KickUp"] = function( wep, stat ) return stat * 1.20 end,
		["Sound"] = function(wep,stat) return "FAS2TFA_MP5.2" or stat end,
		["SilencedSound"] = function(wep,stat) return "FAS2TFA_MP5.4" or stat end,
		["RPM"] = function( wep, stat ) return stat + 125 end,
	},
	["MoveSpeed"] = function( wep, stat ) return stat * 1.05 end,
	["IronSightsMoveSpeed"] = function( wep, stat ) return stat * 1.05 end,
	["IronSightsSensitivity"] = function( wep, stat ) return stat * 0.95 end,
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
