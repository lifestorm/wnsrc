--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLAYER = FindMetaTable( "Player" )
if not PLAYER then return end

function PLAYER:GetChessElo()
	return self:GetNWInt( "ChessElo", 1400 ) or 1400
end
function PLAYER:GetDraughtsElo()
	return self:GetNWInt( "DraughtsElo", 1400 ) or 1400
end
if CLIENT then return end
function PLAYER:SetChessElo( num )
	self:SetNWInt( "ChessElo", num or Chess_GetElo(ply:SteamID()) or 1400 )
	Chess_SetElo( self:SteamID(), num, false )
end
function PLAYER:SetDraughtsElo( num )
	self:SetNWInt( "DraughtsElo", num or Chess_GetElo(ply:SteamID(), true) or 1400 )
	Chess_SetElo( self:SteamID(), num, true )
end

function PLAYER:RefreshChessElo()
	-- Convert old PData stuff
	if self:GetPData("ChessElo") then
		Chess_SetElo( self:SteamID(), self:GetPData("ChessElo"), false )
		self:RemovePData("ChessElo")
	end
	if self:GetPData("DraughtsElo") then
		Chess_SetElo( self:SteamID(), self:GetPData("DraughtsElo"), true )
		self:RemovePData("DraughtsElo")
	end
	
	self:SetChessElo( Chess_GetElo(self:SteamID()) or 1400)
	self:SetDraughtsElo( Chess_GetElo(self:SteamID(), true) or 1400)
end
hook.Add( "PlayerInitialSpawn", "Chess InitialSpawn InitElo", function(ply)
	ply:RefreshChessElo()
end)

function PLAYER:ExpectedChessWin( against )
	return (1/ (1+( 10^( (against:GetChessElo() - self:GetChessElo())/400 ) )) )
end
function PLAYER:ExpectedDraughtsWin( against )
	return (1/ (1+( 10^( (against:GetDraughtsElo() - self:GetDraughtsElo())/400 ) )) )
end

function PLAYER:GetChessKFactor() --Imitating FIDE's K-factor ranges
	local games = tonumber(self:GetPData( "ChessGamesPlayed", 0 )) or 0
	if games<30 then
		self:SetPData( "ChessEloKFactor", 15 )
		return 30
	end
	local k = self:GetChessElo()>=2400 and 10 or self:GetPData( "ChessEloKFactor", 15 ) or 15
	self:SetPData( "ChessEloKFactor", k )
	return k
end
function PLAYER:GetDraughtsKFactor() --Imitating FIDE's K-factor ranges
	local games = self:GetPData( "DraughtsGamesPlayed", 0 )
	if games<30 then
		self:SetPData( "DraughtsEloKFactor", 15 )
		return 30
	end
	local k = self:GetDraughtsElo()>=2400 and 10 or self:GetPData( "DraughtsEloKFactor", 15 ) or 15
	self:SetPData( "DraughtsEloKFactor", k )
	return k
end

function PLAYER:DoChessElo( score, against )
	local mod = math.ceil(self:GetChessKFactor() * (score - self:ExpectedChessWin(against)))
	local NewElo = math.floor( self:GetChessElo() + mod )
	
	self:SetChessElo( NewElo )
	
	if IsValid(against) then
		mod = mod*(-1)
		local NewElo = math.floor( against:GetChessElo() + mod )
		
		against:SetChessElo( NewElo )
		local rank,count = Chess_GetRank(against)
		against:ChatPrint( "Your chess Elo rating changed by "..tostring(mod).." to "..tostring(NewElo).."!" ..(rank and " You are #"..tostring(rank).." on this server." or "")  )
	end
	local rank,count = Chess_GetRank(self)
	self:ChatPrint( "Your chess Elo rating changed by "..tostring(mod).." to "..tostring(NewElo).."!" ..(rank and " You are #"..tostring(rank).." on this server." or "") )
	
	Chess_UpdateElo( self )
end
function PLAYER:ChessWin( against )
	if not IsValid(against) then return end
	
	self:DoChessElo(1, against)
end
function PLAYER:ChessDraw( against ) self:DoChessElo(0.5, against) end

function PLAYER:DoDraughtsElo( score, against )
	local mod = math.ceil(self:GetDraughtsKFactor() * (score - self:ExpectedDraughtsWin(against)))
	local NewElo = math.floor( self:GetDraughtsElo() + mod )
	
	self:SetDraughtsElo( NewElo )
	
	if IsValid(against) then
		mod = mod*(-1)
		local NewElo = math.floor( against:GetDraughtsElo() + mod )
		
		against:SetDraughtsElo( NewElo )
		local rank = Chess_GetRank(self, "Draughts")
		against:ChatPrint( "Your draughts Elo rating changed by "..tostring(mod).." to "..tostring(NewElo).."!" ..(rank and " You are #"..tostring(rank).." on this server." or "") )
	end
	local rank = Chess_GetRank(self, "Draughts")
	self:ChatPrint( "Your draughts Elo rating changed by "..tostring(mod).." to "..tostring(NewElo).."!" ..(rank and " You are #"..tostring(rank).." on this server." or "") )
	
	Chess_UpdateElo( self )
end
function PLAYER:DraughtsWin( against ) self:DoDraughtsElo(1, against) end
function PLAYER:DraughtsDraw( against ) self:DoDraughtsElo(0.5, against) end
