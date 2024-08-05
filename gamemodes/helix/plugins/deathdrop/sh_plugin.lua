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
local table = table
local pairs = pairs
local ents = ents
local IsValid = IsValid
local Color = Color
local math = math


local PLUGIN = PLUGIN

PLUGIN.name = "Drop Items on Death"
PLUGIN.author = "AleXXX_007"
PLUGIN.description = "After death, the character will drop they belongings."

ix.config.Add("dropItems", false, "Whether or not characters drop their items after death.", nil, {
	category = "Drop Items on Death"
})

ix.config.Add("dropContainerModel", "models/props_c17/BriefCase001a.mdl", "A model path of a container with dropped items.", nil, {
	category = "Drop Items on Death"
})

ix.util.Include("sv_plugin.lua")

if (ix.allowedHoldableClasses) then
	ix.allowedHoldableClasses["ix_drop"] = true
end

ix.char.RegisterVar("refundItems", {
	field = "refundItems",
	default = {},
	bNoNetworking = true,
	bNoDisplay = true
})

ix.lang.AddTable("english", {
	deathDropRemoved = "Removed a total of %d death drops."
})

ix.lang.AddTable("spanish", {
	deathDropRemoved = "Borrados un total de %d death drops."
})

ix.command.Add("RemoveDeathDrops", {
	description = "Removes all death drops on the map or in the given radius.",
	adminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, radius)
		radius = radius and radius * radius or math.huge
		local pos = client:GetPos()

		local count = 0
		for k, v in pairs(ents.GetAll()) do
			if (!IsValid(v)) then continue end

			if (v:GetClass() != "ix_drop") then continue end
			if (v:GetPos():DistToSqr(pos) > radius) then continue end

			v:Remove()
			count = count + 1
		end

		return "@deathDropRemoved", count
	end
})

if (CLIENT) then
	function PLUGIN:PostDrawTranslucentRenderables(bDrawingDepth, bDrawingSkybox)
		local command = string.utf8lower(ix.chat.currentCommand)
		if (command == "removedeathdrops") then
			local range = tonumber(ix.chat.currentArguments[1])
			if (range) then
				render.SetColorMaterial()
				render.DrawSphere(LocalPlayer():GetPos(), 0 - range, 50, 50, Color(255,150,0,100))
			end
		end
	end
end

ix.command.Add("RefundKill", {
	description = "Returns all items player lost after they last death.",
	adminOnly = true,
	arguments = {
		ix.type.player
	},
	OnRun = function(self, client, target)
		local inventory = target:GetCharacter():GetInventory()
		local itemIds = target:GetCharacter():GetRefundItems()

		if (!itemIds) then
			client:NotifyLocalized("plyNoRefunding")
		end
		local leftItems = table.Copy(itemIds)
		local lost = 0
		local temp = false

		for _, v in pairs(itemIds) do
			local itemTable = ix.item.instances[v]
			if (!itemTable) then
				lost = lost + 1
				continue
			end

			local curInv = ix.item.inventories[self.invID or 0]
			if (!curInv) then
				ErrorNoHalt("[DEATHDROP] Failed to transfer item "..itemTable.uniqueID.." (#"..v.."), no curInv!")
				continue
			end

			local w, h = itemTable.width, itemTable.height
			if (inventory:FindEmptySlot(w, h)) then
				PLUGIN:TransferItem(target, itemTable, curInv, inventory)
				table.RemoveByValue(leftItems, v)
			else
				temp = true

				local container = ents.Create("ix_drop")
				container:SetPos(target:GetPos() + target:GetAngles():Forward() * 5)
				container:SetModel(ix.config.Get("dropContainerModel", "models/props_c17/BriefCase001a.mdl"))
				container:Spawn()

				ix.inventory.New(0, "droppedItems", function(newInv)
					newInv.vars.isBag = false
					newInv.vars.isDrop = true

					function newInv.OnAuthorizeTransfer(_, _, _, item)
						if (item.authorized) then
							return true
						end
					end

					if (!IsValid(container)) then
						return
					end

					container:SetInventory(newInv)
					newInv.vars.entity = container

					for _, v1 in pairs(leftItems) do
						local item = ix.item.instances[v1]

						if (!item) then continue end
						local owner = item:GetOwner()
						local curInv1 = IsValid(owner) and owner:GetCharacter():GetInventory() or false

						PLUGIN:TransferItem(owner, item, curInv1, newInv)
					end

					ix.saveEnts:SaveEntity(container)
				end)

				break
			end
		end

		local notify = temp and "plyRefundTemp" or "plyRefund"
		client:NotifyLocalized(notify)

		if (lost > 0) then
			client:NotifyLocalized("plyRefundLost", lost)
		end

		if (client != target) then
			target:NotifyLocalized(notify)

			if (lost > 0) then
				target:NotifyLocalized("plyRefundLost", lost)
			end
		end

		target:GetCharacter():SetRefundItems(nil)
	end
})

function PLUGIN:InitializedConfig()
	ix.inventory.Register("droppedItems", 9, 9)
end

function PLUGIN:CanTransferItem(itemTable, curInv, inventory)
	if (!itemTable.authorized) then
		if (curInv:GetID() == 0) then return end

		if (curInv.vars and curInv.vars.isDrop and inventory:GetID() == curInv:GetID()) then
			return false
		end

		if (inventory.vars and inventory.vars.isDrop) then
			return false
		end
	end
end

function PLUGIN:OnItemTransferred(itemTable, curInv, inventory)
	if (curInv.vars and curInv.vars.isDrop and table.IsEmpty(curInv:GetItems())) then
		local container = curInv.vars.entity

		if (IsValid(container)) then
			container:Remove()
		end
	end
end

if (CLIENT) then
	local color = Color(255, 0, 128)
	function PLUGIN:InitializedPlugins()
		local function drawDropESP(client, entity, x, y, factor)
			ix.util.DrawText("Death Drop", x, y - math.max(10, 32 * factor), color,
				TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, math.max(255 * factor, 80))
		end

		ix.observer:RegisterESPType("ix_drop", drawDropESP, "drop")
	end
end
