--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Chemical"
ITEM.model = Model("models/willardnetworks/skills/chemical_flask1.mdl")
ITEM.description = "A chemical used in Infestation Control."
ITEM.category = "Infestation Control"
ITEM.width = 1
ITEM.height = 2
ITEM.chemicalColor = Color(255, 255, 255)

ITEM.functions.Insert = {
	icon = "icon16/paintcan.png",
	OnRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor()
		local target = trace.Entity

		if (target:GetClass() == "ix_infestation_tank" and trace.HitPos:Distance(client:GetShootPos()) <= 192) then
			local chemicalType = target:GetChemicalType()

			if (chemicalType == "" or chemicalType == item.uniqueID) then
				if (target:GetChemicalVolume() < 100) then
					target:SetChemicalType(item.uniqueID)
					target:SetChemicalVolume(math.Clamp(target:GetChemicalVolume() + 25, 0, 100))
					target:SetColor(item.chemicalColor)

					client:NotifyLocalized("tankFilled", L(item.name, client))
				else
					client:NotifyLocalized("tankFull")

					return false
				end
			else
				client:NotifyLocalized("tankDifferentChemical")

				return false
			end
		else
			client:NotifyLocalized("invalidTank")

			return false
		end
	end
}
