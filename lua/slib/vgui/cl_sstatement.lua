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

local colorpickerMat, checkmarkMat = Material("slib/icons/color-picker16.png", "noclamp smooth" ), Material("slib/icons/checkmark.png", "noclamp smooth" )

local textcolor, textcolor_50, maincolor, maincolor_7, maincolor_10, accentcolor, cleanaccentcolor = slib.getTheme("textcolor"), slib.getTheme("textcolor", -50), slib.getTheme("maincolor"), slib.getTheme("maincolor", 7), slib.getTheme("maincolor", 10), slib.getTheme("accentcolor"), slib.getTheme("accentcolor")
local margin = slib.getTheme("margin")

function PANEL:Init()
    self:Dock(TOP)
    self:SetTall(slib.getScaledSize(25, "y"))
    self:DockMargin(margin, 0, margin, margin)
    self.font = slib.createFont("Roboto", 14)
	self.bg = maincolor_7
	self.elemBg = maincolor
	
	slib.wrapFunction(self, "SetZPos", nil, function() return self end, true)
	slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
end

function PANEL:Paint(w,h)
    surface.SetDrawColor(self.bg)
    surface.DrawRect(0, 0, w, h)
	
    draw.SimpleText(self.name, self.font, self.center and w * .5 - self.xoffset - margin or margin, h * .5, textcolor, self.center and TEXT_ALIGN_CENTER or TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

function PANEL:OnSizeChanged(w, h)
	if self.center then
		self:setCenter()
	end
end

function PANEL:setCenter()
	self.center = true

	self.xoffset = self.element:GetWide() * .5

	surface.SetFont(self.font)
	local w, h = surface.GetTextSize(self.name)

	local l,t,r,b = self.element:GetDockMargin()
	self.element:DockMargin(l,t,self:GetWide() * .5 - self.xoffset - (w * .5) - margin,b)
end

function PANEL:addStatement(name, value)
    self.name = name
	local statement = slib.getStatement(value)
	local element

	if statement == "color" then
		element = vgui.Create("SButton", self)
		element:SetWide(slib.getScaledSize(25, "y") - slib.getScaledSize(2, "x") - slib.getScaledSize(2, "x"))
		element.color = value
		element.old_color = value

		element.Paint = function(s,w,h)
			draw.RoundedBox(h * .3, 0, 0, w, h, element.color)

			surface.SetDrawColor(textcolor_50)
			surface.SetMaterial(colorpickerMat)
			local sizew, sizeh = 16, 16

			surface.DrawTexturedRect( (w * .5) - (sizew * .5), (h * .5) - (sizeh * .5), sizew, sizeh )
		end

		element.OnRemove = function()
			if IsValid(element.ColorPicker) then element.ColorPicker:Remove() end
		end

		element.DoClick = function()
			if element.ColorPicker and IsValid(element.ColorPicker) then return end

			local posx, posy = self:LocalToScreen( element:GetPos() )

			element.ClosePicker = vgui.Create("SButton")
			element.ClosePicker:Dock(FILL)
			element.ClosePicker:MakePopup()
			element.ClosePicker.DoClick = function()
				if IsValid(element.ColorPicker) then element.ColorPicker:Remove() end
				if IsValid(element.ClosePicker) then element.ClosePicker:Remove() end
			end

			element.ClosePicker.Paint = function() end

			element.ColorPicker = vgui.Create("DColorMixer")
			element.ColorPicker:SetSize( slib.getScaledSize(200, "x"), slib.getScaledSize(160, "y") )
			element.ColorPicker:SetPos( posx - element.ColorPicker:GetWide(), posy )
			element.ColorPicker:SetPalette(false)
			element.ColorPicker:SetAlphaBar(false)
			element.ColorPicker:SetAlphaBar( true )
			element.ColorPicker:SetWangs(false)
			element.ColorPicker:SetColor(element.color and element.color or Color(255,0,0))
			element.ColorPicker:MakePopup()

			element.ColorPicker.Think = function()
				element.color = element.ColorPicker:GetColor()
			end

			element.ColorPicker.OnRemove = function()
				element.old_color = element.color

				if isfunction(element.onValueChange) then
					local result = element.onValueChange(element.color)
					if result == false then element.color = element.old_color end
				end
			end
		end
	elseif statement == "bool" then
		element = vgui.Create("SButton", self)
		element:SetWide(slib.getScaledSize(25, "y") - slib.getScaledSize(2, "x") - slib.getScaledSize(2, "x"))
		element.basealpha = cleanaccentcolor.a

		element.Paint = function(s,w,h)
			draw.RoundedBox(h * .3, 0, 0, w, h, self.elemBg)
            
            local wantedcolor = accentcolor

			wantedcolor.a = s.enabled and element.basealpha or 0
		
			local ico_size = h * .55

			surface.SetDrawColor(slib.lerpColor(s, wantedcolor, 3))
			surface.SetMaterial(checkmarkMat)
			surface.DrawTexturedRect(w * .5 - ico_size * .5,h * .5 - ico_size * .5, ico_size, ico_size)
		end

		element.enabled = value

		element.DoClick = function()
			element.enabled = !element.enabled
            
            if isfunction(element.onValueChange) then
				local result = element.onValueChange(element.enabled)
				if result == false then element.enabled = !element.enabled end
            end
		end
	elseif statement == "int" then
		element = vgui.Create("DNumberWang", self)
		element:SetWide(slib.getScaledSize(50, "x"))
		element:SetDrawLanguageID(false)
		element:SetFont(self.font)
		element:SetMin(0)
		element:SetMax(2000000)
		element.oldValue = value

		element.Paint = function(s,w,h)
			draw.RoundedBox(h * .3, 0, 0, w, h, self.elemBg)

			s:DrawTextEntryText(textcolor, cleanaccentcolor, cleanaccentcolor)
		end

		element.OnValueChanged = function(ignore)
			local oldValue = element.oldValue
			local newValue = element:GetValue()

			timer.Create(tostring(element), .3, 1, function()
				if isfunction(element.onValueChange) then
					local result = element.onValueChange(newValue)
					if result == false then
						element.oldValue = oldValue
						element:SetText(oldValue)
					return end

					element.oldValue = newValue
				end
			end)
		end

		element:SetText(value)
	elseif statement == "function" or statement == "table" then
		element = vgui.Create("SButton", self)
		element:Dock(RIGHT)
		element:DockMargin(0,slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"))
		element:setTitle(statement == "function" and "Execute" or "View Table")

		element.DoClick = function()
			if statement == "function" then
				value()
			return end
			
			local display_data = vgui.Create("STableViewer")
			display_data:setTable(value)
			display_data:SetBG(false, true, nil, true)

			if isfunction(element.onElementOpen) then
				element.onElementOpen(display_data)
			end
		end
	elseif statement == "string" then
		element = vgui.Create("DTextEntry", self)
		element:SetWide(slib.getScaledSize(80, "x"))
		element:SetDrawLanguageID(false)
		element:SetFont(self.font)
		element.Paint = function(s,w,h)
			draw.RoundedBox(h * .3, 0, 0, w, h, self.elemBg)

			s:DrawTextEntryText(textcolor, cleanaccentcolor, cleanaccentcolor)
		end
    end
    
    element:Dock(RIGHT)
    element:DockMargin(0,slib.getScaledSize(2, "x"),slib.getScaledSize(2, "x"),slib.getScaledSize(2, "x"))

	self.element = element

	return self, element
end

vgui.Register("SStatement", PANEL, "EditablePanel")