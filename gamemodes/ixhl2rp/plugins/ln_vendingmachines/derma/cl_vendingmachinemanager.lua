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
	self:SetSize(ScrH() * 0.7, ScrH() * 0.71)

	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function(self, width, height)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, width, height)

		Derma_DrawBackgroundBlur(self, 1)
	end

	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(700 / 3), SScaleMin(260 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.innerContent)
end

local color_green = Color(0, 255, 0, 255)
local color_red = Color(255, 0, 0, 255)
local color_orange = Color(255, 125, 0, 255)

function PANEL:Populate(data)
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
	titleText:SetText("Vending Machine Manager")
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

	self.panels = {}

    for i = 1, 8 do
		self.panels[i] = {}

		self.panels[i].index = self.innerContent:Add("DPanel")
		self.panels[i].index:Dock(TOP)
		self.panels[i].index:DockMargin(10, i == 1 and SScaleMin(10 / 3) or 0, 10, SScaleMin(10 / 3))
		self.panels[i].index:SetHeight(SScaleMin(60 / 3))
		self.panels[i].index.Paint = function(self, width, height)
			surface.SetDrawColor(0, 0, 0, 130)
			surface.DrawRect(0, 0, width, height)
		end

		self.panels[i].index.leftPanel = self.panels[i].index:Add("DPanel")
		self.panels[i].index.leftPanel:Dock(LEFT)
		self.panels[i].index.leftPanel:SetSize((self:GetWide() / 2) - 15, 0)
		self.panels[i].index.leftPanel.Paint = function() end

		self.panels[i].index.title = self.panels[i].index.leftPanel:Add("DLabel")
		self.panels[i].index.title:SetFont("ixMediumFont")
		self.panels[i].index.title:SetText((data.labels[i] != "" and data.labels[i] != " ") and data.labels[i] or "---")
		self.panels[i].index.title:Dock(TOP)
		self.panels[i].index.title:DockMargin(10, 10, 0, 0)
		self.panels[i].index.title:SetColor(ix.config.Get("color", Color(255, 255, 255)))

		self.panels[i].index.price = self.panels[i].index.leftPanel:Add("DLabel")
		self.panels[i].index.price:SetFont("ixGenericFont")
		self.panels[i].index.price:SetText("Price: " .. data.prices[i] .. " Credits")
		self.panels[i].index.price:Dock(BOTTOM)
		self.panels[i].index.price:DockMargin(10, 0, 0, 10)

		self.panels[i].index.indicator = self.panels[i].index:Add("DPanel")
		self.panels[i].index.indicator:SetSize(40, 0)
		self.panels[i].index.indicator:Dock(RIGHT)
		self.panels[i].index.indicator:DockMargin(10, 10, 10, 10)
		self.panels[i].index.indicator.Paint = function(self, w, h)
			if (data.labels[i] != "" and data.labels[i] != " ") then
				if (data.buttons[i]) then
					if (data.stocks[i]) then
						surface.SetDrawColor(color_green)
					else
						surface.SetDrawColor(color_red)
					end
				else
					surface.SetDrawColor(color_orange)
				end

				surface.DrawRect(0, 0, w, h)
			end
		end

		self.panels[i].index.toggle = self.panels[i].index:Add("DButton")
		self.panels[i].index.toggle:Dock(RIGHT)
		self.panels[i].index.toggle:SetText("Toggle")
		self.panels[i].index.toggle.DoClick = function()
			net.Start("ixToggleVendingMachineButton")
			net.WriteEntity(data.entity)
			net.WriteFloat(i)
			net.SendToServer()

			data.buttons[i] = !data.buttons[i]

			surface.PlaySound("helix/ui/press.wav")
		end

		self.panels[i].index.toggle.Paint = function() end

		self.panels[i].index.reprice = self.panels[i].index:Add("DButton")
		self.panels[i].index.reprice:Dock(RIGHT)
		self.panels[i].index.reprice:SetText("Reprice")
		self.panels[i].index.reprice.DoClick = function()
			Derma_StringRequest(
				"Change price", 
				"Change the price of this selection",
				data.prices[i],
				function(price)
					price = tonumber(price or 0) or 0
					price = math.Round(price)

					if (price < 0) then
						LocalPlayer():Notify("The price of a selection cannot be lower than 0!")

						return
					end
					
					net.Start("ixSetVendingMachinePrice")
					net.WriteEntity(data.entity)
					net.WriteFloat(i)
					net.WriteFloat(price)
					net.SendToServer()

					data.prices[i] = price
					self.panels[i].index.price:SetText("Price: " .. price .. " Credits")
				end
			)
			
			surface.PlaySound("helix/ui/press.wav")
		end

		self.panels[i].index.reprice.Paint = function() end

		self.panels[i].index.rename = self.panels[i].index:Add("DButton")
		self.panels[i].index.rename:Dock(RIGHT)
		self.panels[i].index.rename:SetText("Rename")
		self.panels[i].index.rename.DoClick = function()
			Derma_StringRequest(
				"Change label", 
				"Change the label of this selection",
				data.labels[i],
				function(label)
					net.Start("ixSetVendingMachineLabel")
					net.WriteEntity(data.entity)
					net.WriteFloat(i)
					net.WriteString(label)
					net.SendToServer()

					data.labels[i] = label
					self.panels[i].index.title:SetText(label)
				end
			)

			surface.PlaySound("helix/ui/press.wav")
		end

		self.panels[i].index.rename.Paint = function() end

		self.innerContent:SetTall(self.innerContent:GetTall() + self.panels[i].index:GetTall() + (i == 1 and SScaleMin(10 / 3) or 0) + SScaleMin(10 / 3))
	end

	self.innerContent:Center()
	
	local skinPanel = self.innerContent:Add("DPanel")
	skinPanel:Dock(TOP)
	skinPanel:DockMargin(10, 0, 10, 0)
	skinPanel:SetTall(SScaleMin(50 / 3))
	skinPanel.Paint = function() end

	local skins = data.entity:SkinCount()
	
	for i = 1, skins do
		local skinButton = skinPanel:Add("DButton")
		skinButton:Dock(LEFT)
		skinButton:DockMargin(0, 0, i != skins and 10 or 0, 0)
		skinButton:SetWidth((self.innerContent:GetWide() - 20 - 10 * (skins - 1)) / skins)
		skinButton:SetFont("ixMediumFont")
		skinButton:SetColor(Color(255, 255, 255, 255))
		skinButton:SetText(i - 1)
		skinButton.DoClick = function()
			surface.PlaySound("helix/ui/press.wav")

			net.Start("ixSetVendingMachineSkin")
			net.WriteEntity(data.entity)
			net.WriteFloat(i - 1)
			net.SendToServer()
		end
	end
	
	local invButton = self.innerContent:Add("DButton")
	invButton:Dock(TOP)
	invButton:DockMargin(10, SScaleMin(10 / 3), 10, 0)
	invButton:SetTall(SScaleMin(60 / 3))
	invButton:SetFont("ixMediumFont")
	invButton:SetColor(ix.config.Get("color", Color(255, 255, 255)))
	invButton:SetText("OPEN INVENTORY")
	invButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")

		net.Start("ixOpenVendingInventory")
		net.WriteEntity(data.entity)
		net.SendToServer()
		
		self:Remove()
	end
	
	self.collectButton = self.innerContent:Add("DButton")
	self.collectButton:Dock(TOP)
	self.collectButton:DockMargin(10, SScaleMin(10 / 3), 10, 0)
	self.collectButton:SetTall(SScaleMin(60 / 3))
	self.collectButton:SetFont("ixMediumFont")
	self.collectButton:SetColor(ix.config.Get("color", Color(255, 255, 255)))
	self.collectButton:SetText("COLLECT CREDITS (" .. tostring(data.credits) .. ")")
	self.collectButton.DoClick = function()
		surface.PlaySound("helix/ui/press.wav")
		
		net.Start("ixCollectVendingMachineCredits")
		net.WriteEntity(data.entity)
		net.SendToServer()

		self:Remove()
	end
end

vgui.Register("ixVendingMachineManager", PANEL, "EditablePanel")
