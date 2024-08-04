--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PICTURE_WIDTH = PLUGIN.PICTURE_WIDTH
local PICTURE_HEIGHT = PLUGIN.PICTURE_HEIGHT
local PICTURE_WIDTH2 = PICTURE_WIDTH * 0.5
local PICTURE_HEIGHT2 = PICTURE_HEIGHT * 0.5

surface.CreateFont("ixScannerFont", {
    font = "Lucida Sans Typewriter",
    antialias = false,
    outline = true,
    weight = 800,
    size = SScaleMin(18 / 3)
})

local view = {}
local zoom = 0
local deltaZoom = zoom
local nextClick = 0
local hidden = false
local data = {}

local CLICK = "buttons/button18.wav"

local blackAndWhite = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1.5,
    ["$pp_colour_colour"] = 0,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

function PLUGIN:CalcView(client, origin, angles, fov)
    local entity = client:GetViewEntity()

    if (IsValid(entity) and entity:GetClass():find("scanner")) then
        view.angles = client:GetAimVector():Angle()
        view.fov = fov - deltaZoom

        if (math.abs(deltaZoom - zoom) > 5 and nextClick < RealTime()) then
            nextClick = RealTime() + 0.05
            client:EmitSound("common/talk.wav", 50, 180)
        end

        return view
    end
end

function PLUGIN:InputMouseApply(command, x, y, angle)
    zoom = math.Clamp(zoom + command:GetMouseWheel()*1.5, 0, 40)
    deltaZoom = Lerp(FrameTime() * 2, deltaZoom, zoom)
end

function PLUGIN:PreDrawOpaqueRenderables()
    local viewEntity = LocalPlayer():GetViewEntity()

    if (IsValid(self.lastViewEntity) and self.lastViewEntity != viewEntity) then
        self.lastViewEntity:SetNoDraw(false)
        self.lastViewEntity = nil
        LocalPlayer():EmitSound(CLICK, 50, 120)
    end

    if (IsValid(viewEntity) and viewEntity:GetClass():find("scanner")) then
        viewEntity:SetNoDraw(true)

        if (self.lastViewEntity ~= viewEntity) then
            viewEntity:EmitSound(CLICK, 50, 140)
        end

        self.lastViewEntity = viewEntity

        hidden = true
    elseif (hidden) then
        hidden = false
    end
end

function PLUGIN:ShouldDrawCrosshair()
    if (hidden) then
        return false
    end
end

function PLUGIN:AdjustMouseSensitivity()
    if (hidden) then
        return 0.3
    end
end

function PLUGIN:HUDPaint()
    if (not hidden) then return end

    local scrW, scrH = surface.ScreenWidth() * 0.5, surface.ScreenHeight() * 0.5
    local x, y = scrW - PICTURE_WIDTH2, scrH - PICTURE_HEIGHT2

    if (self.lastPic and self.lastPic >= CurTime()) then
        local delay = ix.config.Get("pictureDelay", 15)
        local percent = math.Round(math.TimeFraction(self.lastPic - delay, self.lastPic, CurTime()), 2) * 100
        local glow = math.sin(RealTime() * 15)*25

        draw.SimpleText("RE-CHARGING: "..percent.."%", "ixScannerFont", x, y - SScaleMin(24 / 3), Color(255 + glow, 100 + glow, 25, 250))
    end


    local angle = LocalPlayer():GetAimVector():Angle()

    if (LocalPlayer():GetArea()) then
        draw.SimpleText("POS ("..LocalPlayer():GetArea()..")", "ixScannerFont", x + SScaleMin(8 / 3), y + SScaleMin(8 / 3), color_white)
    else
        local position = LocalPlayer():GetPos()
        draw.SimpleText("POS ("..math.floor(position[1])..", "..math.floor(position[2])..", "..math.floor(position[3])..")", "ixScannerFont", x + SScaleMin(8 / 3), y + SScaleMin(8 / 3), color_white)
    end

    draw.SimpleText("ANG ("..math.floor(angle[1])..", "..math.floor(angle[2])..", "..math.floor(angle[3])..")", "ixScannerFont", x + SScaleMin(8 / 3), y + SScaleMin(24 / 3), color_white)
    draw.SimpleText("ID  ("..LocalPlayer():Name()..")", "ixScannerFont", x + SScaleMin(8 / 3), y + SScaleMin(40 / 3), color_white)
    draw.SimpleText("ZM  ("..(math.Round(zoom / 40, 2) * 100).."%)", "ixScannerFont", x + SScaleMin(8 / 3), y + SScaleMin(56 / 3), color_white)

    if (IsValid(self.lastViewEntity)) then
        data.start = self.lastViewEntity:GetPos()
        data.endpos = data.start + LocalPlayer():GetAimVector() * 500
        data.filter = self.lastViewEntity

        local entity = util.TraceLine(data).Entity

        if (IsValid(entity) and entity:IsPlayer()) then
            entity = entity:Name()
        else
            entity = "NULL"
        end

        draw.SimpleText("TRG ("..entity..")", "ixScannerFont", x + SScaleMin(8 / 3), y + SScaleMin(72 / 3), color_white)
    end

    surface.SetDrawColor(235, 235, 235, 230)

    surface.DrawLine(0, scrH, x - SScaleMin(128 / 3), scrH)
    surface.DrawLine(scrW + PICTURE_WIDTH2 + SScaleMin(128 / 3), scrH, ScrW(), scrH)
    surface.DrawLine(scrW, 0, scrW, y - SScaleMin(128 / 3))
    surface.DrawLine(scrW, scrH + PICTURE_HEIGHT2 + SScaleMin(128 / 3), scrW, ScrH())

    surface.DrawLine(x, y, x + SScaleMin(128 / 3), y)
    surface.DrawLine(x, y, x, y + SScaleMin(128 / 3))

    x = scrW + PICTURE_WIDTH2

    surface.DrawLine(x, y, x - SScaleMin(128 / 3), y)
    surface.DrawLine(x, y, x, y + SScaleMin(128 / 3))

    x = scrW - PICTURE_WIDTH2
    y = scrH + PICTURE_HEIGHT2

    surface.DrawLine(x, y, x + SScaleMin(128 / 3), y)
    surface.DrawLine(x, y, x, y - SScaleMin(128 / 3))

    x = scrW + PICTURE_WIDTH2

    surface.DrawLine(x, y, x - SScaleMin(128 / 3), y)
    surface.DrawLine(x, y, x, y - SScaleMin(128 / 3))

    surface.DrawLine(scrW - SScaleMin(48 / 3), scrH, scrW - SScaleMin(8 / 3), scrH)
    surface.DrawLine(scrW + SScaleMin(48 / 3), scrH, scrW + SScaleMin(8 / 3), scrH)
    surface.DrawLine(scrW, scrH - SScaleMin(48 / 3), scrW, scrH - SScaleMin(8 / 3))
    surface.DrawLine(scrW, scrH + SScaleMin(48 / 3), scrW, scrH + SScaleMin(8 / 3))
end

function PLUGIN:RenderScreenspaceEffects()
    if (not hidden) then return end
    blackAndWhite["$pp_colour_brightness"] = -0.05
        + math.sin(RealTime() * 5) * 0.01
    DrawColorModify(blackAndWhite)
end

function PLUGIN:PlayerBindPress(client, bind, pressed)
    bind = bind:utf8lower()

    if (bind:find("attack2") and pressed and hidden and IsValid(self.lastViewEntity)) then
        data.start = self.lastViewEntity:GetPos()
        data.endpos = data.start + LocalPlayer():GetAimVector() * 500
        data.filter = self.lastViewEntity

        local entity = util.TraceLine(data).Entity

        if (entity and IsEntity(entity) and entity:IsValid() and entity:IsPlayer() and entity.GetCharacter) then
            local character = entity:GetCharacter()

            if (character:IsVortigaunt()) then
                if (character:GetCollarID()) then
                    ix.command.Send("datafile", "!" .. character:GetCollarID())
                else
                    ix.command.Send("datafile", character:GetCid())
                end
            else
                ix.command.Send("datafile", character:GetName())
            end
        end
    elseif (bind:find("attack") and pressed and hidden and IsValid(self.lastViewEntity)) then
        self:TakePicture()
        return true
    end
end