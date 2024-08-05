--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Vending Machine Key"
ITEM.description = "A small piece of metal consisting of a 'blade' with several cuts and a 'bow', used to operate a lock."
ITEM.model = "models/gibs/metal_gib4.mdl"
ITEM.category = "Tools"

function ITEM:PopulateTooltip(tooltip)
	local ID = self:GetData("vendingMachineID", nil)

	if (ID) then
		local vendingMachineID = tooltip:AddRow("vendingMachineID")
		vendingMachineID:SetBackgroundColor(derma.GetColor("Info", tooltip))
		vendingMachineID:SetText("It has \"" .. ID .. "\" engraved on it.")
		vendingMachineID:SizeToContents()
	end
end

ITEM.functions.Insert = {
	icon = "icon16/key.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity

		if (target and target:GetClass() == "ix_customvendingmachine") then
			if (trace.HitPos:Distance(client:GetShootPos()) < 200) then
				if (itemTable:GetData("vendingMachineID", nil) == target:GetID()) then
					target:SetLocked(!target:GetLocked())
					target:EmitSound("buttons/combine_button" .. math.random(1, 3) .. ".wav")
				else
					client:Notify("This key does not fit in this Vending Machine!")
				end
			else
				client:Notify("That Vending Machine is too far away!")
			end
		else
			client:Notify("The Vending Machine Key can only be inserted into a vending machine!")
		end
			
		return false
	end,
	OnCanRun = function(itemTable)
		return !itemTable.entity
	end
}
