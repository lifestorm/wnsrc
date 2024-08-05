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
	if ix.gui.cidSelector then
		ix.gui.cidSelector:Remove()
	end
	
	ix.gui.cidSelector = self

	self:SetSize(ScrW(), ScrH())
	self:SetAlpha(0)
	self:AlphaTo(255, 0.5, 0)
	self.Paint = function(self, w, h)
		surface.SetDrawColor(Color(63, 58, 115, 220))
		surface.DrawRect(0, 0, w, h)

		Derma_DrawBackgroundBlur( self, 1 )
	end
	
	self.innerContent = self:Add("Panel")
	self.innerContent:SetSize(SScaleMin(500 / 3), SScaleMin(50 / 3))
	self.innerContent:Center()
	self.innerContent:MakePopup()
	self.innerContent.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end

	Schema:AllowMessage(self.innerContent)
	
	self:CreateTopBar()
	self:CreateSelector()
end

function PANEL:CreateTopBar()
	local topbar = self.innerContent:Add("Panel")
	topbar:SetSize(self.innerContent:GetWide(), SScaleMin(50 / 3))
	topbar:Dock(TOP)
	topbar.Paint = function( self, w, h )
		surface.SetDrawColor(0, 0, 0, 130)
		surface.DrawRect(0, 0, w, h)
	end
	
	local titleText = topbar:Add("DLabel")
	titleText:SetFont("CharCreationBoldTitleNoClamp")
	titleText:Dock(LEFT)
	titleText:SetText("Which CID do you want to use?")
	titleText:DockMargin(SScaleMin(10 / 3), 0, 0, 0)
	titleText:SetContentAlignment(4)
	titleText:SizeToContents()
	
	local exit = topbar:Add("DImageButton")
	exit:SetImage("willardnetworks/tabmenu/navicons/exit.png")
	exit:SetSize(SScaleMin(20 / 3), SScaleMin(20 / 3))
	exit:DockMargin(0, SScaleMin(15 / 3), SScaleMin(10 / 3), SScaleMin(15 / 3))
	exit:Dock(RIGHT)
	exit.DoClick = function()
		if self.ExitCallback then
			self.ExitCallback()
		end
		
		self:Remove()
		surface.PlaySound("helix/ui/press.wav")
	end	
	
	local function createDivider(parent)
		parent:SetSize(1, topbar:GetTall())
		parent:Dock(RIGHT)
		parent:DockMargin(0, SScaleMin(10 / 3), SScaleMin(10 / 3), SScaleMin(10 / 3))
		parent.Paint = function(self, w, h)
			surface.SetDrawColor(Color(111, 111, 136, (255 / 100 * 30)))
			surface.DrawLine(0, 0, 0, h)
		end
	end
	
	local divider = topbar:Add("Panel")
	createDivider(divider)
end

function PANEL:CreateSelector()
	local selectorPanel = self.innerContent:Add("DScrollPanel")
	selectorPanel:Dock(FILL)
	
	local character = LocalPlayer():GetCharacter()
	local inventoryItems = character:GetInventory():GetItemsByUniqueID("id_card")
	
	for k, v in pairs(inventoryItems) do
		local cidButton = selectorPanel:Add("DButton")
		local cidName = v:GetData("name") or ""
		local cid = v:GetData("cid") or ""
		
		cidButton:Dock(TOP)
		cidButton:SetTall(SScaleMin(50 / 3))
		cidButton:DockMargin(SScaleMin(50 / 3), k == 1 and SScaleMin(10 / 3) or 0, SScaleMin(50 / 3), SScaleMin(10 / 3))
		cidButton:SetFont("MenuFontNoClamp")
		cidButton:SetText(cidName.." | "..cid.." | "..v:GetData("cardNumber"))
		cidButton.Paint = function( self, w, h )
			surface.SetDrawColor(0, 0, 0, 130)
			surface.DrawRect(0, 0, w, h)
		end
		
		cidButton.DoClick = function()
			self:AlphaTo(0, 0.5, 0)
			timer.Simple(0.5, function()
				if self.SelectCallback then
					self.SelectCallback(v:GetID(), cid, cidName, self.activeEntity)
				end
				
				self:Remove()
			end)
		end
		
		self.innerContent:SetTall(math.Clamp(self.innerContent:GetTall() + cidButton:GetTall() + (k == 1 and SScaleMin(10 / 3) or 0) + SScaleMin(10 / 3), 0, SScaleMin(600 / 3)))
		self.innerContent:Center()
	end
end

vgui.Register("CIDSelector", PANEL, "EditablePanel")
