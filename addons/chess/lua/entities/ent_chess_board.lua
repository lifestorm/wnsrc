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
	
	--From client
	util.AddNetworkString( "Chess ClientRequestMove" )
	util.AddNetworkString( "Chess ClientWager" )
	util.AddNetworkString( "Chess ClientCallDraw" )
	
	util.AddNetworkString( "Chess ClientResign" )
	util.AddNetworkString( "Chess RequestSeat" )
	
	--2-way
	util.AddNetworkString( "Chess DrawOffer" )
	util.AddNetworkString( "Chess PromotionSelection" )
	util.AddNetworkString( "Chess Update" )
	--From server
	util.AddNetworkString( "Chess GameOver" )
end

ENT.Type = "anim"
ENT.Model = Model("models/weapons/w_slam.mdl")

-- This is a quick swap to alternate settings so you don't need to configure it yourself
-- Set to `true` if your users aren't expected to have CS:S mounted
local UseHL2Model = false

ENT.Models = {
	["board"] = Model("models/props_phx/games/chess/board.mdl"),
	["table"] = (UseHL2Model and Model( "models/props_c17/furnituretable001a.mdl" ) or Model("models/props/de_tides/restaurant_table.mdl")),
	["hl2table"] = Model( "models/props_c17/furnituretable001a.mdl" ),
	
	["BlackPawn"] = Model("models/props_phx/games/chess/black_pawn.mdl"),      ["WhitePawn"] = Model("models/props_phx/games/chess/white_pawn.mdl"),
	["BlackRook"] = Model("models/props_phx/games/chess/black_rook.mdl"),      ["WhiteRook"] = Model("models/props_phx/games/chess/white_rook.mdl"),
	["BlackKnight"] = Model("models/props_phx/games/chess/black_knight.mdl"),  ["WhiteKnight"] = Model("models/props_phx/games/chess/white_knight.mdl"),
	["BlackBishop"] = Model("models/props_phx/games/chess/black_bishop.mdl"),  ["WhiteBishop"] = Model("models/props_phx/games/chess/white_bishop.mdl"),
	["BlackQueen"] = Model("models/props_phx/games/chess/black_queen.mdl"),    ["WhiteQueen"] = Model("models/props_phx/games/chess/white_queen.mdl"),
	["BlackKing"] = Model("models/props_phx/games/chess/black_king.mdl"),      ["WhiteKing"] = Model("models/props_phx/games/chess/white_king.mdl"),
	
	["dama"] = Model("models/props_phx/games/chess/white_dama.mdl"),
}

-- 2D mode icons
ENT.Characters = {
	["BlackPawn"] = "♟",    ["WhitePawn"] = "♙",
	["BlackRook"] = "♜",    ["WhiteRook"] = "♖",
	["BlackKnight"] = "♞",	["WhiteKnight"] = "♘",
	["BlackBishop"] = "♝",	["WhiteBishop"] = "♗",
	["BlackQueen"] = "♛",   ["WhiteQueen"] = "♕",
	["BlackKing"] = "♚",    ["WhiteKing"] = "♔",
}

-- Board position (Offset from ground)
ENT.BoardHeight = Vector(0, 0, (UseHL2Model and 17 or 30))

-- Table position
ENT.TableOffset = Vector(0, 0, (UseHL2Model and 10 or 0))

-- Table phys box
ENT.PhysBox = {
	mins = Vector(-30, -30, -0),
	maxs = Vector(30, 30, 33)
}

ENT.PrintName		= "Chess"
ENT.Author			= "my_hat_stinks"
ENT.Information		= "A chess board"
ENT.Category		= "Game boards"

ENT.Game = "Chess"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AdminSpawnable = true

ENT.IsChessBoard = true


ENT.TopLeft = Vector(2.5,-15.5,-16) --Local pos of the board's corner (Used for alignment)
ENT.SquareH = 78.5 ENT.SquareW = 80.2 --For drawing square highlights
ENT.RealH = 4 ENT.RealW = 3.9 --For vector positions

ENT.MoveTime = 0.3 --Time it takes to complete a move
ENT.MoveSound = Sound( "physics/wood/wood_solid_impact_soft1.wav" )
ENT.CheckSound = Sound( "physics/concrete/rock_impact_hard1.wav" )

local NumToLetter = {"a", "b", "c", "d", "e", "f", "g", "h", ["a"]=1, ["b"]=2, ["c"]=3, ["d"]=4, ["e"]=5, ["f"]=6, ["g"]=7, ["h"]=8} --Used extensively for conversions
local PassantFlags = {1,2,4,8,16,32,64,128} --Bitflags, translate to board positions 1-8. For En Passant rule

--Status
local CHESS_INACTIVE = 0
local CHESS_WHITEMOVE = 1
local CHESS_BLACKMOVE = 2
local CHESS_WHITEPROMO = 3
local CHESS_BLACKPROMO = 4
local CHESS_WAGER = 5

--Captured piece squares
local CHESS_WCAP1 = 10
local CHESS_WCAP2 = 11
local CHESS_BCAP1 = 12
local CHESS_BCAP2 = 13

-- Draw Offer
local PLAYER_NONE  = 0 -- Nobody offering to draw
local PLAYER_WHITE = 1 -- White offering to draw
local PLAYER_BLACK = 2 -- Black offering to draw

--Draws
local CHESS_DRAW_50 = 0
local CHESS_DRAW_3 = 1

ENT.StartState = CHESS_WHITEMOVE

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "BlackPassant" )
	self:NetworkVar( "Int", 1, "WhitePassant" )
	
	self:NetworkVar( "Int", 2, "ChessState" )
	self:NetworkVar( "Bool", 0, "Playing" )
	self:NetworkVar( "Int", 3, "DrawOffer" )
	
	self:NetworkVar( "Float", 0, "WhiteWager" )
	self:NetworkVar( "Float", 1, "BlackWager" )
	
	self:NetworkVar( "Entity", 0, "WhitePlayer" )
	self:NetworkVar( "Entity", 1, "BlackPlayer" )
	self:NetworkVar( "Entity", 2, "TableEnt" )
	
	self:NetworkVar( "Int", 4, "MoveCount" )
	self:NetworkVar( "Bool", 1, "Repetition" )
	
	self:NetworkVar( "Bool", 2, "PSWager" )
	
	self:NetworkVar( "Float", 2, "WhiteTime" )
	self:NetworkVar( "Float", 3, "BlackTime" )
end
local ChessScale = Matrix({
	{0.1225,0,0,0},
	{0,0.1225,0,0},
	{0,0,0.1225,0},
	{0,0,0,0},
})

local SpawnedEnts = {}
function ENT:SpawnFunction( ply, tr, ClassName )
	if (not tr.Hit) then return end
	
	local SpawnPos = tr.HitPos --+ (tr.HitNormal*16)
	
	local board = (IsValid(self) and self) or ents.Create( ClassName )
	board.SavePos = SpawnPos
	board:SetPos( SpawnPos )
	board:Spawn()
	
	SpawnedEnts[board]=true
	
	return board
end
function ENT:Initialize()
	if SERVER then
		local pos,ang = self:GetPos(),self:GetAngles()
		
		local tbl = ents.Create( "prop_physics" )
		tbl:SetModel(self.Models["table"])
		tbl:SetPos(pos + self.TableOffset)
		tbl:Spawn()
		tbl:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		tbl:PhysicsInitBox(self.PhysBox.mins - self.TableOffset, self.PhysBox.maxs - self.TableOffset)
		tbl:SetMoveType(MOVETYPE_NONE)
		tbl:SetMaxHealth(1000000)
		tbl.IsChessEntity = true
		
		if not self.SkipBlackChair then
			local BlackSeat = ents.Create( "prop_vehicle_prisoner_pod" )
			BlackSeat:SetModel( "models/nova/chair_plastic01.mdl" )
			BlackSeat:SetPos( self.BlackChairPos or (pos+ (self:GetRight()*60)) )
			BlackSeat:SetAngles( self.BlackChairAng or ang )
			BlackSeat:Spawn()
			BlackSeat:SetMoveType( MOVETYPE_NONE )
			BlackSeat:SetCollisionGroup( COLLISION_GROUP_WORLD )
			BlackSeat.IsChessEntity = true
			
			self.BlackSeat = BlackSeat
			BlackSeat:SetNWBool("IsChessSeat", true)
			BlackSeat:SetNWEntity( "ChessBoard", self )
			
			BlackSeat.DoorData = {NonOwnable = true}
			if BlackSeat.setKeysNonOwnable then BlackSeat:setKeysNonOwnable( true ) end
		end
		if not self.SkipWhiteChair then
			local WhiteSeat = ents.Create( "prop_vehicle_prisoner_pod" )
			WhiteSeat:SetModel( "models/nova/chair_plastic01.mdl" )
			WhiteSeat:SetPos( self.WhiteChairPos or (pos+ (self:GetRight()*-60)) )
			ang:RotateAroundAxis( self:GetUp(),180 )
				WhiteSeat:SetAngles( self.WhiteChairAng or ang )
			ang:RotateAroundAxis( self:GetUp(),180 )
			WhiteSeat:Spawn()
			WhiteSeat:SetMoveType( MOVETYPE_NONE )
			WhiteSeat:SetCollisionGroup( COLLISION_GROUP_WORLD )
			WhiteSeat.IsChessEntity = true
		
			--Set some stuff up so we can see it's for chess
			self.WhiteSeat = WhiteSeat
			WhiteSeat:SetNWBool("IsChessSeat", true)
			WhiteSeat:SetNWEntity( "ChessBoard", self )
			
			--Darkrp lets people steal seats...
			WhiteSeat.DoorData = {NonOwnable = true}
			if WhiteSeat.setKeysNonOwnable then WhiteSeat:setKeysNonOwnable( true ) end
		end
		
		self.IsChessEntity = true
		
		ang:RotateAroundAxis(self:GetRight(), 90)
		self:SetPos(pos + self.BoardHeight + self.TableOffset)
		self:SetAngles(ang)
		
		self.TableEnt = tbl self:SetTableEnt( tbl )
		self:SetParent( tbl )
		
		self:SetChessState( CHESS_INACTIVE )
		self:SetPlaying( false )
		
	
		timer.Simple( 1, function()
			if not IsValid(self) then return end
			
			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableCollisions( false )
				phys:Sleep()
			end
			
			local phys = IsValid(tbl) and tbl:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableCollisions( false )
				phys:Sleep()
			end
			
			local phys = IsValid(WhiteSeat) and WhiteSeat:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableCollisions( false )
				phys:Sleep()
			end
			
			local phys = IsValid(BlackSeat) and BlackSeat:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableCollisions( false )
				phys:Sleep()
			end
		end)
	end
	
	self.Pieces = { ["a"] = {}, ["b"] = {}, ["c"] = {}, ["d"] = {}, ["e"] = {}, ["f"] = {}, ["g"] = {}, ["h"] = {} }
	
	self:SetModel( self.Models["board"] )
	//self:SetModelScale( 0.35, 0 )
	
	self:DrawShadow( false )
	
	local mins = self:OBBMins()*0.1
	local maxs = self:OBBMaxs()*0.1
	-- self:PhysicsInitBox( mins, maxs )
	self:PhysicsInit(SOLID_NONE)
	if CLIENT then
		self:EnableMatrix( "RenderMultiply", ChessScale )
		hook.Add( "KeyPress", self, self.GetSpectateUse )
		hook.Add( "PrePlayerDraw", self, self.PrePlayerDraw )
	end
	
	self:ResetBoard()
end
function ENT:OnRemove()
	if SERVER then
		local WhitePly = self:GetPlayer( "White" )
		local BlackPly = self:GetPlayer( "Black" )
		
		if IsValid(WhitePly) then
			WhitePly:SetNWBool( "IsInChess", false )
			WhitePly:SetNWEntity( "ActiveChessBoard", NULL )
		end
		if IsValid(BlackPly) then
			BlackPly:SetNWBool( "IsInChess", false )
			BlackPly:SetNWEntity( "ActiveChessBoard", NULL )
		end
		
		if self:GetPlaying() then
			local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
			local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
			net.Start( "Chess GameOver" )
				net.WriteTable( {Color(150,255,150), "Chess removed! ", Color(255,255,255), WhiteName, Color(150,255,150), " vs ", Color(100,100,100), BlackName, Color(150,255,150)," ended prematurely!"} )
			net.Broadcast()
			self:EndGame( "Error" )
		end
		
		if IsValid( self.WhiteSeat ) then self.WhiteSeat:Remove() end
		if IsValid( self.BlackSeat ) then self.BlackSeat:Remove() end
		if IsValid( self.TableEnt ) then self.TableEnt:Remove() end
		
		for GridLet,column in pairs( self.Pieces ) do
			for GridNum,square in pairs( column ) do
				if IsValid( square.Ent ) then
					square.Ent:Remove()
				end
			end
		end
	end
	if CLIENT then
		if IsValid( self.PiecesEnt ) then self.PiecesEnt:Remove() end
		if IsValid( self:GetTableEnt() ) and IsValid( self:GetTableEnt().ClientChessTable ) then
			self:GetTableEnt().ClientChessTable:Remove()
		end
	end
end
if SERVER then
	hook.Add( "ShutDown", "Chess Server Shutdown", function()
		local Ents = ents.FindByClass( "ent_chess_board" )
		for _,v in pairs( Ents ) do
			if IsValid(v) then
				v:EndGame( "Error" )
			end
		end
		local Ents = ents.FindByClass( "ent_draughts_board" )
		for _,v in pairs( Ents ) do
			if IsValid(v) then
				v:EndGame( "Error" )
			end
		end
	end)
end

function ENT:GetTableGrid( tbl, key1, key2 )
	if type(key1)=="number" then key1=NumToLetter[key1+1] end
	return tbl and tbl[key1] and tbl[key1][8-key2]
end
function ENT:GetTableKey( tbl, key1, key2 )
	if type(key1)=="string" then key1=NumToLetter[key1]-1 end
	return tbl and tbl[key1] and tbl[key1][8-key2]
end

function ENT:GetSquare( GridLet, GridNum, tbl )
	tbl = tbl or self.Pieces
	return tbl[GridLet] and tbl[GridLet][GridNum]
end
function ENT:SquareTeam( square )
	if square.Team then return square.Team end
	
	return (IsValid(square.Ent) and (square.Ent:GetWhite() and "White" or "Black"))
end
function ENT:SquareMoved( square )
	if square.Moved~=nil then return square.Moved end
	
	return (IsValid(square.Ent) and square.Ent:GetMoved())
end
function ENT:SquareClass( square )
	if square.Class~=nil then return square.Class end
	
	return (IsValid(square.Ent) and square.Ent:GetRole())
end
function ENT:SquareColor( GridLet, GridNum )
	local NumEven = ((GridNum/2) == math.floor(GridNum/2))
	local LetEven = ((NumToLetter[GridLet]/2) == math.floor(NumToLetter[GridLet]/2))
	
	return (NumEven==LetEven) and "Black" or "White"
end

function ENT:GetRookMoves( tbl, GridLet, GridNum, IsWhite, limit, CheckTable )
	limit = limit or 8
	local count = 0
	for TargetRow = GridNum+1,8 do
		local target = self:GetSquare( GridLet, TargetRow, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then
				tbl[GridLet][TargetRow] = true
			end
			break
		end
		tbl[GridLet][TargetRow] = true
		count = count+1 if count>=limit then break end
	end
	count = 0
	for TargetRow = GridNum-1,1,-1 do
		local target = self:GetSquare( GridLet, TargetRow, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then
				tbl[GridLet][TargetRow] = true
			end
			break
		end
		tbl[GridLet][TargetRow] = true
		count = count+1 if count>=limit then break end
	end
	count = 0
	for TargetColumn = NumToLetter[GridLet]+1,8 do
		local target = self:GetSquare( NumToLetter[TargetColumn], GridNum, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then
				tbl[NumToLetter[TargetColumn]][GridNum] = true
			end
			break
		end
		tbl[NumToLetter[TargetColumn]][GridNum] = true
		count = count+1 if count>=limit then break end
	end
	count = 0
	for TargetColumn = NumToLetter[GridLet]-1,1,-1 do
		local target = self:GetSquare( NumToLetter[TargetColumn], GridNum, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then
				tbl[NumToLetter[TargetColumn]][GridNum] = true
			end
			break
		end
		tbl[NumToLetter[TargetColumn]][GridNum] = true
		count = count+1 if count>=limit then break end
	end
end
function ENT:GetBishopMoves( tbl, GridLet, GridNum, IsWhite, limit, CheckTable )
	limit = limit or 8
	local TargetColumn, count = NumToLetter[GridLet], 0
	for TargetRow = GridNum+1,8 do
		TargetColumn = TargetColumn+1 if TargetColumn>8 then break end
		local target = self:GetSquare( NumToLetter[TargetColumn], TargetRow, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then tbl[NumToLetter[TargetColumn]][TargetRow] = true end
			break
		end
		tbl[NumToLetter[TargetColumn]][TargetRow] = true
		count = count+1 if count>=limit then break end
	end
	local TargetColumn, count = NumToLetter[GridLet], 0
	for TargetRow = GridNum+1,8 do
		TargetColumn = TargetColumn-1 if TargetColumn<1 then break end
		local target = self:GetSquare( NumToLetter[TargetColumn], TargetRow, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then tbl[NumToLetter[TargetColumn]][TargetRow] = true end
			break
		end
		tbl[NumToLetter[TargetColumn]][TargetRow] = true
		count = count+1 if count>=limit then break end
	end
	local TargetColumn, count = NumToLetter[GridLet], 0
	for TargetRow = GridNum-1,1,-1 do
		TargetColumn = TargetColumn+1 if TargetColumn>8 then break end
		local target = self:GetSquare( NumToLetter[TargetColumn], TargetRow, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then tbl[NumToLetter[TargetColumn]][TargetRow] = true end
			break
		end
		tbl[NumToLetter[TargetColumn]][TargetRow] = true
		count = count+1 if count>=limit then break end
	end
	local TargetColumn, count = NumToLetter[GridLet], 0
	for TargetRow = GridNum-1,1,-1 do
		TargetColumn = TargetColumn-1 if TargetColumn<1 then break end
		local target = self:GetSquare( NumToLetter[TargetColumn], TargetRow, CheckTable )
		if target then
			if ((self:SquareTeam(target)=="White")~=IsWhite) then tbl[NumToLetter[TargetColumn]][TargetRow] = true end
			break
		end
		tbl[NumToLetter[TargetColumn]][TargetRow] = true
		count = count+1 if count>=limit then break end
	end
end
function ENT:GetMove( GridLet, GridNum, IgnoreCheck, CheckTable )
	if not (GridLet and GridNum) then return {} end
	if not NumToLetter[GridLet] then return {} end
	if NumToLetter[GridLet]<1 or NumToLetter[GridLet]>8 then return {} end
	if GridNum<1 or GridNum>8 then return {} end
	
	local square = self:GetSquare( GridLet, GridNum, CheckTable )
	if not square then return {} end
	
	local class = square.Class or (IsValid(square.Ent) and square.Ent:GetRole())
	if not class then return {} end
	
	local IsWhite = self:SquareTeam(square)=="White"
	local Moved = self:SquareMoved(square)
	
	local ChecksPerformed = false --Castling checks for check differently, flag it as done here
	local tbl = { ["a"] = {}, ["b"] = {}, ["c"] = {}, ["d"] = {}, ["e"] = {}, ["f"] = {}, ["g"] = {}, ["h"] = {} }
	if class=="Pawn" then
		local TargetRow = IsWhite and GridNum+1 or GridNum-1
		
		local CapOne = self:GetSquare( NumToLetter[NumToLetter[GridLet]-1], TargetRow, CheckTable )
		if CapOne then --There's a unit here
			local TargetWhite = self:SquareTeam(CapOne)=="White"
			if TargetWhite~=IsWhite then
				tbl[NumToLetter[NumToLetter[GridLet]-1]][TargetRow] = true
			end
		elseif (IsWhite and TargetRow==6) or ((not IsWhite) and TargetRow==3) then --Clear, EnPasse check
			local PassantCheck = IsWhite and self:GetBlackPassant() or self:GetWhitePassant()
			if (NumToLetter[GridLet]>1) and bit.band(PassantCheck, PassantFlags[ NumToLetter[GridLet]-1 ])==PassantFlags[NumToLetter[GridLet]-1]  then
				tbl[NumToLetter[NumToLetter[GridLet]-1]][TargetRow] = "ENPASSANT"
			end
		end
		
		local CapTwo = self:GetSquare( NumToLetter[NumToLetter[GridLet]+1], TargetRow, CheckTable )
		if CapTwo then
			local TargetWhite = self:SquareTeam(CapTwo)=="White"
			if TargetWhite~=IsWhite then
				tbl[NumToLetter[NumToLetter[GridLet]+1]][TargetRow] = true
			end
		elseif (IsWhite and TargetRow==6) or ((not IsWhite) and TargetRow==3) then --Clear, EnPasse check
			local PassantCheck = IsWhite and self:GetBlackPassant() or self:GetWhitePassant()
			if (NumToLetter[GridLet]<8) and bit.band(PassantCheck, PassantFlags[ NumToLetter[GridLet]+1 ])==PassantFlags[NumToLetter[GridLet]+1] then
				tbl[NumToLetter[NumToLetter[GridLet]+1]][TargetRow] = "ENPASSANT"
			end
		end
		
		local FrontOne = self:GetSquare( GridLet, TargetRow, CheckTable )
		if (not FrontOne) then --It's clear, we can move
			tbl[GridLet][TargetRow] = true
			if not Moved then
				TargetRow = IsWhite and TargetRow+1 or TargetRow-1
				if (TargetRow>0 and TargetRow<9) and (not self:GetSquare( GridLet, TargetRow, CheckTable )) then tbl[GridLet][TargetRow] = "PAWNDOUBLE" end
			end
		end
	elseif class=="Rook" then
		self:GetRookMoves( tbl, GridLet, GridNum, IsWhite, 8, CheckTable )
	elseif class=="Bishop" then
		self:GetBishopMoves( tbl, GridLet, GridNum, IsWhite, 8, CheckTable )
	elseif class=="Queen" then
		self:GetRookMoves( tbl, GridLet, GridNum, IsWhite, 8, CheckTable )
		self:GetBishopMoves( tbl, GridLet, GridNum, IsWhite, 8, CheckTable )
	elseif class=="King" then
		self:GetRookMoves( tbl, GridLet, GridNum, IsWhite, 1, CheckTable )
		self:GetBishopMoves( tbl, GridLet, GridNum, IsWhite, 1, CheckTable )
		
		ChecksPerformed = true --King performs it's own checks for Check
		
		local InCheck = true
		if not IgnoreCheck then
			for CheckLet,File in pairs(tbl) do
				for CheckNum,v in pairs(File) do
					local Positions = table.Copy( self.Pieces )
					Positions[GridLet][GridNum] = nil
					Positions[CheckLet][CheckNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
					if self:CheckForCheck( Positions, IsWhite ) then
						tbl[CheckLet][CheckNum] = nil --Puts us in check, remove it
					end
				end
			end
			
			InCheck = self:CheckForCheck( self.Pieces, IsWhite )
		end
		
		if (not Moved) and (not InCheck) then --Castling
			local Kingside = self:GetSquare( "h", GridNum, CheckTable )
			local Queenside = self:GetSquare( "a", GridNum, CheckTable )
			if Kingside and not self:SquareMoved(Kingside) then
				if not (self:GetSquare( "f", GridNum, CheckTable ) or self:GetSquare( "g", GridNum, CheckTable )) then
					local Positions = table.Copy( self.Pieces ) Positions[GridLet][GridNum] = nil Positions["f"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
					local FSafe = not self:CheckForCheck( Positions, IsWhite )
					local Positions = table.Copy( self.Pieces ) Positions[GridLet][GridNum] = nil Positions["g"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
					local GSafe = not self:CheckForCheck( Positions, IsWhite )
					if FSafe and GSafe then
						tbl["g"][GridNum] = "CASTLEKINGSIDE"
					end
				end
			end
			if Queenside and not self:SquareMoved(Queenside) then
				if not (self:GetSquare( "b", GridNum, CheckTable ) or self:GetSquare( "c", GridNum, CheckTable ) or self:GetSquare( "d", GridNum, CheckTable )) then
					local Positions = table.Copy( self.Pieces ) Positions[GridLet][GridNum] = nil Positions["c"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
					local CSafe = not self:CheckForCheck( Positions, IsWhite )
					local Positions = table.Copy( self.Pieces ) Positions[GridLet][GridNum] = nil Positions["d"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
					local DSafe = not self:CheckForCheck( Positions, IsWhite )
					if CSafe and DSafe then
						tbl["c"][GridNum] = "CASTLEQUEENSIDE"
					end
				end
			end
		end
	elseif class=="Knight" then
		local Up = NumToLetter[GridLet] + 2
		if Up and Up >=1 and Up<=8 then
			local Pos1 = self:GetSquare( NumToLetter[Up], GridNum-1, CheckTable )
			local Pos2 = self:GetSquare( NumToLetter[Up], GridNum+1, CheckTable )
			if (GridNum-1>=1) and ((not Pos1) or (self:SquareTeam(Pos1)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Up]][GridNum-1] = true
			end
			if (GridNum+1<=8) and ((not Pos2) or (self:SquareTeam(Pos2)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Up]][GridNum+1] = true
			end
		end
		
		local Down = NumToLetter[GridLet] - 2
		if Down and Down>=1 and Down<=8 then
			local Pos1 = self:GetSquare( NumToLetter[Down], GridNum-1, CheckTable )
			local Pos2 = self:GetSquare( NumToLetter[Down], GridNum+1, CheckTable )
			if (GridNum-1>=1) and ((not Pos1) or (self:SquareTeam(Pos1)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Down]][GridNum-1] = true
			end
			if (GridNum+1<=8) and ((not Pos2) or (self:SquareTeam(Pos2)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Down]][GridNum+1] = true
			end
		end
		
		local Let = NumToLetter[GridLet]
		
		local Left = GridNum - 2
		if Left and Left>=1 and Left<=8 then
			local Pos1 = self:GetSquare( NumToLetter[Let-1], Left, CheckTable )
			local Pos2 = self:GetSquare( NumToLetter[Let+1], Left, CheckTable )
			if Let>1 and ((not Pos1) or (self:SquareTeam(Pos1)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Let-1]][Left] = true
			end
			if Let<8 and ((not Pos2) or (self:SquareTeam(Pos2)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Let+1]][Left] = true
			end
		end
		
		local Right = GridNum + 2
		if Right and Right>=1 and Right<=8 then
			local Pos1 = self:GetSquare( NumToLetter[Let-1], Right, CheckTable )
			local Pos2 = self:GetSquare( NumToLetter[Let+1], Right, CheckTable )
			if Let>1 and ((not Pos1) or (self:SquareTeam(Pos1)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Let-1]][Right] = true
			end
			if Let<8 and ((not Pos2) or (self:SquareTeam(Pos2)==(IsWhite and "Black" or "White"))) then
				tbl[NumToLetter[Let+1]][Right] = true
			end
		end
	end
	
	if not IgnoreCheck then
		for CheckLet,File in pairs(tbl) do
			for CheckNum,v in pairs(File) do
				local Positions = table.Copy( self.Pieces )
				Positions[GridLet][GridNum] = nil
				Positions[CheckLet][CheckNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
				if self:CheckForCheck( Positions, IsWhite ) then
					tbl[CheckLet][CheckNum] = nil --Puts us in check, remove it
				end
			end
		end
	end
	
	return tbl
end

function ENT:CastlingCheck( square, IsWhite )
	if not square then return false,false end
	
	local GridNum = IsWhite and 1 or 8
	local moved = self:SquareMoved( square )
	local InCheck = self:CheckForCheck( self.Pieces, IsWhite )
	local Queenside, Kingside = false, false
	if (not Moved) and (not InCheck) then --Castling
		local Kingside = self:GetSquare( "h", GridNum, CheckTable )
		local Queenside = self:GetSquare( "a", GridNum, CheckTable )
		if Kingside and not self:SquareMoved(Kingside) then
			if not (self:GetSquare( "f", GridNum, CheckTable ) or self:GetSquare( "g", GridNum, CheckTable )) then
				local Positions = table.Copy( self.Pieces ) Positions["d"][GridNum] = nil Positions["f"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
				local FSafe = not self:CheckForCheck( Positions, IsWhite )
				local Positions = table.Copy( self.Pieces ) Positions["d"][GridNum] = nil Positions["g"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
				local GSafe = not self:CheckForCheck( Positions, IsWhite )
				if FSafe and GSafe then
					Kingside = true
				end
			end
		end
		if Queenside and not self:SquareMoved(Queenside) then
			if not (self:GetSquare( "b", GridNum, CheckTable ) or self:GetSquare( "c", GridNum, CheckTable ) or self:GetSquare( "d", GridNum, CheckTable )) then
				local Positions = table.Copy( self.Pieces ) Positions["d"][GridNum] = nil Positions["c"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
				local CSafe = not self:CheckForCheck( Positions, IsWhite )
				local Positions = table.Copy( self.Pieces ) Positions["d"][GridNum] = nil Positions["d"][GridNum] = {Team = IsWhite and "White" or "Black", Class = class, Moved = true}
				local DSafe = not self:CheckForCheck( Positions, IsWhite )
				if CSafe and DSafe then
					Queenside = true
				end
			end
		end
	end
	return Queenside, Kingside
end

function ENT:RefreshSquares()
	self.Squares = {}
	self.LastSquaresUpdatePos = self:GetPos()
	
	local pos = self:LocalToWorld( self.TopLeft )
	
	local forward = -self:GetRight() * self.RealH
	local right = self:GetUp() * self.RealW
	
	for i=0,7 do
		self.Squares[i] = {}
		for n=0,7 do
			local offsetX = ((right*i)+(right*0.5))
			local offsetY = ((forward*n)+(forward*0.5))
			
			self.Squares[i][n] = pos + (offsetX + offsetY)
		end
	end
	local HalfW = (self:GetRight() * self.RealW/2)
	self.Squares[CHESS_WCAP1] = {}
	self.Squares[CHESS_WCAP2] = {}
	self.Squares[CHESS_BCAP1] = {}
	self.Squares[CHESS_BCAP2] = {}
	for n=0,7 do
		local offsetXOne = ((right*8.5)+(right*0.5))
		local offsetXTwo = ((right*9.3)+(right*0.5))
		local offsetY = ((HalfW*-(7+n))+(forward*0.5))
		
		self.Squares[CHESS_WCAP1][n] = pos + (offsetXOne + offsetY)
		self.Squares[CHESS_WCAP2][n] = pos + (offsetXTwo + offsetY)
	end
	for n=0,7 do
		local offsetXOne = ((right*-1.4)+(right*0.5))
		local offsetXTwo = ((right*-2.2)+(right*0.5))
		local offsetY = ((HalfW*(n-7))+(forward*0.5))
		
		self.Squares[CHESS_BCAP1][n] = pos + (offsetXOne + offsetY)
		self.Squares[CHESS_BCAP2][n] = pos + (offsetXTwo + offsetY)
	end
end
function ENT:GetSquarePos( GridLetter, GridNumber)
	return self:GetTableKey( self.Squares, GridLetter, GridNumber )
end
function ENT:ResetBoard()
	if SERVER then
		self:SetDrawOffer( PLAYER_NONE )
		
		self:SetWhiteWager( -1 )
		self:SetBlackWager( -1 )
		
		self:SetWhitePassant( 0 )
		self:SetBlackPassant( 0 )
		
		self:SetWhiteTime( 600 )
		self:SetBlackTime( 600 )
		
		self:SetMoveCount( 0 )
		self:SetRepetition( false )
		self.RepetitionTable = {}
	end
	self:RefreshSquares()
	
	if self.Pieces then
		for _,File in pairs( self.Pieces ) do
			for _,Square in pairs(File) do
				if IsValid(Square.Ent) then Square.Ent:SetGridNum(-1) Square.Ent:Remove() end
			end
		end
	end
	self.Pieces = {
		["a"] = {
			[1] = {Team="White",Class="Rook",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Rook",Moved=false},
		},
		["b"] = {
			[1] = {Team="White",Class="Knight",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Knight",Moved=false},
		},
		["c"] = {
			[1] = {Team="White",Class="Bishop",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Bishop",Moved=false},
		},
		["d"] = {
			[1] = {Team="White",Class="Queen",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Queen",Moved=false},
		},
		["e"] = {
			[1] = {Team="White",Class="King",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="King",Moved=false},
		},
		["f"] = {
			[1] = {Team="White",Class="Bishop",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Bishop",Moved=false},
		},
		["g"] = {
			[1] = {Team="White",Class="Knight",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Knight",Moved=false},
		},
		["h"] = {
			[1] = {Team="White",Class="Rook",Moved=false}, [2] = {Team="White",Class="Pawn",Moved=false}, [7] = {Team="Black",Class="Pawn",Moved=false}, [8] = {Team="Black",Class="Rook",Moved=false},
		},
		[CHESS_WCAP1] = {}, [CHESS_WCAP2] = {}, [CHESS_BCAP1] = {}, [CHESS_BCAP2] = {},
	}
	self:Update()
end

function ENT:Update( Move1, Move2 )
	if CLIENT then return end
	Move1,Move2 = Move1 or {},Move2 or {}
	net.Start( "Chess Update" )
		net.WriteEntity( self )
		net.WriteTable( self.Pieces )
		if Move1 then
			net.WriteTable( Move1 )
			if Move2 then net.WriteTable( Move2 ) end
		end
	net.Broadcast()
end

ENT.LastTick = 0
ENT.LastTickTeam = ""
function ENT:Think()
	if SERVER then
		if self.Removing then return end
		-- if not (IsValid(self.TableEnt) and IsValid(self.WhiteSeat) and IsValid(self.BlackSeat)) then -- Make sure entities exist
		if not (IsValid(self.TableEnt)) then -- Make sure entities exist
			self.Removing = true
			self:Remove()
			return
		end
		
		self.TableEnt:SetHealth( 1000000 ) -- If the table's a breakable model this should prevent destruction.
		self.TableEnt:SetVelocity( Vector(0,0,0) )
		
		if (not self.NextUnlock) or (CurTime()>self.NextUnlock) then -- Force unlock seats
			if IsValid(self.WhiteSeat) then self.WhiteSeat:Fire( "Unlock", "", 0 ) end
			if IsValid(self.BlackSeat) then self.BlackSeat:Fire( "Unlock", "", 0 ) end
			
			self.NextUnlock = CurTime()+10
			
			if self:GetChessState()~=CHESS_WAGER then
				self:SetWhiteWager( -1 )
				self:SetBlackWager( -1 )
			end
		end
		
		if self:GetChessState()==CHESS_WHITEMOVE or self:GetChessState()==CHESS_WHITEPROMO then
			if self.LastTickTeam=="White" then self:SetWhiteTime( math.max(0,self:GetWhiteTime()-(CurTime()-self.LastTick)) ) end
			self.LastTickTeam = "White"
			
			if self:GetWhiteTime()<=0 then
				local WhitePly = self:GetPlayer( "White" )
				local BlackPly = self:GetPlayer( "Black" )
				
				local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
				local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
				
				self:EndGame( "Black" )
				net.Start( "Chess GameOver" )
					net.WriteTable( {Color(150,255,150), "Time's up! ", Color(100,100,100), BlackName, Color(150,255,150), self:GetElo(BlackPly), " won against ", Color(255,255,255), WhiteName, Color(150,255,150), self:GetElo(WhitePly),"."} )
					net.WriteString( "icon16/clock.png" )
				net.Broadcast()
			end
		elseif self:GetChessState()==CHESS_BLACKMOVE or self:GetChessState()==CHESS_BLACKPROMO then
			if self.LastTickTeam=="Black" then self:SetBlackTime( math.max(0,self:GetBlackTime()-(CurTime()-self.LastTick)) ) end
			self.LastTickTeam = "Black"
			
			if self:GetBlackTime()<=0 then
				local WhitePly = self:GetPlayer( "White" )
				local BlackPly = self:GetPlayer( "Black" )
				
				local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
				local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
				
				self:EndGame( "White" )
				net.Start( "Chess GameOver" )
					net.WriteTable( {Color(150,255,150), "Time's up! ", Color(255,255,255), WhiteName, Color(150,255,150), self:GetElo(BlackPly), " won against ", Color(100,100,100), BlackName, Color(150,255,150), self:GetElo(WhitePly),"."} )
					net.WriteString( "icon16/clock.png" )
				net.Broadcast()
			end
		else
			self.LastTickTeam = ""
		end
		self.LastTick = CurTime()
	else --if CLIENT then
		local tbl = self:GetTableEnt()
		if IsValid(tbl) then
			if tbl.ChessIsErrorModel or tbl:GetModel()=="models/error.mdl" then --Much cheaper than a file.Find
				tbl.ChessIsErrorModel = true
				self:SetParent( nil )
				tbl:SetNoDraw( true )
				
				tbl.ClientChessTable = IsValid(tbl.ClientChessTable) and tbl.ClientChessTable or ClientsideModel( self.Models["hl2table"] )
				local ent = tbl.ClientChessTable
				
				if not tbl.PerformedChessTableSetup then
					ent:SetPos( tbl:GetPos()+Vector(0,0,13) )
					
					tbl:SetMoveType( MOVETYPE_NONE )
					tbl:PhysicsInit( SOLID_NONE )
					tbl:SetCollisionGroup( COLLISION_GROUP_WORLD )
					
					ent:SetMoveType( MOVETYPE_NONE )
					ent:PhysicsInit( SOLID_VPHYSICS )
					ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
					
					self:SetMoveType( MOVETYPE_NONE )
					self:PhysicsInit( SOLID_NONE )
					self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
					
					tbl.PerformedChessTableSetup = true
				end
				
				tbl:SetModel( self.Models["hl2table"] )
				tbl:SetPos( ent:GetPos() )
				tbl:SetNoDraw( true )
				self:SetPos( ent:GetPos()+Vector(0,0,17) )
			elseif IsValid( tbl.ClientChessTable ) then
				tbl.ClientChessTable:Remove()
				tbl.PerformedChessTableSetup = nil
			end
		end
	end
end

function ENT:GetPlayer( team )
	if (team=="White" or team==true) then
		return (self:GetWhitePlayer())
	else
		return (self:GetBlackPlayer())
	end
end
function ENT:EndGame( winner, HideMsg )
	self:SetChessState( CHESS_INACTIVE )
	self:SetPlaying( false )
	
	local White = self:GetPlayer( "White" )
	local Black = self:GetPlayer( "Black" )
	timer.Simple( 0.5, function()
		if IsValid(White) then
			White:SetNWBool( "IsInChess", false )
			White:SetNWEntity( "ActiveChessBoard", NULL )
			
			if IsValid(self) and White:GetVehicle()==self.WhiteSeat then White:ExitVehicle() end
		end
		if IsValid(Black) then
			Black:SetNWBool( "IsInChess", false )
			Black:SetNWEntity( "ActiveChessBoard", NULL )
			
			if IsValid(self) and Black:GetVehicle()==self.BlackSeat then Black:ExitVehicle() end
		end
	end)
	
	self:SetWhitePlayer( NULL )
	self:SetBlackPlayer( NULL )
	
	local winnings = (self.WagerValue or 0)*2
	if IsValid( White ) then
		if winner=="White" then
			if IsValid(Black) then White:ChessWin( Black ) end
			if self.WagerValue then
				if self:GetPSWager() then
					White:PS_GivePoints( winnings )
				else
					if White.addMoney then White:addMoney( winnings ) else White:SetDarkRPVar( "money", (White:getDarkRPVar( "money" ) or 0) + winnings ) end
				end
			end
		elseif winner~="Black" then
			if winner~="Error" and IsValid(Black) then White:ChessDraw( Black ) end
			if self.WagerValue then
				if self:GetPSWager() then
					White:PS_GivePoints( self.WagerValue )
				else
					if White.addMoney then White:addMoney( self.WagerValue ) else White:SetDarkRPVar( "money", (White:getDarkRPVar( "money" ) or 0) + self.WagerValue ) end
				end
			end
		end
	end
	if IsValid( Black ) then
		if winner=="Black" then
			if IsValid(White) then Black:ChessWin( White ) end
			if self.WagerValue then
				if self:GetPSWager() then
					Black:PS_GivePoints( winnings )
				else
					if Black.addMoney then Black:addMoney( winnings ) else Black:SetDarkRPVar( "money", (Black:getDarkRPVar( "money" ) or 0) + winnings ) end
				end
			end
		elseif winner~="White" then
			if self.WagerValue then
				if self:GetPSWager() then
					Black:PS_GivePoints( self.WagerValue )
				else
					if Black.addMoney then Black:addMoney( self.WagerValue ) else Black:SetDarkRPVar( "money", (Black:getDarkRPVar( "money" ) or 0) + self.WagerValue ) end
				end
			end
		end
	end
end
function ENT:DoCapture( square, EndLet, EndNum )
	if not square then return end
	
	table.Empty( self.RepetitionTable ) --When it's gone, it's gone for good
	self:SetRepetition( false )
	
	self:SetMoveCount( 0 )
	
	local class = square.Class
	
	local made = false
	local CapLet,CapNum
	if square.Team=="White" then --Black captured
		for i=CHESS_BCAP1,CHESS_BCAP2 do
			for n=1,8 do
				local CapSq = self:GetSquare( i, n )
				if not CapSq then
					self.Pieces[i][n] = {Team="White", Class=class, Moved=false}
					CapSq = self.Pieces[i][n]
					
					made = true
					CapLet,CapNum = i,n
					break
				end
			end
			if made then break end
		end
	else
		for i=CHESS_WCAP1,CHESS_WCAP2 do
			for n=1,8 do
				local CapSq = self:GetSquare( i, n )
				if not CapSq then
					self.Pieces[i][n] = {Team="Black", Class=class, Moved=false}
					CapSq = self.Pieces[i][n]
					
					made = true
					CapLet,CapNum = i,n
					break
				end
			end
			if made then break end
		end
	end
	
	return {From={EndLet,EndNum}, To={CapLet,CapNum}}
end

function ENT:CheckForCheck( tbl, CheckWhite )
	if not tbl then return true end --Assume invalid move
	
	local king, KingLet, KingNum
	for GridLet,File in pairs(tbl) do
		for GridNum,square in pairs(File) do
			if square and self:SquareClass(square)=="King" and ((CheckWhite and self:SquareTeam(square)=="White") or ((not CheckWhite) and self:SquareTeam(square)=="Black")) then
				king = square
				KingLet = GridLet
				KingNum = GridNum
				break
			end
		end
		if king then break end
	end
	if not king then return true end --Assume invalid
	
	for GridLet,File in pairs(tbl) do
		for GridNum,square in pairs(File) do
			if square and ((CheckWhite and self:SquareTeam(square)=="Black") or ((not CheckWhite) and self:SquareTeam(square)=="White")) then
				local Moves = self:GetMove( GridLet, GridNum, true, tbl )
				if Moves[KingLet] and Moves[KingLet][KingNum] then return true end --Something can take the king
			end
		end
	end
	
	return false --King is safe
end
function ENT:IsCheckmate( CheckWhite )
--	local IsCheck = self:CheckForCheck( self.Pieces, CheckWhite ) --We no longer check for check here, this is also a stalemate check
--	if not IsCheck then return false end
	
	for GridLet,File in pairs(self.Pieces) do
		for GridNum,square in pairs(File) do
			if square and ((CheckWhite and self:SquareTeam(square)=="White") or ((not CheckWhite) and self:SquareTeam(square)=="Black")) then
				local Moves = self:GetMove( GridLet, GridNum, false, tbl )
				for MoveLet,File in pairs(Moves) do
					if table.Count(File)>0 then return false end --There's a valid move, it's fine
				end
			end
		end
	end
	
	return true
end
function ENT:NoMaterialCheck()
	local BlackMat = {}
	local WhiteMat = {}
	
	for GridLet,File in pairs(self.Pieces) do
		if GridLet==CHESS_WCAP1 or GridLet==CHESS_WCAP2 or GridLet==CHESS_BCAP1 or GridLet==CHESS_BCAP2 then continue end
		for GridNum,square in pairs(File) do
			if square then
				local IsWhite = self:SquareTeam(square)=="White"
				local Class = self:SquareClass(square)
				if Class=="Queen" or Class=="Rook" or Class=="Pawn" then return false end --Always sufficient material
				if Class=="King" then continue end --Don't count king
				
				if IsWhite then
					table.insert( WhiteMat, {Square=square, Class=Class, GridLet=GridLet, GridNum=GridNum} )
				else
					table.insert( BlackMat, {square=square, Class=Class, GridLet=GridLet, GridNum=GridNum} )
				end
			end
		end
	end
	
	if #BlackMat==0 and #WhiteMat==0 then return true end --Kings only, draw
	if #BlackMat==1 and #WhiteMat==0 and (BlackMat[1].Class=="Bishop" or BlackMat[1].Class=="Knight") then return true end --King versus King+Bishop/Knight
	if #BlackMat==0 and #WhiteMat==1 and (WhiteMat[1].Class=="Bishop" or WhiteMat[1].Class=="Knight") then return true end --King versus King+Bishop/Knight
	
	local BishopCol
	for i=1,#BlackMat do
		if BlackMat[i].Class~="Bishop" then return false end --Has non-bishops, it's fine
		if not BishopCol then BishopCol = self:SquareColor(BlackMat[i].GridLet,BlackMat[i].GridNum) end
		if BishopCol~=self:SquareColor(BlackMat[i].GridLet,BlackMat[i].GridNum) then return false end --Bishops are on different colours, it's fine
	end
	for i=1,#WhiteMat do
		if WhiteMat[i].Class~="Bishop" then return false end
		if not BishopCol then BishopCol = self:SquareColor(WhiteMat[i].GridLet,WhiteMat[i].GridNum) end
		if BishopCol~=self:SquareColor(WhiteMat[i].GridLet,WhiteMat[i].GridNum) then return false end --Even if it's the enemy on a different colour, checkmate is possible
	end
	
	return true
end

function table.EqualsTable( CheckTable, MatchTable, depth )
	if not (CheckTable and MatchTable) then return false end
	depth = depth or 1
	if depth>=15 then error("Unable to match tables: Tables too deep!") end
	
	if table.Count( CheckTable ) ~= table.Count( MatchTable ) then return false end
	for k,v in pairs( CheckTable ) do
		if type(v)=="table" then
			if type(MatchTable[k])~="table" then return false end
			if not table.EqualsTable( v, MatchTable[k], depth+1 ) then return false end
		elseif type(v)=="Entity" then
		else
			if MatchTable[k]~=v then return false end
		end
	end
	return true
end
function ENT:DoRepetition()
	local Pieces = self.Pieces
	local WKing = self:GetSquare( "d", 1 )
	local BKing = self:GetSquare( "d", 8 )
	local WCQ, WCK = self:CastlingCheck( WKing, true ) --WhiteCastleQueenside, Kingside
	local BCQ, BCK = self:CastlingCheck( BKing, false ) --BlackCastleQueenside, Kingside
	for _,Saved in pairs( self.RepetitionTable ) do
		if table.EqualsTable( Saved.Pieces, Pieces ) and Saved.WCQ==WCQ and Saved.WCK==WCK and Saved.BCQ==BCQ and Saved.BCK==BCK then
			Saved.Count = Saved.Count+1
			if Saved.Count>=3 then self:SetRepetition( true ) end
			return
		end
	end
	self:SetRepetition( false )
	--No match
	table.insert( self.RepetitionTable, {
		WCQ = WCQ, WCK = WCK, BCQ = BCQ, BCK = BCK,
		Pieces = table.Copy( Pieces ), Count = 1
	})
end

function ENT:DoMove( StartLet, StartNum, EndLet, EndNum )
	if CLIENT then return end
	if not (StartLet and EndLet and StartNum and EndNum) then return end
	if (StartLet==EndLet) and (StartNum==EndNum) then return end
	
	local Start = self:GetSquare( StartLet, StartNum )
	if not Start then return end
	
	local Moves = self:GetMove( StartLet, StartNum )
	if not Moves[EndLet][EndNum] then return end
	local Move = Moves[EndLet][EndNum]
	
	self:SetWhitePassant( 0 ) --Reset after the move verified
	self:SetBlackPassant( 0 )
	self:SetRepetition( false )
	
	self:SetMoveCount( ((Start.Class=="Pawn") and 0) or self:GetMoveCount()+1 )
	local IgnoreRepetition
	
	local CapMove
	if Move=="PAWNDOUBLE" then
		if Start.Team=="White" then
			self:SetWhitePassant( PassantFlags[NumToLetter[StartLet]] )
		else
			self:SetBlackPassant( PassantFlags[NumToLetter[StartLet]] )
		end
	elseif Move=="ENPASSANT" then
		local Take = self:GetSquare( EndLet, StartNum )
		if Take and Take.Class then
			CapMove = self:DoCapture( Take, EndLet, StartNum )
		end
		self.Pieces[EndLet][StartNum] = nil
		IgnoreRepetition = true --Passant state is counted, and is never the same
	elseif Move=="CASTLEKINGSIDE" then
		CapMove = self:DoMove( "h", StartNum, "f", StartNum )
	elseif Move=="CASTLEQUEENSIDE" then
		CapMove = self:DoMove( "a", StartNum, "d", StartNum )
	end
	
	local End = self:GetSquare( EndLet, EndNum )
	if not End then
		self.Pieces[EndLet] = self.Pieces[EndLet] or {}
		self.Pieces[EndLet][EndNum] = self.Pieces[EndLet][EndNum] or {}
		End = self.Pieces[EndLet][EndNum]
	end
	if End.Class then
		CapMove = self:DoCapture( End, EndLet, EndNum )
	end
	
	End.Team=Start.Team
	End.Class=Start.Class
	End.Moved=true
	
	self.Pieces[StartLet][StartNum] = nil
	
	local ply = self:GetPlayer( End.Team )
	if (EndNum==1 or EndNum==8) and End.Class=="Pawn" and IsValid(ply) then --End of the board
		net.Start( "Chess PromotionSelection" )
			net.WriteInt( NumToLetter[EndLet], 5 )
		net.Send( ply )
		self:SetChessState( End.Team=="White" and CHESS_WHITEPROMO or CHESS_BLACKPROMO )
	else
		self:SetChessState( End.Team=="White" and CHESS_BLACKMOVE or CHESS_WHITEMOVE )
	end
	
	local move = {From={StartLet,StartNum},To={EndLet,EndNum}}
	self:Update( move, CapMove )
	
	local IsCheck = self:CheckForCheck( self.Pieces, End.Team~="White" )
	local Checkmate = self:IsCheckmate( End.Team~="White" )
	if IsCheck and Checkmate then
		local WhitePly = self:GetPlayer( "White" )
		local BlackPly = self:GetPlayer( "Black" )
		
		local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
		local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
		self:EndGame( End.Team )
		net.Start( "Chess GameOver" )
			if End.Team=="White" then
				net.WriteTable( {Color(255,255,255), WhiteName, Color(150,255,150), self:GetElo(WhitePly), " has checkmated ", Color(100,100,100), BlackName, Color(150,255,150), self:GetElo(BlackPly),"!"} )
			else
				net.WriteTable( {Color(100,100,100), BlackName, Color(150,255,150), self:GetElo(BlackPly), " has checkmated ", Color(255,255,255), WhiteName, Color(150,255,150), self:GetElo(WhitePly),"!"} )
			end
			net.WriteString( "icon16/medal_gold_2.png" )
		net.Broadcast()
		
		return
	elseif Checkmate then
		local WhitePly = self:GetPlayer( "White" )
		local BlackPly = self:GetPlayer( "Black" )
		
		local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
		local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
		self:EndGame()
		net.Start( "Chess GameOver" )
			net.WriteTable( {Color(150,255,150), "Stalemate! ", Color(255,255,255), WhiteName, Color(150,255,150), self:GetElo(WhitePly), " drew with ", Color(100,100,100), BlackName, Color(150,255,150), self:GetElo(BlackPly),"!"} )
			net.WriteString( "icon16/medal_silver_1.png" )
		net.Broadcast()
		
		return
	end
	
	local NoMaterial = self:NoMaterialCheck()
	if NoMaterial then
		local WhitePly = self:GetPlayer( "White" )
		local BlackPly = self:GetPlayer( "Black" )
		
		local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
		local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
		self:EndGame()
		net.Start( "Chess GameOver" )
			net.WriteTable( {Color(150,255,150), "Insufficient material! ", Color(255,255,255), WhiteName, Color(150,255,150), " drew with ", Color(100,100,100), BlackName, Color(150,255,150),"!"} )
			net.WriteString( "icon16/medal_silver_1.png" )
		net.Broadcast()
		
		return
	end
	
	if IgnoreRepetition then
		self:SetRepetition( false )
	else
		self:DoRepetition()
	end
	return move
end
function ENT:GetElo( ply )
	return IsValid(ply) and " ("..ply:GetChessElo()..")" or ""
end
function ENT:GameName()
	return self.Game or "a board game"
end

if CLIENT then
	-- Stop spectating --
	local function EndSpec(board)
		if IsValid(LocalPlayer()) then
			if LocalPlayer().Chess_Spectating==board then
				LocalPlayer().Chess_Spectating = nil
			end
		end
		
		if not IsValid(board) then return end
		
		if board.SpectatingTable then chat.AddText( HatsChat and {"LINEICON", Icon=Material( "icon16/controller.png" )} or "", Color(150,255,150), "You are no longer spectating this game." ) end
		board.SpectatingTable = false
	end
	function ENT:EndSpectating()
		EndSpec(self)
	end
	
	-- Reset Board --
	local ChessPanel, WagerPanel
	function ENT:Refresh()
		for GridLet,column in pairs( self.Pieces ) do
			for GridNum,square in pairs( column ) do
				if (not IsValid( square.Ent )) or (NumToLetter[square.Ent:GetGridLet()]~=GridLet) or (square.Ent:GetGridNum()~=GridNum) then
					column[GridNum] = nil
				end
			end
		end
	end
	
	-- Do Move --
	function ENT:RequestMove( StartLet, StartNum, EndLet, EndNum)
		if not (StartLet and StartNum and EndLet and EndNum) then return end
		
		net.Start( "Chess ClientRequestMove" )
			net.WriteInt( StartLet+1, 5 )
			net.WriteInt( 8-StartNum, 5 )
			net.WriteInt( EndLet+1, 5 )
			net.WriteInt( 8-EndNum, 5 )
		net.SendToServer()
	end
	
	-- In-Game VGUI --
	local PanelCol = {
		Main = Color(0,0,0,200), ToMove = Color(200,200,200,20), Text = Color(180,180,180),
		White = Color(255,255,255), Black = Color(20,20,20,255),
	}
	surface.CreateFont( "ChessTextSmall", { font = "Arial", size = 16, weight = 600})
	surface.CreateFont( "ChessText", { font = "Arial", size = 24, weight = 600})
	surface.CreateFont( "ChessTextLarge", { font = "Arial", size = 32, weight = 600})
	function ENT:CreateChessPanel()
		EndSpec(self)
		
		local frame = vgui.Create( "DFrame" )
		frame:SetSize(400,155)
		frame:SetPos( (ScrW()/2)-150, ScrH()-170 )
		--frame:SetDraggable( false )
		frame:SetTitle( "" )
		frame:ShowCloseButton( false )
		frame:SetDeleteOnClose( true )
		frame.Paint = function( s,w,h )
			if not IsValid(self) then
				s:Remove()
				gui.EnableScreenClicker( false )
				
				return
			end
			
			draw.RoundedBox( 8, 0, 0, w, h, PanelCol.Main )
		end
		frame:DockMargin( 0,0,0,0 )
		frame:DockPadding( 5,6,5,5 )
		
		-- Panels --
		local IconsPanel = vgui.Create("DPanel", frame)
		IconsPanel:Dock(RIGHT)
		IconsPanel:SetWide(20)
		IconsPanel.Paint = function() end
		
		local TimePnl = vgui.Create( "DPanel", frame )
		TimePnl:Dock( RIGHT )
		TimePnl:SetWide( 90 )
		TimePnl:DockMargin( 2,2,2,2 )
		TimePnl.Paint = function(s,w,h)
			if not IsValid(self) then return end
			
			draw.RoundedBox( 16, 0, 0, w, (h/2)-1, PanelCol.ToMove )
			draw.RoundedBox( 16, 0, (h/2)+1, w, (h/2)-1, PanelCol.ToMove )
			
			draw.SimpleText( string.FormattedTime( math.Round(self:GetWhiteTime() or 300,1), "%02i:%02i" ), "ChessText", w/2, h/4, PanelCol.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( string.FormattedTime( math.Round(self:GetBlackTime() or 300,1), "%02i:%02i" ), "ChessText", w/2, (h/4)+(h/2), PanelCol.Black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		
		local ButtonPanel = vgui.Create( "DPanel", frame )
		ButtonPanel:SetSize( 100, 20 )
		ButtonPanel:Dock( LEFT )
		ButtonPanel:DockMargin( 4,4,4,4 )
		ButtonPanel.Paint = function() end
		
		local MidPanel = vgui.Create("DPanel", frame)
		MidPanel:SetSize(200,125)
		MidPanel:Dock( FILL )
		MidPanel:DockMargin( 4,4,4,4 )
		MidPanel.Paint = function() end
		
		-- Playing As --
		local PlayingAs = vgui.Create( "DPanel", MidPanel )
		PlayingAs:SetTall( 55 )
		PlayingAs:Dock( BOTTOM )
		PlayingAs:DockMargin( 0,0,0,0 )
		PlayingAs.Paint = function( s,w,h )
			draw.RoundedBox( 8, 0, 0, w, h, PanelCol.ToMove )
			draw.SimpleText( "Playing as", "ChessTextSmall", 5, 0, PanelCol.Text )
			
			if not IsValid(self) then return end
			
			local p = LocalPlayer()
			if p==self:GetWhitePlayer() then
				draw.SimpleText( "White", "ChessText", w/2, h/2+5, PanelCol.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			elseif p==self:GetBlackPlayer() then
				draw.SimpleText( "Black", "ChessText", w/2, h/2+5, PanelCol.Black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				draw.SimpleText( "Spectator", "ChessText", w/2, h/2+5, PanelCol.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
		
		-- Current Move --
		local ToMove = vgui.Create( "DPanel", MidPanel )
		ToMove:SetSize(200,125)
		ToMove:Dock( FILL )
		ToMove:DockMargin( 0,0,0,5 )
		ToMove.Paint = function( s,w,h )
			draw.RoundedBox( 8, 0, 0, w, h, PanelCol.ToMove )
			draw.SimpleText( "To move", "ChessTextSmall", 5, 0, PanelCol.Text )
			local state = IsValid(self) and self:GetChessState()
			if not (IsValid( self ) and state) then
				draw.SimpleText( "[N/A]", "ChessTextSmall", w/2, h/2, PanelCol.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				local str = (state==CHESS_WAGER and "Wagers") or (state==CHESS_INACTIVE and "Waiting") or ((state==CHESS_WHITEMOVE or state==CHESS_WHITEPROMO) and "White") or ((state==CHESS_BLACKMOVE or state==CHESS_BLACKPROMO) and "Black") or "N/A"
				local col = (str=="White" and PanelCol.White) or (str=="Black" and PanelCol.Black) or PanelCol.Text
				draw.SimpleText( str, "ChessTextLarge", w/2, h/2+3, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
		
		-- Buttons Sidebar --
		---------------------
		
		frame.OfferDraw = vgui.Create( "DButton", ButtonPanel)
		frame.OfferDraw:SetSize(94,25)
		frame.OfferDraw:Dock( TOP )
		frame.OfferDraw:SetText( "Offer Draw" )
		frame.OfferDraw.DoClick = function( s )
			if (IsValid(self)) and not (self:GetPlaying()) then
				chat.AddText( Color(150,255,150), "You can't offer a draw before the game starts!" )
				return
			end
			net.Start( "Chess DrawOffer" ) net.SendToServer()
		end
		frame.OfferDraw.Think = function(s)
			if IsValid(self) and self:GetDrawOffer()~=PLAYER_NONE then
				if s.TextChanged then return end
				s.TextChanged = true
				
				if LocalPlayer()==self:GetWhitePlayer() then
					if self:GetDrawOffer()==PLAYER_WHITE then
						s:SetText( "Draw Offered" )
					elseif self:GetDrawOffer()==PLAYER_BLACK then
						s:SetText( "Accept Draw Offer" )
					end
				elseif LocalPlayer()==self:GetBlackPlayer() then
					if self:GetDrawOffer()==PLAYER_WHITE then
						s:SetText( "Accept Draw Offer" )
					elseif self:GetDrawOffer()==PLAYER_BLACK then
						s:SetText( "Draw Offered" )
					end
				end
			elseif s.TextChanged then
				s.TextChanged = false
				s:SetText( "Offer Draw" )
			end
		end
		
		local Resign = vgui.Create( "DButton", ButtonPanel)
		Resign:SetSize(94,25)
		Resign:Dock( TOP )
		Resign:SetText( "Resign" )
		Resign.DoClick = function( s )
			net.Start( "Chess ClientResign" ) net.SendToServer()
		end
		
		
		local MoveLimit = vgui.Create( "DButton", ButtonPanel)
		MoveLimit:SetSize(94,25)
		MoveLimit:Dock( TOP )
		--MoveLimit:Dock( FILL )
		MoveLimit:SetText( "Draw (50 moves)" )
		MoveLimit.DoClick = function( s )
			net.Start( "Chess ClientCallDraw" )
				net.WriteUInt( CHESS_DRAW_50, 2 )
			net.SendToServer()
		end
		MoveLimit:SetEnabled( false )
		MoveLimit.Think = function( s )
			MoveLimit:SetEnabled( IsValid(self) and self:GetMoveCount()>=50 )
		end
		
		local Repetition = vgui.Create( "DButton", ButtonPanel)
		Repetition:SetSize(94,25)
		Repetition:Dock( TOP )
		Repetition:SetText( "Draw (Repetition)" )
		Repetition.DoClick = function( s )
			net.Start( "Chess ClientCallDraw" )
				net.WriteUInt( CHESS_DRAW_3, 2 )
			net.SendToServer()
		end
		Repetition:SetEnabled( false )
		Repetition.Think = function( s )
			Repetition:SetEnabled( IsValid(self) and self:GetRepetition() )
		end
		
		local DermaMode = vgui.Create( "DButton", ButtonPanel)
		DermaMode:SetSize(94,25)
		DermaMode:Dock( TOP )
		DermaMode:SetText( "Toggle 2D Mode" )
		DermaMode.DoClick = function( s )
			if IsValid(Chess_2DDermaPanel) then
				Chess_2DDermaPanel:Remove()
			else
				Chess_Open2DBoard( self )
			end
		end
		
		-- Icons sidebar --
		-------------------
		
		local resignIcon = vgui.Create( "DButton", IconsPanel )
		resignIcon:SetImage( "icon16/door_in.png" )
		resignIcon:SetSize( 16,20 )
		-- resignIcon:SetPos( 377,0 )
		resignIcon:Dock(TOP)
		resignIcon:SetText( "" )
		resignIcon.DoClick = function(s)
			net.Start( "Chess ClientResign" ) net.SendToServer()
		end
		resignIcon.Paint = function() end
		resignIcon:SetTooltip( "Resign" )
		
		local toggleSide = vgui.Create( "DButton", IconsPanel )
		toggleSide:SetImage( "icon16/arrow_rotate_clockwise.png" )
		toggleSide:Dock(TOP)
		toggleSide:SetSize( 16,20 )
		toggleSide:SetPos( 377,20 )
		toggleSide:SetText( "" )
		toggleSide.DoClick = function(s)
			self.FlipView = not self.FlipView
		end
		toggleSide.Paint = function() end
		toggleSide:SetTooltip( "Rotate View" )
		
		local toggleGridLetters = vgui.Create( "DCheckBox", IconsPanel )
		toggleGridLetters:SetImage( "icon16/font.png" )
		toggleGridLetters:Dock(TOP)
		toggleGridLetters:SetSize( 16,20 )
		toggleGridLetters:SetPos( 377,20 )
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
		toggleGridLetters:SetTooltip( "Toggle Coordinates" )
		
		return frame
	end
	local function CreateWagerPanel( board )
		local frame = vgui.Create( "DFrame" )
		frame:SetSize(200,70)
		frame:SetPos( (ScrW()/2)-100, (ScrH()/2)-75 )
		--frame:SetDraggable( false )
		frame:SetTitle( "" )
		frame:ShowCloseButton( false )
		frame:SetDeleteOnClose( true )
		frame.Paint = function( s,w,h )
			draw.RoundedBox( 8, 0, 0, w, h, PanelCol.Main )
		end
		frame.Think = function( s )
			if board:GetChessState()~=CHESS_WAGER then
				s:Remove()
			end
		end
		frame:DockMargin( 0,0,0,0 )
		frame:DockPadding( 5,6,5,5 )
		
		local SliderPanel = vgui.Create( "DPanel", frame )
		SliderPanel:SetSize(200,20)
		SliderPanel:Dock( TOP )
		SliderPanel:DockPadding( 2,2,2,2 )
		SliderPanel.Paint = function( s,w,h )
			draw.RoundedBox( 4, 0, 0, w, h, PanelCol.ToMove )
		end
		
		local WagerNum = vgui.Create( "DNumSlider", SliderPanel )
		WagerNum:SetSize(200,20)
		WagerNum:Dock( FILL )
		WagerNum:SetText( "Wager" )
		WagerNum.Label:SizeToContents()
		WagerNum:SetMinMax( 0, math.Clamp(
			((board:GetPSWager() and LocalPlayer():PS_GetPoints()) or ((not board:GetPSWager()) and LocalPlayer():getDarkRPVar( "money" ))) or 0,
			0, 16777215) )
		WagerNum:SetDark( true )
		WagerNum:SetDecimals( 0 )
		WagerNum:SetValue( 0 )
		--WagerNum.Slider:SetLockY( 10 )
		WagerNum:SizeToContents()
		
		local ButtonPanel = vgui.Create( "DPanel", frame )
		ButtonPanel:SetSize(200, 30)
		ButtonPanel:Dock( BOTTOM )
		ButtonPanel.Paint = function() end
		
		local AcceptButton = vgui.Create( "DButton", ButtonPanel )
		AcceptButton:SetWide( 61 )
		AcceptButton:SetText( "Accept" )
		AcceptButton:SetEnabled( false )
		AcceptButton:Dock( LEFT )
		AcceptButton.WagerVal = -1
		AcceptButton.Think = function( s )
			if LocalPlayer()==board:GetWhitePlayer() then
				if board:GetBlackWager() and board:GetBlackWager()>=0 then
					s:SetEnabled( true )
					s:SetText( tostring(board:GetBlackWager()) )
					s.WagerVal = board:GetBlackWager()
				end
			elseif LocalPlayer()==board:GetBlackPlayer() then
				if board:GetWhiteWager() and board:GetWhiteWager()>=0 then
					s:SetEnabled( true )
					s:SetText( tostring(board:GetWhiteWager()) )
					s.WagerVal = board:GetWhiteWager()
				end
			end
		end
		AcceptButton.DoClick = function()
			net.Start( "Chess ClientWager" )
				net.WriteUInt( math.Clamp(AcceptButton.WagerVal, 0, 16777215), 24 )
			net.SendToServer()
		end
		
		local ExitButton = vgui.Create( "DButton", ButtonPanel )
		ExitButton:SetWide( 61 )
		ExitButton:SetText( "Exit" )
		ExitButton:Dock( RIGHT )
		ExitButton.DoClick = function( s )
			net.Start( "Chess ClientResign" ) net.SendToServer()
		end
		
		local WagerButton = vgui.Create( "DButton", ButtonPanel )
		WagerButton:SetText( "Wager" )
		WagerButton:Dock( FILL )
		WagerButton:DockMargin(5,0,5,0)
		WagerButton.DoClick = function( s )
			net.Start( "Chess ClientWager" )
				net.WriteUInt( WagerNum:GetValue() or 0, 24 )
			net.SendToServer()
		end
		frame:MakePopup()
		
		return frame
	end
	
	-- Camera control --
	local IsInChess, ScreenPos, ScreenAng, ActiveBoard
	local function ChessSeatCam( ply, pos, ang, fov, nearz, farz )
		if ply:GetNWBool( "IsInChess", false ) or IsValid(ply.Chess_Spectating) then
			ActiveBoard = nil
			if ply:GetNWBool( "IsInChess", false ) then
				ActiveBoard = ply:GetNWEntity( "ActiveChessBoard", nil )
			else
				ActiveBoard = ply.Chess_Spectating
			end
			if not IsValid(ActiveBoard) then return end
			
			if ply:GetNWBool( "IsInChess", false ) then
				if not IsValid(ChessPanel) then
					ChessPanel = IsValid(ActiveBoard.ChessPanel) and ActiveBoard.ChessPanel or ActiveBoard:CreateChessPanel() --Autorefresh fix
					ActiveBoard.ChessPanel = ChessPanel
				end
				if ActiveBoard:GetChessState()==CHESS_WAGER then
					if not IsValid(WagerPanel) then
						WagerPanel = IsValid(ActiveBoard.WagerPanel) and ActiveBoard.WagerPanel or CreateWagerPanel( ActiveBoard ) --Autorefresh fix
						ActiveBoard.WagerPanel = WagerPanel
					end
				elseif IsValid( WagerPanel ) then
					WagerPanel:Remove()
				end
			end
			
			local ViewPos = ActiveBoard:GetPos() + Vector(0,0,30)
			if ply.Chess_Spectating then
				ply.Chess_ViewAngle = ply.Chess_ViewAngle or ActiveBoard:GetRight()*-20
				
				local ctime = RealTime()
				local delta = ctime - (ActiveBoard.LastCameraUpdate or ctime)
				ActiveBoard.LastCameraUpdate = ctime
				
				ply.Chess_ViewMomentum = ply.Chess_ViewMomentum or math.random(-100,100)
				
				
				ply.Chess_ViewAngle:Rotate( Angle(0,ply.Chess_ViewMomentum*delta,0) )
				ply.Chess_ViewMomentum = math.Approach( ply.Chess_ViewMomentum, 0, delta*150 )
				
				local IsMouseDown = input.IsMouseDown( MOUSE_LEFT )
				local MouseClick = IsMouseDown and (not ActiveBoard.WasMouseDown)
				
				local mouseX = gui.MouseX()
				
				if IsMouseDown and not MouseClick then
					ply.Chess_ViewMomentum = ((ActiveBoard.LastX or mouseX) - mouseX) * delta * 500
				end
				
				ActiveBoard.LastX = mouseX
				ActiveBoard.WasMouseDown = IsMouseDown
				
				ViewPos = ViewPos + ply.Chess_ViewAngle
			elseif ply==ActiveBoard:GetBlackPlayer() then
				ViewPos = ViewPos + ActiveBoard:GetRight() * (ActiveBoard.FlipView and (-20) or 20)
			else
				ViewPos = ViewPos + ActiveBoard:GetRight() * (ActiveBoard.FlipView and 20 or (-20))
			end
			
			local ViewAng = (ActiveBoard:GetPos()-ViewPos):Angle()
			if input.IsKeyDown( KEY_LALT ) then
				ViewAng = ang
				gui.EnableScreenClicker(false)
			else
				gui.EnableScreenClicker(true)
			end
			local view = {
				origin = ViewPos,
				angles = ViewAng,
				fov = fov,
				znear = nearz,
				zfar = farz,
				drawviewer = true,
			}
			
			IsInChess = true
			ScreenPos = ViewPos
			ScreenAng = ViewAng
			
			return view
		elseif IsInChess then --Exit
			gui.EnableScreenClicker(false)
			
			IsInChess = false
			ScreenPos = nil
			ScreenAng = nil
			ActiveBoard = nil
		else --Not in seat, and not just exited. Don't disable mouse here
			if IsValid( ChessPanel ) then ChessPanel:Remove() end
			if IsValid( WagerPanel ) then WagerPanel:Remove() end
			IsInChess = false
			ScreenPos = nil
			ScreenAng = nil
			ActiveBoard = nil
		end
	end
	hook.Add( "CalcView", "ChessBoardSeatCam", ChessSeatCam )
	
	function ENT:ResetHighlights()
		self.Highlight = {-1,-1}
		self.Selected = {-1,-1}
		self.Moves = {}
	end
	
	function ENT:GetTraceFilter()
		local tbl = player.GetAll()--{self}
		
		for GridLet,column in pairs( self.Pieces ) do
			for GridNum,square in pairs( column ) do
				if (IsValid( square.Ent )) then table.insert( tbl, square.Ent ) end
			end
		end
		
		return tbl
	end
	
	local ColHover,ColText,ColSel = Color(0,255,0,50),Color(50,50,50,200),Color(150,50,50,150)
	local ColBlack,ColWhite,ColMove = Color(0,0,0,120),Color(255,255,255,10),Color(50,50,150,150)
	function ENT:Draw()
		if self.IsInCheck then
			if not self.PlayedCheckSound then
				sound.Play( self.CheckSound, self:GetPos() )
				self.PlayedCheckSound = true
			end
		else
			self.PlayedCheckSound = nil
		end
		
		if IsValid(Chess_2DDermaPanel) then return end -- In 2D mode, skip 3D rendering
		local ctime = CurTime()
		
		-- Scale model
		if (self.LastReScaleTime or 0)+10<ctime then self:EnableMatrix("RenderMultiply", ChessScale) self.LastReScaleTime=ctime end
		
		-- Scale pieces
		if not self.PiecesEnts then
			self.PiecesEnts = {}
			for i=1,16 do
				self.PiecesEnts[i] = ClientsideModel( self.Models["WhitePawn"] )
				self.PiecesEnts[i]:SetNoDraw( true )
				self.PiecesEnts[i]:EnableMatrix( "RenderMultiply", ChessScale )
			end
		end
		
		-- Track framerate so we can skip during lag
		if FrameTime()>=0.33 and not self.SpectatingTable then --Less than 30 fps
			if self.FPSFailTimeout and self.FPSFailTimeout<ctime then
				self.FPSFailCount = 0
			end
			
			if (not self.FPSNextCheck) or self.FPSNextCheck<=ctime then
				self.FPSNextCheck = ctime+0.1
				self.FPSFailTimeout = ctime+2
				self.FPSFailCount = (self.FPSFailCount or 0)+1
				if self.FPSFailCount>=30 then
					self.LowFPSCheck = ctime+5
				end
			end
		end
		local InChessGame = LocalPlayer():GetNWBool("IsInChess",false)
		
		if self:GetPos()~=self.LastSquaresUpdatePos then
			self:RefreshSquares()
		end
		
		-- Draw pieces if in game, spectating, or high enough FPS
		if InChessGame or self.SpectatingTable or (not (self.LowFPSCheck and self.LowFPSCheck>ctime)) then
			local i=0
			for let,column in pairs( self.Pieces ) do
				for num,square in pairs( column ) do
					if not (square.Team and square.Class) then continue end
					i=(i or 0)+1
					local pos = self:GetSquarePos( let, num )
					
					if square.Moving and square.MoveStart then
						local delta = math.Clamp( (RealTime()-square.MoveStart)/self.MoveTime, 0,1 )
						if delta==1 or (not delta) then
							square.Moving = false
							sound.Play( self.MoveSound, pos )
						else
							local Height = (delta*6)>=3 and (6-(delta*6)) or (delta*6)
							pos = Vector(
								square.MoveFrom[1] + (pos[1]-square.MoveFrom[1])*delta,
								square.MoveFrom[2] + (pos[2]-square.MoveFrom[2])*delta,
								pos[3] + Height
							)
						end
					end
					
					if not IsValid( self.PiecesEnts[i] ) then
						self.PiecesEnts[i] = ClientsideModel( self.Models["WhitePawn"] )
						self.PiecesEnts[i]:SetNoDraw( true )
						self.PiecesEnts[i]:EnableMatrix( "RenderMultiply", ChessScale )
					end
					if self.PiecesEnts[i]:GetPos()~=pos then self.PiecesEnts[i]:SetPos( pos ) end
					if self.PiecesEnts[i]:GetModel()~=self.Models[ square.Team .. square.Class ] then
						self.PiecesEnts[i]:SetModel( self.Models[ square.Team .. square.Class ] )
					end
					self.PiecesEnts[i]:DrawModel()
					if self.DrawDouble and self.DrawDouble[ square.Class ] then
						self.PiecesEnts[i]:SetModel( self.Models[ "dama" ] ) --Prevents invisible pieces
						self.PiecesEnts[i]:SetModel( self.Models[ square.Team .. square.Class ] ) 
						self.PiecesEnts[i]:SetPos( pos + Vector(0,0,(self.PiecesEnts[i]:OBBMaxs()[3]-self.PiecesEnts[i]:OBBMins()[3])*0.1225) )
						self.PiecesEnts[i]:DrawModel()
					end
				end
			end
		end
		self:DrawModel()
		
		-- Remove highlights
		if not InChessGame then
			self.Highlight = nil
			self.Selected = nil
			self.Moves = nil
			
			self.FlipView = false
			
			if not cvars.Bool("chess_debug") then return end
		end
		
		self.Highlight = self.Highlight or {-1,-1}
		self.Selected = self.Selected or {-1,-1}
		self.Moves = self.Moves or {}
		local IsMouseDown = input.IsMouseDown( MOUSE_LEFT )
		local MouseClick = IsMouseDown and (not self.WasMouseDown)
		if ActiveBoard==self then
			self.Highlight[1]=(-1) self.Highlight[2]=(-1)
			local x,y = gui.MouseX(), gui.MouseY()
			
			local Target = ScreenPos + (gui.ScreenToVector( x, y )*10000)
			
			local tr = util.TraceLine( {start=ScreenPos, endpos=Target, filter=self:GetTraceFilter()} )
			
			local pos = self:WorldToLocal( tr.HitPos )
			local x,y = -1,-1
			if pos[2]>self.TopLeft[2] and pos[3]>self.TopLeft[3] then
				for i=0,8 do --Fall off the top
					if pos[2]<(self.TopLeft[2]+(self.RealW*i)) then break end
					y = i
				end
				for i=0,8 do
					if pos[3]<(self.TopLeft[3]+(self.RealH*i)) then break end
					x = i
				end
			end
			self.Highlight = {x,y}
			if self.Highlight[1]==8 then self.Highlight[1] = -1 end
			if self.Highlight[2]==8 then self.Highlight[2] = -1 end
			
			if MouseClick then
				if self.Selected and self:GetTableGrid( self.Moves, x, y ) then
					self:RequestMove( self.Selected[1], self.Selected[2], x, y )
					self:ResetHighlights()
				else
					self:ResetHighlights()
					self.Selected = {x,y}
					self.Moves = self:GetMove( NumToLetter[x+1], 8-y )
				end
			end
		else
			self.Selected[1]=(-1) self.Selected[2]=(-1)
			self.Highlight[1]=(-1) self.Highlight[2]=(-1)
			self.Moves = {}
			
			if not cvars.Bool("chess_debug") then return end
		end
		
		local pos = self:LocalToWorld( self.TopLeft )
		local ang = self:GetUp():Angle()
		
		cam.Start3D2D( pos, ang, 0.05 )
			for i=0,7 do
				for n=0,7 do
					local xpos = self.SquareW*i
					local ypos = self.SquareH*n
					
					local square = self:GetTableGrid( self.Pieces, i,n )
					if square and IsValid(square.Ent) then
						draw.RoundedBox( 0, xpos, ypos, self.SquareW, self.SquareH, square.Ent:GetWhite() and ColWhite or ColBlack )
					end
					if self.Highlight[1]==i and self.Highlight[2]==n then
						draw.RoundedBox( 0, xpos, ypos, self.SquareW, self.SquareH, ColHover )
					end
					if self:GetTableGrid( self.Moves, i, n ) then
						draw.RoundedBox( 0, xpos, ypos, self.SquareW, self.SquareH, ColMove )
					end
					if self.Selected[1]==i and self.Selected[2]==n then
						draw.RoundedBox( 0, xpos, ypos, self.SquareW, self.SquareH, ColSel )
					end
					if cvars.Bool("chess_debug") then
						draw.RoundedBox( 0, xpos, ypos, self.SquareW, self.SquareH, Color(255,255,255, 50) )
					end
					
					if cvars.Bool("chess_gridletters") then
						ypos = ypos + self.SquareH - 20
						local str = NumToLetter[i+1]..tostring(8-n)
						draw.SimpleText( str, "ChessTextSmall", xpos+6, ypos+1, PanelCol.Black )
						draw.SimpleText( str, "ChessTextSmall", xpos+5, ypos,   PanelCol.White )
					end
				end
			end
		cam.End3D2D()
		
		self.WasMouseDown = input.IsMouseDown( MOUSE_LEFT )
	end
	
	-- Start Spectating --
	function ENT:GetSpectateUse(ply,key)
		if ply~=LocalPlayer() then return end
		if key~=IN_USE then return end
		if input.IsMouseDown( MOUSE_LEFT ) then return end
		
		if CurTime()<(self.Spec_LastPoll or 0)+1 then return end
		self.Spec_LastPoll = CurTime()
		
		if ply==self:GetWhitePlayer() or ply==self:GetBlackPlayer() then
			EndSpec(self)
			return
		end
		
		local tr = util.TraceLine( {start=ply:EyePos(), endpos=ply:EyePos()+(ply:GetAimVector()*150), filter=ply} )
		if not (tr.Hit and IsValid(tr.Entity)) then EndSpec(self) return end
		if (tr.Entity~=self:GetTableEnt()) then EndSpec(self) return end
		
		if not self.SpectatingTable then
			chat.AddText( HatsChat and {"LINEICON", Icon=Material( "icon16/controller.png" )} or "", Color(150,255,150), "You are now spectating this game." )
		end
		self.SpectatingTable = true
		ply.Chess_Spectating = self
		
		local frame = vgui.Create( "DFrame" )
		frame:SetSize(300,135)
		frame:SetPos( (ScrW()/2)-100, ScrH()-150 )
		frame:SetTitle( "" )
		frame:ShowCloseButton( false )
		frame:SetDeleteOnClose( true )
		frame.Paint = function( s,w,h )
			if (not (IsValid(self) and self.SpectatingTable)) then
				s:Remove()
				gui.EnableScreenClicker( false )
				
				return
			end
			
			draw.RoundedBox( 8, 0, 0, w, h, PanelCol.Main )
		end
		frame:DockMargin( 0,0,0,0 )
		frame:DockPadding( 5,6,5,5 )
		-- frame:MakePopup()
		
		-- Turn Timer --
		local TimePnl = vgui.Create( "DPanel", frame )
		TimePnl:Dock( RIGHT )
		TimePnl:SetWide( 100 )
		TimePnl:DockMargin( 2,2,2,2 )
		TimePnl.Paint = function(s,w,h)
			if not IsValid(self) then return end
			
			draw.RoundedBox( 16, 0, 0, w, (h/2)-1, PanelCol.ToMove )
			draw.RoundedBox( 16, 0, (h/2)+1, w, (h/2)-1, PanelCol.ToMove )
			
			draw.SimpleText( string.FormattedTime( math.Round(self:GetWhiteTime() or 300,1), "%02i:%02i" ), "ChessText", w/2, h/4, PanelCol.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( string.FormattedTime( math.Round(self:GetBlackTime() or 300,1), "%02i:%02i" ), "ChessText", w/2, (h/4)+(h/2), PanelCol.Black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		
		-- Layout --
		local JoinGamePanel = vgui.Create( "DPanel", frame )
		JoinGamePanel:SetSize( 100, 20 )
		JoinGamePanel:Dock( BOTTOM )
		JoinGamePanel.Paint = function() end
		local ButtonPanel = vgui.Create( "DPanel", frame )
		ButtonPanel:SetSize( 100, 20 )
		ButtonPanel:Dock( BOTTOM )
		ButtonPanel.Paint = function() end
		
		-- Move Info --
		local ToMove = vgui.Create( "DPanel", frame )
		ToMove:SetSize(200,80)
		ToMove:Dock( FILL )
		ToMove.Paint = function( s,w,h )
			draw.RoundedBox( 4, 0, 0, w, h, PanelCol.ToMove )
			draw.SimpleText( "To move", "ChessTextSmall", 5, 0, PanelCol.Text )
			local state = IsValid(self) and self:GetChessState()
			if not (IsValid( self ) and state) then
				draw.SimpleText( "[N/A]", "ChessTextSmall", w/2, h/2, PanelCol.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				local str = (state==CHESS_WAGER and "Wagers") or (state==CHESS_INACTIVE and "Waiting") or ((state==CHESS_WHITEMOVE or state==CHESS_WHITEPROMO) and "White") or ((state==CHESS_BLACKMOVE or state==CHESS_BLACKPROMO) and "Black") or "N/A"
				local col = (str=="White" and PanelCol.White) or (str=="Black" and PanelCol.Black) or PanelCol.Text
				draw.SimpleText( str, "ChessTextLarge", w/2, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
		
		-- Toggle 2D
		local DermaMode = vgui.Create( "DButton", ButtonPanel)
		DermaMode:SetSize(94,20)
		DermaMode:Dock( LEFT )
		DermaMode:SetText( "Toggle 2D Mode" )
		DermaMode.DoClick = function( s )
			if IsValid(Chess_2DDermaPanel) then
				Chess_2DDermaPanel:Remove()
			else
				Chess_Open2DBoard( self )
			end
		end
		
		-- Leave Spectating --
		local StopSpec = vgui.Create( "DButton", ButtonPanel)
		StopSpec:SetSize(94,20)
		StopSpec:Dock( RIGHT )
		StopSpec:SetText( "Stop Spectating" )
		StopSpec.DoClick = function( s )
			EndSpec(self)
		end
		
		-- Join Game --
		local JoinWhite = vgui.Create( "DButton", JoinGamePanel)
		JoinWhite:SetSize(94,20)
		JoinWhite:Dock( LEFT )
		JoinWhite:SetText( "Play as White" )
		JoinWhite.DoClick = function( s )
			net.Start( "Chess RequestSeat" )
				net.WriteEntity( self )
				net.WriteBool( true )
			net.SendToServer()
		end
		local JoinBlack = vgui.Create( "DButton", JoinGamePanel)
		JoinBlack:SetSize(94,20)
		JoinBlack:Dock( RIGHT )
		JoinBlack:SetText( "Play as Black" )
		JoinBlack.DoClick = function( s )
			net.Start( "Chess RequestSeat" )
				net.WriteEntity( self )
				net.WriteBool( false )
			net.SendToServer()
		end
	end
	
	-- Render Stuff --
	local function CleanupPlayerDraw(ply)
		if ply.Chess_OldCol then
			ply:SetColor( ply.Chess_OldCol )
			ply.Chess_OldCol = nil
		end
		if ply.Chess_OldRenderMode then
			ply:SetRenderMode( ply.Chess_OldRenderMode )
			ply.Chess_OldRenderMode = nil
		end
	end
	function ENT:PrePlayerDraw(ply)
		if not IsValid(ply) then return end
		
		local client = LocalPlayer()
		if not client:GetNWBool( "IsInChess", false ) then return CleanupPlayerDraw(ply) end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if board~=self then return end
		
		local c = ply:GetColor()
		ply.Chess_OldCol = ply.Chess_OldCol or c
		ply.Chess_OldRenderMode = ply.Chess_OldRenderMode or ply:GetRenderMode()
		
		ply:SetColor( Color(c.r, c.g, c.b, 50) )
		ply:SetRenderMode( RENDERMODE_TRANSALPHA )
	end
	
	-- net.Receive( "Chess DrawOffer", function()
		-- if IsValid( ChessPanel ) and IsValid( ChessPanel.OfferDraw ) then
			-- ChessPanel.OfferDraw:SetText( "Accept Draw Offer" )
		-- end
	-- end)
	net.Receive( "Chess GameOver", function() -- Now used for all messages
		local tbl = net.ReadTable()
		local emote = net.ReadString()
		if HatsChat then
			local Mat
			if emote and emote~="" then
				Mat = Material(emote)
			end
			if (not Mat) then
				Mat = Material( "icon16/controller.png" )
			end
			if not Mat:IsError() then
				table.insert(tbl, 1, {"LINEICON", Icon=Mat} )
			end
		end
		chat.AddText( unpack( tbl ) )
	end)
	net.Receive( "Chess PromotionSelection", function()
		local File = net.ReadInt( 5 )
		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 100, 225 )
		Frame:SetPos( (ScrW()/2) - 50, (ScrH()/2)-112 )
		Frame:SetDraggable( false )
		Frame:ShowCloseButton( false )
		Frame:DockMargin( 5,5,5,5 )
		Frame:DockPadding( 5,5,5,5 )
		Frame:MakePopup()
		Frame:SetTitle( "" )
		Frame.Paint = function( s,w,h )
			draw.RoundedBox( 4, 0, 0, w, h, Color(0,0,0,150) )
		end
		
		local Queen = vgui.Create( "DButton", Frame )
		Queen.DoClick = function( s )
			net.Start( "Chess PromotionSelection" )
				net.WriteString( "Queen" )
				net.WriteInt( File, 5 )
			net.SendToServer()
			Frame:Remove()
		end
		Queen:SetText( "Queen" )
		Queen:Dock( TOP )
		Queen:SetSize( 90, 50 )
		Queen:DockMargin( 0,0,0,0 )
		
		local Rook = vgui.Create( "DButton", Frame )
		Rook.DoClick = function( s )
			net.Start( "Chess PromotionSelection" )
				net.WriteString( "Rook" )
				net.WriteInt( File, 5 )
			net.SendToServer()
			Frame:Remove()
		end
		Rook:SetText( "Rook" )
		Rook:Dock( TOP )
		Rook:SetSize( 90, 50 )
		Rook:DockMargin( 0,5,0,0 )
		
		local Bishop = vgui.Create( "DButton", Frame )
		Bishop.DoClick = function( s )
			net.Start( "Chess PromotionSelection" )
				net.WriteString( "Bishop" )
				net.WriteInt( File, 5 )
			net.SendToServer()
			Frame:Remove()
		end
		Bishop:SetText( "Bishop" )
		Bishop:Dock( TOP )
		Bishop:SetSize( 90, 50 )
		Bishop:DockMargin( 0,5,0,0 )
		
		local Knight = vgui.Create( "DButton", Frame )
		Knight.DoClick = function( s )
			net.Start( "Chess PromotionSelection" )
				net.WriteString( "Knight" )
				net.WriteInt( File, 5 )
			net.SendToServer()
			Frame:Remove()
		end
		Knight:SetText( "Knight" )
		Knight:Dock( TOP )
		Knight:SetSize( 90, 50 )
		Knight:DockMargin( 0,5,0,0 )
	end)
	
	net.Receive( "Chess Update", function()
		local board = net.ReadEntity()
		local pieces = net.ReadTable()
		
		local Move1 = net.ReadTable()
		local Move2 = net.ReadTable()
		
		if IsValid(board) and pieces then
			board.Pieces = pieces
			if Move1.To then
				if Move1.From then
					board.Pieces[Move1.To[1]][Move1.To[2]].Moving = true
					board.Pieces[Move1.To[1]][Move1.To[2]].MoveStart = RealTime()
					board.Pieces[Move1.To[1]][Move1.To[2]].MoveFrom = board:GetSquarePos( Move1.From[1],Move1.From[2] )
				else
					sound.Play( board.MoveSound, board:GetSquarePos( Move1.To[1],Move1.To[2]) or board:GetPos() )
				end
			end
			if Move2.To then
				if Move2.From then
					board.Pieces[Move2.To[1]][Move2.To[2]].Moving = true
					board.Pieces[Move2.To[1]][Move2.To[2]].MoveStart = RealTime()
					board.Pieces[Move2.To[1]][Move2.To[2]].MoveFrom = board:GetSquarePos( Move2.From[1],Move2.From[2] )
				else
					sound.Play( board.MoveSound, board:GetSquarePos( Move2.To[1],Move2.To[2]) or board:GetPos()  )
				end
			end
			
			if Move1.To and board.Pieces and board.Pieces[Move1.To[1]] and board.Pieces[Move1.To[1]][Move1.To[2]] then
				board.IsInCheck = board:CheckForCheck( board.Pieces, Move1.To and board.Pieces[Move1.To[1]][Move1.To[2]].Team~="White" )
			else
				board.IsInCheck = false
			end
		end
	end)
end
if SERVER then
	net.Receive( "Chess ClientRequestMove", function(len, ply)
		if not IsValid(ply) then return end
		if not (ply:GetNWBool( "IsInChess", false )) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if not IsValid(board) then return end
		
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		
		if (not cvars.Bool( "chess_debug" )) and ((IsWhite and board:GetChessState()~=CHESS_WHITEMOVE) or ((not IsWhite) and board:GetChessState()~=CHESS_BLACKMOVE)) then return end
		
		local StartLet, StartNum =	NumToLetter[math.Clamp(net.ReadInt(5),1,8)], math.Clamp(net.ReadInt(5),1,8)
		local EndLet, EndNum =		NumToLetter[math.Clamp(net.ReadInt(5),1,8)], math.Clamp(net.ReadInt(5),1,8)
		
		local StartSquare = board:GetSquare( StartLet, StartNum )
		if not StartSquare then return end
		
		if (not cvars.Bool( "chess_debug" )) and ((IsWhite and board:SquareTeam(StartSquare)~="White") or ((not IsWhite) and board:SquareTeam(StartSquare)~="Black")) then return end
		
		if IsWhite and board:GetDrawOffer()==PLAYER_WHITE then
			board:SetDrawOffer( PLAYER_NONE )
		elseif (not IsWhite) and board:GetDrawOffer()==PLAYER_BLACK then
			board:SetDrawOffer( PLAYER_NONE )
		end
		
		board:DoMove( StartLet, StartNum, EndLet, EndNum )
	end)
	
	net.Receive( "Chess DrawOffer", function( len,ply )
		if not IsValid(ply) then return end
		if not (ply:GetNWBool( "IsInChess", false )) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if not IsValid(board) then return end
		
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		
		if board:GetDrawOffer()==(IsWhite and PLAYER_BLACK or PLAYER_WHITE) then
			local WhitePly = board:GetPlayer( "White" )
			local BlackPly = board:GetPlayer( "Black" )
			
			local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
			local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
			board:EndGame()
			net.Start( "Chess GameOver" )
				net.WriteTable( {Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly), " and ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly), " have agreed to draw."} )
				net.WriteString( "icon16/medal_silver_1.png" )
			net.Broadcast()
		else
			board:SetDrawOffer( IsWhite and PLAYER_WHITE or PLAYER_BLACK )
			-- board.DrawOffer = IsWhite and "White" or "Black"
			-- net.Start( "Chess DrawOffer" )
			-- net.Send( board:GetPlayer( IsWhite and "Black" or "White" ) )
		end
	end)
	net.Receive( "Chess ClientCallDraw", function( len,ply )
		if not IsValid(ply) then return end
		if not (ply:GetNWBool( "IsInChess", false )) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if not IsValid(board) then return end
		
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		
		local DrawType = net.ReadUInt( 2 )
		if DrawType==CHESS_DRAW_50 then
			if not cvars.Bool("chess_limitmoves") then ply:ChatPrint( "This option is disabled on this server." ) return end
			if board:GetMoveCount()<50 then ply:ChatPrint( "This option is available when 50 moves pass without a pawn move or capture." ) return end
			local WhitePly = board:GetPlayer( "White" )
			local BlackPly = board:GetPlayer( "Black" )
			
			local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
			local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
			board:EndGame()
			net.Start( "Chess GameOver" )
				if IsWhite then
					net.WriteTable( {Color(150,255,150), "50 moves! ", Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly), " has called a draw against ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly),"!"} )
				else
					net.WriteTable( {Color(150,255,150), "50 moves! ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly), " has called a draw against ", Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly),"!"} )
				end
				net.WriteString( "icon16/medal_bronze_1.png" )
			net.Broadcast()
		elseif DrawType==CHESS_DRAW_3 then
			if not board:GetRepetition() then ply:ChatPrint( "This option is available when the board is in the same position three times." ) return end
			local WhitePly = board:GetPlayer( "White" )
			local BlackPly = board:GetPlayer( "Black" )
			
			local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
			local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
			board:EndGame()
			net.Start( "Chess GameOver" )
				if IsWhite then
					net.WriteTable( {Color(150,255,150), "Threefold repetition! ", Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly), " has called a draw against ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly),"!"} )
				else
					net.WriteTable( {Color(150,255,150), "Threefold repetition! ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly), " has called a draw against ", Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly),"!"} )
				end
				net.WriteString( "icon16/medal_bronze_1.png" )
			net.Broadcast()
		end
	end)
	net.Receive( "Chess ClientWager", function( len,ply )
		if not IsValid(ply) then return end
		if not (ply:GetNWBool( "IsInChess", false )) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if not IsValid(board) then return end
		
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		
		if board:GetChessState()~=CHESS_WAGER then return end
		
		local wager = net.ReadUInt( 24 )
		if (not wager) or wager<0 then return end
		if board:GetPSWager() then
			if not ply:PS_HasPoints( wager ) then return end
		else
			if wager>(ply:getDarkRPVar( "money" ) or 0) then return end
		end
		
		if IsWhite then
			if board:GetBlackWager()>=0 and wager==board:GetBlackWager() then
				board:SetPlaying( true )
				board:SetChessState( board.StartState )
				
				local PlyName = ply:Nick() or "[N/A]"
				local OtherPly = board:GetPlayer( "Black" )
				local OtherName = IsValid(OtherPly) and OtherPly:Nick() or "[N/A]"
				net.Start( "Chess GameOver" )
					if IsWhite then
						net.WriteTable( {Color(255,255,255), PlyName, Color(150,255,150), board:GetElo(ply), " has challenged ", Color(100,100,100), OtherName, Color(150,255,150), board:GetElo(OtherPly)," to "..board:GameName().."!"} )
					else
						net.WriteTable( {Color(100,100,100), PlyName, Color(150,255,150), board:GetElo(ply), " has challenged ", Color(255,255,255), OtherName, Color(150,255,150), board:GetElo(OtherPly)," to "..board:GameName().."!"} )
					end
				net.Broadcast()
				
				board.WagerValue = wager
				
				if board:GetPSWager() then
					OtherPly:PS_TakePoints( board.WagerValue )
					ply:PS_TakePoints( board.WagerValue )
				else
					if OtherPly.addMoney then OtherPly:addMoney( -board.WagerValue ) else OtherPly:SetDarkRPVar( "money", (OtherPly:getDarkRPVar( "money" ) or 0) - board.WagerValue ) end
					if ply.addMoney then ply:addMoney( -board.WagerValue ) else ply:SetDarkRPVar( "money", (ply:getDarkRPVar( "money" ) or 0) - board.WagerValue ) end
				end
			else
				board:SetWhiteWager( wager )
			end
		else
			if board:GetWhiteWager()>=0 and wager==board:GetWhiteWager() then
				board:SetPlaying( true )
				board:SetChessState( board.StartState )
				
				local PlyName = ply:Nick() or "[N/A]"
				local OtherPly = board:GetPlayer( "White" )
				local OtherName = IsValid(OtherPly) and OtherPly:Nick() or "[N/A]"
				net.Start( "Chess GameOver" )
					if IsWhite then
						net.WriteTable( {Color(255,255,255), PlyName, Color(150,255,150), board:GetElo(ply), " has challenged ", Color(100,100,100), OtherName, Color(150,255,150), board:GetElo(OtherPly)," to "..board:GameName().."!"} )
					else
						net.WriteTable( {Color(100,100,100), PlyName, Color(150,255,150), board:GetElo(ply), " has challenged ", Color(255,255,255), OtherName, Color(150,255,150), board:GetElo(OtherPly)," to "..board:GameName().."!"} )
					end
				net.Broadcast()
				
				board.WagerValue = wager
				
				if board:GetPSWager() then
					OtherPly:PS_TakePoints( board.WagerValue )
					ply:PS_TakePoints( board.WagerValue )
				else
					if OtherPly.addMoney then OtherPly:addMoney( -board.WagerValue ) else OtherPly:SetDarkRPVar( "money", (OtherPly:getDarkRPVar( "money" ) or 0) - board.WagerValue ) end
					if ply.addMoney then ply:addMoney( -board.WagerValue ) else ply:SetDarkRPVar( "money", (ply:getDarkRPVar( "money" ) or 0) - board.WagerValue ) end
				end
			else
				board:SetBlackWager( wager )
			end
		end
	end)
	
	local PromotionClass = {["Queen"] = true, ["Bishop"] = true, ["Rook"] = true, ["Knight"] = true}
	net.Receive( "Chess PromotionSelection", function( len, ply )
		if not IsValid(ply) then return end
		if not (ply:GetNWBool( "IsInChess", false )) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if not IsValid(board) then return end
		
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		if (IsWhite and board:GetChessState()~=CHESS_WHITEPROMO) or ((not IsWhite) and board:GetChessState()~=CHESS_BLACKPROMO) then return end
		
		local GridNum = (IsWhite and 8) or 1
		
		local Class = net.ReadString()
		local GridLetter = NumToLetter[net.ReadInt(5)]
		if not (GridLetter and Class) then return end
		if not PromotionClass[Class] then return end
		
		local square = board:GetSquare( GridLetter, GridNum )
		if not square then return end
		if (IsWhite and board:SquareTeam( square )~="White") or ((not IsWhite) and board:SquareTeam( square )~="Black") then return end
		if square.Class~="Pawn" then return end
		
		if IsValid(square.Ent) then square.Ent:SetGridNum(-1) square.Ent:Remove() end
		
		square.Class = Class
		
		board:Update( {To={GridLet,GridNum}} )
		
		local IsCheck = board:CheckForCheck( board.Pieces, square.Team~="White" )
		local Checkmate = board:IsCheckmate( square.Team~="White" )
		if IsCheck and Checkmate then
			local WhitePly = board:GetPlayer( "White" )
			local BlackPly = board:GetPlayer( "Black" )
			
			local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
			local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
			board:EndGame( square.Team )
			net.Start( "Chess GameOver" )
				if square.Team=="White" then
					net.WriteTable( {Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly), " has checkmated ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly),"!"} )
				else
					net.WriteTable( {Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly), " has checkmated ", Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly),"!"} )
				end
				net.WriteString( "icon16/medal_gold_2.png" )
			net.Broadcast()
		elseif Checkmate then
			local WhitePly = board:GetPlayer( "White" )
			local BlackPly = board:GetPlayer( "Black" )
			
			local WhiteName = IsValid(WhitePly) and WhitePly:Nick() or "[Anonymous White]"
			local BlackName = IsValid(BlackPly) and BlackPly:Nick() or "[Anonymous Black]"
			board:EndGame()
			net.Start( "Chess GameOver" )
				net.WriteTable( {Color(150,255,150), "Stalemate! ", Color(255,255,255), WhiteName, Color(150,255,150), board:GetElo(WhitePly), " drew with ", Color(100,100,100), BlackName, Color(150,255,150), board:GetElo(BlackPly),"!"} )
				net.WriteString( "icon16/medal_silver_1.png" )
			net.Broadcast()
		else
			board:SetChessState( IsWhite and CHESS_BLACKMOVE or CHESS_WHITEMOVE )
		end
	end)
	
	----------------
	-- Start Game --
	----------------
	
	local function GameStart( ply, board )
		local IsWhite = (ply==board:GetWhitePlayer())
		local OtherPly = IsWhite and board:GetBlackPlayer() or board:GetWhitePlayer()
		
		if (board:GetPlaying() or not IsValid(OtherPly)) and not cvars.Bool( "chess_debug" ) then return end
		
		board:ResetBoard()
		local IsDarkRP = gmod.GetGamemode().Name=="DarkRP"
		if (not cvars.Bool( "chess_debug" )) and IsDarkRP and cvars.Bool( "chess_darkrp_wager" ) and cvars.Bool( "chess_wagers" ) then
			board:SetPlaying( false )
			board:SetChessState( CHESS_WAGER )
			board:SetPSWager( false )
			
			if IsValid(OtherPly) and OtherPly:IsBot() then if IsWhite then board:SetBlackWager(0) else board:SetWhiteWager(0) end end
			if IsValid(ply) and ply:IsBot() then if IsWhite then board:SetWhiteWager(0) else board:SetBlackWager(0) end end
		elseif (not cvars.Bool( "chess_debug" )) and cvars.Bool( "chess_wagers" ) and PS and PS.Items then
			board:SetPlaying( false )
			board:SetPSWager( true )
			board:SetChessState( CHESS_WAGER )
			
			if IsValid(OtherPly) and OtherPly:IsBot() then if IsWhite then board:SetBlackWager(0) else board:SetWhiteWager(0) end end
			if IsValid(ply) and ply:IsBot() then if IsWhite then board:SetWhiteWager(0) else board:SetBlackWager(0) end end
		else
			board:SetPlaying( true )
			board:SetChessState( board.StartState )
			board:SetPSWager( false )
			board.WagerValue = nil
			
			local PlyName = ply:Nick() or "[N/A]"
			local OtherName = IsValid(OtherPly) and OtherPly:Nick() or "[N/A]"
			net.Start( "Chess GameOver" )
				if IsWhite then
					net.WriteTable( {Color(255,255,255), PlyName, Color(150,255,150), board:GetElo(ply), " has challenged ", Color(100,100,100), OtherName, Color(150,255,150), board:GetElo(OtherPly)," to "..board:GameName().."!"} )
				else
					net.WriteTable( {Color(100,100,100), PlyName, Color(150,255,150), board:GetElo(ply), " has challenged ", Color(255,255,255), OtherName, Color(150,255,150), board:GetElo(OtherPly)," to "..board:GameName().."!"} )
				end
			net.Broadcast()
		end
	end
	
	hook.Add( "PlayerEnteredVehicle", "Chess PlayerEnter BeginGame", function( ply, seat )
		if not seat:GetNWBool("IsChessSeat", false) then return end
		
		local board = seat:GetNWEntity( "ChessBoard" )
		if not IsValid(board) then return end
		
		ply.CanExitChess = false
		ply:GodEnable()
		
		ply:SetNWBool( "IsInChess", true )
		ply:SetNWEntity( "ActiveChessBoard", board )
		
		local IsWhite = (seat==board.WhiteSeat)
		if (not IsWhite) and seat~=board.BlackSeat then return end
		if IsWhite then board:SetWhitePlayer( ply ) else board:SetBlackPlayer( ply ) end
		
		GameStart( ply, board )
	end)
	net.Receive( "Chess RequestSeat", function(l,ply)
		if not IsValid(ply) then return end
		
		local board = net.ReadEntity()
		local IsWhite = net.ReadBool()
		if not (IsValid(board) and board.IsChessBoard) then return end
		
		if ply:GetPos():DistToSqr(board:GetPos()) > 20000 then
			ply:ChatPrint( "Too far away." )
			return
		end
		
		if ply:GetNWBool("IsInChess", false) then -- Already in a game?
			local onBoard = ply:GetNWEntity( "ActiveChessBoard", nil )
			if IsValid(onBoard) and (ply==onBoard:GetWhitePlayer() or ply==onBoard:GetBlackPlayer()) then
				ply:ChatPrint( "You are already on a table." )
				return
			end
		end
		
		local seat
		if IsWhite then
			if IsValid( board:GetWhitePlayer() ) then
				ply:ChatPrint( "This seat is taken." )
				return
			end
			
			seat = board.WhiteSeat
			board:SetWhitePlayer( ply )
			
			if board:GetBlackPlayer()==ply then board:SetBlackPlayer( NULL ) end
		else
			if IsValid( board:GetBlackPlayer() ) then
				ply:ChatPrint( "This seat is taken." )
				return
			end
			
			seat = board.BlackSeat
			board:SetBlackPlayer( ply )
			
			if board:GetWhitePlayer()==ply then board:SetWhitePlayer( NULL ) end
		end
		
		ply:SetNWBool( "IsInChess", true )
		ply:SetNWEntity( "ActiveChessBoard", board )
		
		if IsValid(seat) then
			local driver = seat:GetDriver()
			if IsValid(driver) and driver~=ply then
				driver.CanExitChess = true
				ply:ExitVehicle()
			end
			
			ply:EnterVehicle( seat )
		end
		
		GameStart( ply, board )
	end)
	
	--------------
	-- End Game --
	--------------
	
	hook.Add( "CanExitVehicle", "Chess CanExitVehicle Anti-minge", function( seat, ply )
		if not (IsValid(ply) and IsValid(seat)) then return end
		if not (ply:GetNWBool( "IsInChess", false )) then return end
		if not seat:GetNWBool("IsChessSeat", false) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard", nil )
		if not IsValid(board) then return end
		
		if board:GetPlaying() and (not ply.CanExitChess) then return false end
	end)
	local function LeaveGame( ply, seat, board )
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		
		ply:SetNWBool( "IsInChess", false )
		ply:SetNWEntity( "ActiveChessBoard", NULL )
		
		local OtherPly = IsWhite and board:GetBlackPlayer() or board:GetWhitePlayer()
		
		board:SetChessState( CHESS_INACTIVE )
		if not board:GetPlaying() then
			if IsWhite then
				board:SetWhitePlayer( NULL )
			else
				board:SetBlackPlayer( NULL )
			end
			return
		end
		board:SetPlaying( false )
		
		local PlyName = IsValid(ply) and ply:Nick() or "[N/A]"
		local OtherName = IsValid(OtherPly) and OtherPly:Nick() or (IsWhite and "[Anonymous Black]" or "[Anonymous White]")
		
		board:EndGame( IsWhite and "Black" or "White", true )
		net.Start( "Chess GameOver" )
			if IsWhite then
				net.WriteTable( {Color(255,255,255), PlyName, Color(150,255,150), board:GetElo(ply), " has surrendered to ", Color(100,100,100), OtherName, Color(150,255,150), board:GetElo(OtherPly),"!"} )
			else
				net.WriteTable( {Color(100,100,100), PlyName, Color(150,255,150), board:GetElo(ply), " has surrendered to ", Color(255,255,255), OtherName, Color(150,255,150), board:GetElo(OtherPly),"!"} )
			end
			net.WriteString( "icon16/medal_bronze_3.png" )
		net.Broadcast()
		
		board:SetChessState( CHESS_INACTIVE )
		board:SetPlaying( false )
		
		if IsValid(OtherPly) then
			OtherPly:ExitVehicle()
			
			OtherPly:SetNWBool( "IsInChess", false )
			OtherPly:SetNWEntity( "ActiveChessBoard", NULL )
		end
	end
	hook.Add( "PlayerLeaveVehicle", "Chess PlayerLeave ResignGame", function( ply, seat )
		if not (IsValid(ply) and IsValid(seat)) then return end
		if not seat:GetNWBool("IsChessSeat", false) then return end
		
		ply:SetPos( seat:GetPos() - (seat:GetForward()*10) )
		--ply:SetAngles( seat:GetAngles() ) --Doesn't work?
		ply:GodDisable()
		
		ply:SetNWBool( "IsInChess", false )
		ply:SetNWEntity( "ActiveChessBoard", nil )
		
		local board = seat:GetNWEntity( "ChessBoard" )
		if not IsValid(board) then return end
		
		if board:GetPlaying() and (not ply.CanExitChess) then
			timer.Simple(0, function() if IsValid(ply) and IsValid(seat) then ply:EnterVehicle(seat) end end)
			return
		end
		
		LeaveGame( ply, seat, board )
	end)
	net.Receive( "Chess ClientResign", function( len,ply )
		if not IsValid(ply) then return end
		if not ply:GetNWBool( "IsInChess", false ) then return end
		
		local board = ply:GetNWEntity( "ActiveChessBoard" )
		if not IsValid(board) then return end
		
		LeaveGame( ply, seat, board )
		
		local seat = ply:GetVehicle()
		if IsValid(seat) then
			ply.CanExitChess = true
			ply:ExitVehicle()
		end
	end)
	
	hook.Add( "PlayerDisconnected", "Chess PlayerDisconnect ResignGame", function( ply )
		if not (IsValid(ply)) then return end
		
		-- local seat = ply:GetVehicle()
		-- if not (IsValid(seat) and seat:GetNWBool("IsChessSeat", false)) then return end
		if not ply:GetNWBool( "IsInChess", false ) then return end
		local board = ply:GetNWEntity( "ActiveChessBoard" )
		
		ply:SetNWBool( "IsInChess", false )
		ply:SetNWEntity( "ActiveChessBoard", nil )
		
		if not IsValid(board) then return end
		
		local IsWhite = (ply==board:GetWhitePlayer())
		if (not IsWhite) and ply~=board:GetBlackPlayer() then return end
		if IsWhite then board:SetWhitePlayer( NULL ) else board:SetBlackPlayer( NULL ) end
		
		board:SetChessState( CHESS_INACTIVE )
		if not board:GetPlaying() then return end
		board:SetPlaying( false )
		
		local OtherPly 
		if IsWhite then OtherPly = board:GetBlackPlayer() else OtherPly = board:GetWhitePlayer() end
		
		local PlyName = IsValid(ply) and ply:Nick() or "[N/A]"
		local OtherName = IsValid(OtherPly) and OtherPly:Nick() or (IsWhite and "[Anonymous Black]" or "[Anonymous White]")
		
		board:EndGame( IsWhite and "Black" or "White", true )
		net.Start( "Chess GameOver" )
			if IsWhite then
				net.WriteTable( {Color(255,255,255), PlyName, Color(150,255,150), board:GetElo(ply), " rage quit against ", Color(100,100,100), OtherName, Color(150,255,150), board:GetElo(OtherPly),"!"} )
			else
				net.WriteTable( {Color(100,100,100), PlyName, Color(150,255,150), board:GetElo(ply), " rage quit against ", Color(255,255,255), OtherName, Color(150,255,150), board:GetElo(OtherPly),"!"} )
			end
			net.WriteString( "icon16/medal_gold_2.png" )
		net.Broadcast()
		
		board:SetChessState( CHESS_INACTIVE )
		board:SetPlaying( false )
		
		if IsValid( OtherPly ) then OtherPly:ExitVehicle() end
	end)
	hook.Add( "CanPlayerSuicide", "Chess PlayerSuicide Prevention", function( ply )
		if not (IsValid(ply)) then return end
		
		if not ply:GetNWBool( "IsInChess", false ) then return end
		
		return false
	end)
	
	
	-------------------------------
	-- Save/Load Board Positions --
	-------------------------------
	
	local SaveSystem = {}
	local SaveFile = game.GetMap()
	SaveSystem.Load = function( self )
		if not SaveFile then SaveFile=game.GetMap() end
		if not file.IsDir( "chessboard", "DATA" ) then file.CreateDir( "chessboard", "DATA" ) end
		local data = file.Read( "chessboard/"..SaveFile..".txt", "DATA" )
		
		if data then
			local tbl = util.JSONToTable(data) or {}
			for _,v in pairs(tbl) do
				local ent = ents.Create( v.class )
				if IsValid(ent) then
					ent.SavePos = SpawnPos
					ent:SetPos( v.pos )
					
					if v.ang then ent:SetAngles( v.ang ) end
					
					if v.skipWhite then
						ent.SkipWhiteChair = true
					else
						ent.WhiteChairPos = v.posWhite
						ent.WhiteChairAng = v.angWhite
					end
					if v.skipBlack then
						ent.SkipBlackChair = true
					else
						ent.BlackChairPos = v.posBlack
						ent.BlackChairAng = v.angBlack
					end
					
					ent:Spawn()
				end
			end
		end
		
		if file.Exists( "chessboard/savedata.txt", "DATA" ) then --Read old system
			local data = file.Read( "chessboard/savedata.txt", "DATA" )
			
			if data then
				local tbl = util.JSONToTable(data) or {}
				for _,v in pairs(tbl) do
					local ent = ents.Create( v.class )
					if IsValid(ent) then ent.SavePos = SpawnPos ent:SetPos( v.pos ) ent:Spawn() end
				end
			end
			
			file.Delete( "chessboard/savedata.txt", "DATA" )
			self:Save()
		end
		return true
	end
	
	local function GetSaveData(board)
		local ang = board:GetAngles()
		ang:RotateAroundAxis(board:GetRight(),-90)
		
		local pos
		if (board.BoardHeight and board.TableOffset) then
			pos = board:GetPos() - board.BoardHeight - board.TableOffset
		elseif (board.SavePos) then
			pos = board.SavePos
		else
			pos = board:GetPos()
		end
		
		local data = {
			class=board:GetClass(),
			pos = pos,
			ang = ang
		}
		if IsValid(board.WhiteSeat) then
			data.posWhite = board.WhiteSeat:GetPos()
			data.angWhite = board.WhiteSeat:GetAngles()
		else
			data.skipWhite = true
		end
		if IsValid(board.BlackSeat) then
			data.posBlack = board.BlackSeat:GetPos()
			data.angBlack = board.BlackSeat:GetAngles()
		else
			data.skipBlack = true
		end
		
		return data
	end
	SaveSystem.Save = function( self )
		if not SaveFile then SaveFile=game.GetMap() end
		
		local SaveTbl = {}
		local Ents = ents.FindByClass( "ent_chess_board" )
		for _,v in pairs( Ents ) do
			if IsValid(v) then
				table.insert(SaveTbl, GetSaveData(v))
			end
		end
		local Ents = ents.FindByClass( "ent_draughts_board" )
		for _,v in pairs( Ents ) do
			if IsValid(v) then
				table.insert(SaveTbl, GetSaveData(v))
			end
		end
		
		if not file.IsDir( "chessboard", "DATA" ) then file.CreateDir( "chessboard", "DATA" ) end
		file.Write( "chessboard/"..SaveFile..".txt", util.TableToJSON(SaveTbl) )
		return true
	end
	hook.Add( "InitPostEntity", "Chess InitPostEntity LoadBoards", function() SaveSystem:Load() end)
	hook.Add( "PostCleanupMap", "Chess PostCleanup LoadBoards", function() SaveSystem:Load() end)
	
	local SaveCommands = {
		["/chesssave"] = true, ["/savechess"] = true, ["!chesssave"] = true, ["!savechess"] = true,
		["/draughtssave"] = true, ["/savedraughts"] = true, ["!draughtssave"] = true, ["!savedraughts"] = true,
		["/checkerssave"] = true, ["/savecheckers"] = true, ["!checkerssave"] = true, ["!savecheckers"] = true,
	}
	hook.Add( "PlayerSay", "Chess PlayerSay SaveBoards", function( ply, str, tm )
		if not IsValid(ply) then return end
		if not ply:IsSuperAdmin() then return end
		
		if SaveCommands[str:lower()] then
			local saved = SaveSystem:Save()
			ply:ChatPrint( saved and "Saved game board positions" or "Save failed!" )
		end
	end)
	local function ChessSave( ply, c, a )
		if IsValid(ply) and not ply:IsSuperAdmin() then ply:ChatPrint( "You can't do this" ) end
		
		local saved = SaveSystem:Save()
		if IsValid(ply) then
			ply:ChatPrint( saved and "Saved game board positions" or "Save failed!" )
		else
			print( saved and "Saved game board positions" or "Save failed!" )
		end
	end
	concommand.Add( "chess_save", ChessSave ) concommand.Add( "draughts_save", ChessSave ) concommand.Add( "checkers_save", ChessSave )
end

hook.Add( "GravGunPickupAllowed", "Chess PreventGrav", function( ply, ent )
	if IsValid(ent) and ent.IsChessEntity then return false end
end)
hook.Add( "canPocket", "Chess DarkRP PreventPocket", function( ply, ent )
	if IsValid(ent) and ent.IsChessEntity then return false,"Please do not interfere with Chess." end
end)


-- Override Movement --

local function CancelMovement( ply, mvData )
	if (not IsValid(ply)) or not (ply:GetNWBool("IsInChess", false) or IsValid(ply.Chess_Spectating)) then return end -- Not in chess
	
	local board = ply:GetNWEntity( "ActiveChessBoard", nil )
	if (not IsValid(board)) or (ply~=board:GetWhitePlayer() and ply~=board:GetBlackPlayer()) then -- Invalid board
		if SERVER or (not IsValid(ply.Chess_Spectating)) then -- Not a client in spectate mode
			return
		end
	end
	
	local zero = Vector()
	mvData:SetButtons( 0 )
	mvData:SetVelocity( zero )
	mvData:SetMaxSpeed( 0 )
	mvData:SetMaxClientSpeed( 0 )
	mvData:SetForwardSpeed( 0 )
	mvData:SetSideSpeed( 0 )
	
	return mvData
end
hook.Add( "SetupMove",  "Chess_CancelMovement", CancelMovement )
hook.Add( "Move",       "Chess_CancelMovement", CancelMovement )
hook.Add( "FinishMove", "Chess_CancelMovement", CancelMovement )

if CLIENT then
	-- Prevent movement while spectating
	-- This is clientside only so easily overridden,
	-- but that's not a big deal in this case
	local function CancelCommands( ply, cUserCmd )
		if not (IsValid(ply) and IsValid(ply.Chess_Spectating)) then return end
		
		-- local zero = Vector()
		cUserCmd:ClearMovement()
	end
	hook.Add( "CreateMove", "Chess_CancelMovement", function(cUserCmd) CancelCommands(LocalPlayer(), cUserCmd) end)
end
