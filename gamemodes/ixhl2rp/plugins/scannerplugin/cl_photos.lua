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

local PHOTO_CACHE = {}
local CURRENT_PHOTO

function PLUGIN:TakePicture()
    if ((self.lastPic or 0) < CurTime()) then
        self.lastPic = CurTime() + ix.config.Get("pictureDelay", 15)

        net.Start("ixScannerPicture")
        net.SendToServer()

        timer.Simple(0.1, function()
            self.startPicture = true
        end)
    end
end

function PLUGIN:PostRender()
    if (self.startPicture) then
        local data = util.Compress(render.Capture({
            format = "jpeg",
            h = PICTURE_HEIGHT,
            w = PICTURE_WIDTH,
            quality = 35,
            x = ScrW()*0.5 - PICTURE_WIDTH2,
            y = ScrH()*0.5 - PICTURE_HEIGHT2
        }))

        net.Start("ixScannerData")
            net.WriteUInt(#data, 16)
            net.WriteData(data, #data)
        net.SendToServer()

        self.startPicture = false
    end
end


net.Receive("ixScannerData", function()
    local data = net.ReadData(net.ReadUInt(16))
    data = util.Base64Encode(util.Decompress(data))

    if (not data) then return end

    if (IsValid(CURRENT_PHOTO)) then
        local panel = CURRENT_PHOTO

        CURRENT_PHOTO:AlphaTo(0, 0.25, 0, function()
            if (IsValid(panel)) then
                panel:Remove()
            end
        end)
    end

    local html = Format([[
        <html>
            <body style="background: black; overflow: hidden; margin: 0; padding: 0;">
                <img src="data:image/jpeg;base64,%s" width="%s" height="%s" />
            </body>
        </html>
    ]], data, PICTURE_WIDTH, PICTURE_HEIGHT)

    local panel = vgui.Create("DPanel")
    panel:SetSize(PICTURE_WIDTH + SScaleMin(8 / 3), PICTURE_HEIGHT + SScaleMin(8 / 3))
    panel:SetPos(ScrW(), SScaleMin(8 / 3))
    panel:SetDrawBackground(true)
    panel:SetAlpha(150)

    panel.body = panel:Add("DHTML")
    panel.body:Dock(FILL)
    panel.body:DockMargin(SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3))
    panel.body:SetHTML(html)

    panel:MoveTo(ScrW() - (panel:GetWide() + SScaleMin(8 / 3)), SScaleMin(8 / 3), 0.5)

    timer.Simple(15, function()
        if (IsValid(panel)) then
            panel:MoveTo(ScrW(), SScaleMin(8 / 3), 0.5, 0, -1, function()
                panel:Remove()
            end)
        end
    end)

    PHOTO_CACHE[#PHOTO_CACHE + 1] = {data = html, time = os.time()}
    CURRENT_PHOTO = panel
end)

net.Receive("ixScannerClearPicture", function()
    if (IsValid(CURRENT_PHOTO)) then
        CURRENT_PHOTO:Remove()
    end
end)

concommand.Add("ix_photocache", function()
    local frame = vgui.Create("DFrame")
    frame:SetTitle("Photo Cache")
    frame:SetSize(SScaleMin(480 / 3), SScaleMin(360 / 3))
    frame:Center()
    DFrameFixer(frame)

    frame.list = frame:Add("DScrollPanel")
    frame.list:Dock(FILL)
    frame.list:SetDrawBackground(true)

    for _, v in ipairs(PHOTO_CACHE) do
        local button = frame.list:Add("DButton")
        button:SetTall(SScaleMin(28 / 3))
        button:Dock(TOP)
		button:SetFont("MenuFontNoClamp")
        button:DockMargin(SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3), 0)
        button:SetText(os.date("%X - %d/%m/%Y", v.time))
        button.DoClick = function()
            local frame2 = vgui.Create("DFrame")
            frame2:SetSize(PICTURE_WIDTH + SScaleMin(8 / 3), PICTURE_HEIGHT + SScaleMin(8 / 3))
            frame2:SetTitle(button:GetText())
            frame2:Center()
            DFrameFixer(frame2)

            frame2.body = frame2:Add("DHTML")
            frame2.body:SetHTML(v.data)
            frame2.body:Dock(FILL)
            frame2.body:DockMargin(SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3), SScaleMin(4 / 3))
        end
    end
end)
