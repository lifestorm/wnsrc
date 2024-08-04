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

local DrawCircle

DrawCircle = function( x, y, radius, seg )
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
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
		draw.SimpleText("PONG", "arcade_font80", -0, -450, HSVToColor(CurTime()*6*5%360,1,1), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if ((CurTime()*4)%4) > 2 then 
			draw.SimpleText("Insert "..ix.config.Get("arcadePrice").." Credit", "arcade_font60", -0, -360, Color(55,210,55), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("to play!", "arcade_font60", -0, -320, Color(55,210,55), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		
		surface.SetDrawColor( 255, 255, 255, 255 )
		draw.NoTexture()
		if ((CurTime()*40)%494) > 247 then
			DrawCircle(216-(CurTime()*80)%494, -220, 10, 20)
		else
			DrawCircle(-216+(CurTime()*80)%494, -220, 10, 20)
		end

		draw.RoundedBox(0, -215, -260, 10, 70, Color(255,255,255))
		draw.RoundedBox(0, 205, -260, 10, 70, Color(255,255,255))

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
