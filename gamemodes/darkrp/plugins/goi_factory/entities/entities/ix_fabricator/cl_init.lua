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
	local fabricatorMenu = ix.factoryPanels:CreatePanel("ixFabricator", self)
	fabricatorMenu:SetUsedBy(client)
	fabricatorMenu:SetDisc(data[1] or "")
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
	vec = Vector(16, -40.15, 43.25),
	ang = Angle(0, 65, 55),
	res = 0.01
}

function ENT:DrawTranslucent()
	self:DrawModel()

	vgui.Start3D2D( self:LocalToWorld(self.vguiLocalizedTransform.vec), self:LocalToWorldAngles(self.vguiLocalizedTransform.ang), self.vguiLocalizedTransform.res )
		if self.terminalPanel then
			self.terminalPanel:Paint3D2D()
		end
	vgui.End3D2D()

	if (imgui.Entity3D2D(self, Vector(17.592129, -44.555752, 40.282715), Angle(0, 65, 55), 0.01)) then
		if (imgui.xButton(-165, 10, 285, 135, 5, Color(255, 44, 44, 0), Color(255, 44, 44, 255), Color(255, 44, 44, 10))) then
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
end