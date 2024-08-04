--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Clé de distributeur automatique"
ITEM.description = "Une petite pièce de métal composée d'une « lame » avec plusieurs coupes et d'un « arc », utilisée pour actionner une serrure."
ITEM.model = "models/gibs/metal_gib4.mdl"
ITEM.category = "Outils"

function ITEM:PopulateTooltip(tooltip)
	local ID = self:GetData("vendingMachineID", nil)

	if (ID) then
		local vendingMachineID = tooltip:AddRow("vendingMachineID")
		vendingMachineID:SetBackgroundColor(derma.GetColor("Info", tooltip))
		vendingMachineID:SetText("Il y est inscrit l'ID \"" .. ID .. "\".")
		vendingMachineID:SizeToContents()
	end
end

ITEM.functions.Insert = {
	name = "Insérer",
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
					client:Notify("Cette clé ne rentre pas dans ce distributeur automatique !")
				end
			else
				client:Notify("Ce distributeur automatique est trop loin !")
			end
		else
			client:Notify("La clé de distributeur automatique ne peut être insérée que dans un distributeur automatique !")
		end
			
		return false
	end,
	OnCanRun = function(itemTable)
		return !itemTable.entity
	end
}
