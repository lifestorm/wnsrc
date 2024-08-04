--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Clé de chaîne"
ITEM.model = "models/willardnetworks/props/vortkey.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Une clé pour déverrouiller des chaînes d'un Vortigaunt."
ITEM.category = "Vortigaunt"
ITEM.colorAppendix = {["red"] = "Cette item peut uniquement être utiliser qu'une seule fois."}

local usedOnItems = {"Collier vortiguant", "Chaînes Vortigaunt", "Crochets vortigaunt"}

ITEM.functions.use = {
	name = "Utiliser sur soi",
	tip = "applyTip",
	icon = "icon16/key.png",
	OnCanRun = function(item)
		if (item.entity) then return false end

		local client = item.player
		if (client:GetMoveType() != MOVETYPE_NOCLIP or client:InVehicle()) then return false end

		return CAMI.PlayerHasAccess(client, "Helix - Shackles Self Release")
	end,
	OnRun = function(item)
		local character = item.player:GetCharacter()
		local foundSomething = false
		local collarID = false
		if character:IsVortigaunt() then
			for _, v in pairs(character:GetInventory():GetItems()) do
				if table.HasValue( usedOnItems, v.name ) and v:GetData("equip") == true and v:GetData("Locked") then
					if v:GetData("collarID") then
						collarID = v:GetData("collarID")
					end
					v:SetData("Locked", false)
					foundSomething = true
				end
			end

			if foundSomething then
				ix.combineNotify:AddImportantNotification(collarID and "WRN:// Une clée a été utiliser sur un collier avec l'ID: #" .. collarID or "WRN:// Une clée a été utiliser sur un collier avec une ID inconnu.", Color(255, 81, 0), item.player, item.player:GetPos())
				item.player:NotifyLocalized("Vos chaînes ne sont plus verrouillées et peuvent être enlevées...")
				return false
			else
				item.player:NotifyLocalized("Vous ne portez pas de chaînes verrouillées..")
				return false
			end
		else
			item.player:NotifyLocalized("Tu n’es pas un vortiguant !")
			return false
		end
	end,
}

ITEM.functions.give = {
	name = "Utiliser sur le personnage",
	tip = "giveTip",
	icon = "icon16/key_go.png",
	OnCanRun = function(item)
		if (item.entity) then return false end

		local trace = item.player:GetEyeTraceNoCursor()
		local target = trace.Entity
		if (!IsValid(target)) then
			return false
		end

		if (CLIENT and target:GetClass() == "prop_ragdoll") then
			return true
		end

		if (IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		if (!target:IsPlayer() or !target:GetCharacter()) then
			return false
		end
	end,
	OnRun = function(item)
		local target = item.player:GetEyeTraceNoCursor().Entity
		if (!IsValid(target)) then
			return false
		end

		if (IsValid(target.ixPlayer)) then
			target = target.ixPlayer
		end

		local targetChar = target:GetCharacter()
		local foundSomething = false
		local collarID = false

		if targetChar:IsVortigaunt() then
			for _, v in pairs(targetChar:GetInventory():GetItems()) do
				if table.HasValue( usedOnItems, v.name ) and v:GetData("equip") and v:GetData("Locked") then
					if v:GetData("collarID") then
						collarID = v:GetData("collarID")
					end
					v:SetData("Locked", false)
					foundSomething = true
				end
			end

			if foundSomething then
				ix.combineNotify:AddImportantNotification(collarID and "WRN:// Une clée a été utiliser sur un collier avec l'ID: #" .. collarID or "WRN:// Une clée a été utiliser sur le collier avec une ID inconnu.", Color(255, 81, 0), item.player, item.player:GetPos())
				item.player:NotifyLocalized("Ses chaînes ne sont plus verrouillées et peuvent être enlevées..")
			else
				item.player:NotifyLocalized("Il ne porte pas de chaînes verrouillées...")
			end
		else
			item.player:NotifyLocalized("Ce n'est pas un vortiguant !")
		end

		item.player:EmitSound("physics/metal/metal_box_strain1.wav", 110)
	end,
}
