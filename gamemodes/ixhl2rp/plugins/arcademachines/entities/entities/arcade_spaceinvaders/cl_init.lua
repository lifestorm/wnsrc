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

local DrawShip

DrawShip = function()
	draw.RoundedBox(0, 216-((CurTime()*80)%494)+0, -200, 60, 20, Color(55,255,55))
	draw.RoundedBox(0, 216-((CurTime()*80)%494)+5, -205, 50, 5, Color(55,255,55))
	draw.RoundedBox(0, 216-((CurTime()*80)%494)+20, -215, 20, 10, Color(55,255,55))
end


function ENT:Draw()
	self:DrawModel()

	if LocalPlayer():GetPos():Distance( self:GetPos() ) > 500 then return end	
	-- Basic setups
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	

	Ang:RotateAroundAxis(Ang:Up(), -90)
	Ang:RotateAroundAxis(Ang:Forward(), 76)

	cam.Start3D2D(Pos + Ang:Up()*10, Ang, 0.05)
	--	draw.RoundedBox(0, -120, -250, 170, 110, Color(70, 70, 70))
		draw.SimpleText("Space Invaders", "arcade_font80", -0, -450, HSVToColor(CurTime()*6*5%360,1,1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if ((CurTime()*4)%4) > 2 then 
			draw.SimpleText("Insert "..ix.config.Get("arcadePrice").." Credit", "arcade_font60", -0, -360, Color(55,210,55), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("to play!", "arcade_font60", -0, -320, Color(55,210,55), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if ((CurTime()*80)%494) > 140 and ((CurTime()*80)%494) < 300 then
			draw.RoundedBox(0, 100, -210-((CurTime()*80)%494)/10, 10, 10, Color(55,255,55))
		end
		if ((CurTime()*80)%494) > 240 and ((CurTime()*80)%494) < 420 then
			draw.RoundedBox(0, 0, -200-((CurTime()*80)%494)/10, 10, 10, Color(55,255,55))
		end
		if ((CurTime()*80)%494) > 340 and ((CurTime()*80)%494) < 580 then
			draw.RoundedBox(0, -100, -190-((CurTime()*80)%494)/10, 10, 10, Color(55,255,55))
		end

		DrawShip()


		-- Movement = 216-((CurTime()*60)%494)
		-- Off screen Right = 216
		-- Off screen Left = -278

	cam.End3D2D()
	Ang:RotateAroundAxis(Ang:Forward(), 14)

	local tr = LocalPlayer():GetEyeTrace().HitPos
	local pos = self:WorldToLocal(tr)
	local HeighlightColor = HSVToColor(CurTime()*6*5%360,1,1)

	cam.Start3D2D(Pos + Ang:Up()*22.4, Ang, 0.05)
		if pos.x < -22.174904 and pos.x > -23.252708 and pos.y < 9.953964 and pos.y > 8.003653 and pos.z < -2.079835 and pos.z > -6.987538 then
			draw.RoundedBox(0, -200, 40, 40, 100, HeighlightColor)
		else
			draw.RoundedBox(0, -200, 40, 40, 100, Color(0, 0, 0, 240))
		end
		draw.RoundedBox(0, -195, 45, 30, 90, Color(40, 40, 40, 255))
		draw.SimpleText("|", "arcade_font60", -180, 85, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end
