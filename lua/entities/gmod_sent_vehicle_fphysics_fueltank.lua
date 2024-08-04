--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Type            = "anim"
ENT.DoNotDuplicate = true

function ENT:SetupDataTables()
	self:NetworkVar( "Entity",0, "Base" )
end

function ENT:GetFuel()
	local veh = self:GetBase()

	if not IsValid( veh ) then return 0 end

	return veh:GetFuel() / veh:GetMaxFuel()
end

function ENT:SetFuel( new )
	local veh = self:GetBase()

	if not IsValid( veh ) then return end

	veh:SetFuel( new * veh:GetMaxFuel() )
end

function ENT:GetSize()
	local veh = self:GetBase()

	if not IsValid( veh ) then return 0 end

	return veh:GetMaxFuel()
end

function ENT:GetFuelType()
	local veh = self:GetBase()

	if not IsValid( veh ) then return -1 end

	return veh:GetFuelType()
end

function ENT:GetDoorHandler()
	return NULL
end

function ENT:GetHP()
	return 100
end

function ENT:GetMaxHP()
	return 100
end

function ENT:GetDestroyed()
	return false
end

if SERVER then
	function ENT:Initialize()	
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_NONE )
		self:DrawShadow( false )
		debugoverlay.Cross( self:GetPos(), 20, 5, Color( 255, 93, 0 ) )
	end

	function ENT:ExtinguishAndRepair()
	end

	function ENT:Think()
		self:NextThink( CurTime() + 1 )

		return true
	end

	function ENT:OnTakeDamage( dmginfo )
	end

	return
end

function ENT:Initialize()
end

function ENT:OnRemove()
end

function ENT:Draw()
end

function ENT:Think()
	return false
end
