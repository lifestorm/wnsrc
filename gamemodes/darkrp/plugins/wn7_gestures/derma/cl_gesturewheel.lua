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
local function FramePaint( s, w, h )
    surface.SetDrawColor(Color(0, 0, 0, 50))
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(Color(100, 100, 100, 150))
    surface.DrawOutlinedRect(0, 0, w, h)
end
local function PointOnCircle( ang, radius, offX, offY )
	ang =  math.rad( ang )
	local x = math.cos( ang ) * radius + offX
	local y = math.sin( ang ) * radius + offY
	return x, y
end
function PANEL:Init()
    ix.gui.handsignalMenu = self
    self:SetSize(ScrW(), ScrH())
    self.gestButtons = {}
    local gestures = ix.handsignal:GetAnimClassGestures(ix.anim.GetModelClass(LocalPlayer():GetModel()))
    local numSquares = #gestures
    local interval = 360 / numSquares
    local centerX, centerY = self:GetWide()*0.485, self:GetTall()*0.45
    local radius = 240
    for degrees = 1, 360, interval do --Start at 1, go to 360, and skip forward at even intervals.

		local x, y = PointOnCircle( degrees, radius, centerX, centerY )

        local gestButton = self:Add("DButton")
        gestButton:SetFont("MenuFontNoClamp")
        gestButton:SetText( "..." )
        gestButton:SetPos(x, y)
        self.gestButtons[#self.gestButtons + 1] = gestButton

        gestButton.Paint = function( s, w, h ) FramePaint(s, w, h) end

        gestButton.DoClick = function ( btn )
            self:Remove()
        end

	end
    for k, v in ipairs(gestures) do
        local btn = self.gestButtons[k]
        btn:SetText(v.name)
        btn.DoClick = function()
            net.Start("ixAskForGestureAnimation")
                net.WriteString(v.gesturePath)
            net.SendToServer()
            surface.PlaySound("helix/ui/press.wav")
            self:Remove()
        end
        btn:SetWide(ScreenScale(128 / 3))
        btn:SetHeight(ScreenScale(64 / 3))
    end

	self.closeButton = self:Add("DButton")
    self.closeButton:Dock(BOTTOM)
	self.closeButton:SetFont("MenuFontNoClamp")
	self.closeButton:SetText( "Close" )
	self.closeButton:SetHeight(ScreenScale(64 / 3))

	self.closeButton.Paint = function( s, w, h ) FramePaint(s, w, h) end

	self.closeButton.DoClick = function ( btn )
        surface.PlaySound("helix/ui/press.wav")
        self:Remove()
	end

    self:MakePopup()
    self:SetKeyboardInputEnabled(false)
end

function PANEL:Paint(width, height)
	surface.SetDrawColor(Color(63, 58, 115, 100))
	surface.DrawRect(0, 0, width, height)

	Derma_DrawBackgroundBlur( self, 0 )
end

vgui.Register("ixGestureWheel", PANEL)