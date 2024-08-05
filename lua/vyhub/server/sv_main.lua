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

VyHub.frontend_url = VyHub.frontend_url or nil

function VyHub:server_data_ready()
    VyHub:msg(f("I am server %s in bundle %s.", VyHub.server.name, VyHub.server.serverbundle.name))

    VyHub.ready = true

    hook.Run("vyhub_ready")
end

function VyHub:get_frontend_url(callback)
    if VyHub.frontend_url != nil then
        if callback then
            callback(VyHub.frontend_url)
        end
        
        return VyHub.frontend_url
    end

    VyHub.API:get('/general/frontend-url', nil, nil, function (code, result)
        VyHub.frontend_url = result.frontend_url
        VyHub.Cache:save('frontend_url', VyHub.frontend_url)

        if callback then
            callback(VyHub.frontend_url)
        end
    end, function ()
        local frontend_url = VyHub.Cache:get('frontend_url')

        if frontend_url == nil then
            VyHub:msg("Could not get frontend_url!", "error")
        end

        if callback then
            callback(frontend_url)
        end
    end)
end

hook.Add("vyhub_api_ready", "vyhub_main_vyhub_api_ready", function ()
    VyHub.API:get("/server/%s", { VyHub.Config.server_id }, nil, function(code, result) 
        VyHub.server = result

        VyHub:server_data_ready()

        VyHub.Cache:save("server", VyHub.server)
    end, function (code, result)
        VyHub:msg(f("Could not find server with id %s", VyHub.Config.server_id), "error")

        timer.Simple(60, function ()
            hook.Run("vyhub_loading_finish")
        end)
    end)

    VyHub:get_frontend_url()
end)

hook.Add("vyhub_api_failed", "vyhub_main_vyhub_api_failed", function ()
    local server = VyHub.Cache:get("server", 604800)

    if server != nil then
        VyHub.server = server

        VyHub:server_data_ready()
    else
        VyHub:msg("Could not find cached server data or cached data is too old. Please make sure that the server is able to reach the VyHub API.", "error")
        
        timer.Simple(60, function ()
            hook.Run("vyhub_loading_finish")
        end)
    end
end)

timer.Create("vyhub_not_ready_msg", 30, 0, function ()
    if VyHub.ready then
        timer.Remove("vyhub_not_ready_msg")
    else
        VyHub.Util:print_chat_all("<green>VyHub</green> is not ready. Please check the server log/console for errors.")
    end
end)
