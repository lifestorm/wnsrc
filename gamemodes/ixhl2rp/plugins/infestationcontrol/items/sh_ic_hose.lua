--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "hoseItemName"
ITEM.model = Model("models/jq/hlvr/props/xen/combine_foam_hose.mdl")
ITEM.description = "hoseItemDesc"
ITEM.category = "Infestation Control"
ITEM.skin = 1
ITEM.exRender = true
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(178.91, 88.39, 13.04),
	ang = Angle(3.85, 205.44, 0),
	fov = 17.03
}

-- Inventory drawing
if (CLIENT) then
	-- Draw camo if it is available.
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("connected", false)) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
else
	-- Doing all this because the hose model has no physics model.
	function ITEM:OnEntityCreated(itemEntity)
		itemEntity:SetModel("models/squad/sf_plates/sf_plate3x3.mdl")
		itemEntity:DrawShadow(false)
		itemEntity:SetColor(Color(255, 255, 255, 0))
		itemEntity:SetRenderMode(RENDERMODE_TRANSCOLOR)

		itemEntity:PhysicsInit(SOLID_VPHYSICS)
		itemEntity:SetSolid(SOLID_VPHYSICS)

		local physObj = itemEntity:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end

		itemEntity.tube = ents.Create("prop_dynamic")
		itemEntity.tube:DrawShadow(true)
		itemEntity.tube:SetParent(itemEntity)
		itemEntity.tube:SetModel("models/jq/hlvr/props/xen/combine_foam_hose.mdl")
		itemEntity.tube:SetSkin(1)
		
		local forward, right, up = itemEntity:GetForward(), itemEntity:GetRight(), itemEntity:GetUp()
		
		itemEntity.tube:SetAngles(itemEntity:GetAngles())
		itemEntity.tube:SetPos(itemEntity:GetPos() + forward * 18 + right * - 20 + up * 5)
		itemEntity.tube:Spawn()
		itemEntity:DeleteOnRemove(itemEntity.tube)
	end
end

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("connected", false)) then
		return false
	end

	return true
end

ITEM.functions.Attach = {
	icon = "icon16/basket_put.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity

		if (target:GetClass() == "ix_infestation_tank" and trace.HitPos:Distance(client:GetShootPos()) <= 192) then
			if (target:GetDTBool(4) or target:GetDTBool(2)) then
				client:NotifyLocalized("hoseAttachFailureAttached")

				return false
			end

			if (item:GetData("connected", false)) then
				ix.item.PerformInventoryAction(client, "ConnectDis", item.id, item.invID)
			end

			target:SetBodygroup(target:FindBodygroupByName("Hose"), 0)
			target:SetDTBool(2, true)
			client:NotifyLocalized("hoseAttachSuccess")
		else
			client:NotifyLocalized("invalidTank")

			return false
		end
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}

ITEM.functions.Connect = {
	icon = "icon16/link.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity

		if (target:GetClass() == "ix_infestation_tank" and trace.HitPos:Distance(client:GetShootPos()) <= 192) then
			if (target:GetDTBool(4) or target:GetDTBool(2)) then
				client:NotifyLocalized("hoseConnectFailureConnected")

				return false
			end

			local inventoryID = client:GetCharacter():GetInventory():GetID()
			local inventory = ix.item.inventories[inventoryID]

			local hasOtherHoseConnected = false

			for _, items in pairs(inventory.slots) do
				for _, item in pairs(items) do
					if (item.uniqueID == "hose" and item:GetData("connected", false)) then
						hasOtherHoseConnected = true

						break
					end
				end
			end

			if (hasOtherHoseConnected) then
				client:NotifyLocalized("hoseConnectFailureMultipleHoses")
				
				return false
			end

			item:SetData("connected", target:EntIndex())
			target:SetDTBool(4, true)
			client:NotifyLocalized("hoseConnectSuccess")

			local rope = constraint.Rope(client, target, 0, 0, Vector(0, 0, 20), Vector(0, 0, 0), 0, 750, 1, 4, "cable/combine_foam_tank_hose_rope")

			rope:CallOnRemove("RopeBroken", function(entity)
				if (item.functions.ConnectDis.OnCanRun(item)) then
					item.functions.ConnectDis.OnRun(item, true, client)
				end
			end)

			client:SetNetVar("tankHose", rope)
		else
			client:NotifyLocalized("invalidTank")
		end

		return false
	end,
	OnCanRun = function(item)
		return !item:GetData("connected", false) and !IsValid(item.entity)
	end
}

ITEM.functions.ConnectDis = { -- Sorry
	name = "Disconnect",
	icon = "icon16/link_break.png",
	OnRun = function(item, forceUnequip, activator)
		local client = item.player
		
		if (forceUnequip == true) then
			client = activator
		end
		
		local character
		local inventory

		-- This is retarded but better safe than sorry.
		if (client) then
			character = client:GetCharacter()

			if (character) then
				inventory = character:GetInventory()

				if (!inventory) then
					return false
				end
			else
				return false
			end
		else
			return false
		end

		if (client:HasWeapon("weapon_applicator")) then
			if (forceUnequip == true) then
				local applicator = inventory:HasItem("applicator")

				if (applicator) then
					ix.item.PerformInventoryAction(client, "EquipUn", applicator.id, applicator.invID)
				end
			else
				client:NotifyLocalized("hoseDisconnectFailureApplicator")

				return false
			end
		end

		local target = item:GetData("connected", false)
		
		if (target and isnumber(target)) then
			target = Entity(target)

			if (target and target:IsValid()) then
				target:SetDTBool(4, false)
			end
		end

		item:SetData("connected", false)

		if (forceUnequip != true) then
			client:NotifyLocalized("hoseDisconnectSuccess")
		else
			client:NotifyLocalized("hoseDisconnectForced")
		end

		local rope = client:GetNetVar("tankHose")

		if (rope and IsValid(rope)) then
			rope:Remove()
		end

		client:SetNetVar("tankHose", nil)

		return false
	end,
	OnCanRun = function(item)
		return item:GetData("connected", false) and !IsValid(item.entity)
	end
}

function ITEM:OnLoadout()
	local connected = self:GetData("connected", false)

	if (connected and isnumber(connected)) then
		connected = Entity(connected)

		if (connected and connected:IsValid()) then
			connected:SetDTBool(4, false)
		end
	end

	self:SetData("connected", false)
end
