--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Nawóz"
ITEM.description = "Niewielki worek wypełniony małymi bryłkami nawozu, saletry i innymi artykułami ogrodniczymi, które są niezbędne do uzyskania udanych i obfitych zbiorów."
ITEM.model = "models/props_junk/garbage_milkcarton001a.mdl"
ITEM.category = "Farming"

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Error", tooltip))
		data:SetText("Możesz użyć tego przedmiotu, aby zwiększyć poziom płodności rośliny")
		data:SizeToContents()
	end
end 

ITEM.functions.Water = {
	name = "Fertilize",
	icon = "icon16/brick.png",
	OnRun = function(item)
		local player = item.player
		local trace = player:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance(player:GetShootPos()) <= 192) then
			if (trace.Entity:GetClass() == "cw_plant") then
				trace.Entity.Fertilizer = math.min(trace.Entity.Fertilizer + 25, 100)
				trace.Entity:SetNWInt("Fertilizer", math.min(trace.Entity:GetNWInt("Fertilizer", 0) + 25, 100))
					

				player:ChatNotify("Rozsypujesz trochę nawozu wokół rośliny...")
				return true 
				 
			else				
				player:Notify("Nie patrzysz na prawidłową roślinę.")
				return false
			end
		end
	end
}
