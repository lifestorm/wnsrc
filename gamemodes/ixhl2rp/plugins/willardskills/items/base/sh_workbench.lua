--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Workbench Base"
ITEM.description = "It is a workbench. Can only be picked up by the first person to place it."
ITEM.category = "Workbenches"
ITEM.isWorkbench = true

ITEM.functions.place = {
    name = "Place",
	tip = "Place the workbench",
	icon = "icon16/brick_add.png",
	OnRun = function(item)
        local client = item.player

        if (!client:Alive()) then return false end
        client:EmitSound("physics/cardboard/cardboard_box_break3.wav")

        client.previousWep = client:GetActiveWeapon():GetClass()
        client:Give("weapon_workbench_placer")
		client:SelectWeapon("weapon_workbench_placer")

		local weapon = client:GetActiveWeapon()
		weapon:SetInfo(item.uniqueID, item.model)

        return false
    end,
    OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

ITEM.functions.Use = {
	name = "Use",
	icon = "icon16/wrench.png",
	OnCanRun = function(itemTable)
		return IsValid(itemTable.entity)
	end,
	OnClick = function(itemTable)
		LocalPlayer().lastSelectedSkill = itemTable.workbenchSkill
		ix.gui.lastMenuTab = 3

		if (!IsValid(ix.gui.menu)) then
			vgui.Create("ixMenu")
		end
	end,
	OnRun = function(itemTable)
		return false
	end
}

ITEM.functions.PackUp = {
	name = "Pack Up",
	icon = "icon16/box.png",
	OnRun = function(item)
		local client = item.player
		local character = client and IsValid(client) and client.GetCharacter and client:GetCharacter()
		local inventory = character:GetInventory()
		local toolkit = inventory:HasItem("tool_toolkit")

		if (!toolkit) then
			client:Notify("You need a toolkit to pack up this workbench!")

			return false
		end

		if (item:GetData("bolted", false)) then
			client:Notify("This workbench is bolted down!")

			return false
		end

		local placerData = item:GetData("placer", false)
		if placerData and character:GetID() != placerData then
			client:Notify("You do not own this workbench!")
			return false
		end

		client:SetAction("Packing up workbench...", 10, function()
			if (inventory:Add(item.uniqueID .. "_assembly")) then
				toolkit:DamageDurability(1)
				client:Notify("Workbench packed up.")
			else
				client:Notify("You do not have enough inventory space to pack up this workbench!")

				return false
			end
		end)
	end,
	OnCanRun = function(item)
		return !item.noPackUp
	end
}

ITEM.functions.Bolt = {
	name = "Bolt Workbench",
	icon = "icon16/wrench.png",
	OnRun = function(item)
		local client = item.player
		local inventory = client:GetCharacter():GetInventory()
		local toolkit = inventory:HasItem("tool_toolkit")

		if (!toolkit) then
			client:Notify("You need a toolkit to bolt down this workbench!")

			return false
		end

		client:SetAction("Bolting down workbench...", 10, function()
			item:SetData("bolted", true)
			
			client:Notify("You bolt down the workbench.")
		end)
		
		toolkit:DamageDurability(1)
		
		return false
	end,
	OnCanRun = function(itemTable)
		return itemTable.entity and itemTable.entity:IsValid() and !itemTable:GetData("bolted", false)
	end
}

ITEM.functions.UnBolt = {
	name = "Unbolt Workbench",
	icon = "icon16/wrench_orange.png",
	OnRun = function(item)
		local client = item.player
		
		if (client:IsAdmin()) then
			item:SetData("bolted", false)
			
			client:Notify("Workbench unbolted.")
		else
			client:Notify("Workbench unbolting requires admin supervision. Please contact one before proceeding!")
		end
		
		return false
	end,
	OnCanRun = function(itemTable)
		return itemTable.entity and itemTable.entity:IsValid() and itemTable:GetData("bolted", false)
	end
}

ITEM.postHooks.drop = function(item, result)
	if (item.player and !item:GetData("placer")) then
		item:SetData("placer", item.player:GetCharacter():GetID())
	end
end

function ITEM:CanTransfer(oldInventory, newInventory)
	local placerData = self:GetData("placer", false)
	local newInvOwner = newInventory and newInventory.GetOwner and newInventory:GetOwner()

	if newInventory and newInvOwner then
		if newInvOwner and IsValid(newInvOwner) then
			if placerData and newInvOwner.GetCharacter and newInvOwner:GetCharacter():GetID() != placerData then
				newInvOwner:Notify("You are not the owner of this workbench!")

				return false
			end
		end
	end

	return true
end

function ITEM:OnEntityCreated(entity)
	timer.Simple(1, function()
		if (IsValid(entity)) then
			local physObj = entity:GetPhysicsObject()
			physObj:EnableMotion(false)
		end
	end)
end

function ITEM:OnEntityTakeDamage(entity, damage)
	return false
end
