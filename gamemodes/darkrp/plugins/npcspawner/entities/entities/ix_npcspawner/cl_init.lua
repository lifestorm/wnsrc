--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include("shared.lua")

local entityMat = CreateMaterial("GA0249aSFJ3","VertexLitGeneric",{
	["$basetexture"] = "models/debug/debugwhite",
	["$model"] = 1,
	["$translucent"] = 1,
	["$alpha"] = 1,
	["$nocull"] = 1,
	["$ignorez"] = 1
})

function ENT:Draw()
	if (ix.option.Get("npcspawnerESP", false) and LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP) and !LocalPlayer():InVehicle() then
		render.SuppressEngineLighting(true)
		render.SetColorModulation(255 / 255, 255 / 255, 255 / 255)
		render.SetBlend(math.Remap(math.Clamp(LocalPlayer():GetPos():Distance(self:GetPos()), 200, 4000), 200, 8000, 0.05, 1))
		render.MaterialOverride(entityMat)
		self:DrawModel()
		render.MaterialOverride()
		render.SuppressEngineLighting(false)
	end
end
