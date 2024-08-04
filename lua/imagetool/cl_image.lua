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

-- Создаем файл с конфигом, если его нету
if !file.Exists(ImageTool.path .. "/" .. ImageTool.history, "DATA") then
    file.Write(ImageTool.path .. "/" .. ImageTool.history, "[]")
end


-- Получаем историю
function ImageTool:GetHistory()
    local data = {}

    if file.Exists(ImageTool.path .. "/" .. ImageTool.history, "DATA") then
        local info = file.Read(ImageTool.path .. "/" .. ImageTool.history)

        data = util.JSONToTable(info)
    end

    return data
end

-- Сохраняем историю
function ImageTool:SaveHistory(data)
    data = util.TableToJSON(data)

    file.Write(ImageTool.path .. "/" .. ImageTool.history, data)
end

-- Если картинка находится в кеше, то возвращаем его
function ImageTool:FindInCache(data)
    if self.cacheMaterials[data] then
        return self.cacheMaterials[data]
    end
end

-- Получаем картинку по uniqueID
function ImageTool:GetImage(data)
    local path = Format("%s/%s", self.path, game.GetMap())
    local filename = data .. ".png"

    local cache = self:FindInCache(data)
    if cache then
        return cache
    end

    return Material("data/" .. path .. "/" .. filename)
end

-- Скачиваем картинку
function ImageTool:DownloadImage(path, data)
    if !self.requestList[data] or CurTime() >= self.requestList[data] then
        if self:IsUsesTool(LocalPlayer()) then
            LocalPlayer():ChatPrint(self.prefix .. " Download the picture: " .. data)
        end

        -- Запрос на сайт
        http.Fetch(data, function(body, size, headers)
            local extension = self:CheckExtensionImage(body, headers)
            if !extension then return end

            file.Write(path, body)
        end)

        self.requestList[data] = CurTime() + 10
    end
end

-- Грузим картинку из URL
function ImageTool:LoadingURL(data)
    local uniqueID = util.CRC(data) -- Уникальный ID картинки

    -- Если картинка уже закешированна, то возвращаем ее
    if self:FindInCache(uniqueID) then
        return self:FindInCache(uniqueID)
    end

    local path = Format("%s/%s", self.path, game.GetMap())
    local filename = uniqueID .. ".png"

    -- Пытаемся найти картинку в дате
    if file.Exists(path .. "/" .. filename, "DATA") then
        local mat = self:GetImage(uniqueID)

        if mat and !mat:IsError() then
            if self:IsUsesTool(LocalPlayer()) then
                LocalPlayer():ChatPrint(self.prefix .. " Image has been uploaded successfully: " .. data)
            end

            self.cacheMaterials[uniqueID] = mat -- Сохраняем картинку в Кеше

            return mat
        end

        if !self.notifyErr[data] or CurTime() >= self.notifyErr[data] then
            if self:IsUsesTool(LocalPlayer()) then
                LocalPlayer():ChatPrint(self.prefix .. " It is not possible to upload a picture: " .. data .. ". Repeated request in 5 seconds!")
            end

            self.notifyErr[data] = CurTime() + 5

            -- Прерываем функцию и качаем картинку
            return self:DownloadImage(path .. "/" .. filename, data)
        end
    end

    -- Если не нашли картинку, то качаем ее
    self:DownloadImage(path .. "/" .. filename, data)
end

-- Рисуем выбранную картинку в TOOL-е
function ImageTool:DrawImageTool()
    local client = LocalPlayer()

    -- Если у нас в руках не ТулГан, то прерываем функцию
    local data = self:GetToolData(client)
    if !data then return end

    self:Start3D2D(data)
end

local function clear()
    if IsValid(ImageTool.historyPanel.List) then
        ImageTool.historyPanel.List:Remove()
    end

    local historylist = ImageTool.historyPanel:GetChildren()[1]

    for k, v in ipairs(historylist:GetChildren()) do
        if v.image then
            v:Remove()
        end
    end
end

local scale = 0.2
local function set_size(panel1, panel2, mat)
    if panel1.setsize then return end

    local w, h = mat:Width() * scale, mat:Height() * scale

    panel1:SetSize(w, h)
    panel2:SetSize(w, h)

    panel1.setsize = true
end

local function drawing(url, w, h, panel1, panel2)
    local imageMaterial = ImageTool:LoadingURL(url)

    if type(imageMaterial) == "IMaterial" and !imageMaterial:IsError() then
        set_size(panel1, panel2, imageMaterial)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(imageMaterial)
        surface.DrawTexturedRect(5, 5, w - 10, h - 10)
    else
        local alpha, dotStr = ImageTool:Anim()

        surface.SetDrawColor(255, alpha, 255)
        surface.DrawRect(0, 0, w, h)
        draw.DrawText("Loading" .. dotStr, "Default", w / 2, h / 2 - 10, Color(alpha, 0, 0), TEXT_ALIGN_CENTER)
    end
end

local function derma_menu(image, id, url)
    local menu = DermaMenu() 
        menu:AddOption("Replace URL", function()
            local l = "imagetool_"

            RunConsoleCommand(l .. "url", url)
        end):SetIcon("icon16/disconnect.png")

        menu:AddOption("Copy URL", function()
            SetClipboardText(url)
        end):SetIcon("icon16/disk.png")

        menu:AddOption("Remove", function()
            local history = ImageTool:GetHistory() or {}
            table.remove(history, id)

            ImageTool:SaveHistory(history)

            if IsValid(image) then
                image:Remove()
            end
        end):SetIcon("icon16/delete.png")
    menu:Open()
end

-- Грузим историю
function ImageTool:LoadingHistory()
    local panel = ImageTool.historyPanel
    if !IsValid(panel) then return end

    clear()

    local history = ImageTool:GetHistory() or {}
    for id, url in SortedPairs(history, true) do
        local image = panel:Add("Panel")
        image.image = true
        image:SetTall(100)
        image:Dock(TOP)
        image:DockMargin(2, 2, 2, 2)

        local button = image:Add("DButton")
        button:SetText("")
        button:SetSize(100, 100)
        button:Dock(LEFT)
        button.alpha = 0
        button.Paint = function(this, w, h)
            this.alpha = Lerp(FrameTime() * 10, this.alpha, this:IsHovered() and 200 or 0)

            surface.SetDrawColor(255, 61, 96, this.alpha)
            surface.DrawRect(0, 0, w, h)

            drawing(url, w, h, image, this)

            surface.SetDrawColor(255, 61, 96, 150)
            surface.DrawOutlinedRect(0, 0, w, h, 1)
        end
        button.DoClick = function()
            derma_menu(image, id, url)
        end
    end

    panel.List = ListImage

    panel:Rebuild()
end

-- Чото типо анимации)
function ImageTool:Anim()
    local systime = SysTime()
    local alpha = math.sin(systime * 2) * 255
    local dotA = math.sin(systime * 1) * 255
    local dot = math.floor(math.abs(dotA) * 0.015)
    local dotStr = string.rep(".", dot + 1)

    return alpha, dotStr
end

-- Запускаем cam3d2d для отрисовки картинки
function ImageTool:Start3D2D(data)
    if !data then return end

    local alpha = tonumber(data.alpha) or 255
    local scale = (tonumber(data.scale) or 40) / 100
    local brightness = tonumber(data.brightness) or 255
    local imageMaterial = self:LoadingURL(data.url)

    local w, h = tonumber(data.width), tonumber(data.height)
    if !isnumber(w) or !isnumber(h) then return end -- number expected, got string

    -- Рисуем
    cam.Start3D2D(data.position, data.angles, scale)
        render.PushFilterMin(TEXFILTER.ANISOTROPIC)
        render.PushFilterMag(TEXFILTER.ANISOTROPIC)
            if type(imageMaterial) == "IMaterial" and !imageMaterial:IsError() then -- Проверяем загрузилась ли картинка
                surface.SetDrawColor(brightness, brightness, brightness, alpha)
                surface.SetMaterial(imageMaterial)
                surface.DrawTexturedRect(0, 0, w, h)
            else
                local alphaStr, dotStr = ImageTool:Anim()

                surface.SetDrawColor(255, alphaStr, 255)
                surface.DrawRect(0, 0, w, h)
                draw.DrawText("Loading" .. dotStr, "Default", w / 2, h / 2 - 10, Color(alphaStr, 0, 0), TEXT_ALIGN_CENTER)
            end
        render.PopFilterMag()
        render.PopFilterMin()
    cam.End3D2D()
end