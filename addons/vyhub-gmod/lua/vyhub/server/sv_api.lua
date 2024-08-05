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

VyHub.API = VyHub.API or {}

local content_type = "application/json; charset=utf-8"
local json = VyHub.Lib.json

function VyHub.API:request(method, url, path_params, query, headers, request_body, type, success, failed, no_error_for)
    no_error_for = no_error_for or {}
    
    if path_params != nil then
        url = f(url, unpack(path_params))
    end

    if istable(request_body) then
        request_body = json.encode(request_body)
    end

    success_func = function(code, body, headers)
        local result = body

        if headers["Content-Type"] and headers["Content-Type"] == 'application/json' then
            result = json.decode(body)
        end

        if code >= 200 and code < 300 then
            VyHub:msg(f("HTTP %s %s (%s): %s", method, url, json.encode(query), code), "debug")

            if success != nil then
                -- VyHub:msg(f("Response: %s", body), "debug")

                success(code, result, headers)
            end
        else
            if not table.HasValue(no_error_for, code) then
                local err_msg = f("HTTP %s %s: %s", method, url, code)

                if query then
                    err_msg = err_msg .. f("\nQuery: %s", json.encode(query))
                end
                if request_body then
                    err_msg = err_msg .. f("\nBody: %s", request_body)
                end

                VyHub:msg(err_msg, "error")
                
                if code < 500 and string.find( body:lower(), "html>" ) == nil then
                    VyHub:msg(f("Response: %s", body), "error")
                end
            end

            if failed != nil then
                local err_text = json.encode(result)

                if istable(result) and result.detail != nil and result.detail.msg != nil then
                    err_text = f("%s (%s)", result.detail.msg, result.detail.code)
                end

                failed(code, result, headers, err_text)
            end
        end
    end

    failed_func = function(reason)
        local err_msg = f("HTTP %s %s: %s", method, url, code)

        if query then
            err_msg = err_msg .. f("\nQuery: %s", json.encode(query))
        end
        if request_body then
            err_msg = err_msg .. f("\nBody: %s", request_body)
        end

        VyHub:msg(err_msg, "error")

        if failed != nil then
            failed(0, reason, {})
        end
    end

    HTTP({
        method = method,
        url = url,
        parameters = query,
        headers = headers,
        body = request_body,
        type = type,
        success = success_func,
        failed = failed_func,
    })
end

function VyHub.API:get(endpoint, path_params, query, success, failed, no_error_for)
    local url = f("%s%s", VyHub.API.url, endpoint)

    VyHub.API:request("GET", url, path_params, query, self.headers, nil, content_type, success, failed, no_error_for)
end

function VyHub.API:delete(endpoint, path_params, success, failed)
    local url = f("%s%s", VyHub.API.url, endpoint)

    self:request("DELETE", url, path_params, nil, self.headers, nil, content_type, success, failed)
end

function VyHub.API:post(endpoint, path_params, body, success, failed, query)
    local url = f("%s%s", VyHub.API.url, endpoint)

    self:request("POST", url, path_params, query, self.headers, body, content_type, success, failed)
end

function VyHub.API:patch(endpoint, path_params, body, success, failed)
    local url = f("%s%s", VyHub.API.url, endpoint)

    self:request("PATCH", url, path_params, nil, self.headers, body, content_type, success, failed)
end

function VyHub.API:put(endpoint, path_params, body, success, failed)
    local url = f("%s%s", VyHub.API.url, endpoint)

    self:request("PUT", url, path_params, nil, self.headers, body, content_type, success, failed)
end

hook.Add("vyhub_loading_finish", "vyhub_api_vyhub_loading_finish", function()
    if VyHub.Util:invalid_str({VyHub.Config.api_url, VyHub.Config.api_key, VyHub.Config.server_id}) then
        VyHub:msg("API URL, Server ID or API Key not set! Please follow the manual.", "error")

        timer.Simple(60, function ()
            hook.Run("vyhub_loading_finish")
        end)

        return
    end

    VyHub.API.url = VyHub.Config.api_url
    VyHub.API.headers = {
        Authorization = f("Bearer %s", VyHub.Config.api_key)
    }

    if string.EndsWith(VyHub.API.url, "/") then
        VyHub.API.url = string.sub(VyHub.API.url, 1, -2)
    end

    VyHub:msg(f("API URL is %s", VyHub.API.url))

    VyHub.API:get("/openapi.json", nil, nil, function(code, result, headers)
        VyHub:msg(f("Connection to API %s version %s successful!", result.info.title, result.info.version), "success")

        hook.Run("vyhub_api_ready")
    end, function()
        VyHub:msg("Connection to API failed! Trying to use cache.", "error")

        hook.Run("vyhub_api_failed")
    end)
end)

concommand.Add("vh_reinit", function (ply)
    if not VyHub.Util:is_server(ply) then return end

    hook.Run("vyhub_loading_finish")
end)