--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Klucz do automatu"
ITEM.description = "Specjalnie stworzony, mały kawałek metalu robiący za klucz do zamka w automacie."
ITEM.model = "models/gibs/metal_gib4.mdl"
ITEM.category = "Tools"

function ITEM:PopulateTooltip(tooltip)
	local ID = self:GetData("vendingMachineID", nil)

	if (ID) then
		local vendingMachineID = tooltip:AddRow("vendingMachineID")
		vendingMachineID:SetBackgroundColor(derma.GetColor("Info", tooltip))
		vendingMachineID:SetText("Wygrawerowane na kluczu \"" .. ID .. "\".")
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
					client:Notify("Ten Klucz nie pasuje do tego automatu!")
				end
			else
				client:Notify("Automat jest za daleko!")
			end
		else
			client:Notify("Klucz do automatu może być tylko włożony do automatu.")
		end
			
		return false
	end,
	OnCanRun = function(itemTable)
		return !itemTable.entity
	end
}
