--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Bâton"
ITEM.model = "models/props_debris/wood_splinters01a.mdl"
ITEM.description = "Un petit bâton de bois. Totalement inutile pour vous."
ITEM.birdDescription = "Un petit bâton en bois, lisse et poli, de la taille d'un doigt, avec une extrémité pointue et l'autre légèrement incurvée. Cet objet est souvent utilisé par les oiseaux pour construire leur nid."
ITEM.category = "Déchets"
ITEM.maxStackSize = 10

function ITEM:GetDescription()
	return LocalPlayer():Team() == FACTION_BIRD and self.birdDescription or self.description
end

ITEM.functions.BuildNest = {
	name = "Constuire un nid",
	icon = "icon16/basket.png",
	OnRun = function(item)
		local client = item.player
		local target = client:GetEyeTraceNoCursor().Entity

		if (target and target:GetClass() == "ix_birdnest") then
			local progress = target:GetNetVar("progress", 0)
			local stackSize = item:GetStackSize()
			
			target:SetProgress(progress + stackSize)
			target:EmitSound("physics/cardboard/cardboard_box_break" .. math.random(1, 3) .. ".wav")

			local position = target:LocalToWorld(target:OBBCenter())

			local effect = EffectData()
				effect:SetStart(position)
				effect:SetOrigin(position)
				effect:SetScale(1)
			util.Effect("GlassImpact", effect)

			item:RemoveStack(stackSize)
		else
			client.isBuildingNest = true
			
			net.Start("toggleBuildingNest")
				net.WriteBool(true)
			net.Send(client)
		end

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item.player:Team() == FACTION_BIRD
	end
}
