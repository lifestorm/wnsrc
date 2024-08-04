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

PLUGIN.MAX_ATTEMPTS = 3
PLUGIN.FAILS_WAIT = 60 -- wait in minutes after entering the wrong code too often
PLUGIN.messageText = [[Hello!

%s is trying to link their steam account to your forum account. If this is you, please follow the below instructions:

The token to link your account is: %s

Please use '/LinkComplete <token>' in-game to complete the link. This token is valid for 1 hour.

If you did not do this, please ignore this message.

-ServerBot]]

function PLUGIN:DatabaseConnected()
    local query = mysql:Create("xenforo_link")
        query:Create("steamid", "VARCHAR(20) NOT NULL")
        query:Create("forum_id", "VARCHAR(20) NOT NULL")
        query:Create("groups", "TEXT DEFAULT NULL")
        query:PrimaryKey("forum_id")
    query:Execute()
end

function PLUGIN.GenerateCode(length)
    local result = {}
    while (#result != 12) do
        local char = string.char(math.random(32, 126))
        if (string.find(char, "%w")) then
            result[#result + 1] = char
        end
    end
    return table.concat(result)
end

function PLUGIN:CheckClientWait(client)
    if (client:GetData("xenforoLinkFailPause", 0) > os.time()) then
        client:NotifyLocalized("xenforoFailsPause", math.ceil((client:GetData("xenforoLinkFailPause", 0) - os.time()) / 60))
        return false
    end

    if (client.ixXenforoLink and client:GetLocalVar("xenforoLinkStart", 0) * self.NEW_ATTEMPT_WAIT * 15 <= os.time()) then
        client:NotifyLocalized("xenforoStartWait")
        return false
    end

    return true
end

function PLUGIN:FindUser(client, name)
    if (!self.API_KEY) then return end

    if (!self:CheckClientWait(client)) then return end

    if (string.find(name, "willard.network/forums/members/[^%.]+%.%d+/")) then
        PLUGIN:CheckLinkExists(client, string.match(name, "willard.network/forums/members/[^%.]+%.(%d+)/"))
        return
    elseif (string.find(name, "$%d+^") and tonumber(name) and tonumber(name) > 0) then
        PLUGIN:CheckLinkExists(client, name)
        return
    end

    local steamName = client:SteamName()
    local endpoint = "https://willard.network/forums/api/users/find-name?username="
    if (string.find(name, "@")) then
        endpoint = "https://willard.network/forums/api/users/find-email?email="
    end

    endpoint = endpoint..name

    local request = {
        failed = function(error)
            print("[XENFORO-LINK] Failed to find user: "..error)
            print("[XENFORO-LINK] Client: "..steamName.."; endpoint: "..endpoint)
            if (IsValid(client)) then
                client:NotifyLocalized("xenforoFailedFindUser", name)
            end
        end,
        success = function(code, body, headers)
            if (!IsValid(client)) then return end

            local httpResult = util.JSONToTable(body)
            if (!httpResult) then
                print("[XENFORO-LINK] Received invalid response; endpoint: "..endpoint, code)
                file.Write("xenforoError.html", body)
                client:NotifyLocalized("xenforoFailedFindUser", name)
                return
            end

            if (!httpResult.exact) then
                client:NotifyLocalized("xenforoFindUserNoExactMatch", name)
                return
            end

            self:CheckLinkExists(client, httpResult.exact.user_id)
        end,
        url = endpoint,
        method = "GET",
        headers = {
            ["XF-Api-Key"] = self.API_KEY
        }
    }

    CHTTP(request)
end

function PLUGIN:CheckLinkExists(client, forumID)
    local query = mysql:Select("xenforo_link")
        query:Where("forum_id", forumID)
        query:Callback(function(result)
            if (!IsValid(client)) then return end
            if (result and #result > 0) then
                client:NotifyLocalized("xenforoUserAlreadyLinked")
                return
            else
                PLUGIN:StartLink(client, forumID)
            end
        end)
    query:Execute()
end

function PLUGIN:StartLink(client, forumID)
    if (!self.API_KEY) then return end

    if (!self:CheckClientWait(client)) then return end

    --TODO: add link start log
    client.ixXenforoLink = {
        id = tostring(forumID),
        code = PLUGIN.GenerateCode(),
        validUntil = os.time() + self.TOKEN_VALID * 60,
        fails = 0
    }
    client:SetLocalVar("xenforoLinkStart", os.time())

    local steamName = client:SteamName()
    local messageText = string.format(self.messageText, steamName, client.ixXenforoLink.code)
    local endpoint = string.format("https://willard.network/forums/api/conversations/")
    local request = {
        failed = function(error)
            print("[XENFORO-LINK] Failed to send message: "..error)
            print("[XENFORO-LINK] Client: "..steamName)
            if (IsValid(client)) then
                client:NotifyLocalized("xenforoFailedCreatePM")
            end
        end,
        success = function(code, body, headers)
            if (!IsValid(client)) then return end

            local httpResult = util.JSONToTable(body)
            if (!httpResult) then
                print("[XENFORO-LINK] Received invalid response; endpoint: "..endpoint)
                client:NotifyLocalized("xenforoFailedCreatePM")
                return
            end

            if (httpResult.errors) then
                print("[XENFORO-LINK] Failed to send PM")
                ix.log.AddRaw("[XENFORO-LINK] Send message error: "..util.TableToJSON(httpResult))
                client:NotifyLocalized("xenforoFailedCreatePMError")
                return
            end

            client:ChatNotifyLocalized("xenforoCodeSend")
        end,
        url = endpoint,
        parameters = {
            ["recipient_ids[]"] = tostring(client.ixXenforoLink.id),
            ["title"] = "Account Link Token",
            ["message"] = messageText,
            ["conversation_open"] = "0",
            ["open_invite"] = "0",
        },
        method = "POST",
        type = "application/x-www-form-urlencoded",
        headers = {["XF-Api-Key"] = self.API_KEY}
    }

    CHTTP(request)
end

function PLUGIN:FinishLink(client, code)
    if (!self:CheckClientWait(client)) then return end

    if (!client.ixXenforoLink) then
        client:NotifyLocalized("xenoforoNoLinkActive")
        return
    end

    if (client.ixXenforoLink.validUntil < os.time()) then
        client:SetLocalVar("xenforoLinkStart", nil)
        client.ixXenforoLink = nil
        client:NotifyLocalized("xenoforoLinkNotValid")
        return
    end

    code = string.Trim(code)
    if (code == "") then
        return
    end

    if (client.ixXenforoLink.code == code) then
        self:FinalCheckLinkExists(client, client.ixXenforoLink.id)
    else
        client.ixXenforoLink.fails = client.ixXenforoLink.fails + 1
        if (client.ixXenforoLink.fails >= self.MAX_ATTEMPTS) then
            client:SetData("xenforoLinkFailPause", os.time() + self.FAILS_WAIT * 60)
            client:SetLocalVar("xenforoLinkStart", nil)
            client.ixXenforoLink = nil
            client:NotifyLocalized("xenforoFailsPauseStart")
        else
            client:NotifyLocalized("xenforoWrongCode", self.MAX_ATTEMPTS - client.ixXenforoLink.fails)
        end
    end
end

function PLUGIN:FinalCheckLinkExists(client, forumID)
    local query = mysql:Select("xenforo_link")
        query:Where("forum_id", forumID)
        query:Callback(function(result)
            if (!IsValid(client)) then return end

            if (result and #result > 0) then
                client:NotifyLocalized("xenforoUserAlreadyLinked")
                return
            else
                local insert = mysql:Insert("xenforo_link")
                    insert:Insert("steamid", client:SteamID64())
                    insert:Insert("forum_id", forumID)
                insert:Execute()

                client.ixXenforoID = forumID
                client.ixXenforoLink = nil

                client:NotifyLocalized("xenforoLinkSuccess")
                self:GetXenforoGroups(client, client)
            end
        end)
    query:Execute()
end

function PLUGIN:RemoveLink(client)
    local query = mysql:Delete("xenforo_link")
    query:Where("steamid", client:SteamID64())
    query:Execute()

    client.ixXenforoID = nil
    client.ixXenforoGroups = nil
    client:SetLocalVar("xenforoLink", false)

    client:SetLocalVar("xenforoLinkStart", nil)
    ix.xenforo:ApplyInGameGroups(client)

    client:NotifyLocalized("xenforoLinkRemoved")
end