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

ITEM.name = "Container"
ITEM.description = "Container."
ITEM.category = "Containers"
ITEM.model = "models/props_junk/wood_crate001a.mdl"
ITEM.width = 1
ITEM.height = 1

ITEM.colorAppendix = {["red"] = "Contact an admin to convert this into a container. Requires a group of minimum 5 members.", ["blue"] = "We have a limit of 2 small OR 1 medium personal container per player.\nGroups may also get 3 large containers."}
ITEM.maxStackSize = 1

if (CLIENT) then
	function ITEM:PaintOver(item, width, height)
		local client = LocalPlayer()
		local info = client:GetLocalVar("containerToPlaceInfo")

		if (info and info.itemID == item.id) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(width - 14, height - 14, 8, 8)
		end
	end
else
	function ITEM:OnTransferred(oldInv, newInv)
		local oldOwner = oldInv.GetOwner and oldInv:GetOwner() or nil
		local oldOwnerInfo = IsValid(oldOwner) and oldOwner:GetLocalVar("containerToPlaceInfo")

		if (oldOwnerInfo and oldOwnerInfo.itemID == self.id) then
			oldOwner:SetLocalVar("containerToPlaceInfo", nil)
		end
	end
end

ITEM:Hook("drop", function(item)
	local client = item.player
	local info = IsValid(client) and client:GetLocalVar("containerToPlaceInfo")

	if (info and info.itemID == item.id) then
		client:SetLocalVar("containerToPlaceInfo", nil)
	end
end)

ITEM.functions.Place = {
	name = "Place",
	tip = "placeTip",
	icon = "icon16/arrow_down.png",
	OnRun = function(item)
		local client = item.player
		local entity = item.entity

		if (IsValid(entity)) then
			local clientPos = client:GetPos()
			local entityPos = entity:GetPos()

			if (clientPos:DistToSqr(entityPos) <= 100 * 100) then
				PLUGIN:CreateContainer(client, entity:GetPos(), entity:GetAngles(), item.model, item.name, item.invType)

				return
			else
				client:Notify("Сontainer item is too far!")
			end
		else
			local info = {}
			info.itemID = item.id
			info.name = item.name
			info.model = item.model

			client:SetLocalVar("containerToPlaceInfo", info)
			client:SelectWeapon("ix_keys")
		end

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return isstring(item.model) and isstring(item.invType) and
			IsValid(client) and !client:GetLocalVar("containerToPlaceInfo") and
			hook.Run("CanPlayerEquipItem", client, item) != false
	end
}

ITEM.functions.PlaceCancel = {
	name = "Cancel Place",
	tip = "placeCancelTip",
	icon = "icon16/arrow_up.png",
	OnRun = function(item)
		local client = item.player

		client:SetLocalVar("containerToPlaceInfo", nil)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player
		local info = IsValid(client) and client:GetLocalVar("containerToPlaceInfo")

		return isstring(item.model) and isstring(item.invType) and
			!IsValid(item.entity) and info != nil and info.itemID == item.id and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}
