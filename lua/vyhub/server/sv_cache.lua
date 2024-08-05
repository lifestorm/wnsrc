--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local f = string.format
local json = VyHub.Lib.json

VyHub.Cache = VyHub.Cache or {}

function VyHub.Cache:save(key, value)
    local data = {
        timestamp = os.time(),
        data = value
    }

    local filename = f("vyhub/%s.json", key)
    local json = json.encode(data)

    VyHub:msg("Write " .. filename .. ": " .. json, "debuga")

    file.Write(filename, json)
end

function VyHub.Cache:get(key, max_age)
    local path = f("vyhub/%s.json", key)

    if not file.Exists(path, "data") then
        return nil
    end

    local data_str = file.Read(path, "data")

    if not string.Trim(data_str) then
        return nil
    end

    local success, data = pcall(json.decode, data_str)

    if not success then
        return nil
    end

    if istable(data) and data.timestamp and data.data then
        if max_age != nil and os.time() - data.timestamp > max_age then
            return nil
        end

        return data.data
    end

    return nil
end