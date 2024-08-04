--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

eProtect = eProtect or {}
eProtect.overrides = eProtect.overrides or {}

if !eProtect.overrides["net.Incoming"] then
    eProtect.overrides["net.Incoming"] = true
    function net.Incoming( len, client )
        local i = net.ReadHeader()
        local strName = util.NetworkIDToString( i )
        
        if ( !strName ) then return end
        
        local func = net.Receivers[ strName:lower() ]
        if ( !func ) then return end

        len = len - 16
        
        local pre = hook.Run("eP:PreNetworking", client, strName, len)

        if pre == false then return end

        func( len, client )

        hook.Run("eP:PostNetworking", client, strName, len)
    end
end

if !eProtect.config["disablehttplogging"] and ((!VC and !XEON and !mLib) or eProtect.config["ignoreDRM"]) then
    if !eProtect.overrides["http.Fetch"] then
        eProtect.overrides["http.Fetch"] = true
        local oldFetch = http.Fetch
        function http.Fetch(...)
            local args = {...}
            local result = hook.Run("eP:PreHTTP", args[1], "fetch")

            if result == false then return end

            oldFetch(...)

            hook.Run("eP:PostHTTP", args[1], "fetch")
        end
    end

    if !eProtect.overrides["http.Post"] then
        eProtect.overrides["http.Post"] = true
        local oldPost = http.Post
        function http.Post(...)
            local args = {...}
            local result = hook.Run("eP:PreHTTP", args[1], "post")

            if result == false then return end

            oldPost(...)

            hook.Run("eP:PostHTTP", args[1], "post")
        end
    end
end