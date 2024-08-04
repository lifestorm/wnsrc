--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


ITEM.name = "Patyk"
ITEM.model = "models/props_debris/wood_splinters01a.mdl"
ITEM.description = "Mały ułamany patyk, raczej do niczego się nie przyda."
ITEM.birdDescription = "Mały patyk, który idealnie nadaje się do zrobienia gniazda. Jeżeli spojrzysz na gniazdo będziesz mógł dołożyć do niego patyki, w innym wypadku stworzysz nowe."
ITEM.category = "Junk"
ITEM.maxStackSize = 16

function ITEM:GetDescription()
	return LocalPlayer():Team() == FACTION_BIRD and self.birdDescription or self.description
end

ITEM.functions.BuildNest = {
	name = "Zbuduj gniazdo",
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
