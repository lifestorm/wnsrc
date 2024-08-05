--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local Top10
local function ChessTop10( typ )
	if IsValid(Top10) then Top10:Remove() end
	
	typ = typ or "Chess"
	
	Top10 = vgui.Create( "DFrame" )
	Top10:SetSize( 450, 245 )
	Top10:SetPos( (ScrW()/2)-150, (ScrH()/2)-100 )
	Top10:SetTitle( "Top 10 Chess Elo ratings" )
	Top10:MakePopup()
	Top10.Column = "Elo"
	
	local pnl = vgui.Create("DPanel", Top10)
	pnl.Paint = function() end
	pnl:SetTall(20)
	pnl:Dock(BOTTOM)
	
	Top10.Rank = vgui.Create( "DLabel", pnl )
	Top10.Rank:Dock( LEFT )
	Top10.Rank:SetTall( 20 )
	Top10.Rank:SetWide( 150 )
	Top10.Rank:SetText("")
	
	Top10.Updated = vgui.Create( "DLabel", pnl )
	Top10.Updated:Dock( RIGHT )
	Top10.Updated:SetTall( 150 )
	Top10.Updated:SetText("")
	
	Top10.List = vgui.Create( "DListView", Top10 )
	local List = Top10.List
	List:Dock( FILL )
	List:AddColumn( "Rank" )
	List:AddColumn( "Name" )
	List:AddColumn( "SteamID" )
	List:AddColumn( "Elo" )
	
	List:AddLine( "", "Loading..." )
	-- PrintTable( List.Columns )
	List:OnRequestResize( List.Columns[1], 10 )
	List:OnRequestResize( List.Columns[2], 150 )
	List:OnRequestResize( List.Columns[3], 100 )
	List:OnRequestResize( List.Columns[4], 10 )
	
	net.Start( "Chess Top10" ) net.WriteString( typ ) net.SendToServer()
end
local function DraughtsTop10()
	ChessTop10( "Draughts" )
end
concommand.Add( "chess_top", function( p,c,a ) ChessTop10() end)
concommand.Add( "checkers_top", function( p,c,a ) DraughtsTop10() end)

local ChatCommands = {
	["!chess"]=ChessTop10,	["!chesstop"]=ChessTop10,	["!topchess"]=ChessTop10,
	["/chess"]=ChessTop10,	["/chesstop"]=ChessTop10,	["/topchess"]=ChessTop10,
	
	["!draughts"]=DraughtsTop10,	["!draughtstop"]=DraughtsTop10,	["!topdraughts"]=DraughtsTop10,
	["/draughts"]=DraughtsTop10,	["/draughtstop"]=DraughtsTop10,	["/topdraughts"]=DraughtsTop10,
	
	["!checkers"]=DraughtsTop10,	["!checkerstop"]=DraughtsTop10,	["!topcheckers"]=DraughtsTop10,
	["/checkers"]=DraughtsTop10,	["/checkerstop"]=DraughtsTop10,	["/topcheckers"]=DraughtsTop10,
}
hook.Add( "OnPlayerChat", "Chess Top10 PlayerChat", function( ply, str, tm, dead )
	if ChatCommands[str:lower()] then
		if ply==LocalPlayer() then
			ChatCommands[str:lower()]()
		end
		return true
	end
end)

local function SecondsToTime(num)
	if updateTime>=86400 then
		return ("%i day%s"):format( math.floor(updateTime/86400), updateTime>=172800 and "s" or "")
	elseif updateTime>=3600 then
		return ("%i hour%s"):format( math.floor(updateTime/3600), updateTime>=7200 and "s" or "")
	elseif updateTime>=60 then
		return ("%i minute%s"):format( math.floor(updateTime/60), updateTime>=120 and "s" or "")
	else
		return ("%i second%s"):format(updateTime, updateTime>=2 and "s" or "")
	end
end

local lastTable = {}
local lastRank = {}
local lastUpdate = {}
net.Receive( "Chess Top10", function()
	if not (IsValid(Top10) and IsValid(Top10.List)) then return end
	
	Top10.List:Clear()
	
	local typ = net.ReadString() or "[Error]"
	
	Top10:SetTitle( "Top 10 "..typ.." Elo ratings" )
	
	local tbl = net.ReadTable()
	if (not tbl) or (#tbl==0) then -- Rate limit exceeded
		if lastTable[typ] then
			for i=1,#lastTable[typ] do
				Top10.List:AddLine( tonumber(lastTable[typ][i].Rank), lastTable[typ][i].Username, lastTable[typ][i].SteamID, tonumber(lastTable[typ][i]["Elo" ]) )
			end
			Top10.Rank:SetText( "You are rank "..lastRank[typ] )
			
			if lastUpdate[typ] then
				updateTime = math.floor(CurTime() - lastUpdate[typ])
				if updateTime>0 then
					Top10.Updated:SetText( ("Updated %s ago."):format(SecondsToTime(updateTime)) )
				end
				Top10.Updated:SizeToContents()
			end
		else
			Top10.List:AddLine( "", "ERROR: Rate limit exceeded." )
			Top10.List:AddLine( "", "Please try again in a few minutes." )
		end
		
		return
	end
	
	for i=1,#tbl do
		Top10.List:AddLine( tonumber(tbl[i].Rank), tbl[i].Username, tbl[i].SteamID, tonumber(tbl[i]["Elo" ]) )
	end
	
	local rank = (net.ReadString() or "N/A")
	Top10.Rank:SetText( "You are rank "..rank )
	
	lastUpdate[typ] = tonumber(net.ReadString())
	if lastUpdate[typ] then
		updateTime = math.floor(CurTime() - lastUpdate[typ])
		
		if updateTime>0 then
			Top10.Updated:SetText( ("Updated %s ago."):format(SecondsToTime(updateTime)) )
		end
		Top10.Updated:SizeToContents()
	end
	
	lastTable[typ] = tbl
	lastRank[typ] = rank
end)
