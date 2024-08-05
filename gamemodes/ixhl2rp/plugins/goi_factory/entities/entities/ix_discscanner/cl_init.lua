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
ENT.nextClickTime = 0

function ENT:TurnOn()
	net.Start("ix.terminal.turnOn")
		net.WriteEntity(self)
	net.SendToServer()
end

function ENT:TurnOff()
	net.Start("ix.terminal.turnOff")
		net.WriteEntity(self)
	net.SendToServer()
end

function ENT:CreateStartScreen(client, data)
	local encoderMenu = ix.factoryPanels:CreatePanel("ixDataEncoder", self)
	encoderMenu:SetUsedBy(client)
	encoderMenu:SetDisc(data[1] or false)
	self:EmitSound("buttons/button1.wav")
end

function ENT:PurgeScreenPanels(muteSound)
	ix.factoryPanels:PurgeEntityPanels(self)
	if (!muteSound) then
		self:EmitSound("buttons/button5.wav")
	end
end

function ENT:OnRemove()
	self:PurgeScreenPanels(true)
	self:StopSound("wn_goi/terminal_turnon.mp3")
end

ENT.vguiLocalizedTransform = {
	vec = Vector(6, -8.9, 65.710434),
	ang = Angle(0, 90, 90),
	res = 0.01
}

function ENT:DrawTranslucent()
	self:DrawModel()

	vgui.Start3D2D( self:LocalToWorld(self.vguiLocalizedTransform.vec), self:LocalToWorldAngles(self.vguiLocalizedTransform.ang), self.vguiLocalizedTransform.res )
		if self.terminalPanel then
			self.terminalPanel:Paint3D2D()
		end
	vgui.End3D2D()

	if (imgui.Entity3D2D(self, Vector(5.502635, -6.055101, 55.513432), Angle(90, 0, 0), 0.01)) then
		if (imgui.xButton(-75, -150, 100, 300, 5, Color(255, 44, 44, 0), Color(255, 44, 44, 75), Color(255, 44, 44, 10))) then
			if (!self.terminalPanel and self.nextClickTime < CurTime()) then
				self:TurnOn()
				self.nextClickTime = CurTime() + 1.5
			elseif (self.terminalPanel and self.nextClickTime < CurTime()) then
				self:TurnOff()
				self.nextClickTime = CurTime() + 1.5
			end
		end

		imgui.End3D2D()
	end

	if (!self:GetNetVar("scanning") or !IsEntity(self:GetNetVar("scanning")) or !IsValid(self:GetNetVar("scanning"))) then return end

	local topPos = self:LocalToWorld(Vector(0.139367, -0.340202, 47.403870))

	if (!LocalPlayer():IsLineOfSightClear(topPos)) then return end

	local trace = {}

	trace.mask = CONTENTS_SOLID + CONTENTS_MOVEABLE + CONTENTS_OPAQUE + CONTENTS_DEBRIS + CONTENTS_HITBOX + CONTENTS_MONSTER
	trace.start = LocalPlayer():EyePos()
	trace.endpos = topPos
	trace.filter = {LocalPlayer()}

	trace = util.TraceLine(trace)

	if (trace.Fraction < 0.75) then return end

	local right = self:GetRight() * math.sin(CurTime()) * 2

	for i = 1, 4 do
		render.DrawLine(self:LocalToWorld(self.linePoses[i]), self:GetNetVar("scanning"):LocalToWorld(self:GetNetVar("scanning"):OBBCenter()) + right * (i / 2), Color(255, math.random(50, 255), 0, math.random(100)))
	end
end
