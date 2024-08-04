--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


if SERVER then
	AddCSLuaFile()
	AddCSLuaFile( "chess/sh_player_ext.lua" )
	AddCSLuaFile( "chess/cl_top.lua" )
	AddCSLuaFile( "chess/cl_dermaboard.lua" )
	
	include( "chess/sh_player_ext.lua" )
	include( "chess/sv_sql.lua" )
else
	include( "chess/sh_player_ext.lua" )
	include( "chess/cl_top.lua" )
	include( "chess/cl_dermaboard.lua" )
end

if SERVER then
	function ChessBoard_DoOverrides()
		if GAMEMODE.Name=="Cinema" then --Cinema overrides
			hook.Add("CanPlayerEnterVehicle", "EnterSeat", function(ply, vehicle) --Overrides default func
				if vehicle:GetClass() != "prop_vehicle_prisoner_pod" then return end

				if vehicle.Removing then return false end
				return (vehicle:GetOwner() == ply) or vehicle:GetNWBool( "IsChessSeat", false )
			end)
		end
	end
	hook.Add( "Initialize", "ChessBoardOverrides", ChessBoard_DoOverrides )
	
	CreateConVar( "chess_wagers", 1, FCVAR_ARCHIVE, "Set whether players can wager on their chess games." )
	CreateConVar( "chess_darkrp_wager", 1, FCVAR_ARCHIVE, "[DarkRP only] Wagers should use DarkRP wallet." )
	
	CreateConVar( "chess_debug", 0, FCVAR_ARCHIVE, "Debug mode." )
	CreateConVar( "chess_limitmoves", 1, FCVAR_ARCHIVE, "Enable 50 move rule." )
else -- CLIENT
	CreateConVar( "chess_gridletters", 1, FCVAR_ARCHIVE, "Show grid letters." )
end

-- DarkRP --
------------
hook.Add("canArrest", "Chess PreventArrest", function( cop, target )
	if not (IsValid(target) and target:GetNWBool("IsInChess", false)) then return end
	
	local board = target:GetNWEntity( "ActiveChessBoard", nil )
	if not (IsValid(board) and board:GetPlaying()) then return end
	if target~=board:GetWhitePlayer() and target~=board:GetBlackPlayer() then return end
	
	return false,"Cannot arrest players during a game in progress" -- Prevent arrest during Chess
end)

-- Admin Commands --
--------------------
local function SetupCommands()
	if serverguard then
		/////////////////
		// Serverguard //
		/////////////////
		serverguard.permission:Add("Set Chess Elo")
		
		if SERVER then
			// Update function
			local function SGUpdate(player, target, newElo, isDraughts)
				if type(target)=="Player" and IsValid(target) then
					if isDraughts then
						target:SetDraughtsElo( newElo )
					else
						target:SetChessElo( newElo )
					end
					Chess_UpdateElo( target )
					
					serverguard.Notify(nil,
					  SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
					  SERVERGUARD.NOTIFY.WHITE, isDraughts and " has set the Checkers Elo rating of " or " has set the Chess Elo rating of ",
					  SERVERGUARD.NOTIFY.RED,   serverguard.player:GetName(target),
					  SERVERGUARD.NOTIFY.WHITE, " to ",
					  SERVERGUARD.NOTIFY.RED,   tostring(newElo),
					  SERVERGUARD.NOTIFY.WHITE, "."
					)
				elseif (string.SteamID(target)) then
					local success,reason = Chess_SetElo( target, newElo, isDraughts )
					
					local queryObj = serverguard.mysql:Select("serverguard_users");
					queryObj:Where("steam_id", target)
					queryObj:Limit(1)
					queryObj:Callback(function(result, status, lastID)
						local name = target
						if (type(result) == "table" and #result > 0) then
							name = result[1].name or name
						end
						
						if success then
							serverguard.Notify(nil,
							  SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), 
							  SERVERGUARD.NOTIFY.WHITE, isDraughts and " has set the Checkers Elo rating of " or " has set the Chess Elo rating of ",
							  SERVERGUARD.NOTIFY.RED,   name,
							  SERVERGUARD.NOTIFY.WHITE, " to ",
							  SERVERGUARD.NOTIFY.RED,   tostring(newElo),
							  SERVERGUARD.NOTIFY.WHITE, "."
							)
						else
							serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, ("Could not set elo. (%s)"):format(tostring(reason)) )
						end
					end)
					queryObj:Execute()
				else
					serverguard.Notify(player, SGPF("cant_find_player_with_identifier"))
				end
			end
			
			// Chess command
			local command = {}
			
			command.help        = "Set a player's Chess Elo rating."
			command.command     = "setelo"
			command.arguments   = {"player", "elo"}
			command.permissions = {"Set Chess Elo"}
			command.aliases     = {"setelochess", "chesselo", "setchess", "setchesselo"}
			
			function command:Execute(player, silent, arguments)
				local target = util.FindPlayer(arguments[1], player, true)
				local newElo = tonumber(arguments[2]) or 1400
				
				SGUpdate( player, IsValid(target) and target or arguments[1], newElo, false )
			end
			serverguard.command:Add(command)
			
			// Draughts command
			local command = {}
			
			command.help        = "Set a player's Checkers Elo rating."
			command.command     = "setelocheckers"
			command.arguments   = {"player", "elo"}
			command.permissions = {"Set Chess Elo"}
			command.aliases     = {"setcheckers", "setcheckerselo", "checkerselo", "setelodraughts", "setdraughts", "setdraughtselo", "draughtselo"}
			
			function command:Execute(player, silent, arguments)
				local target = util.FindPlayer(arguments[1], player, true)
				local newElo = tonumber(arguments[2]) or 1400
				
				SGUpdate( player, IsValid(target) and target or arguments[1], newElo, true )
			end
			
			serverguard.command:Add(command)
		end
	end
	if ulx then
		/////////
		// ULX //
		/////////
		
		// Update
		local function ULXUpdate(calling_ply, target, newElo, isDraughts)
			if CLIENT then return end
			
			if type(target)=="Player" and IsValid(target) then
				if isDraughts then
					target:SetDraughtsElo( newElo )
				else
					target:SetChessElo( newElo )
				end
				Chess_UpdateElo( target )
				
				ulx.fancyLogAdmin( calling_ply, "#A set the #s Elo rating of #T to #i.", isDraughts and "Checkers" or "Chess", target, newElo )
			elseif (string.SteamID(target or "")) then
				local success,reason = Chess_SetElo( target, newElo, isDraughts )
				
				if success then
					ulx.fancyLogAdmin( calling_ply, "#A set the #s Elo rating of #s to #i.", isDraughts and "Checkers" or "Chess", target, newElo )
				else
					ULib.tsayError( calling_ply, ("Could not set elo. (%s)"):format(tostring(reason)) )
				end
			else
				ULib.tsayError( calling_ply, "Invalid SteamID or Player." )
			end
		end
		
		// Autocomplete
		local function AutoComplete(...) return ULib.cmds.PlayerArg.complete(ULib.cmds.PlayerArg, ...) end
		
		// Chess command
		local function SetChessElo( calling_ply, steamid, newElo )
			local target = ULib.getUser( steamid or "", true, calling_ply )
			
			ULXUpdate( calling_ply, IsValid(target) and target or steamid, newElo, false )
		end
		local setchess = ulx.command( "Chess", "ulx chesselo", SetChessElo, {"!setelo", "!setelochess", "!chesselo", "!setchess", "!setchesselo"}, false, false, true )
		setchess:addParam{ type=ULib.cmds.StringArg, hint="Player or SteamID", autocomplete_fn=AutoComplete }
		setchess:addParam{ type=ULib.cmds.NumArg, hint="New Elo", min=0, default=1400 }
		setchess:defaultAccess( ULib.ACCESS_SUPERADMIN )
		setchess:help( "Set Chess Elo rating for user." )
		
		// Draughts command
		local function SetDraughtsElo( calling_ply, steamid, newElo )
			local target = ULib.getUser( steamid, true, calling_ply )
			
			ULXUpdate( calling_ply, IsValid(target) and target or steamID, newElo, true )
		end
		local setdraughts = ulx.command( "Chess", "ulx checkerselo", SetDraughtsElo, {"!setelocheckers", "!setcheckers", "!setcheckerselo", "!checkerselo", "!setelodraughts", "!setdraughts", "!setdraughtselo", "!draughtselo"}, false, false, true )
		setdraughts:addParam{ type=ULib.cmds.StringArg, hint="Player or SteamID", autocomplete_fn=AutoComplete }
		setdraughts:addParam{ type=ULib.cmds.NumArg, hint="New Elo", min=0, default=1400 }
		setdraughts:defaultAccess( ULib.ACCESS_SUPERADMIN )
		setdraughts:help( "Set Checkers Elo rating for user." )
	end
end
hook.Add( "Initialize", "ChessBoardPermissions", SetupCommands )
