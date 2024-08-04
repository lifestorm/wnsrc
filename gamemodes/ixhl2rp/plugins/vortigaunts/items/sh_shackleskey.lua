--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Klucz do kajdan"
ITEM.model = "models/willardnetworks/props/vortkey.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Klucz do odblokowania elementów kajdan Vortigaunta."
	ITEM.category = "Vortigaunt"
	ITEM.colorAppendix = {["red"] = "Powinien być użyty tylko w Nexusie! Jest to przedmiot jednorazowego użytku."}

local usedOnItems = {"Obroża Vortigaunta", "Kajdany Vortigaunta", "Haki Vortigaunta"}

ITEM.functions.use = {
	name = "Użyj na sobie",
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
				ix.combineNotify:AddImportantNotification(collarID and "WRN:// Klucz został użyty na biotyku z ID obroży: #" .. collarID or "WRN:// Klucz został użyty na biotyku z nieznanym ID obroży.", Color(255, 81, 0), item.player, item.player:GetPos())
				item.player:NotifyLocalized("Twoje kajdany nie są już zamknięte i możesz je zdjąć.")
				return false
			else
				item.player:NotifyLocalized("Nie masz na sobie żadnych zamkniętych kajdan...")
				return false
			end
		else
			item.player:NotifyLocalized("Nie jesteś Vortigauntem!")
			return false
		end
	end,
}

ITEM.functions.give = {
	name = "Użyj na postaci",
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
				ix.combineNotify:AddImportantNotification(collarID and "WRN:// Klucz został użyty na biotyku z ID obroży: #" .. collarID or "WRN:// Klucz został użyty na biotyku z nieznanym ID obroży.", Color(255, 81, 0), item.player, item.player:GetPos())
				item.player:NotifyLocalized("Jego kajdany nie są już zamknięte i może je zdjąć.")
			else
				item.player:NotifyLocalized("Nie ma na sobie żadnych zamkniętych kajdan.")
			end
		else
			item.player:NotifyLocalized("Jest nie jest vortigauntem!")
		end

		item.player:EmitSound("physics/metal/metal_box_strain1.wav", 110)
	end,
}
