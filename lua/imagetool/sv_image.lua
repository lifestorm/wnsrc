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

        ——— Chop your own wood and it will warm you twice.
]]--

-- Создаем файл с конфигом, если его нету
if !file.Exists(ImageTool.path .. "/" .. ImageTool.config, "DATA") then
    file.Write(ImageTool.path .. "/" .. ImageTool.config, "{}")
end


-- Получаем конфиг
function ImageTool:GetConfig()
    local data = {}

    if file.Exists(ImageTool.path .. "/" .. ImageTool.config, "DATA") then
        local info = file.Read(ImageTool.path .. "/" .. ImageTool.config)

        data = util.JSONToTable(info)
    end

    return data
end

-- Отправляем картинку игроку/игрокам
function ImageTool:SendImage(client, id, data)
    data = util.TableToJSON(data)

    local compressed = util.Compress(data)
    local length = compressed:len()

    net.Start("image.SendImage")
        net.WriteUInt(length, 32)
        net.WriteUInt(id, 32)
        net.WriteData(compressed, length)

    if IsValid(client) then
        net.Send(client)
    else
        net.Broadcast()
    end
end

-- Сохраняем конфиг
function ImageTool:SaveConfig(data)
    data = util.TableToJSON(data)

    file.Write(ImageTool.path .. "/" .. ImageTool.config, data)
end

-- Добавляем новую картинку в мир
function ImageTool:AddImage(data)
    if !data then return end

    local config = self:GetConfig() or {}
    local map = game.GetMap()

    config[map] = config[map] or {}
    config[map][#config[map] + 1] = data -- Записываем

    self:SaveConfig(config) -- Сохраняем конфиг
    self:SendImage(nil, #config[map], data) -- Передаем всем игрокам данную картинку
end

-- Удаляем картинку из мира
function ImageTool:RemoveImage(data)
    if !data then return end

    local pos = data.position
    local config = ImageTool:GetConfig() or {}
    local map = game.GetMap()

    config[map] = config[map] or {}

    -- Находим картинку с наименьшей дистанцией
    local images = {}
    for k, v in pairs(config[map]) do
        if pos:Distance(v.position) <= 200 then
            local dist = math.floor(pos:Distance(v.position))

            images[dist] = k
        end
    end

    local imagesPack = {}
    for k, v in pairs(images) do
        if !isnumber(k) then continue end -- number expected err

        imagesPack[#imagesPack + 1] = k
    end

    if #imagesPack <= 0 then return end

    local min = math.min(unpack(imagesPack))
    local imageMin = images[min]

    -- Если нашли — удаляем
    if imageMin and config[map][imageMin] then
        config[map][imageMin] = nil

        self:SaveConfig(config)

        net.Start("image.RemoveImage")
            net.WriteUInt(imageMin, 32)
        net.Broadcast()
    end
end

-- Удаляем все картинки из мира
function ImageTool:RemoveImageAll()
    local config = ImageTool:GetConfig() or {}
    local map = game.GetMap()

    config[map] = {}

    ImageTool:SaveConfig(config)

    net.Start("image.RemoveImageAll")
    net.Broadcast()
end