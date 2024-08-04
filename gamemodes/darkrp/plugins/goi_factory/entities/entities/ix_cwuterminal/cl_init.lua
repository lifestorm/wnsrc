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
	local cwuMenu = ix.factoryPanels:CreatePanel("ixCWUTerminalMenu", self)
	cwuMenu:SetUsedBy(client)
	cwuMenu:SetUserGenData(istable(data) and !table.IsEmpty(data) and data[1] or nil)
	cwuMenu.cidCardInserted = data[1] and true or nil
	cwuMenu.cwuCardInserted = data[2] and true or nil
	cwuMenu.authError = data[3]


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
	vec = Vector(4.53, -8.15, 44.03),
	ang = Angle(0, 90, 55),
	res = 0.01
}

function ENT:DrawTranslucent()
	self:DrawModel()

	-- main panel
	vgui.Start3D2D( self:LocalToWorld(self.vguiLocalizedTransform.vec), self:LocalToWorldAngles(self.vguiLocalizedTransform.ang), self.vguiLocalizedTransform.res )
		if self.terminalPanel then
			self.terminalPanel:Paint3D2D()
		end
	vgui.End3D2D()

	-- buttons
	if (imgui.Entity3D2D(self, Vector(7.19, 10.16, 41.73), Angle(0, 90, 55), 0.01)) then
		if (imgui.xButton(22, -315, 100, 210, 5, Color(255, 44, 44, 0), Color(255, 44, 44, 255), Color(255, 44, 44, 10))) then
			if (!self.terminalPanel and self.nextClickTime < CurTime()) then
				self:TurnOn()
				self.nextClickTime = CurTime() + 1.5
			elseif (self.terminalPanel and self.nextClickTime < CurTime()) then
				self:TurnOff()
				self.nextClickTime = CurTime() + 1.5
			end
		end

		draw.SimpleText("CITY STOCK", "ButtonLabel", 470, 30, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if (imgui.xButton(0, 5, 150, 50, 5, Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 10)) and self.terminalPanel and self.nextClickTime < CurTime()) then
			if self.terminalPanel then
				self.terminalPanel:CreateOption(string.utf8upper("city stock"))
			end
			self.nextClickTime = CurTime() + 1.5
		end

		draw.SimpleText("MARKET", "ButtonLabel", 470, 155, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if (imgui.xButton(0, 130, 150, 50, 5, Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 10)) and self.nextClickTime < CurTime()) then
			if self.terminalPanel then
				self.terminalPanel:CreateOption(string.utf8upper("market"))
			end
			self.nextClickTime = CurTime() + 1.5
		end

		draw.SimpleText("CART", "ButtonLabel", 470, 280, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if (imgui.xButton(0, 254, 150, 50, 5, Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 10)) and self.nextClickTime < CurTime()) then
			if self.terminalPanel then
				self.terminalPanel:CreateOption(string.utf8upper("cart"))
			end
			self.nextClickTime = CurTime() + 1.5
		end

		draw.SimpleText("STATUS", "ButtonLabel", 470, 405, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if (imgui.xButton(0, 378, 150, 50, 5, Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 10)) and self.nextClickTime < CurTime()) then
			if self.terminalPanel then
				self.terminalPanel:CreateOption(string.utf8upper("status"))
			end
			self.nextClickTime = CurTime() + 1.5
		end

		draw.SimpleText("SHIFT", "ButtonLabel", 470, 530, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if (imgui.xButton(0, 503, 150, 50, 5, Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 10)) and self.nextClickTime < CurTime()) then
			if self.terminalPanel then
				self.terminalPanel:CreateOption(string.utf8upper("shift"))
			end
			self.nextClickTime = CurTime() + 1.5
		end

		--[[draw.SimpleText("CALL-IN", "ButtonLabel", 470, 653, Color(0, 0, 0, 225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if (imgui.xButton(0, 628, 150, 50, 5, Color(255, 255, 255, 0), Color(255, 255, 255, 255), Color(255, 255, 255, 10)) and self.nextClickTime < CurTime()) then

			self.nextClickTime = CurTime() + 1.5
		end--]]

		imgui.End3D2D()
	end
end
