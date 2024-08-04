--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Engrais avancé"
ITEM.description = "Un petit sac rempli de petits morceaux d'engrais, de salpêtre et de tous les bons produits de jardinage dont vous avez besoin pour obtenir une récolte abondante et réussie. Celui-ci a été fabriqué avec maîtrise pour répondre à tous les besoins des plantes."
ITEM.model = "models/props/de_dust/hr_dust/dust_flour_sack/dust_flour_sack.mdl"
ITEM.category = "Farming"

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Error", tooltip))
		data:SetText("Vous pouvez utiliser cet article pour augmenter la fertilité et l'hydratation d'une plante.")
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
				trace.Entity.Fertilizer = 100
				trace.Entity.Hydration = 100
			
				player:ChatNotify("Vous avez épandu de l'engrais autour de la plante... la plante est contente !!")
				return true 
			else				
				player:Notify("Vous ne regardez pas une plante valide.")
				return false
			end
		end
	end
}
