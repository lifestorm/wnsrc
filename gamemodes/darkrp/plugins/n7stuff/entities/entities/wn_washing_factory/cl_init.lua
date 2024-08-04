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

surface.CreateFont( "WashingMachine", {
	font = "Roboto Light",
	extended = false,
	size = 25,
	weight = 500,
	extended = true
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

	if LocalPlayer():GetPos():Distance(self:GetPos()) < 200 then
		cam.Start3D2D(Pos + Ang:Up() * 14, Ang, 0.11)
			if (self:GetNWInt('timer') > CurTime()) then
				draw.RoundedBox(6, -47, -75, 165, 40, Color(15,15,15,225))
				draw.WordBox(2, -42, -70, "Process: "..string.ToMinutesSeconds(TIMER), "WashingMachine", Color(214, 181, 16, 200), Color(35,35,35,255))
			end
			draw.RoundedBox(6, -105, -125, 195, 44, Color(15,15,15,225)) -- Name
			draw.RoundedBox(6, -105, -75, 50, 40, Color(15,15,15,225)) -- /3
			draw.WordBox(2, -100, -117, "Washing Machine", "WashingMachine", Color(214, 181, 16, 200), Color(35,35,35,255))
			draw.WordBox(2, -100, -70, self:GetNWInt("ItemsRequired").."/3", "WashingMachine", Color(214, 163, 16, 200), Color(35,35,35,255))

		cam.End3D2D()
	end
end

function ENT:Think()
end
