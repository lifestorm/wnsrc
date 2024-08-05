--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:PostDrawTranslucentRenderables(bDrawingDepth, bDrawingSkybox)
	if (bDrawingDepth or bDrawingSkybox) then
		return
	end
	
	local client = LocalPlayer()

	if (ix.option.Get("npcspawnerESP", false) and client:GetMoveType() == MOVETYPE_NOCLIP) and !client:InVehicle() then
		for _, spawner in ipairs(ents.FindByClass("ix_npcspawner")) do
			local alpha = math.Remap(math.Clamp(client:GetPos():Distance(spawner:GetPos()), 1500, 2000), 1500, 2000, 255, 45)

			render.SetColorMaterial()
			//render.DrawSphere(spawner:GetPos(), spawner:GetSpawnRange(), 50, 50, Color(0, 150, 0, alpha / 2))
			render.DrawSphere(spawner:GetPos(), spawner:GetPlayerNoSpawnRange(), 50, 50, Color(150, 0, 0, alpha / 2))
			
			if LocalPlayer().npcEditStart then return end
			local center, min, max = spawner:SpawnAreaPosition(spawner:GetSpawnPosStart(), spawner:GetSpawnPosEnd())
			local color = Color(255, 255, 255, 255)

			render.DrawWireframeBox(center, angle_zero, min, max, color)
		end
	end
end
