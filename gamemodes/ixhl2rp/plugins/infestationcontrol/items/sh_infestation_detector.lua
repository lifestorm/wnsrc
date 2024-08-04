--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "detectorItemName"
ITEM.model = Model("models/hlvr/combine_hazardprops/combinehazardprops_detector.mdl")
ITEM.description = "detectorItemDesc"
ITEM.category = "Infestation Control"

ITEM.functions.Calibrate = {
	icon = "icon16/monitor_link.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local reading = nil
		
		for _, entity in ipairs(ents.FindInSphere(client:GetPos(), 192)) do
			if (entity:GetClass() == "ix_infestation_prop") then
				local readingData = ix.infestation.types[ix.infestation.stored[entity:GetInfestation()].type].reading
				reading = math.random(readingData[1], readingData[2]) .. ", " .. math.random(readingData[1], readingData[2]) .. ", " .. math.random(readingData[1], readingData[2])
				
				break
			end
		end
		
		client:EmitSound("helix/ui/press.wav")
		
		if (reading) then
			ix.util.EmitQueuedSounds(client, {"player/geiger" .. math.random(1, 3) .. ".wav", "player/geiger" .. math.random(1, 3) .. ".wav", "player/geiger" .. math.random(1, 3) .. ".wav"})
		end

		itemTable:SetData("reading", reading)

		return false
	end
}

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local reading = self:GetData("reading", "0, 0, 0")

		local panel = tooltip:AddRowAfter("name", "reading")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("reading") .. reading)
		panel:SizeToContents()
	end
end
