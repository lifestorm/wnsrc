--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PANEL = {}

function PANEL:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function(self, width, height)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, width, height)

		Derma_DrawBackgroundBlur(self, 1)
	end

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(180), SScaleMin(300))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	local topbar = self.innerContent:Add("Panel")
	topbar:SetHeight(SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function(self, width, height)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, width, height)
	end
	
	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Egg Hatch Menu")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()
	
	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		if (self.ExitCallback) then
			self.ExitCallback()
		end
		
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end

	local divider = topbar:Add("Panel")
	divider:SetSize(1, topbar:GetTall())
	divider:Dock(RIGHT)
	divider:DockMargin(0, SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
	divider.Paint = function(self, w, h)
		surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
		surface.DrawLine(0, 0, 0, h)
	end
	
	local titleText = self.innerContent:Add("DLabel")
	titleText:SetFont("TitlesFontNoClamp")
	titleText:Dock(TOP)
	titleText:SetText("Select a player to receive a temporary bird whitelist:")
	titleText:DockMargin(0, SScaleMin(10 / 3), 0, SScaleMin(10 / 3))
	titleText:SetContentAlignment(5)
	titleText:SizeToContents()

	local scrollPanel = self.innerContent:Add("DScrollPanel")
	scrollPanel:Dock(FILL)
	scrollPanel:DockMargin(0, 0, 0, 20)
	
	for _, v in pairs(player.GetAll()) do
		if (v == LocalPlayer()) then continue end
		
		local playerPanel = scrollPanel:Add("DPanel")
		playerPanel:Dock(TOP)
		playerPanel:DockMargin(20, 0, 20, SScaleMin(10 / 3))
		playerPanel:SetTall(SScaleMin(50 / 3))
		playerPanel.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0, 130)
			surface.DrawRect(0, 0, w, h)
		end
		
		local avatar = playerPanel:Add("AvatarImage")
		avatar:SetSize(SScaleMin(50 / 3), SScaleMin(50 / 3))
		avatar:Dock(LEFT)
		avatar:SetPlayer(v, 64)
		
		local name = playerPanel:Add("DLabel")
		name:SetFont("TitlesFontNoClamp")
		name:Dock(FILL)
		name:DockMargin(10, 0, 0, 0)
		name:SetText(v:SteamName())
		name:SetContentAlignment(4)
		name:SizeToContents()
		
		local button = playerPanel:Add("DButton")
		button:SetText("")
		button:Dock(RIGHT)
		button:SetSize(SScaleMin(50 / 3), SScaleMin(50 / 3))
		button.Paint = function(self, w, h)
			surface.SetDrawColor(color_white)
			surface.SetMaterial(ix.util.GetMaterial("willardnetworks/mainmenu/charcreation/tick.png"))
			surface.DrawTexturedRectRotated(w / 2, h / 2, 30, 72, 0)
		end
		button.DoClick = function()
			net.Start("birdEggHatch")
				net.WriteEntity(v)
			net.SendToServer()

			self:Remove()
			surface.PlaySound("helix/ui/press.wav")
		end
	end
end

vgui.Register("ixbirdEggHatch", PANEL, "EditablePanel")
