--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local ix = ix
local pairs = pairs
local math = math

local PLUGIN = PLUGIN

-- Always ensure the character's current CID item is loaded
function PLUGIN:CharacterLoaded(character)
	local idCardID = character:GetIdCard()
	local inventory = character:GetInventory()
	if (idCardID and (!inventory or !inventory:GetItemByID(idCardID)) and !ix.item.instances[idCardID]) then
		ix.item.LoadItemByID(idCardID)
	end

	if (inventory) then
		for _, v in pairs(inventory:GetItems()) do
			if (v:GetData("cardID") and !ix.item.instances[v:GetData("cardID")]) then
				ix.item.LoadItemByID(v:GetData("cardID"))
			end
		end
	end
end

function PLUGIN:OnCharacterCreated(client, character)
	local charID = character.id
	local id = self:GenerateCid(charID)

	character:SetCid(id)
end

function PLUGIN:InventoryItemAdded(oldInv, inventory, newItem)
	if (oldInv != nil) then return end

	if (newItem.uniqueID == "id_card" and
		newItem:GetData("owner") == inventory.owner and
		newItem:GetData("active") != false) then

		local character = ix.char.loaded[inventory.owner]
		local oldCardId = character:GetIdCard()
		if (oldCardId) then
			local oldCard = ix.item.instances[oldCardId]
			if (oldCard) then
				oldCard:TransferData(newItem, true)
			end
		else
			local dataBackup = character:GetIdCardBackup({})
			for k, v in pairs(dataBackup) do
				newItem:SetData(k, v)
			end
		end

		character:SetIdCard(newItem:GetID())
	end
end
