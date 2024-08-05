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
eProtect.data = eProtect.data or {}

local function networkData(data, ...)
    local args = {...}

    net.Start("eP:Handeler")
    net.WriteBit(1)
    net.WriteUInt(1, 2)
    net.WriteUInt(#args, 3)
    
    for k,v in pairs(args) do
        net.WriteString(v)
    end

    local statement = slib.getStatement(data)

    if statement == "bool" then
        net.WriteUInt(1, 2)
        net.WriteBool(data)
    elseif statement == "int" then
        net.WriteUInt(2, 2)
        net.WriteInt(data, 32)
    elseif statement == "table" or statement == "color" then
        net.WriteUInt(3, 2)

        data = table.Copy(data)
        
        local converted_tbl = {}

        for k,v in pairs(data) do
            local isSID = util.SteamIDFrom64(k) != "STEAM_0:0:0"

            if isSID then
                converted_tbl["sid64_"..k] = v
            else
                converted_tbl[k] = v
            end
        end

        data = converted_tbl
        
        data = util.Compress(util.TableToJSON(data))
        net.WriteUInt(#data, 32)
        net.WriteData(data, #data)
    end

    net.SendToServer()
end

local convertedTbl

convertedTbl = function(tbl)
    local converted_tbl = {}

    for k, v in pairs(tbl) do
        if istable(v) then v = convertedTbl(v) end

        if string.sub(k, 1, 6) == "sid64_" then
            local sid64 = string.sub(k, 7, #k)

            if util.SteamIDFrom64(sid64) != "STEAM_0:0:0" then
                k = sid64
            end
        end

        converted_tbl[k] = v
    end

    return converted_tbl
end

local function openScreenshot(ply, id)
    if !IsValid(ply) then return end
    http.Fetch("https://stromic.dev/eprotect/img.php?id="..id, function(result)
        local sc_frame = vgui.Create("SFrame")
        sc_frame:SetSize(slib.getScaledSize(960, "x"), slib.getScaledSize(540, "y") + slib.getScaledSize(25, "y"))
        :setTitle(slib.getLang("eprotect", eProtect.config["language"], "sc-preview")..ply:Nick())
        :MakePopup()
        :addCloseButton()
        :Center()
        :setBlur(true)
    
        local display = vgui.Create("HTML", sc_frame.frame)
        display:Dock(FILL)
        display:SetHTML([[<img src="data:image/jpeg;base64,]] ..result.. [[" style="height:]]..(sc_frame.frame:GetTall())..[[px;width:]]..(sc_frame.frame:GetWide())..[[px;position:fixed;top:0px;left:0px">]])
    end)
end

local function sid64format(sid64)
    return slib.findName(sid64).." ("..sid64..")"
end

local function fillCleanData(index, tbl)
    local files, directories = file.Find(index, "DATA")

    if files then
        for k,v in pairs(files) do
            tbl[v] = true
        end
    end
	
	if index == "*" then index = "" end
	local attribute = !index and "/" or ""

    if directories then
        for k,v in pairs(directories) do
            tbl[v] = tbl[v] or {}

           fillCleanData(index..attribute..v.."/*", tbl[v])
        end
    end
end

local margin = slib.getTheme("margin")
local maincolor_7, maincolor_10, hovercolor, linecol = slib.getTheme("maincolor", 7), slib.getTheme("maincolor", 10), slib.getTheme("hovercolor"), Color(0,0,0,160)
local arrow_ico = Material("slib/down-arrow.png", "smooth noclamp")

local createPaginator = function(parent)
    local font = slib.createFont("Roboto", 16)
    local paginator_tall = slib.getScaledSize(25, "y")
    local paginator = vgui.Create("EditablePanel", parent)
    paginator:Dock(BOTTOM)
    paginator:DockPadding(margin,margin,margin,margin)
    paginator:SetTall(paginator_tall)
    paginator.page = 1
    paginator.maxpage = 5

    paginator.Paint = function(s,w,h)
        surface.SetDrawColor(linecol)
        surface.DrawRect(0,0,w,1)

        draw.SimpleText(slib.getLang("eprotect", eProtect.config["language"], "page_of_page", s.page, s.maxpage), font, w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    surface.SetFont(font)
    local prev_w = select(1, surface.GetTextSize(slib.getLang("eprotect", eProtect.config["language"], "previous")))
    local next_w = select(1, surface.GetTextSize(slib.getLang("eprotect", eProtect.config["language"], "next")))

    local left = vgui.Create("SButton", paginator)
    :Dock(LEFT)
    :SetWide(paginator_tall + prev_w)

    local ico_size = paginator:GetTall() * .5

    left.Paint = function(s,w,h)
        surface.SetDrawColor(maincolor_7)
        surface.DrawRect(0,0,w,h)

        local hover = s:IsHovered()
        local curCol = slib.lerpColor(s, hover and hovercolor or color_white)

        s.move = s.move or 1
        s.move = math.Clamp(hover and s.move + .05 or s.move - .05, 0, 2)

        surface.SetDrawColor(curCol)
        surface.SetMaterial(arrow_ico)
        surface.DrawTexturedRectRotated(h * .5 - s.move, h * .5,ico_size ,ico_size, -90)

        draw.SimpleText(slib.getLang("eprotect", eProtect.config["language"], "previous"), font, w - margin, h * .5, curCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
    end

    left.DoClick = function()
        if paginator.page <= 1 then return end
        local nextpage = paginator.page - 1

        paginator.onPageChanged(nextpage)
    end

    local right = vgui.Create("SButton", paginator)
    :Dock(RIGHT)
    :SetWide(paginator_tall + next_w)

    right.Paint = function(s,w,h)
        surface.SetDrawColor(maincolor_7)
        surface.DrawRect(0,0,w,h)

        local hover = s:IsHovered()
        local curCol = slib.lerpColor(s, hover and hovercolor or color_white)

        s.move = s.move or 1
        s.move = math.Clamp(hover and s.move + .05 or s.move - .05, 0, 2)

        surface.SetDrawColor(curCol)
        surface.SetMaterial(arrow_ico)
        surface.DrawTexturedRectRotated(w - (h * .5 - s.move), h * .5,ico_size ,ico_size, 90)

        draw.SimpleText(slib.getLang("eprotect", eProtect.config["language"], "next"), font, margin, h * .5, curCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    right.DoClick = function()
        if paginator.page >= paginator.maxpage then return end
        local nextpage = paginator.page + 1

        paginator.onPageChanged(nextpage)
    end

    return paginator
end

local function showID(ply, id)
    id = util.JSONToTable(util.Base64Decode(id))
    if !id or !istable(id) then slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "ply-sent-invalid-data")) return end

    local id_list = vgui.Create("SFrame")
    id_list:SetSize(slib.getScaledSize(500, "x"),slib.getScaledSize(330, "y"))
    :Center()
    :MakePopup()
    :addCloseButton()
    :setTitle(slib.getLang("eprotect", eProtect.config["language"], "id-info")..ply:Nick(), slib.createFont("Roboto", 17))
    :setBlur(true)

    local id_details = vgui.Create("SListView", id_list.frame)
    id_details:Dock(FILL)
    :addColumns(slib.getLang("eprotect", eProtect.config["language"], "player"), slib.getLang("eprotect", eProtect.config["language"], "date"))
    
    for i, z in pairs(id) do
        local sid64 = util.SteamIDTo64(i)

        local _, line = id_details:addLine(function() return sid64format(sid64) end, {os.date("%H:%M:%S - %d/%m/%Y", z), z})
        line.DoClick = function()
            gui.OpenURL("http://steamcommunity.com/profiles/"..sid64)
        end

        line:SetZPos(z)
    end
end

local function showCorrelation(ply, data)
    data = util.JSONToTable(util.Base64Decode(data))
    if !data or !istable(data) then return end

    local correlation_list = vgui.Create("SFrame")
    correlation_list:SetSize(slib.getScaledSize(450, "x"),slib.getScaledSize(330, "y"))
    :Center()
    :MakePopup()
    :addCloseButton()
    :setTitle(slib.getLang("eprotect", eProtect.config["language"], "ip-correlation")..ply:Nick(), slib.createFont("Roboto", 17))
    :setBlur(true)

    local correlation_details = vgui.Create("SListView", correlation_list.frame)
    correlation_details:Dock(FILL)
    :addColumns(slib.getLang("eprotect", eProtect.config["language"], "player"), slib.getLang("eprotect", eProtect.config["language"], "ip"))

    for k, v in ipairs(data) do        
        local _, line = correlation_details:addLine(function() return sid64format(v.sid64) end, v.ip)
        line.DoClick = function()
            gui.OpenURL("http://steamcommunity.com/profiles/"..v.sid64)
        end

        line:SetZPos(z)
    end
end

local function showIPs(ply, data)
    data = util.JSONToTable(util.Base64Decode(data))
    if !data or !istable(data) then return end

    local ip_list = vgui.Create("SFrame")
    ip_list:SetSize(slib.getScaledSize(400, "x"),slib.getScaledSize(280, "y"))
    :Center()
    :MakePopup()
    :addCloseButton()
    :setTitle(slib.getLang("eprotect", eProtect.config["language"], "ip-info")..ply:Nick(), slib.createFont("Roboto", 17))
    :setBlur(true)

    local ip_details = vgui.Create("SListView", ip_list.frame)
    ip_details:Dock(FILL)
    :addColumns(slib.getLang("eprotect", eProtect.config["language"], "country-code"), slib.getLang("eprotect", eProtect.config["language"], "ip"), slib.getLang("eprotect", eProtect.config["language"], "date"))

    for k, v in pairs(data) do
        local _, line = ip_details:addLine(v.country, v.ip, {os.date("%H:%M:%S - %d/%m/%Y", v.logged_time), v.logged_time})
        line.DoClick = function()
            gui.OpenURL("https://whatismyipaddress.com/ip/"..v.ip)
        end

        line:SetZPos(v.logged_time)
    end
end

local requestLogData = function(id, page, search)
    net.Start("eP:Handeler")
    net.WriteBit(1)
    net.WriteUInt(0, 2)
    net.WriteUInt(id, 1)
    net.WriteUInt(page, 15)
    net.WriteString(search)
    net.SendToServer()
end

local eprotect_menu

local function openMenu()
    eprotect_menu = vgui.Create("SFrame")
    eprotect_menu:SetSize(slib.getScaledSize(720, "x"),slib.getScaledSize(530, "y"))
    :setTitle("eProtect")
    :Center()
    :addCloseButton()
    :MakePopup()
    :addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-general"), "eprotect/tabs/general.png")

    if !eProtect.config["disabledModules"]["identifier"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-identifier"), "eprotect/tabs/identifier.png")
    end

    if !eProtect.config["disabledModules"]["detection_log"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-detectionlog"), "eprotect/tabs/detectionlog.png")
    end

    if !eProtect.config["disabledModules"]["net_limiter"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-netlimiter"),"eprotect/tabs/netlimit.png")
    end

    if !eProtect.config["disabledModules"]["net_logger"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-netlogger"), "eprotect/tabs/netlog.png")
    end

    if !eProtect.config["disablehttplogging"] and ((!VC and !XEON and !mLib) or eProtect.config["ignoreDRM"]) then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-httplogger"), "eprotect/tabs/httplog.png")
    end

    if !eProtect.config["disabledModules"]["exploit_patcher"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-exploitpatcher"), "eprotect/tabs/exploitpatcher.png")
    end

    if !eProtect.config["disabledModules"]["exploit_finder"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-exploitfinder"), "eprotect/tabs/exploitfinder.png")
    end

    if !eProtect.config["disabledModules"]["fake_exploits"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-fakeexploits"), "eprotect/tabs/fakeexploit.png")
    end

    
    if !eProtect.config["disabledModules"]["data_snooper"] then
        eprotect_menu:addTab(slib.getLang("eprotect", eProtect.config["language"], "tab-datasnooper"), "eprotect/tabs/datasnooper.png")
    end

    eprotect_menu:setActiveTab(slib.getLang("eprotect", eProtect.config["language"], "tab-general"))

    local generalscroller = vgui.Create("SScrollPanel", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-general")])
    generalscroller:Dock(FILL)
    generalscroller:GetCanvas():DockPadding(0,slib.getTheme("margin"),0,slib.getTheme("margin"))

    local player_list = vgui.Create("SListPanel", generalscroller)
    player_list:setTitle(slib.getLang("eprotect", eProtect.config["language"], "player-list"))
    :addSearchbar()
    :SetZPos(-200)
    :addButton(slib.getLang("eprotect", eProtect.config["language"], "disable-networking"), 
    function(s)
        if !s.selected or !IsValid(s.selected) then return end
        local sid = s.selected:SteamID()
        eProtect.data.disabled[sid] = !eProtect.data.disabled[sid]

        net.Start("eP:Handeler")
        net.WriteBit(1)
        net.WriteUInt(2, 2)
        net.WriteUInt(1, 3)
        net.WriteUInt(s.selected:EntIndex(), 14)
        net.WriteBool(eProtect.data.disabled[sid])
        net.SendToServer()
    end,
    function(s, bttn)
        if !s.selected or !IsValid(s.selected) then 
            bttn:setTitle(slib.getLang("eprotect", eProtect.config["language"], "disable-networking"))    
        return end

        if eProtect.data.disabled[s.selected:SteamID()] then 
            bttn:setTitle(slib.getLang("eprotect", eProtect.config["language"], "enable-networking")) 
        else 
            bttn:setTitle(slib.getLang("eprotect", eProtect.config["language"], "disable-networking")) 
        end
    end)
    :addButton(slib.getLang("eprotect", eProtect.config["language"], "capture"), function(s)
        if !s.selected or !IsValid(s.selected) then return end

        net.Start("eP:Handeler")
        net.WriteBit(1)
        net.WriteUInt(2, 2)
        net.WriteUInt(2, 3)
        net.WriteUInt(s.selected:EntIndex(), 14)
        net.WriteUInt(1, 2)
        net.SendToServer()
    end)
    :addButton(slib.getLang("eprotect", eProtect.config["language"], "check-ips"), function(s)
        if !s.selected or !IsValid(s.selected) then return end

        net.Start("eP:Handeler")
        net.WriteBit(1)
        net.WriteUInt(2, 2)
        net.WriteUInt(3, 3)
        net.WriteUInt(s.selected:EntIndex(), 14)
        net.WriteBit(0)
        net.SendToServer()
    end)

    for k,v in pairs(player.GetAll()) do
        if v:IsBot() then continue end
        player_list:addEntry(v)
    end

    if eProtect.data.general then
        for k,v in pairs(eProtect.data.general) do
            local type = slib.getStatement(eProtect.BaseConfig[k][1])
            local cur_type =  slib.getStatement(v)
            if type ~= cur_type then v = eProtect.BaseConfig[k][1] end
            local option = vgui.Create("SStatement", generalscroller)
            local _, element = option:SetZPos(eProtect.BaseConfig[k][2])
            :addStatement(slib.getLang("eprotect", eProtect.config["language"], k), v)

            if type == "int" then
                element:SetMin(eProtect.BaseConfig[k][3].min)
                element:SetMax(eProtect.BaseConfig[k][3].max)
            elseif type == "table" then
                element.onElementOpen = function(s)
                    s.title = slib.getLang("eprotect", eProtect.config["language"], k)
                    s:SetSize(slib.getScaledSize(850, "x"), slib.getScaledSize(350, "y"))
                    s:Center()
                    s:addEntry()
                    s:addSuggestions(isfunction(eProtect.BaseConfig[k][3]) and eProtect.BaseConfig[k][3]() or {})
                    s:addSearch(s.viewbox, s.viewer)
                    s:addSearch(s.suggestionbox, s.suggestions)
                    
                    s.OnRemove = function()
                        if s.modified then
                            element.onValueChange(s.viewer.tbl)
                        end
                    end
                end
            end

            element.onValueChange = function(value)
                networkData(value, "general", k)
            end

            slib.createTooltip(slib.getLang("eprotect", eProtect.config["language"], k.."-tooltip"), option)
        end
    end

    -- Identifier tab
    if !eProtect.config["disabledModules"]["identifier"] then
        local search_id = vgui.Create("SSearchBar", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-identifier")])
        search_id:DockMargin(0,0,0,0)
        :addIcon()

        search_id.bg = maincolor_10

        local identifier = vgui.Create("SScrollPanel", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-identifier")])
        identifier:Dock(FILL)
        identifier:GetCanvas():DockPadding(0,slib.getTheme("margin"),0,slib.getTheme("margin"))

        search_id.entry.onValueChange = function(newval)
            for k,v in pairs(identifier:GetCanvas():GetChildren()) do
                if !string.find(string.lower(v.name), string.lower(newval)) then
                    v:SetVisible(false)
                else
                    v:SetVisible(true)
                end

                identifier:GetCanvas():InvalidateLayout(true)
            end
        end

        for k,v in pairs(player.GetAll()) do
            if v:IsBot() then continue end
            local ply = vgui.Create("SPlayerPanel", identifier)
            ply:setPlayer(v)
            :addButton(slib.getLang("eprotect", eProtect.config["language"], "check-ids"), function()
                if !v or !IsValid(v) then return end
                
                net.Start("eP:Handeler")
                net.WriteBit(1)
                net.WriteUInt(2, 2)
                net.WriteUInt(2, 3)
                net.WriteUInt(v:EntIndex(), 14)
                net.WriteUInt(2, 2)
                net.SendToServer()
            end)
            :addButton(slib.getLang("eprotect", eProtect.config["language"], "correlate-ip"), function()
                if !v or !IsValid(v) then return end
                
                net.Start("eP:Handeler")
                net.WriteBit(1)
                net.WriteUInt(2, 2)
                net.WriteUInt(3, 3)
                net.WriteUInt(v:EntIndex(), 14)
                net.WriteBit(1)
                net.SendToServer()
            end)
            :addButton(slib.getLang("eprotect", eProtect.config["language"], "family-share-check"), function()
                if !v or !IsValid(v) then return end
                
                net.Start("eP:Handeler")
                net.WriteBit(1)
                net.WriteUInt(2, 2)
                net.WriteUInt(4, 3)
                net.WriteUInt(v:EntIndex(), 14)
                net.SendToServer()
            end)
        end
    end


    -- Punishment log
    if !eProtect.config["disabledModules"]["detection_log"] then
        local search_punishments = vgui.Create("SSearchBar", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-detectionlog")])
        search_punishments:DockMargin(0,0,0,2)
        :addIcon()

        search_punishments.bg = maincolor_10

        search_punishments.entry.onValueChange = function(newval)
            requestLogData(1, 1, newval)
        end

        local punishment_log = vgui.Create("SListView", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-detectionlog")])
        punishment_log:Dock(FILL)
        :addColumns(slib.getLang("eprotect", eProtect.config["language"], "player"), slib.getLang("eprotect", eProtect.config["language"], "reason"), slib.getLang("eprotect", eProtect.config["language"], "info"), slib.getLang("eprotect", eProtect.config["language"], "type"))

        local typeToLang = {
            [1] = "kicked",
            [2] = "banned",
            [3] = "notified"
        }

        local detections_paginator = createPaginator(eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-detectionlog")])
        detections_paginator.onPageChanged = function(page)
            local val = search_punishments.entry:GetValue()

            requestLogData(1, page, val == search_punishments.entry.placeholder and "" or val)
        end

        detections_paginator.onPageChanged(1)

        punishment_log.paginator = detections_paginator

        punishment_log.rebuild = function()
            for k,v in ipairs(punishment_log:GetCanvas():GetChildren()) do
                if !v.isLine then continue end
                v:Remove()
            end

            local tbl_detections = eProtect.data["requestedDetections"] and eProtect.data["requestedDetections"].result or {}
            
            detections_paginator.page, detections_paginator.maxpage = eProtect.data["requestedDetections"].page, eProtect.data["requestedDetections"].pageCount

            for k,v in ipairs(tbl_detections) do
                local _, line = punishment_log:addLine(v.name, function() return slib.getLang("eprotect", eProtect.config["language"], v.reason) end, v.info, function() return slib.getLang("eprotect", eProtect.config["language"], typeToLang[tonumber(v.type)]) end)
                line.isLine = true
            end

            punishment_log:GetCanvas():SetTall(punishment_log:GetTall())
        end

        eprotect_menu.punishment_log = punishment_log
    end

    -- Net limitation
    if eProtect.data.netLimitation and !eProtect.config["disabledModules"]["net_limiter"] then
        local search = vgui.Create("SSearchBar", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-netlimiter")])
        search:DockMargin(0,0,0,0)
        :addIcon()

        search.bg = maincolor_10


        local scroller = vgui.Create("SScrollPanel", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-netlimiter")])
        scroller:Dock(FILL)
        scroller:GetCanvas():DockPadding(0,slib.getTheme("margin"),0,slib.getTheme("margin"))


        search.entry.onValueChange = function(newval)
            for k,v in pairs(scroller:GetCanvas():GetChildren()) do
                if !string.find(string.lower(v.name), string.lower(newval)) then
                    v:SetVisible(false)
                else
                    v:SetVisible(true)
                end

                scroller:GetCanvas():InvalidateLayout(true)
            end
        end


        for k,v in pairs(eProtect.data.netLimitation) do
            if eProtect.data.fakeNets and eProtect.data.fakeNets[k] or !util.NetworkStringToID(k) then continue end

            local netstring = vgui.Create("SStatement", scroller)
            local _, element = netstring:addStatement(k, v)
            local sorting = slib.sortAlphabeticallyByKeyValues(eProtect.data.netLimitation, true)
            
            netstring:SetZPos(sorting[k])

            element:SetMin(-1)
            element:SetMax(999999)

            element.onValueChange = function(value)
                networkData(value, "netLimitation", k)
            end

            slib.createTooltip(slib.getLang("eprotect", eProtect.config["language"], "net-limit-desc"), netstring)
        end
    end

    -- Net logger tab
    if !eProtect.config["disabledModules"]["net_logger"] then
        local net_log_search = vgui.Create("SSearchBar", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-netlogger")])
        :DockMargin(0,0,0,2)
        :addIcon()

        net_log_search.bg = maincolor_10

        local net_logging = vgui.Create("SListView", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-netlogger")])
        net_logging:Dock(FILL)
        :addColumns(slib.getLang("eprotect", eProtect.config["language"], "net-string"), slib.getLang("eprotect", eProtect.config["language"], "called"), slib.getLang("eprotect", eProtect.config["language"], "len"))
        
        net_logging.Columns[1].maxTxtLen = 56
        
        net_log_search.entry.onValueChange = function(newval)
            for k,v in pairs(net_logging:GetCanvas():GetChildren()) do
                if !v.name or v:GetZPos() < 0 then continue end
                if !string.find(string.lower(v.name), string.lower(newval)) then
                    v:SetVisible(false)
                else
                    v:SetVisible(true)
                end

                net_logging:GetCanvas():InvalidateLayout(true)
            end
        end

        if eProtect.data.netLogging then
            for k,v in pairs(eProtect.data.netLogging) do
                if !v or !istable(v) then continue end
                local _, button = net_logging:addLine(k, v.called, v.len)
                button.DoClick = function()
                    if IsValid(button.Menu) then button.Menu:Remove() end

                    button.Menu = vgui.Create("SFrame")
                    button.Menu:SetSize(slib.getScaledSize(450, "x"),slib.getScaledSize(320, "y"))
                    :Center()
                    :MakePopup()
                    :addCloseButton()
                    :setTitle(slib.getLang("eprotect", eProtect.config["language"], "net-info")..k, slib.createFont("Roboto", 17))
                    :setBlur(true)

                    local player_details = vgui.Create("SListView", button.Menu.frame)
                    player_details:Dock(FILL)
                    :addColumns(slib.getLang("eprotect", eProtect.config["language"], "player"), slib.getLang("eprotect", eProtect.config["language"], "called"))
                    
                    for i, z in pairs(v.playercalls) do
                        local sid64 = util.SteamIDTo64(i)
                        local _, line = player_details:addLine(function() return sid64format(sid64) end, z)

                        line.DoClick = function()
                            gui.OpenURL("http://steamcommunity.com/profiles/"..sid64)
                        end
                    end
                end
            end
        end
    end

    -- Http logger tab
    if !eProtect.config["disablehttplogging"] and ((!VC and !XEON and !mLib) or eProtect.config["ignoreDRM"]) then
        local search_http = vgui.Create("SSearchBar", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-httplogger")])
        search_http:DockMargin(0,0,0,2)
        :addIcon()

        search_http.bg = maincolor_10

        local http_logging = vgui.Create("SListView", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-httplogger")])
        http_logging:Dock(FILL)
        :addColumns(slib.getLang("eprotect", eProtect.config["language"], "url"), slib.getLang("eprotect", eProtect.config["language"], "called"), slib.getLang("eprotect", eProtect.config["language"], "type"))

        http_logging.Columns[1].maxTxtLen = 64

        search_http.entry.onValueChange = function(newval)
            requestLogData(0, 1, newval)
        end

        local http_paginator = createPaginator(eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-httplogger")])
        http_paginator.onPageChanged = function(page)
            local val = search_http.entry:GetValue()

            requestLogData(0, page, val == search_http.entry.placeholder and "" or val)
        end

        http_logging.paginator = http_paginator

        http_logging.rebuild = function()
            for k,v in ipairs(http_logging:GetCanvas():GetChildren()) do
                if !v.isLine then continue end
                v:Remove()
            end

            local tbl_http = eProtect.data["requestedHTTP"] and eProtect.data["requestedHTTP"].result or {}
            
            http_paginator.page, http_paginator.maxpage = eProtect.data["requestedHTTP"].page, eProtect.data["requestedHTTP"].pageCount

            for k,v in ipairs(tbl_http) do
                local _, line = http_logging:addLine(v.link, v.called, v.type)
                line.isLine = true

                line.DoClick = function()
                    SetClipboardText(v.link)
                    slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "copied_clipboard"))
                end
            end

            http_logging:GetCanvas():SetTall(http_logging:GetTall())
        end

        eprotect_menu.http_logger = http_logging

        requestLogData(0, 1, "")
    end
    
    -- Exploit patcher tab
    if !eProtect.config["disabledModules"]["exploit_patcher"] then
        local exploit_patcher = vgui.Create("SListView", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-exploitpatcher")])
        exploit_patcher:Dock(FILL)
        :addColumns(slib.getLang("eprotect", eProtect.config["language"], "net-string"), slib.getLang("eprotect", eProtect.config["language"], "secure"))

        if eProtect.data.exploitPatcher then
            for k,v in pairs(eProtect.data.exploitPatcher) do
                exploit_patcher:addLine(k, v)
            end
        end
    end

    -- Exploit finder tab
    if !eProtect.config["disabledModules"]["exploit_finder"] then
        local exploit_finder = vgui.Create("SListView", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-exploitfinder")])
        exploit_finder:Dock(FILL)
        :addColumns(slib.getLang("eprotect", eProtect.config["language"], "net-string"), slib.getLang("eprotect", eProtect.config["language"], "type"), slib.getLang("eprotect", eProtect.config["language"], "status"))

        if eProtect.data.badNets then
            for k,v in pairs(eProtect.data.badNets) do
                local validateNet = tobool(util.NetworkStringToID(k))

                if !validateNet or (validateNet and eProtect.data and eProtect.data.fakeNets[k] and eProtect.data.fakeNets[k].enabled) then continue end

                local fixed = slib.getLang("eprotect", eProtect.config["language"], "unknown")

                if eProtect.data and eProtect.data.exploitPatcher and eProtect.data.exploitPatcher[k] then
                    fixed = slib.getLang("eprotect", eProtect.config["language"], "secured")
                end

                exploit_finder:addLine(k, v.type, fixed)
            end
        end
    end

    -- Fake exploits tab
    if !eProtect.config["disabledModules"]["fake_exploits"] then
        local fake_nets = vgui.Create("SListView", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-fakeexploits")])
        fake_nets:Dock(FILL)
        :addColumns(slib.getLang("eprotect", eProtect.config["language"], "net-string"), slib.getLang("eprotect", eProtect.config["language"], "type"), slib.getLang("eprotect", eProtect.config["language"], "activated"))

        if eProtect.data.fakeNets then
            for k,v in pairs(eProtect.data.fakeNets) do
                fake_nets:addLine(k, v.type, v.enabled)
            end
        end
    end


    -- Data snooper tab
    if !eProtect.config["disabledModules"]["data_snooper"] then
        local search_ds = vgui.Create("SSearchBar", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-datasnooper")])
        search_ds:DockMargin(0,0,0,0)
        :addIcon()

        search_ds.bg = maincolor_10

        local data_snooper = vgui.Create("SScrollPanel", eprotect_menu.tab[slib.getLang("eprotect", eProtect.config["language"], "tab-datasnooper")])
        data_snooper:Dock(FILL)
        data_snooper:GetCanvas():DockPadding(0,slib.getTheme("margin"),0,slib.getTheme("margin"))

        search_ds.entry.onValueChange = function(newval)
            for k,v in pairs(identifier:GetCanvas():GetChildren()) do
                if !string.find(string.lower(v.name), string.lower(newval)) then
                    v:SetVisible(false)
                else
                    v:SetVisible(true)
                end

                identifier:GetCanvas():InvalidateLayout(true)
            end
        end

        for k,v in pairs(player.GetAll()) do
            if v:IsBot() then continue end
            local ply = vgui.Create("SPlayerPanel", data_snooper)
            ply:setPlayer(v)
            :addButton(slib.getLang("eprotect", eProtect.config["language"], "fetch-data"), function()
                if !v or !IsValid(v) then return end
                
                net.Start("eP:Handeler")
                net.WriteBit(1)
                net.WriteUInt(2, 2)
                net.WriteUInt(2, 3)
                net.WriteUInt(v:EntIndex(), 14)
                net.WriteUInt(3, 2)
                net.SendToServer()
            end)
        end
    end
end

concommand.Add("eprotect_menu", function() RunConsoleCommand("say", "!eprotect") end)

net.Receive("eP:Handeler", function()
    local action = net.ReadUInt(3)
    if action == 1 then
        local chunk = net.ReadUInt(32)
        local json = util.Decompress(net.ReadData(chunk))
        if !json then return end
        local data = util.JSONToTable(json)
        local specific = net.ReadString()

        if !specific then
            eProtect.data = convertedTbl(data)
        else
            eProtect.data[specific] = convertedTbl(data)
        end
    elseif action == 2 then
        openMenu()
    elseif action == 3 then
        local subaction = net.ReadUInt(2)
        local target = net.ReadUInt(14)
        target = Entity(target)
        local open = net.ReadBool()
        local data

        if open then
            if subaction == 3 then
                local chunk = net.ReadUInt(32)
                data = net.ReadData(chunk)
                data = util.Decompress(data)
            else
                data = net.ReadString()
            end
        end

        if data == "Failed" or data == "" then slib.notify(eProtect.config["prefix"]..slib.getLang("eprotect", eProtect.config["language"], "ply-failed-retrieving-data", target:Nick())) return end

        if subaction == 1 then
            if open then
                openScreenshot(target, data)
            else
                eProtect.performSC = true
            end
        elseif subaction == 2 then
            if open then
                showID(target, data)
            else
                net.Start("eP:Handeler")
                net.WriteBit(0)
                net.WriteUInt(1, 2)
                net.WriteUInt(2, 2)
                net.WriteString(file.Read("eid.txt", "DATA") or "")
                net.SendToServer()
            end
        elseif subaction == 3 then
            if open then                
                data = util.JSONToTable(data)
                
                local display_data = vgui.Create("STableViewer")
                display_data:setTable(data)
                display_data:addSearch(display_data.viewbox, display_data.viewer)
                display_data.viewOnly = true
            else
                local requestedData = {}

                fillCleanData("*", requestedData)

                requestedData = util.TableToJSON(requestedData)
                requestedData = util.Compress(requestedData)

                if string.len(requestedData) >= 65533 then requestedData = util.Compress("Failed") end

                local chunk = #requestedData

                net.Start("eP:Handeler")
                net.WriteBit(0)
                net.WriteUInt(1, 2)
                net.WriteUInt(3, 2)
                net.WriteUInt(chunk, 32)
                net.WriteData(requestedData, chunk)
                net.SendToServer()
            end
        end
    elseif action == 4 then
        local target = net.ReadUInt(14)
        local ids = net.ReadString()
        local bit = net.ReadBit()

        if tobool(bit) then
            showCorrelation(Entity(target), ids)
        else
            showIPs(Entity(target), ids)
        end
    elseif action == 5 then
        local id = net.ReadUInt(1)
        local chunk = net.ReadUInt(32)
        local data = net.ReadData(chunk)

        data = util.Decompress(data)

        if !data then return end

        data = util.JSONToTable(data)

        if id == 0 then
            eProtect.data["requestedHTTP"] = data

            if IsValid(eprotect_menu) and IsValid(eprotect_menu.http_logger) then
                eprotect_menu.http_logger.rebuild()
            end
        elseif id == 1 then
            eProtect.data["requestedDetections"] = data

            if IsValid(eprotect_menu) and IsValid(eprotect_menu.punishment_log) then
                eprotect_menu.punishment_log.rebuild()
            end
        end
    end
end)