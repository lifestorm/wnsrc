--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function PLUGIN:HUDPaint()
	local client = LocalPlayer()
	local ghostNest = client.ghostNest

	if (client.isBuildingNest) then
		draw.SimpleTextOutlined("Press LMB to place nest", "DermaLarge", ScrW() / 2, ScrH()-230, Color(250,250,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 250))
		draw.SimpleTextOutlined("Press RMB to cancel", "DermaLarge", ScrW() / 2, ScrH()-200, Color(250,250,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 250))
		
		if (ghostNest) then
			ghostNest:SetPos(client:GetPos() + Angle(0, client:EyeAngles().y, 0):Forward() * 20 + Angle(0, client:EyeAngles().y, 0):Up() * -0.1)
			ghostNest:SetAngles(Angle(0, client:EyeAngles().y + 180, 0))
		else
			client.ghostNest = ents.CreateClientProp()
			client.ghostNest:SetModel("models/fless/exodus/gnezdo.mdl")
			client.ghostNest:SetMaterial("models/wireframe")
			client.ghostNest:Spawn()
			client.ghostNest:Activate()
			client.ghostNest:SetParent(client)
			client.ghostNest:SetRenderMode(RENDERMODE_TRANSALPHA)
		end
	elseif (ghostNest) then
		timer.Simple(0, function()
			if (ghostNest and IsValid(ghostNest)) then
				ghostNest:Remove()
				client.ghostNest = nil
			end
		end)
	elseif (client:GetNetVar("ixBirdMounting")) then
		draw.SimpleTextOutlined("Press SPACE to get off", "DermaLarge", ScrW() / 2, ScrH()-230, Color(250,250,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 250))
	end
end
