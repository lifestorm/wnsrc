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
local date = VyHub.Lib.date

VyHub.Util = VyHub.Util or {}
VyHub.Util.chat_commands = VyHub.Util.chat_commands or {}

if SERVER then
	util.AddNetworkString("vyhub_print_chat")
	util.AddNetworkString("vyhub_play_sound")
	util.AddNetworkString("vyhub_open_url")
end

function VyHub.Util:format_datetime(unix_timestamp)
    unix_timestamp = unix_timestamp or os.time()

    local tz_wrong = os.date("%z", unix_timestamp)
    local timezone = f("%s:%s", string.sub(tz_wrong, 1, 3), string.sub(tz_wrong, 4, 5))

    return os.date("%Y-%m-%dT%H:%M:%S" .. timezone, unix_timestamp)
end

function VyHub.Util:is_server(obj)
	if type(obj) == "Entity" and (obj.EntIndex and obj:EntIndex() == 0) and !IsValid(obj) then
		return true
	else
		return false
	end
end

function VyHub.Util:iso_to_unix_timestamp(datetime)
	if datetime == nil then return nil end

	local pd = date(datetime)

	if pd == nil then return nil end

	local time = os.time(
		{
			year = pd:getyear(),
			month = pd:getmonth(),
			day = pd:getday(),
			hour = pd:gethours(),
			minute = pd:getminutes(),
			second = pd:getseconds(),
		}
	)

	return time
end

function VyHub.Util:get_ply_by_nick(nick)
	nick = string.lower(nick);
	
	for _, v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()), nick, 1, true) != nil)
			then return v;
		end
	end
end

function VyHub.Util:register_chat_command(strCommand, Func)
	if !strCommand || !Func then return end
	
	for k, v in pairs( VyHub.Util.chat_commands ) do
		if( strCommand == k ) then
			return
		end
	end
	
	VyHub.Util.chat_commands[ tostring( strCommand ) ] = Func;
end

function VyHub.Util:concat_args(args, pos)
	local toconcat = {}

	if pos > 1 then
		for i = pos, #args, 1 do
			toconcat[#toconcat+1] = args[i]
		end
	end

	return string.Implode(" ", toconcat)
end


if SERVER then
	hook.Add("PlayerSay", "vyhub_util_PlayerSay", function(ply, message)
		if VyHub.ready then
			local chat_string = string.Explode(" ", message)
			local ret = nil
		
			for k, v in pairs( VyHub.Util.chat_commands ) do
				if( string.lower(chat_string[1]) == string.lower(k) ) then
					table.remove(chat_string, 1)
					ret = v(ply, chat_string)
					break
				end
			end
		
			if ret != nil then
				return ret
			end
		end	
	end)
end

local colors = {
	red = Color(255, 24, 35),
	green = Color(45, 170, 0),
	blue = Color(0, 115, 204),
	yellow = Color(229, 221, 0),
	pink = Color(229, 0, 218),
}

-- Takes a str message with colors and returns a table
function VyHub.Util:replace_colors(message, no_color)
    local resultTable = {}
    local currentIndex = 1

    local function getColor(colorName)
        if colors[colorName] then
            return colors[colorName]
        else
            return no_color
        end
    end

    local function addStringToTable(str, color)
        table.insert(resultTable, color)
        table.insert(resultTable, str)
    end

    local tags = {}

    -- Extract all color tags and their corresponding content
    for tag, content in string.gmatch(message, "<([%l]+)>([^<]+)</%1>") do
        table.insert(tags, {tag = tag, content = content})
    end

    -- Process the string, splitting it based on the color tags
    for _, tagData in ipairs(tags) do
        local startIndex, endIndex = string.find(message, f("<(%s)>[^<]+</%s>", string.PatternSafe(tagData.tag), string.PatternSafe(tagData.tag)), currentIndex, false)

        if startIndex then
            local str = string.sub(message, currentIndex, startIndex - 1)

            addStringToTable(str, no_color)
            addStringToTable(tagData.content, getColor(tagData.tag))

            currentIndex = endIndex + 1
        end
    end

    -- Append any remaining part of the string
    local str = string.sub(message, currentIndex)
    if str != "" then
        addStringToTable(str, no_color)
    end

    return resultTable
end

local color_tag = Color(0, 187, 255)

function VyHub.Util:print_chat(ply, message, tag, color)
	color = color or color_white
	
	if SERVER then
		if IsValid(ply) then
			if not VyHub.Config.chat_tag then
				VyHub.Config.chat_tag = "[VyHub] "
			end

			if not tag then
				tag = VyHub.Config.chat_tag
			end

			message = string.Replace(message, '\r', '')
			message = string.Replace(message, '\n', '')

			net.Start("vyhub_print_chat")
				net.WriteString(message)
				net.WriteString(tag)
				net.WriteColor(color)
			net.Send(ply)
		end
	elseif CLIENT then
		msg_table = VyHub.Util:replace_colors(message, color)

		chat.AddText(color_tag, tag, color_white, unpack(msg_table))
	end
end

function VyHub.Util:print_chat_steamid(steamid, message, tag, color)
	if steamid != nil and steamid != false then
		local ply = player.GetBySteamID64(steamid)
	
		if IsValid(ply) then
			VyHub.Util:print_chat(ply, message, tag, color)
		end
	end
end

function VyHub.Util:play_sound_steamid(steamid, url)
	if steamid then
		local ply = player.GetBySteamID64(steamid)
	
		if IsValid(ply) then
			return VyHub.Util:play_sound(ply, url)
		end
	end
end

function VyHub.Util:play_sound(ply, url)
	if SERVER then
		if IsValid(ply) then
			net.Start("vyhub_play_sound")
				net.WriteString(url)
			net.Send(ply)
		end
	elseif CLIENT then
		sound.PlayURL ( url, "", function() end)
	end
end

function VyHub.Util:open_url(ply, url)
	if SERVER then
		if IsValid(ply) then
			net.Start("vyhub_open_url")
				net.WriteString(url)
			net.Send(ply)
		end
	elseif CLIENT then
		gui.OpenURL(url)
	end
end

function VyHub.Util:print_chat_all(message, tag, color)
	for _, ply in ipairs(player.GetHumans()) do
		VyHub.Util:print_chat(ply, message, tag, color)
	end
end


function VyHub.Util:get_player_by_nick(nick)
	nick = string.lower(nick);
	
	for _,v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()), nick, 1, true) != nil)
			then return v;
		end
	end
end


function VyHub.Util:hex2rgb(hex)
    hex = hex:gsub("#","")
    if(string.len(hex) == 3) then
        return Color(tonumber("0x"..hex:sub(1,1)) * 17, tonumber("0x"..hex:sub(2,2)) * 17, tonumber("0x"..hex:sub(3,3)) * 17)
    elseif(string.len(hex) == 6) then
        return Color(tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)))
    else
    	return color_white
    end
end

function VyHub.Util:iso_ts_to_local_str(iso_ts)
	local bias = VyHub.Config.time_offset != nil and -math.Round(VyHub.Config.time_offset * 60 * 60) or nil

	return date(iso_ts):setbias(bias):tolocal():fmt(VyHub.Config.date_format)
end


function VyHub.Util:invalid_str(str_list)
	for _, str in ipairs(str_list) do
		if str == nil or string.Trim(str) == "" then
			return true
		end
	end

	return false
end

function VyHub.Util:escape_concommand_str(str)
	str = string.Replace(str, '"', "'")

	return str
end



if CLIENT then
	net.Receive("vyhub_print_chat", function ()
		local message = net.ReadString()
		local tag = net.ReadString()
		local color = net.ReadColor()

		VyHub.Util:print_chat(nil, message, tag, color)
	end)

	net.Receive("vyhub_play_sound", function ()
		local url = net.ReadString()

		VyHub.Util:play_sound(nil, url)
	end)

	net.Receive("vyhub_open_url", function ()
		local url = net.ReadString()

		VyHub.Util:open_url(nil, url)
	end)
end
