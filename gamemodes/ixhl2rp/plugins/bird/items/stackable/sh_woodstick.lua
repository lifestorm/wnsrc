--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Wood Stick"
ITEM.model = "models/props_debris/wood_splinters01a.mdl"
ITEM.description = "A tiny wooden stick. It's probably not useful to anyone."
ITEM.birdDescription = "A tiny wooden stick. You can use this to make a nest. If you are looking at a nest, you will put the stick(s) in it. Otherwise, you will create a new one."
ITEM.category = "Junk"
ITEM.maxStackSize = 16

function ITEM:GetDescription()
	return LocalPlayer():Team() == FACTION_BIRD and self.birdDescription or self.description
end

ITEM.functions.BuildNest = {
	name = "Build Nest",
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
