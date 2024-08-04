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

-- Допустимые для загрузки расширения
ImageTool.ValidExtension = {
    realm = {
        ["png"] = true,
        ["jpg"] = true,
        ["jfif"] = true
    },
    content = {
        ["image/png"] = true,
        ["image/jpeg"] = true
    }
}

-- Использует ли пользователь Image Tool
function ImageTool:IsUsesTool(client)
    if !IsValid(client) then return false end

    local weapon = client:GetActiveWeapon()
    if !IsValid(weapon) then return false end

    local class = weapon:GetClass()
    if class != "gmod_tool" then return false end

    local tool = client:GetTool() and client:GetTool().Name or nil
    if tool != "Image Tool" then return false end

    return true
end

-- Получаем информацию о Image Tool
function ImageTool:GetToolData(client)
    if !self:IsUsesTool(client) then return end

    local trace = client:GetEyeTrace()
    local position = trace.HitPos
    local angles = trace.HitNormal:Angle()
    angles:RotateAroundAxis(angles:Up(), 90)
    angles:RotateAroundAxis(angles:Forward(), 90)

    local tool = client:GetTool()

    local imageURL = tool:GetClientInfo("url")
    local imageWidth = tool:GetClientInfo("width")
    local imageHeight = tool:GetClientInfo("height")
    local imageScale = tool:GetClientInfo("scale")
    local imageBrightness = tool:GetClientInfo("brightness")
    local imageAlpha = tool:GetClientInfo("alpha")

    imageURL = imageURL:gsub("cdn.discordapp.com", "media.discordapp.net") -- Fix Discord Cloudfire

    local data = {
        url = imageURL,
        width = imageWidth,
        height = imageHeight,
        scale = imageScale,
        brightness = imageBrightness,
        position = position + angles:Up() * 0.5,
        angles = angles,
        alpha = imageAlpha
    }

    return data
end

-- Проверка на валидность на сайте картинки
function ImageTool:CheckExtensionImage(body, header)
    local content = header["Content-Type"]
    local extension = self.ValidExtension

    local urlLowerPNG = string.lower(string.sub(body, 2, 4))
    local urlLowerJPEG = string.lower(string.sub(body, 7, 10))

    if extension.realm[urlLowerPNG] or extension.realm[urlLowerJPEG] or extension.content[content] then
        return true
    end

    return false
end

-- Получаем все картинки на карте
function ImageTool:GetImages()
    return ImageTool.imageList or {}
end