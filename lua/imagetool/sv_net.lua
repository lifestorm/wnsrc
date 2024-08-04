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


util.AddNetworkString("image.SendImage") -- net с отправкой картинки
util.AddNetworkString("image.RemoveImage") -- net с удалением картинки
util.AddNetworkString("image.RemoveImageAll") -- net с удалением всех картинок
util.AddNetworkString("image.SaveImage") -- net с сохранением картинки


-- Команда которая удаляет все картинки с карты
concommand.Add("imagetool_delete_all", function(client)
    if !client:IsSuperAdmin() then
        return client:ChatPrint(ImageTool.prefix .. " You don't have access!")
    end

    ImageTool:RemoveImageAll()
end)