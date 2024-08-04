--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


PLUGIN.activeClientProps = PLUGIN.activeClientProps or {}

function PLUGIN:ManageClientsideProp(csentData)
	if (NikNaks.PVS.IsPositionVisible(csentData.position, LocalPlayer():EyePos())) then
		for _, activeProp in ipairs(self.activeClientProps) do
			if (csentData.position:IsEqualTol(activeProp:GetPos(), 0.1)) then return end -- Ensure we don't have a duplicate
		end

		local clientProp = ClientsideModel(csentData.model)
		clientProp:SetPos(csentData.position)
		clientProp:SetAngles(csentData.angles)
		clientProp:SetSkin(csentData.skin)
		clientProp:SetColor(csentData.color)
		clientProp:SetRenderMode(RENDERMODE_TRANSCOLOR)
		clientProp:SetMaterial(csentData.material)

		clientProp:Spawn()

		self.activeClientProps[#self.activeClientProps + 1] = clientProp
	else
		for k, activeProp in ipairs(self.activeClientProps) do
			if (!csentData.position:IsEqualTol(activeProp:GetPos(), 0.1)) then continue end

			activeProp:Remove()

			table.remove(self.activeClientProps, k)

			return
		end
	end
end
