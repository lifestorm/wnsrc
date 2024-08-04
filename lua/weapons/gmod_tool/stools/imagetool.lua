--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

--[[
        © AsterionStaff 2022.
        This script was created from the developers of the AsterionTeam.
        You can get more information from one of the links below:
            Site - https://asterion.games
            Discord - https://discord.gg/CtfS8r5W3M
        
        developer(s):
            Selenter - https://steamcommunity.com/id/selenter

        ——— Chop your own wood and it will warm you twice.
]]--


AddCSLuaFile()

TOOL.Name = "Image Tool" -- Название
TOOL.Category = "Asterion Tools" -- Категория
TOOL.Information = { -- Дополнительная информация
    {name = "left", stage = 0},
    {name = "right", stage = 0},
}

-- Стандартные конвары
TOOL.ClientConVar.url = "https://i.imgur.com/4vyQ6Hl.png"
TOOL.ClientConVar.width = 100
TOOL.ClientConVar.height = 100
TOOL.ClientConVar.scale = 40
TOOL.ClientConVar.brightness = 255
TOOL.ClientConVar.alpha = 255

-- Добавляем язык
if CLIENT then
    language.Add("tool.imagetool.name", "Image Tool")
    language.Add("tool.imagetool.desc", "Allows you to create pictures in the world")
    language.Add("tool.imagetool.left", "With the left mouse button you can create a picture.")
    language.Add("tool.imagetool.right", "With the right mouse button you can delete the picture next to.")
end

-- Левая кнопка мыши
function TOOL:LeftClick()
    if CLIENT then return true end

    local client = self:GetOwner()

    -- Пытаемся получить данные из тулгана
    local data = ImageTool:GetToolData(client)
    if !data then return end

    ImageTool:AddImage(data)
    
    -- я ненавижу predicted хуки!!! (приходится передавать по net-у, т.к. в одиночке этот хук не обрабатывается на клиенте)
    net.Start("image.SaveImage")
        net.WriteString(data.url)
    net.Send(client)

    return true
end

-- Правая кнопка мыши
function TOOL:RightClick(trace)
    if CLIENT then return true end

    local client = self:GetOwner()

    -- Пытаемся получить данные из тулгана
    local data = ImageTool:GetToolData(client)
    if !data then return end

    ImageTool:RemoveImage(data)

    return true
end

-- C менюшка
function TOOL.BuildCPanel(CPanel)
    CPanel:AddControl("Header",{
        Description = "This Tool will help you put the pictures you need on your map. In the field with the URL, indicate the link to the picture, then you can put it in the world."
    })

    CPanel:AddControl("TextBox", {
        Label = " URL Link to picture",
        Command = "imagetool_url"
    })

    local URLDesc = vgui.Create("DLabel")
    URLDesc:SetText("In this field you must specify the URL of the image you want to put in the world.")
    URLDesc:SetWrap(true)
    URLDesc:SetAutoStretchVertical(true)
    URLDesc:SetTextColor(Color(10,149,255))
    CPanel:AddPanel(URLDesc)

    local NoticePanel = vgui.Create("DLabel")
    NoticePanel:SetText("If your picture is not loaded, then we recommend using IMGUR to publish pictures.")
    NoticePanel:SetWrap(true)
    NoticePanel:SetAutoStretchVertical(true)
    NoticePanel:SetTextColor(Color(255,10,10,255))
    CPanel:AddPanel(NoticePanel)

    CPanel:AddControl("Slider", {
        Label = "Image Width:",
        Command = "imagetool_width",
        Min = 0,
        Max = 10000
    })

    local WidthDesc = vgui.Create("DLabel")
    WidthDesc:SetText("In this slider, you can specify the size of the picture you need in width.")
    WidthDesc:SetWrap(true)
    WidthDesc:SetAutoStretchVertical(true)
    WidthDesc:SetTextColor(Color(10,149,255))
    CPanel:AddPanel(WidthDesc)

    CPanel:AddControl("Slider", {
        Label = "Image Height:",
        Command = "imagetool_height",
        Min = 0,
        Max = 10000
    })

    local HeightDesc = vgui.Create("DLabel")
    HeightDesc:SetText("In this slider, you can specify the size of the picture you need in height.")
    HeightDesc:SetWrap(true)
    HeightDesc:SetAutoStretchVertical(true)
    HeightDesc:SetTextColor(Color(10,149,255))
    CPanel:AddPanel(HeightDesc)

    CPanel:AddControl("Slider", {
        Label = "Image Scale:",
        Command = "imagetool_scale",
        Min = 0,
        Max = 100
    })

    local ScaleDesc = vgui.Create("DLabel")
    ScaleDesc:SetText("In this slider, you can resize the picture in height and width at the same time.")
    ScaleDesc:SetWrap(true)
    ScaleDesc:SetAutoStretchVertical(true)
    ScaleDesc:SetTextColor(Color(10,149,255))
    CPanel:AddPanel(ScaleDesc)

    CPanel:AddControl("Slider", {
        Label = "Image Brightness:",
        Command = "imagetool_brightness",
        Min = 0,
        Max = 255
    })

    local BrightnessDesc = vgui.Create("DLabel")
    BrightnessDesc:SetText("In this slider, you can change the brightness of the picture, it is very suitable if you need to place the picture in a dark place.")
    BrightnessDesc:SetWrap(true)
    BrightnessDesc:SetAutoStretchVertical(true)
    BrightnessDesc:SetTextColor(Color(10,149,255))
    CPanel:AddPanel(BrightnessDesc)

    CPanel:AddControl("Slider", {
        Label = "Image Alpha:",
        Command = "imagetool_alpha",
        Min = 0,
        Max = 255
    })

    local AlphaDesc = vgui.Create("DLabel")
    AlphaDesc:SetText("This slider allows you to change the transparency of your images.")
    AlphaDesc:SetWrap(true)
    AlphaDesc:SetAutoStretchVertical(true)
    AlphaDesc:SetTextColor(Color(10,149,255))
    CPanel:AddPanel(AlphaDesc)

    local ImageSize = vgui.Create("DButton")
    ImageSize:SetText("Set the size settings as in the picture")
    ImageSize.DoClick = function()
        local l = "imagetool_"

        local data = ImageTool:GetToolData(LocalPlayer())
        if !data then return end

        local uniqueID = util.CRC(data.url)

        local material = ImageTool.cacheMaterials[uniqueID]
        if material then
            local width = material:Width()
            local height = material:Height()

            RunConsoleCommand(l .. "width", width)
            RunConsoleCommand(l .. "height", height)
        end
    end
    CPanel:AddPanel(ImageSize)

    local ResetButton = vgui.Create("DButton")
    ResetButton:SetText("Restore default settings")
    ResetButton.DoClick = function()
        local l = "imagetool_"

        RunConsoleCommand(l .. "url", "https://i.imgur.com/4vyQ6Hl.png")
        RunConsoleCommand(l .. "width", 100)
        RunConsoleCommand(l .. "height", 100)
        RunConsoleCommand(l .. "scale", 40)
        RunConsoleCommand(l .. "brightness", 255)
    end
    CPanel:AddPanel(ResetButton)

    CPanel:AddControl("Header",{
        Description = "Your image history:"
    })

    local historyPanel = vgui.Create("DScrollPanel")
    historyPanel:SetTall(300)
    historyPanel.Paint = function(_, w, h)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(0, 0, w, h)
    end
    CPanel:AddPanel(historyPanel)

    ImageTool.historyPanel = historyPanel
    ImageTool:LoadingHistory()
end