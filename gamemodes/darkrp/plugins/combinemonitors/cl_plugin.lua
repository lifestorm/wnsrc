--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

PLUGIN.broadcastWords = {}
PLUGIN.timeNeeded = 0
PLUGIN.newString = ""
PLUGIN.currentWord = 0
PLUGIN.currentLine = {}
PLUGIN.lineAmount = 0

PLUGIN.broadcastWordsTV = {}
PLUGIN.timeNeededTV = 0
PLUGIN.newStringTV = ""
PLUGIN.currentWordTV = 0
PLUGIN.currentLineTV = {}
PLUGIN.lineAmountTV = 0

function PLUGIN:MessageReceived(client, info)
    if istable(info) and info.chatType and (info.chatType == "broadcast" or info.chatType == "dispatch" or (info.chatType == "worlddispatch" and !timer.Exists("CombineMonitorsText"))) then
        local definers = {"TV", ""}
        for _, v in pairs(definers) do
            if (info.chatType == "worlddispatch" and !timer.Exists("CombineMonitorsText"..v)) then
                if !table.IsEmpty(PLUGIN["broadcastWords"..v]) then return end
            end

            self:ResetTextOnMonitor(v)

            for w in info.text:gmatch("%S+") do
                table.insert(PLUGIN["broadcastWords"..v], w)
                PLUGIN["timeNeeded"..v] = PLUGIN["timeNeeded"..v] + (string.len(w) / 10)
            end

            timer.Create("CombineMonitorsText"..v, 1, 0, function()
                PLUGIN["currentWord"..v] = math.Clamp(PLUGIN["currentWord"..v] + 1, 0, #PLUGIN["broadcastWords"..v] + 1)
                timer.Adjust("CombineMonitorsText"..v, (string.len(PLUGIN["broadcastWords"..v][PLUGIN["currentWord"..v]] or "") / 10), nil, nil)
                PLUGIN["newString"..v] = PLUGIN["newString"..v].." "..(PLUGIN["broadcastWords"..v][PLUGIN["currentWord"..v]] or "")

                PLUGIN["currentLine"..v][#PLUGIN["currentLine"..v] + 1] = PLUGIN["broadcastWords"..v][PLUGIN["currentWord"..v]] or ""

                local line = ""
                for i = 1, #PLUGIN["currentLine"..v] do
                    line = line.." "..PLUGIN["currentLine"..v][i]
                    surface.SetFont("CombineMonitor")
                    local tW, _ = surface.GetTextSize(line)

                    if tW > (v == "TV" and 360 or 200) then
                        PLUGIN["newString"..v] = PLUGIN["newString"..v]..string.char(10)
                        PLUGIN["currentLine"..v] = {}
                        PLUGIN["lineAmount"..v] = PLUGIN["lineAmount"..v] + 1
                    end
                end

                if PLUGIN["lineAmount"..v] >= (v == "TV" and 4 or 11) then
                    PLUGIN["newString"..v] = ""
                    PLUGIN["lineAmount"..v] = 0
                end

                if PLUGIN["currentWord"..v] >= #PLUGIN["broadcastWords"..v] + 1 then
                    timer.Remove("CombineMonitorsText"..v)
                    timer.Simple(5, function()
                        if timer.Exists("CombineMonitorsText"..v) then return end
                        self:ResetTextOnMonitor(v)
                    end)
                end
            end)
        end
    end
end

function PLUGIN:ResetTextOnMonitor(v)
    PLUGIN["broadcastWords"..v] = {}
    PLUGIN["timeNeeded"..v] = 0
    PLUGIN["newString"..v] = ""
    PLUGIN["currentWord"..v] = 0
    PLUGIN["currentLine"..v] = {}
    PLUGIN["lineAmount"..v] = 0
end