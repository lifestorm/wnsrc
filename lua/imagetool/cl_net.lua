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


-- Получаем новую картинку
net.Receive("image.SendImage", function()
    local length = net.ReadUInt(32)
    local id = net.ReadUInt(32)
    local data = net.ReadData(length)

    local uncompressed = util.Decompress(data)
    local info = util.JSONToTable(uncompressed)

    ImageTool.imageList[id] = info -- Добавляем

    if ImageTool:IsUsesTool(LocalPlayer()) then
        LocalPlayer():ChatPrint(ImageTool.prefix .. " Image was added successfully! (ID: " .. id .. ")")
    end
end)

-- Удаляем картинку
net.Receive("image.RemoveImage", function()
    local id = net.ReadUInt(32)

    ImageTool.imageList[id] = nil -- Удаляем

    if ImageTool:IsUsesTool(LocalPlayer()) then
        LocalPlayer():ChatPrint(ImageTool.prefix .. " Image has been successfully deleted! (ID: " .. id .. ")")
    end
end)

-- Удаляем все картинки
net.Receive("image.RemoveImageAll", function()
    for id in pairs(ImageTool:GetImages()) do
        ImageTool.imageList[id] = nil -- Удаляем
    end

    if ImageTool:IsUsesTool(LocalPlayer()) then
        LocalPlayer():ChatPrint(ImageTool.prefix .. " All pictures have been removed from the world!")
    end
end)

-- Сохраняем картинку в истории
net.Receive("image.SaveImage", function()
    local url = net.ReadString()

    local history = ImageTool:GetHistory() or {}

    -- Если такой url уже есть в истории, то не сохраняем
    for k, v in ipairs(history) do
        if v == url then
            return
        end
    end

    table.insert(history, url)
    ImageTool:SaveHistory(history)

    ImageTool:LoadingHistory()
end)