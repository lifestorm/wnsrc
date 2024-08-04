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


ImageTool = ImageTool or {}
ImageTool._INFORMATION = ImageTool._INFORMATION or {
    _TITLE = "Image Tool",
    _DESCRIPTION = "This system allows you to create Pictures on your map.",
    _AUTHOR = "Selenter",
    _VERSION = 0.1
}

ImageTool.path = "imagetool" -- путь к папке хранения
ImageTool.prefix = "[ImageTool]" -- Префикс для сообщений в чате

ImageTool.cacheMaterials = ImageTool.cacheMaterials or {} -- Закешированные материалы
ImageTool.requestList = ImageTool.requestList or {} -- Все запросы на сайты
ImageTool.notifyErr = ImageTool.notifyErr or {} -- Сайты которые выдают ошибки
ImageTool.imageList = ImageTool.imageList or {} -- Список картинок которые отображаются в мире

ImageTool.config = "config.txt" -- файл с конфигом
ImageTool.history = "history.txt" -- файл с иторией

-- Создаем каталог с картинками
file.CreateDir(ImageTool.path)
file.CreateDir(ImageTool.path .. "/" .. game.GetMap())



-- Инклаидаем остальные файлы
do
    if SERVER then
        AddCSLuaFile(ImageTool.path .. "/cl_net.lua")
        AddCSLuaFile(ImageTool.path .. "/cl_image.lua")
        AddCSLuaFile(ImageTool.path .. "/cl_hooks.lua")
    elseif CLIENT then
        include(ImageTool.path .. "/cl_net.lua")
        include(ImageTool.path .. "/cl_image.lua")
        include(ImageTool.path .. "/cl_hooks.lua")
    end

    include(ImageTool.path .. "/sh_image.lua")
    AddCSLuaFile(ImageTool.path .. "/sh_image.lua")

    if SERVER then
        include(ImageTool.path .. "/sv_net.lua")
        include(ImageTool.path .. "/sv_image.lua")
        include(ImageTool.path .. "/sv_hooks.lua")
    end
end