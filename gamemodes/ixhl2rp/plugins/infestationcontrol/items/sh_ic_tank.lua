--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "tankItemName"
ITEM.model = Model("models/hlvr/combine_hazardprops/combinehazardprops_hoover.mdl")
ITEM.description = "tankItemDesc"
ITEM.category = "Infestation Control"
ITEM.width = 6
ITEM.height = 4

ITEM.functions.drop = {
	icon = "icon16/world.png",
	OnRun = function(itemTable)
		local client = itemTable.player
		local trace = client:GetEyeTraceNoCursor()

		if (trace.HitPos:Distance(client:GetShootPos()) <= 192) then
			local tank = ents.Create("ix_infestation_tank")
			tank:SetPos(trace.HitPos)
			tank:SetChemicalType(itemTable:GetData("ChemicalType", ""))
			tank:SetChemicalVolume(itemTable:GetData("ChemicalVolume", 0))
			tank:SetColor(itemTable:GetData("TankColor", Color(255, 255, 255)))
			tank:Spawn()
			ix.saveEnts:SaveEntity(tank)

			client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)

			client:NotifyLocalized("tankDeploySuccess")

			local currentItems = client:GetNetVar("visibleItems", {})
			
			if (currentItems["tankItemName"]) then
				currentItems["tankItemName"] = nil
			end
			
			client:SetNetVar("visibleItems", currentItems)
		else
			client:NotifyLocalized("tankDeployFailureDistance")

			return false
		end
	end,
	OnCanRun = function(itemTable)
		return !IsValid(itemTable.entity)
	end
}

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		local type = self:GetData("ChemicalType")
		local volume = self:GetData("ChemicalVolume")

		type = ix.item.list[type] and ix.item.list[type].name or L("none")
		volume = volume and volume .. "%" or L("empty")

		local panel = tooltip:AddRowAfter("name", "type")
		panel:SetBackgroundColor(derma.GetColor("Information", tooltip))
		panel:SetText(L("chemicalType") .. type)
		panel:SizeToContents()

		panel = tooltip:AddRowAfter("type", "volume")
		panel:SetBackgroundColor(derma.GetColor("Warning", tooltip))
		panel:SetText(L("chemicalVolume") .. volume)
		panel:SizeToContents()
	end
end
