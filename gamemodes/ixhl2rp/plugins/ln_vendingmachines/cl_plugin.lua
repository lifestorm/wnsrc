--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


do
	local function vendorESP(client, entity, x, y, factor, distance)
		local color = Color(255, 255, 255, 255)
		local alpha = math.Remap(math.Clamp(distance, 1500, 2000), 1500, 2000, 255, 45)
		color.a = alpha

		ix.util.DrawText("Vending Machine", x, y + math.max(10, 32 * factor), color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
		ix.util.DrawText("ID: " .. entity:GetID(), x, y + math.max(10, 32 * factor) + 20, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
	end

	ix.observer:RegisterESPType("ix_customvendingmachine", vendorESP, "vendor")
end

net.Receive("ixVendingMachineManager", function()
	local entity = net.ReadEntity()

	vgui.Create("ixVendingMachineManager"):Populate({
		entity = entity,
		labels = entity:GetNetVar("labels", {}),
		buttons = entity:GetNetVar("buttons", {}),
		prices = entity:GetNetVar("prices", {}),
		stocks = entity:GetNetVar("stocks", false),
		credits = entity:GetNetVar("credits", 0)
	})
end)

local function ExitCallback()
	local machine = LocalPlayer().activeVendingMachine

	LocalPlayer().activeVendingMachine = nil
	net.Start("ixSelectVendingMachineCID")
	net.WriteBool(false)
	net.WriteEntity(machine)
	net.SendToServer()
end

local function SelectCallback(idCardID, cid, cidName, ent)
	net.Start("ixSelectVendingMachineCID")
	net.WriteBool(true)
	net.WriteEntity(ent)
	net.WriteUInt(idCardID, 16)
	net.SendToServer()
end

net.Receive("ixSelectVendingMachineCID", function()
	LocalPlayer().activeVendingMachine = net.ReadEntity()

	local cidSelector = vgui.Create("CIDSelector")

	cidSelector.activeEntity = LocalPlayer().activeVendingMachine
	cidSelector.ExitCallback = ExitCallback
	cidSelector.SelectCallback = SelectCallback
end)
