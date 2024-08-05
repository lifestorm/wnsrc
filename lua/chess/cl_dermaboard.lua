--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PanelCol = {
	Main = Color(0,0,0,200), Hover = Color(0,255,0,50), Selected = Color(150,50,50,170),
	Move = Color(10,25,150,150), HasMoved = Color(50,50,50,100), Text = Color(0,0,0,255),
	
	GridWhite = Color(255, 248, 220), GridBlack = Color(210, 180, 140),
	
	White = Color(180,180,180), Black = Color(0,0,0),
}
-- local ColText = Color(50,50,50,200)
-- local ColBlack,ColWhite = Color(0,0,0,120),Color(255,255,255,10)

local NumToLetter = {"a", "b", "c", "d", "e", "f", "g", "h", ["a"]=1, ["b"]=2, ["c"]=3, ["d"]=4, ["e"]=5, ["f"]=6, ["g"]=7, ["h"]=8} --Used extensively for conversions
surface.CreateFont( "ChessPieces", { font = "Arial", size = 64, weight = 300})

function Chess_Open2DBoard( board )
	if not IsValid(board) then return end
	if IsValid( Chess_2DDermaPanel ) then Chess_2DDermaPanel:Remove() end
	
	Chess_2DDermaPanel = vgui.Create( "DFrame" )
	local frame = Chess_2DDermaPanel
	frame:SetTitle( "2D Game Board" )
	frame:SetSize( 740, 760 )
	frame:SetPos( (ScrW()/2)-370, (ScrH()/2)-380 )
	frame.Paint = function( s,w,h )
		if not IsValid(board) then
			s:Remove()
		end
		
		draw.RoundedBox( 8, 0, 0, w, h, PanelCol.Main )
	end
	frame:MakePopup()
	
	local pnlBoard = vgui.Create( "DPanel", frame )
	pnlBoard:SetSize( 720, 720 )
	pnlBoard:SetPos(10,30)
	
	pnlBoard.Squares = {}
	pnlBoard.Paint = function() end
	
	local function DoTiles(swapped)
		if pnlBoard.Squares then
			for _,v in pairs(pnlBoard.Squares) do
				for _,pnl in pairs(v) do
					pnl:Remove()
				end
			end
		end
		
		for i=0,7 do
			pnlBoard.Squares[i] = {}
			for n=0,7 do
				local pnl = vgui.Create( "DModelPanel", pnlBoard )
				pnlBoard.Squares[i][n] = pnl
				
				pnl:SetPos( (swapped and 7-i or i)*90, (swapped and 7-n or n)*90 )
				pnl:SetSize(90,90)
				pnl.GridCol = (((i+n)%2)==1) and PanelCol.GridBlack or PanelCol.GridWhite
				pnl.GridPos = {i,n}
				pnl.oPaint = pnl.Paint
				pnl.Paint = function(s,w,h)
					surface.SetDrawColor( s.GridCol )
					surface.DrawRect( 0,0, w,h )
					
					if not IsValid(board) then return end
					
					if s:IsHovered() then
						surface.SetDrawColor( PanelCol.Hover )
						surface.DrawRect( 0,0, w,h )
					end
					if board.Selected and board.Selected[1]==s.GridPos[1] and board.Selected[2]==s.GridPos[2] then
						surface.SetDrawColor( PanelCol.Selected )
						surface.DrawRect( 0,0, w,h )
					end
					if board:GetTableGrid( board.Moves, s.GridPos[1], s.GridPos[2]) then
						surface.SetDrawColor( PanelCol.Move )
						surface.DrawRect( 0,0, w,h )
					end
					
					local col,square = board.Pieces[ NumToLetter[s.GridPos[1]+1] ]
					if col then
						square = col[8-s.GridPos[2]]
						if square then
							if not (square.Team and square.Class) then return end
							
							if square.Moving then
								surface.SetDrawColor( PanelCol.HasMoved )
								surface.DrawRect( 0,0, w,h )
							end
							
							if board.Characters then
								draw.SimpleText( board.Characters[square.Team .. square.Class], "ChessPieces", w/2, h/2, PanelCol.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
							else
								s:SetModel( board.Models[square.Team .. square.Class] )
								
								return s.oPaint( s,w,h )
							end
						end
					end
					
					
					if cvars.Bool("chess_gridletters") then
						local str = (NumToLetter[i+1]..tostring(8-n)):upper()
						draw.SimpleText( str, "ChessTextSmall", 5, h-20, PanelCol.Black )
					end
				end
				
				pnl.DoClick = function(s)
					if not IsValid(board) then return end
					
					if board.Selected and board:GetTableGrid( board.Moves, pnl.GridPos[1], pnl.GridPos[2] ) then
						board:RequestMove( board.Selected[1], board.Selected[2], pnl.GridPos[1], pnl.GridPos[2] )
						board:ResetHighlights()
					elseif board.Selected and board.Selected[1]==s.GridPos[1] and board.Selected[2]==s.GridPos[2] then
						board:ResetHighlights()
					else
						board:ResetHighlights()
						board.Selected = {s.GridPos[1],s.GridPos[2]}
						board.Moves = board:GetMove( NumToLetter[s.GridPos[1]+1], 8-s.GridPos[2] )
					end
				end
				pnl.LayoutEntity = function( s, ent )
					ent:SetPos( Vector(20,20,20) )
					ent:SetAngles( Angle(0,-50,0) )
				end
				
				pnl:SetModel( board.Models["WhitePawn"] )
			end
		end
	end
	
	local swap = vgui.Create( "DButton", frame )
	swap:SetImage( "icon16/arrow_rotate_clockwise.png" )
	swap:SetSize( 18,18 )
	swap:SetPos( 620,6 )
	swap:SetText( "" )
	swap.DoClick = function(s)
		s.Swapped = not s.Swapped
		DoTiles( s.Swapped )
	end
	swap.Paint = function() end
	
	local toggleGridLetters = vgui.Create( "DCheckBox", frame )
	toggleGridLetters:SetImage( "icon16/font.png" )
	toggleGridLetters:SetSize( 18,18 )
	toggleGridLetters:SetPos( 600,6 )
	toggleGridLetters:SetText( "" )
	toggleGridLetters:SetConVar( "chess_gridletters" )
	toggleGridLetters.OnChange = function(s,newvalue)
		s:SetAlpha( s:GetChecked() and 255 or 100 )
	end
	toggleGridLetters.Paint = function() end
	toggleGridLetters.PerformLayout = function(s) -- DCheckBox overwrites DButton's PerformLayout, re-apply it
		if IsValid(s.m_Image) then
			s.m_Image:SetPos( 4, ( s:GetTall() - s.m_Image:GetTall() ) * 0.5 )
			s:SetTextInset( s.m_Image:GetWide() + 16, 0 )
		end
		
		DLabel.PerformLayout( s )
	end
	
	swap.Swapped = false
	DoTiles( swap.Swapped )
end
