--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Fertilizer"
ITEM.description = "A small sack filled with small lumps of fertilizer, saltpetre and all the gardening goodies that you need to make a succesful and bountiful harvest."
ITEM.model = "models/props_junk/garbage_milkcarton001a.mdl"
ITEM.category = "Farming"

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Error", tooltip))
		data:SetText("You can use this item to increase the fertility level of a plant")
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
					

				player:ChatNotify("You spread some fertilizer around the plant...")
				return true 
				 
			else				
				player:Notify("You are not looking at a valid plant.")
				return false
			end
		end
	end
}
