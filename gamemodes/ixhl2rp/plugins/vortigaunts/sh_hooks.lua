--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

function PLUGIN:PlayerHurt(client, attacker, health, damage)
	if (client:GetCharacter():IsVortigaunt()) then
		if ((client.ixNextPain or 0) < CurTime() and health > 0) then
			local PainVort = {
				"vo/npc/vortigaunt/vortigese07.wav",
				"vo/npc/vortigaunt/vortigese11.wav",
				"vo/npc/vortigaunt/vortigese03.wav"
			}

			local vort_pain = table.Random(PainVort)

			client:EmitSound(vort_pain, 75, math.random(95, 105))

			if vort_pain == "vo/npc/vortigaunt/vortigese11.wav" then
				client.ixNextPain = CurTime() + 3
			else
				client.ixNextPain = CurTime() + 1.5
			end
		end
	end
end

function PLUGIN:GetPlayerDeathSound(client)
	if (client:GetCharacter():IsVortigaunt()) then
		return false
	end
end

function PLUGIN:CheckCanTransferToEquipSlots(itemTable, oldInv, inventory)
	local client = itemTable.player or (oldInv and oldInv.GetOwner and oldInv:GetOwner()) or itemTable.GetOwner and itemTable:GetOwner()
	if client and IsValid(client) then
		if client:IsVortigaunt() and itemTable:GetData("Locked", false) then
			return false, "Your collar is locked so you cannot remove it!"
		end
	end
end

function PLUGIN:PostCanTransferToEquipSlots(owner, itemTable, oldInv, inventory)
	if owner.IsVortigaunt and owner:IsVortigaunt() then
		if y == 10 then
			return false, "Vortigaunts can't equip outfits in this slot!"
		end

		local factionList = itemTable.factionList and istable(itemTable.factionList) and itemTable.factionList or false
		if !factionList or factionList and !table.HasValue(factionList, FACTION_VORT) then
			if !itemTable.isBag then
				return false, "This is not clothing meant for vortigaunts!"
			end
		end
	end
end