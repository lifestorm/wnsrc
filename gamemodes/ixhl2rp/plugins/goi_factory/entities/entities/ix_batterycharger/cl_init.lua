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

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
local glowMaterial = Material("sprites/glow04_noz")

function ENT:DrawTranslucent()
	self:DrawModel()

	local spritePos = self:GetPos() + self:GetUp() * 50.5 + self:GetRight() * 16.3 + self:GetForward() * 7.8

	if (!self.hideSprite) then
		render.SetMaterial(glowMaterial)
		render.DrawSprite(spritePos, 2.5, 2.5, Color(255, 0, 0))
	end

	if (imgui.Entity3D2D(self, Vector(7.3, -18, 52.5), Angle(0, 90, 90), 0.01)) then -- I didn't wanna fuck with button positions
		if (imgui.xButton(0, 0, 350, 350, 0, Color(255, 255, 255, 255), Color(255, 255, 255, 255), Color(255, 255, 255, 255))) then
			if (LocalPlayer():EyePos():DistToSqr(spritePos) > 3000) then imgui.End3D2D() return end

			self.hideSprite = true

			net.Start("ixBatteryChargerUse")
				net.WriteEntity(self)
			net.SendToServer()

			timer.Simple(0.1, function()
				self.hideSprite = false
			end)
		end

		imgui.End3D2D()
	end
end
