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

VyHub.Group = VyHub.Group or {}

VyHub.groups = VyHub.groups or nil
VyHub.groups_mapped = VyHub.groups_mapped or nil
VyHub.Group.group_changes = VyHub.Group.group_changes or {} -- dict(steamid64, groupname) of the last in-game group change (VyHub -> GMOD). Used to prevent loop.

util.AddNetworkString("vyhub_group_data")

local meta_ply = FindMetaTable("Player")

function VyHub.Group:refresh()
    VyHub.API:get("/group/", nil, nil, function(code, result)
        if result != VyHub.groups then
            VyHub.groups = result
        
            VyHub:msg(f("Found groups: %s", json.encode(result)), "debug")

            VyHub.groups_mapped = {}

            for _, group in ipairs(VyHub.groups) do
                for _, mapping in ipairs(group.mappings) do
                    if mapping.serverbundle_id == nil or mapping.serverbundle_id == VyHub.server.serverbundle.id then
                        VyHub.groups_mapped[mapping.name] = group
                        break
                    end
                end
            end

            VyHub.Group:send_groups()
        end
    end, function (code, reason)
        VyHub:msg("Could not refresh groups.", "error")
    end)
end

function VyHub.Group:send_groups(ply)
    if not VyHub.groups_mapped then return end

    local groups_to_send = VyHub.groups_mapped

    net.Start("vyhub_group_data")
    net.WriteUInt(table.Count(groups_to_send), 8)

    for name_game, group in pairs(groups_to_send) do
        net.WriteString(name_game)
        net.WriteString(group.name)
        net.WriteString(group.color)
    end

    if ply != nil and IsValid(ply) then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

function VyHub.Group:set(steamid, groupname, seconds, processor_id, callback)
    if seconds != nil and seconds == 0 then
        seconds = nil
    end

    if VyHub.groups_mapped == nil then
        VyHub:msg("Groups not initialized yet. Please try again later.", "error")
        if callback then
            callback(!VyHub.Config.strict_group_sync)
        end
        
        return
    end

    local group = VyHub.groups_mapped[groupname]

    if group == nil then
        VyHub:msg(f("Could not find VyHub group with name %s", groupname), "debug")

        if callback then
            callback(!VyHub.Config.strict_group_sync)
        end
        return 
    end

    VyHub.Player:get(steamid, function (user)
        if user == nil then
            if callback then
                callback(false)
                return
            end
        end

        local end_date = nil 

        if seconds != nil then
            end_date = VyHub.Util:format_datetime(os.time() + seconds)
        end

        local url = '/user/%s/membership'

        if processor_id != nil then
            url = url .. '?morph_user_id=' .. processor_id
        end

        local ply = player.GetBySteamID64(steamid)

        VyHub.API:post(url, {user.id}, {
            begin = VyHub.Util.format_datetime(),
            ["end"] = end_date,
            group_id = group.id,
            serverbundle_id = VyHub.server.serverbundle.id
        }, function (code, result)
            VyHub:msg(f("Added membership in group %s for user %s.", groupname, steamid), "success")

            if IsValid(ply) then
                timer.Simple(5, function()
                    VyHub.Player:refresh(ply)
                end)
            end 

            if callback then
                callback(true)
            end
        end, function (code, reason)
            VyHub:msg(f("Could not add membership in group %s for user %s.", groupname, steamid), "error")
            if callback then
                callback(false)
            end

            if IsValid(ply) then
                timer.Simple(2, function()
                    VyHub.Player:refresh(ply)
                end)
            end 
        end)
    end)
end

function VyHub.Group:remove(steamid, processor_id, callback)
    VyHub.Player:get(steamid, function (user)
        if user == nil then
            if callback then
                callback(false)
                return
            end
        end

        local url = f('/user/%%s/membership?serverbundle_id=%s', VyHub.server.serverbundle.id)

        if processor_id != nil then
            url = url .. '&morph_user_id=' .. processor_id
        end

        VyHub.API:delete(url, {user.id}, function (code, result)
            VyHub:msg(f("Removed %s from all groups.", steamid), "success")

            local ply = player.GetBySteamID64(steamid)

            if IsValid(ply) then
                VyHub.Player:refresh(ply)
            end

            if callback then
                callback(true)
            end
        end, function (code, reason)
            VyHub:msg(f("Could not remove %s from all groups.", steamid), "error")

            if callback then
                callback(false)
            end
        end)
    end)
end

function VyHub.Group:override_admin_mods()
    if VyHub.Config.group_disable_sync then return end

    local _setusergroup = meta_ply.SetUserGroup

    if not ULib and not serverguard and not sam and not (xAdmin and xAdmin.Admin.RegisterBan) and not sAdmin then
        hook.Remove("PlayerInitialSpawn", "PlayerAuthSpawn")

        meta_ply.SetUserGroup = function(ply, name, ignore_vh)
            if ply:GetUserGroup() == name then
                VyHub:msg(ply:SteamID64() .. " already in group " .. name .. ". Ignoring change...")
                return 
            end

            local steamid = ply:SteamID64()

            if not ignore_vh and VyHub.Group.group_changes[steamid] != name then
                if VyHub.Group:set(steamid, name) or VyHub.Config.disable_group_check then
                    _setusergroup(ply, name)
                end
            else
                _setusergroup(ply, name)
            end
        end
    end

    if xAdmin and xAdmin.Admin.RegisterBan then
        local xadmin_setgroup = xAdmin.SetGroup

        xAdmin.SetGroup = function(ply, group, ignore_vh)
            local steamid32 = isstring(ply) and ply or ply:SteamID()
            local steamid64 = util.SteamIDTo64(steamid32)

            if not ignore_vh then
                VyHub.Group:set(steamid64, group, nil, nil, function(success)
                    if success then
                        xadmin_setgroup( ply, group )
                    end
                end)
            else
                xadmin_setgroup( ply, group )
            end
        end
    end

    if ULib then
        local ulx_adduser = ULib.ucl.addUser
        local ulx_removeuser = ULib.ucl.removeUser

        ULib.ucl.addUser = function(steamid32, allow, deny, groupname, ignore_vh)
            if not ignore_vh then
                local steamid64 = util.SteamIDTo64(steamid32)
                VyHub.Group:set(steamid64, groupname, nil, nil, function(success)
                    if success then
                        ulx_adduser( steamid32, allow, deny, groupname )
                    end
                end)
            else
                ulx_adduser( steamid32, allow, deny, groupname )
            end
        end

        ULib.ucl.removeUser = function(id)
            local steamid64 = nil

            if string.find(id, ":") then
                steamid64 = util.SteamIDTo64(id)
            else
                local ply = player.GetByUniqueID(id)

                if IsValid(ply) then
                    steamid64 = ply:SteamID64()
                end
            end

            if steamid64 then
                VyHub.Group:remove(steamid64, nil, function (success)
                    if success then
                        ulx_removeuser( id )
                    end
                end)
            end
        end
    end
    
    if serverguard then
        local servergaurd_setrank = serverguard.player["SetRank"]

        function serverguard.player:SetRank(target, rank, length, ignore_vh)
            if not ignore_vh then
                if target then
                    if type(target) == "Player" and IsValid(target) then
                        VyHub.Group:set(target:SteamID64(), rank, nil, nil, function(success)
                            if success then
                                servergaurd_setrank(self, target, rank, length)
                            end
                        end)
                    elseif type(target) == "string" and string.match(target, "STEAM_%d:%d:%d+") then
                        local steamid = util.SteamIDTo64(target)

                        VyHub.Group:set(steamid, rank, nil, nil, function(success)
                            if success then
                                servergaurd_setrank(self, target, rank, length)
                            end
                        end)
                    end
                end
            else
                servergaurd_setrank(self, target, rank, length)
            end
        end
    end

    if sam then
        local sam_setrank = sam.player.set_rank

        function sam.player.set_rank(ply, rank, length, ignore_vh)
            if not ignore_vh then
                if not sam.isnumber(length) or length < 0 then
                    length = nil
                end

                local seconds = nil

                if length != nil then
                    seconds = math.Round(length * 60, 0)
                end

                VyHub.Group:set(ply:SteamID64(), rank, seconds, nil, function(success)
                    if success then
                        sam_setrank(ply, rank, length)
                    end
                end)
            else
                sam_setrank(ply, rank, length)
            end
        end
    end

    if sAdmin then
        local sadmin_setrank = sAdmin.setRank

        sAdmin.setRank = function(ply, rank, expire, noupdate, ignore_vh)
            rank = rank or "user"

            if not ignore_vh and not noupdate then
                local seconds = nil

                if isnumber(expire) and expire > 0 then
                    seconds = math.max(expire, 0)
                end

                VyHub.Group:set(ply:SteamID64(), rank, seconds, nil, function(success)
                    if success then
                        sadmin_setrank(ply, rank, nil, noupdate)
                    end
                end)
            else
                sadmin_setrank(ply, rank, expire, noupdate)
            end
        end
    end
end


hook.Add("vyhub_ready", "vyhub_group_vyhub_ready", function ()
    VyHub.Group:refresh()

    timer.Create("vyhub_group_refresh", VyHub.Config.group_refresh_time, 0, function ()
        VyHub.Group:refresh()
    end)

    hook.Add("vyhub_ply_connected", "vyhub_group_vyhub_ply_connected", function(ply)
        VyHub.Group:send_groups(ply)
	end)

	concommand.Add("vh_setgroup", function(ply, _, args)
		if VyHub.Util:is_server(ply) then
			local steamid = args[1]
			local group = args[2]
			local bundle = args[3]

			if steamid and group then
				VyHub.Group:set(steamid, group)
			end
		end
	end)

    VyHub.Group:override_admin_mods()
end)