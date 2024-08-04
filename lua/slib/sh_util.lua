--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

slib = slib or {}
slib.panels = slib.panels or {}
slib.cachedAvatars = slib.cachedAvatars or {}
slib.generalCooldowns = slib.generalCooldowns or {}

slib.config = {scale = {x = 1, y = 1}}

slib.getStatement = function(val)
    if isbool(val) then return "bool" end
    if isnumber(val) then return "int" end
    if istable(val) and val.r and val.g and val.b then return "color" end
    if istable(val) then return "table" end
    if isfunction(val) then return "function" end
    if isstring(val) then return "string" end

    return "bool"
end

local callNum = 1
local loadedCalls = {}

local function loadFile(folder, file)
    if string.StartWith(file, "sv_") or string.find(folder, "server") then
        if SERVER then
            include(folder .. file)
            loaded = true
        end
    elseif string.StartWith(file, "sh_") or string.find(folder, "shared") then
        AddCSLuaFile(folder .. file)
        include(folder .. file)
        loaded = true
    elseif string.StartWith(file, "cl_") or string.find(folder, "client") then
        AddCSLuaFile(folder .. file)
        if CLIENT then include(folder .. file) loaded = true end
    end

    if loaded then
        print("[slib] Loaded "..folder..file)

        return folder..file
    end
end

slib.loadFolder = function(folder, subdirectories, firstload, lastload, call)
    local files, directories = file.Find(folder .. "*", "LUA")
    loadedCalls[callNum] = loadedCalls[callNum] or {}

    if firstload then
        for k,v in pairs(firstload) do
            local result = loadFile(v[1], v[2])
            if !result then continue end
            loadedCalls[callNum][result] = true
        end
    end

    if lastload then
        for k,v in pairs(lastload) do
            loadedCalls[callNum][v[1]..v[2]] = true
        end
    end

    for k, v in pairs(files) do
        if loadedCalls[callNum][folder..v] then continue end
        loadFile(folder, v)
    end

    if subdirectories then
        for k,v in pairs(directories) do
            slib.loadFolder(folder..v.."/", true, nil, nil, call and call or callNum)
        end
    end

    if lastload then
        for k,v in pairs(lastload) do
            loadFile(v[1], v[2])
        end
    end

    if call then return end
    callNum = callNum + 1
end

slib.getCooldown = function(var)
    if !slib.generalCooldowns[var] then return true end
    
    return slib.generalCooldowns[var] and CurTime() >= slib.generalCooldowns[var]
end

slib.getTimeLeft = function(var)
    return slib.generalCooldowns[var] and slib.generalCooldowns[var] - CurTime() or 0
end

slib.setCooldown = function(var, cd)
    slib.generalCooldowns[var] = CurTime() + cd
end

slib.oldFunctions = {}

slib.wrapFunction = function(element, funcname, pre, post, returnresult)
    if !slib.oldFunctions[funcname.."Old"] then
        slib.oldFunctions[funcname.."Old"] = element[funcname]
    end

    element[funcname] = function(...)
        local result 
        
        if pre then
            local callback = pre(...)
            result = returnresult and callback or result
        end

        if isfunction(slib.oldFunctions[funcname.."Old"]) then
            result = slib.oldFunctions[funcname.."Old"](...) or result
        end 

        if post then
            local callback = post(...)
            result = returnresult and callback or result
        end

        return result
    end
end

slib.lang = slib.lang or {}

slib.setLang = function(addon, lang, id, str)
    slib.lang[addon] = slib.lang[addon] or {}
    slib.lang[addon][lang] = slib.lang[addon][lang] or {}

    slib.lang[addon][lang][id] = str
end

slib.getLang = function(addon, lang, id, ...)
    local args = {...}
    local unformatted = slib.lang[addon] and slib.lang[addon][lang] and slib.lang[addon][lang][id]

    if !unformatted then unformatted = slib.lang[addon] and slib.lang[addon]["en"] and slib.lang[addon]["en"][id] or id end

    return table.IsEmpty(args) and unformatted or string.format(unformatted, ...)
end

slib.notify = function(str, ply)
    str = tostring(str)
    if SERVER then
        net.Start("slib.msg")
        net.WriteString(str)
        net.Send(ply)
    elseif CLIENT then
        print(str)
        notification.AddLegacy(str, 0, 5)
    end
end

local function differenciate(a, b)
    if !(isstring(a) == isstring(b)) or isbool(a) or isbool(b) then
        return tostring(a), tostring(b)
    end

    return a, b
end

slib.sortAlphabeticallyByKeyValues = function(tbl, ascending)
    local normaltable = {}
    local cleantable = {}
    
    for k,v in pairs(tbl) do
        table.insert(normaltable, k)
    end

    if ascending then
        table.sort(normaltable, function(a, b) a, b = differenciate(a, b) return a < b end)
    else
        table.sort(normaltable, function(a, b) a, b = differenciate(a, b) return a > b end)
    end

    for k,v in pairs(normaltable) do
        cleantable[v] = k
    end

    return cleantable
end

slib.sortAlphabeticallyByValue = function(tbl, ascending, keyvalue)
    if keyvalue then
        tbl = table.Copy(tbl)
    end

    if ascending then
        table.sort(tbl, function(a, b) a, b = differenciate(a, b) return a < b end)
    else
        table.sort(tbl, function(a, b) a, b = differenciate(a, b) return a > b end)
    end

    local cleantable = {}

    for k, v in pairs(tbl) do
        cleantable[v] = k
    end

    return keyvalue and cleantable or tbl
end

slib.sid64ToPly = slib.sid64ToPly or {}

if SERVER then
    slib.playerCache = slib.playerCache or player.GetAll()

    util.AddNetworkString("slib.msg")

    local punished = {}
    slib.punish = function(ply, type, msg, duration)
        local sid = ply:SteamID()

        if punished[sid] then return end
        punished[sid] = true

        if type == 1 then
            ply:Kick(msg)
        elseif type == 2 then
            if duration == nil then duration = 0 end
            if sAdmin then
                RunConsoleCommand("sa","banid", ply:SteamID64(), duration, msg)
            elseif ULib then
                ULib.ban(ply, duration, msg)
            elseif sam then
                RunConsoleCommand("sam","banid", sid, duration, msg)
            elseif xAdmin then
                if xAdmin.Config then
                    if xAdmin.Config.MajorVersion == 1 then
                        RunConsoleCommand("xadmin_ban", sid, duration, msg)
                    else
                        RunConsoleCommand("xadmin","ban", sid, duration, msg)
                    end
                end
            elseif SERVERGUARD then
                RunConsoleCommand("serverguard","ban", sid, duration, msg)
            else
                ply:Ban(duration, true)
            end
        end
    end

    slib.isBanned = function(sid64, callback)
        local sid32 = util.SteamIDFrom64(sid64)

        if sAdmin and sAdmin.isBanned then
            return sAdmin.isBanned(sid64)
        elseif sam and sam.player and sam.player.is_banned then
            return sam.player.is_banned(sid32, callback)
        elseif ulx and ULib and ULib.bans then
            return tobool(ULib.bans[sid32])
        elseif xAdmin and xAdmin.Admin and xAdmin.Admin.Bans then
            local data = xAdmin.Admin.Bans[sid64]
            local endtime = data.StartTime + (data.Length * 60)

            return data and (tonumber(endtime) <= os.time()) or false
        end
    end

    slib.setRank = function(ply, rank)
        local sid64 = ply:SteamID64()

        if sAdmin then
            RunConsoleCommand("sa", "setrankid", sid64, rank)
        elseif sam then
            RunConsoleCommand("sam", "setrankid", sid64, rank)
        elseif ulx then
            RunConsoleCommand("ulx", "adduserid", ply:SteamID(), rank)
        elseif xAdmin then
            RunConsoleCommand("xadmin", "setgroup", ply:Nick(), rank) -- yes
        end
    end

    hook.Add("PlayerInitialSpawn", "slib.reconnected", function(ply)
        local sid = ply:SteamID()
        if punished[sid] then
            punished[sid] = nil
        end
    end)

    hook.Add("PlayerInitialSpawn", "slib.FullLoaded", function( ply )
        table.insert(slib.playerCache, ply)
        local sid64 = ply:SteamID64()
        slib.sid64ToPly[sid64] = ply

        local id = sid64.."_slib"
        hook.Add( "SetupMove", id, function( self, mv, cmd )
            if self == ply and not cmd:IsForced() then
                hook.Run("slib.FullLoaded", ply)
                hook.Remove("SetupMove", id)
            end
        end )
    end)

    hook.Add("PlayerDisconnected", "slib.handleDisconnect", function(ply)
        table.RemoveByValue(slib.playerCache, ply)
    end)
end

if CLIENT then
    local blur = Material("pp/blurscreen")

    slib.DrawBlur = function(panel, amount)
        local x, y = panel:LocalToScreen(0, 0)
        local scrW, scrH = ScrW(), ScrH()
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(blur)
        for i = 1, 3 do
            blur:SetFloat("$blur", (i / 3) * (amount or 6))
            blur:Recompute()
            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
        end
    end

    slib.getScaledSize = function(num, axis, scale)
        scale = scale or {x = 1, y = 1}

        if axis == "x" then
            num = ScrW() * (num/1920)

            num = num * scale.x
        end
    
        if axis == "y" or axis == nil then
            num = ScrH() * (num/1080)

            num = num * scale.y
        end
        
        return math.Round(num)
    end

    slib.cachedFonts = slib.cachedFonts or {}

    slib.createFont = function(fontname, size, thickness, ignorescale)
        size = size or 13
        thickness = thickness or 500
        local identifier = string.gsub(fontname, " ", "_")

        if !fontname or !size or !thickness then return end

        local name = "slib."..identifier..size.."."..thickness
        
        if ignorescale then name = "real_"..name end
        
        if slib.cachedFonts[name] then return name end

        surface.CreateFont( name, {
            font = fontname,
            size = ignorescale and size or slib.getScaledSize(size, "y"),
            weight = thickness,
        })

        slib.cachedFonts[name] = true

        return name
    end

    slib.colorCached = {}

    slib.lerpColor = function(identifier, wantedcolor, multiplier, nolerp)
        wantedcolor = table.Copy(wantedcolor)
        slib.colorCached[identifier] = slib.colorCached[identifier] or wantedcolor
        multiplier = multiplier or 1
        local basespeed = (RealFrameTime() * 3)
        local speed = basespeed * multiplier

        if minspeed then speed = minspeed > speed and minspeed or speed end
        
        for k,v in pairs(slib.colorCached[identifier]) do
            local percentageleft = math.abs(wantedcolor[k] - v)

            slib.colorCached[identifier][k] = math.Approach(v, wantedcolor[k], speed * (nolerp and 100 or percentageleft))
        end

        return slib.colorCached[identifier]
    end

    slib.numCached = {}
    slib.lerpNum = function(identifier, wantednum, multiplier, nolerp)
        slib.numCached[identifier] = slib.numCached[identifier] or wantednum
        multiplier = multiplier or 1
        local basespeed = (RealFrameTime() * 3)
        local speed = basespeed * multiplier

        local percentageleft = math.abs(wantednum - slib.numCached[identifier])

        slib.numCached[identifier] = math.Approach(slib.numCached[identifier], wantednum, speed * (nolerp and 100 or percentageleft))

        return math.Round(slib.numCached[identifier])
    end

    slib.drawTooltip = function(str, parent, align)
        local font = slib.createFont("Roboto", 13)
        local cursortposx, cursortposy = input.GetCursorPos()
        cursortposx = cursortposx + 15
        local x, y = cursortposx, cursortposy
       
        surface.SetFont(font)
        local strw, strh = surface.GetTextSize(str)
       
        local w = strw + slib.getScaledSize(6, "x")

        if align == 1 then
            local parentparent = parent:GetParent()
            if !IsValid(parentparent) then return end
            local posx, posy = parent:GetPos()
            x, y = parentparent:LocalToScreen(posx, posy)
            y = y + parent:GetTall()

            x = x + parent:GetWide() * .5

            x = x - w * .5
        end

        local tooltip = vgui.Create("EditablePanel")
        tooltip:SetMouseInputEnabled(false)
        tooltip:SetPos(x, y)
        tooltip:SetSize(w, slib.getScaledSize(22, "y"))
        tooltip:MakePopup()
    
        tooltip.Paint = function(s,w,h)
            if !parent:IsHovered() and !s:IsHovered() or !s:HasFocus() and !parent.clickable then s:Remove() end
    
            surface.SetDrawColor(slib.getTheme("maincolor", 10))
            surface.DrawRect(0, 0, w, h)
    
            surface.SetDrawColor(120, 120, 120, 200)
            surface.DrawOutlinedRect(0, 0, w, h)
    
            draw.SimpleText(str, font, slib.getScaledSize(3, "x"), h * .5, slib.getTheme("textcolor"), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        return tooltip
    end

    slib.createTooltip = function(str, parent)
        if !str or !parent then return end

        surface.SetFont(parent.font)
        local textw, texth = surface.GetTextSize(parent.name)


        local tooltipbutton = vgui.Create("DButton", parent)
		tooltipbutton:SetText("")
		tooltipbutton:Dock(LEFT)
		tooltipbutton:DockMargin(textw + slib.getScaledSize(6,"x"),slib.getScaledSize(5,"x"),0,slib.getScaledSize(5,"x"))
        tooltipbutton:SetWide(slib.getScaledSize(25, "y") - (slib.getScaledSize(5,"x") + slib.getScaledSize(5,"x")))
        tooltipbutton.bg = slib.getTheme("maincolor")
        
        tooltipbutton.DoClick = function()
            tooltipbutton.clicked = !tooltipbutton.clicked
        end

		tooltipbutton.Paint = function(s,w,h)
            draw.RoundedBox(h * .5, 0, 0, w, h, s.bg)

			draw.SimpleText("?", slib.createFont("Roboto", 14), w * .5, h * .5, slib.getTheme("textcolor", -50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            if s.clickable and !s.clicked and IsValid(s.tooltip) then
                s.tooltip:Remove()
            end

            if s:IsHovered() then
                if IsValid(s.tooltip) then return end
                s.tooltip = slib.drawTooltip(str, tooltipbutton)
            else
                s.clicked = nil
			end
        end
        
        return tooltipbutton
    end

    slib.theme = slib.theme or {}

    slib.setTheme = function(var, val)
        slib.theme[var] = val
    end

    slib.getTheme = function(var, offset)
        local val = slib.theme[var]

        if istable(val) then
            val = table.Copy(val)
            
            if offset then
                for k,v in pairs(val) do
                    val[k] = v + offset
                end

                if val.r and val.g and val.b and val.a then
                    for k,v in pairs(val) do
                        val[k] = math.Clamp(v, 0, 255)
                    end
                end
            end 
        end

        return val
    end

    slib.isValidSID64 = function(sid64)
        return util.SteamIDFrom64(sid64) != "STEAM_0:0:0"
    end

    local loading_ico = Material("slib/load.png", "smooth")

    local matCache = {}
    local fetched = {}
    
    file.CreateDir("slib")
    
    local proxy = ""--"https://proxy.duckduckgo.com/iu/?u=" -- Disabled for now, it doesn't work
    slib.ImgurGetMaterial = function(id) -- RETURN THE LOADING MATERIAL UNTIL IT IS FOUND!!!
        if !matCache[id] then
            local link = proxy.."https://i.imgur.com/"..id..".png"

            if file.Exists("slib/"..id..".png", "DATA") then
                matCache[id] = Material("data/slib/"..id..".png", "noclamp smooth")

                if matCache[id]:IsError() then
                    file.Delete("slib/"..id..".png")

                    if !fetched[link] then
                        slib.ImgurGetMaterial(id)
                    end
                end
            else
                if fetched[link] then return loading_ico, true end
                
                fetched[link] = true
                
                http.Fetch(link,
                    function(body)
                        file.Write("slib/"..id..".png", body)
                        matCache[id] = Material("data/slib/"..id..".png", "noclamp smooth")
                    end
                )
            end
        else
            return matCache[id]
        end
        
        return loading_ico, true
    end

    local cachedNames = {}
    local requestedNames = {}

    slib.findName = function(sid64, rtrn_sid64)
        if cachedNames[sid64] then return cachedNames[sid64] end

        local servercheck = player.GetBySteamID64(sid64)
        local steamcheck = false

        if servercheck then
            cachedNames[sid64] = servercheck:Nick()
        else
            if requestedNames[sid64] then return rtrn_sid64 and sid64 end
            requestedNames[sid64] = true
            local start = "<title>Steam Community :: "
            local theEnd = '<link rel="shortcut icon" href="/favicon.ico" type="image/'

            http.Fetch("http://steamcommunity.com/profiles/"..sid64,
                function(data)
                    local nameStart = select(1, string.find(data, start))
                    local nameEnd = select(1, string.find(data, theEnd))

                    if !nameStart or !nameEnd then return end

                    nameStart = nameStart + #start
                    nameEnd = nameEnd - 12

                    local nick = string.sub(data, nameStart, nameEnd)

                    cachedNames[sid64] = nick
                end
            )

            if !rtrn_sid64 then
                cachedNames[sid64] = "N/A"
            end
        end

        return rtrn_sid64 and sid64 or cachedNames[sid64]
    end

    local function saveImageFromURL(url, path, cb)
        http.Fetch(url, function(data)
            file.Write(path, data)

            if cb then
                cb()
            end
        end)
    end

    local fetchingAvatar = {}
    local default_ico = Material("slib/default_steam.png", "smooth")

    slib.findAvatar = function(sid64, medium)
        if !sid64 then return end
        
        local path = "slib/avatars/"..sid64..(medium and "_medium" or "_full")..".jpg"
        local size = medium and "medium" or "full"

        slib.cachedAvatars[size] = slib.cachedAvatars[size] or {}

        if !slib.cachedAvatars[size][sid64] or slib.cachedAvatars[size][sid64]:IsError() then
            if file.Exists(path, "DATA") then
                slib.cachedAvatars[size][sid64] = Material("data/"..path, "smooth noclamp")

                return slib.cachedAvatars[size][sid64]
            end

            local start = "https://avatars.akamai.steamstatic.com/"
            local theEnd = '">'

            if !fetchingAvatar[sid64] then
                http.Fetch( "http://steamcommunity.com/profiles/"..sid64,
                    function(data)
                        local avatarStart = select(1, string.find(data, start))
                        local avatarEnd = avatarStart + select(1, string.find(string.sub(data, avatarStart, #data), theEnd))

                        if !avatarStart or !avatarEnd then return end

                        local imgLink = string.sub(data, avatarStart, avatarEnd - 2)

                        if medium then
                            imgLink = string.Replace(imgLink, "_full", "_medium")
                        end

                        saveImageFromURL(imgLink, path, function()
                            file.CreateDir("slib/avatars/")
                            slib.cachedAvatars[size][sid64] = Material("data/"..path, "smooth noclamp")
                        end)

                        cachedNames[sid64] = nick
                    end
                )

                fetchingAvatar[sid64] = true
            end

            return default_ico
        end

        return slib.cachedAvatars[size][sid64]
    end

    local storedImages = file.Find("slib/avatars/*.jpg", "DATA")

    for k,v in ipairs(storedImages) do
        if os.time() - file.Time("slib/avatars/"..v, "DATA") >= 259200 then
            file.Delete("slib/avatars/"..v)
        end
    end

    hook.Add("OnEntityCreated", "slib.CacheSid64ToPly", function(ent)
        if ent:IsPlayer() and !ent:IsBot() then
            local sid64 = ent:SteamID64()
            
            if !sid64 then return end

            slib.sid64ToPly[sid64] = ent
        end
    end)

    net.Receive("slib.msg", function(_, ply)
        slib.notify(net.ReadString())
    end)
end

hook.Run("slib:loadBase")
hook.Run("slib:loadedUtils")