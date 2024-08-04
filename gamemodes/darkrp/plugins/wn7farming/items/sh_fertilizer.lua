--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Fertilisant"
ITEM.description = "Un petit sac rempli de petits morceaux d'engrais, de salpêtre et de toutes les bonnes choses de jardinage dont vous avez besoin pour obtenir une récolte réussie et abondante."
ITEM.model = "models/props/de_dust/hr_dust/dust_flour_sack/dust_flour_sack.mdl"
ITEM.category = "Farming"

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Error", tooltip))
		data:SetText("Vous pouvez utiliser cet objet pour augmenter le niveau de fertilité d'une plante.")
		data:SizeToContents()
	end
end 

ITEM.functions.Water = {
	name = "Fertiliser",
	icon = "icon16/brick.png",
	OnRun = function(item)
		local player = item.player
		local trace = player:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance(player:GetShootPos()) <= 192) then
			if (trace.Entity:GetClass() == "cw_plant") then
				trace.Entity.Fertilizer = math.min(trace.Entity.Fertilizer + 25, 100)
				trace.Entity:SetNWInt("Fertilizer", math.min(trace.Entity:GetNWInt("Fertilizer", 0) + 25, 100))
					

				player:ChatNotify("Vous avez répandu de l'engrais autour de la plante....")
				return true 
				 
			else				
				player:Notify("Vous ne regardez pas une plante valide.")
				return false
			end
		end
	end
}
