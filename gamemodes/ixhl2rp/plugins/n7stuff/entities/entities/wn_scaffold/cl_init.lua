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

surface.CreateFont( "ScaffoldFont", {
	font = "Open Sans",
	extended = true,
	size = 30,
	weight = 500
} )


function ENT:Initialize()
end

function ENT:Draw()

	local TIMER;
	if (self:GetNWInt('timer') < CurTime()) then
		TIMER = 0
	else
		TIMER = (self:GetNWInt('timer')-CurTime())
	end
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), -90)

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 400 then
		cam.Start3D2D(Pos + Ang:Up() * 50, Ang, 0.3)
			draw.WordBox(0, -100, -190, "Building Scaffold", "ScaffoldFont", Color(255, 78, 69, 0), Color(240, 240, 240,255))
			draw.WordBox(0, -130, -150, "Building Materials: "..self:GetNWInt("ItemsRequired").."/40", "ScaffoldFont", Color(255, 78, 69, 0), Color(240, 240, 240,255)) -- /40
		if self:GetNWInt("ItemsRequired") == 40 then
		draw.WordBox(0, -100, -110, "Building Finished", "ScaffoldFont", Color(28, 161, 34, 0), Color(28, 161, 34,255))
		end
		cam.End3D2D()
	end
end

function ENT:Think()
end
