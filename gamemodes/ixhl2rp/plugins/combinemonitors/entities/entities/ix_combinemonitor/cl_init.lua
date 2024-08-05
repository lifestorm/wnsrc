--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include('shared.lua')

local PLUGIN = PLUGIN

local overlayMaterial = ix.util.GetMaterial("models/wn/combine_binocoverlay")
local effect = ix.util.GetMaterial("models/wn/combine_monitorbg")
local effectTV = ix.util.GetMaterial("models/wn/combine_monitorbg_tv")

function ENT:Draw()
    self:DrawModel()

    if self.tv then
        if !self:GetEnabled(false) then
            return
        end
    end

    local smallScale = 0.3
    local tvScale = 0.1

    local position = self:GetPos()
    local angles = self:GetAngles()
    angles:RotateAroundAxis(angles:Up(), 90)
    angles:RotateAroundAxis(angles:Forward(), 90)

    local visorColor = !isstring(GetNetVar("visorColor")) and Color(0, 112, 255, 255) or Schema.colors[GetNetVar("visorColor")]
    local visorText =  !isstring(GetNetVar("visorText")) and "SOCIO-STABILIZATION INTACT" or GetNetVar("visorText")
    local visorTextNoSocio = string.Replace(visorText, "SOCIO-STABILIZATION", "")
    local workshiftStatus = !isbool(GetNetVar("WorkshiftStarted")) and false or GetNetVar("WorkshiftStarted")

    local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()
    local w, h = self.tv and 145 or 94, self.tv and 130 or 183
    local alpha = 191 + 64 * math.sin( CurTime() * 4 )

    local trueR = r*-(-45.55) * (self.small and smallScale or self.tv and tvScale * 2 or 1)
    local thisForward = f*54.95 * (self.small and smallScale or self.tv and tvScale or 1)
    local trueU = u*90.40 * (self.small and smallScale or self.tv and tvScale * 0.75 or 1)

    -- Red background
    cam.Start3D2D(position + thisForward + trueR + trueU, angles, 1 * (self.small and smallScale or self.tv and tvScale or 1))
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( self.tv and effectTV or effect )
        surface.DrawTexturedRect( 0, 0, w, h )
    cam.End3D2D()

    local forward = f*55.3 * (self.small and smallScale or self.tv and tvScale or 1)
    -- Combine overlay / broadcast darkening
    cam.Start3D2D(position + forward + trueR + trueU, angles, 1 * (self.small and smallScale or self.tv and tvScale or 1))
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( overlayMaterial )
        surface.DrawTexturedRect( 0, 0, w, h )

        -- Broadcast darkening
        surface.SetDrawColor(0, 0, 0, 150)
        surface.DrawRect(0, h - (self.tv and 51 or 89), w, (self.tv and 51 or 89))
    cam.End3D2D()

    local thisU = u*55.40 * (self.small and smallScale or self.tv and tvScale * 0.85 or 1)
    -- Status headlines and rects
    cam.Start3D2D(position + forward + trueR + thisU, angles, 0.25 * (self.small and smallScale or self.tv and tvScale or 1))
        local widthBox = (w * 4) - 45
        draw.DrawText( "SOCIO-STABILIZATION", "CombineMonitorLarge", w / 2 - (self.tv and 50 or 25), -30, Color( 255, 255, 255, alpha ), TEXT_ALIGN_LEFT )

        local alpha2 = 35 + 10 * math.sin( CurTime() * 4 )
        surface.SetDrawColor( ColorAlpha(visorColor, alpha2) )
        surface.DrawRect( 23, 20, widthBox, h / (self.tv and 3 or 4) )

        draw.DrawText( "WORKSHIFT STATUS", "CombineMonitorLarge", w / 2 - (self.tv and 50 or 25), 80, Color( 255, 255, 255, alpha ), TEXT_ALIGN_LEFT )
        surface.SetDrawColor( ColorAlpha((!workshiftStatus and Color(150, 150, 150) or Color(99, 183, 83)), alpha2) )
        surface.DrawRect( 23, 20 + 156 - 48, widthBox, h / (self.tv and 3 or 4) )
    cam.End3D2D()

    -- Status text
    -- Do not render this part if there's a halo being drawn in the entity, as this will literally
    -- cause epileptic seizures

    local thisR = r*-(-39.8) * (self.small and smallScale or self.tv and tvScale * 2.145 or 1)
    if (halo.RenderedEntity() != self) then
        cam.Start3D2D(position + forward + thisR + thisU, angles, 0.25 * (self.small and smallScale or self.tv and tvScale or 1))
            PLUGIN.clip:Scissor2D(widthBox, h * 2)
                local text = visorTextNoSocio.."     ///     "
                local text2 = (!workshiftStatus and "WORKSHIFT INACTIVE" or "WORKSHIFT ACTIVE").."     ///     "
                surface.SetFont("VisorScrolling")

                local textw, _ = surface.GetTextSize(text)
                local textw2, _ = surface.GetTextSize(text2)
                surface.SetTextColor(ColorAlpha(color_white, alpha))
                
                local x = RealTime() * 150 % textw * -1
                local x2 = RealTime() * 150 % textw2 * -1
                while (x < widthBox) do
                    surface.SetTextPos(x, 25)
                    surface.DrawText(text)
                    x = x + textw
                end

                while (x2 < widthBox) do
                    surface.SetTextPos(x2, 182 - 48)
                    surface.DrawText(text2)
                    x2 = x2 + textw2
                end

            PLUGIN.clip()
        cam.End3D2D()

        local thisR2 = r*-(-52.15) * (self.small and smallScale or self.tv and tvScale * 2 or 1)
        local thisU2 = u * 9.75 * (self.small and smallScale or self.tv and tvScale * 0.30 or 1)
        -- Broadcast text
        cam.Start3D2D(position + forward + thisR2 + thisU2, angles, 0.25 * (self.small and smallScale or self.tv and tvScale or 1))
            PLUGIN.clip:Scissor2D(w * 4.3, h * 2)
                draw.DrawText( "BROADCASTS", "CombineMonitorLarge", w / 2, 5, Color( 255, 255, 255, alpha ), TEXT_ALIGN_LEFT )
                draw.DrawText( (self.tv and PLUGIN.newStringTV or PLUGIN.newString), "CombineMonitor", w / 2 - 10, 70, Color( 255, 255, 255, alpha ), TEXT_ALIGN_LEFT )
            PLUGIN.clip()
        cam.End3D2D()
    end
end