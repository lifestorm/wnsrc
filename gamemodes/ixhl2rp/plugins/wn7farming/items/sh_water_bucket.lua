--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Watering Can"
ITEM.description = "A metal gas can repurposed as a watering can that can be filled with water, specially to water down Plants."
ITEM.model = "models/props_junk/metalgascan.mdl"
ITEM.category = "Farming"

if (CLIENT) then
	local color_green = Color(0, 255, 0, 255)
	local color_red = Color(255, 50, 50, 255)

	function ITEM:PopulateTooltip(tooltip)
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Error", tooltip))
		data:SetText("You can use this bucket directly on plants to water them and increase their Hydration levels\nYou can fill it at bodies of water or Water Caches.")
		data:SizeToContents()

		local water = tooltip:AddRow("water")
		water:SetBackgroundColor(derma.GetColor("Error", tooltip))
		water:SetText("Water: " ..self:GetData("water", 0).. "%")
		water:SizeToContents()
	end
end 

ITEM.functions.Water = {
	name = "Water Plant",
	icon = "icon16/drink.png",
	OnRun = function(item)
		local player = item.player
		local trace = player:GetEyeTraceNoCursor()

		if item:GetData("water") > 0 then 
			if (trace.HitPos:Distance(player:GetShootPos()) <= 192) then
				if (trace.Entity:GetClass() == "cw_plant") then

					local hydration = trace.Entity.Hydration
					trace.Entity.Hydration = math.min(hydration + 25, 100)
				
					local newValue = item:GetData("water", 0) - 25
					item:SetData("water", newValue)
					player:EmitSound("ambient/water/water_spray1.wav")
					player:ChatNotify("You water the plant with the contents of the bucket!")
				else				
					player:Notify("You are not looking at a valid plant.")
				end
			end
		else 
			player:Notify("There's not enough water on the bucket!")
		end 

		return false 
	end
}

ITEM.functions.fill = {
	name = "Fill with Water",
	tip = "applyTip",
	icon = "icon16/arrow_in.png",
	OnRun = function(item)
		if (SERVER) then
			local client = item.player
			local targetEnt = client:GetEyeTraceNoCursor().Entity

			if item:IsWaterDeepEnough(client) then 
				if  item:GetData("water") != 100 then 
					local newValue = item:GetData("water", 0) + 25
					client:ChatNotify("You've refilled to "..newValue.."%")
			
					item:SetData("water", newValue)
					client:EmitSound("ambient/water/water_spray1.wav")
				end 
			end 


			if targetEnt:GetClass() == "ix_watercache" or (targetEnt:GetClass() == "ix_cleanwatercache" and targetEnt:GetNetVar("broken", false)) then 
				if  item:GetData("water") != 100 then 
					local newValue = item:GetData("water", 0) + 25
					client:ChatNotify("You've refilled the Watering Can to "..newValue.."%")
			
					item:SetData("water", newValue)
					client:EmitSound("ambient/water/water_spray1.wav")
				else 
					client:ChatNotify("The Watering Can is full!")
				end 
			else 
				client:ChatNotify("You are not looking at a valid Water Source!")
			end 
		end

		return false
	end
}

function ITEM:IsWaterDeepEnough(client)
    local pos = client:GetPos() + Vector(0, 0, 15)
    local trace = {}
    trace.start = pos
    trace.endpos = pos + Vector(0, 0, 1)
    trace.mask = bit.bor( MASK_WATER )
    local tr = util.TraceLine(trace)

    return tr.Hit
end

function ITEM:OnInstanced(index, x, y, item)
	self:SetData("water", 0)
end
  
