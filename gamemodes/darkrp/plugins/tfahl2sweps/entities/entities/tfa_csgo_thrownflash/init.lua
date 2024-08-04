--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel("models/weapons/arccw_go/w_eq_flashbang_thrown.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	--self:PhysicsInitSphere( ( self:OBBMaxs() - self:OBBMins() ):Length()/4, "metal" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )

	self:EmitSound("TFA_CSGO_Flashbang.Throw")

	local curTime = CurTime()

	self.timeleft = curTime + 2 -- HOW LONG BEFORE EXPLOSION
	self.removeTime = curTime + 30

	self:Think()
end

 function ENT:Think()
	local curTime = CurTime()

	if self.timeleft < curTime and !self.deactivated then
		self:Explosion()
	end

	if (self.removeTime < curTime and !self.noRemove) then
		SafeRemoveEntity(self)
	end

	self:NextThink( curTime )
	return true
end

function ENT:EntityFacingFactor( theirent )
	local dir = theirent:EyeAngles():Forward()
	local facingdir = (self:GetPos() - (theirent.GetShootPos and theirent:GetShootPos() or theirent:GetPos())):GetNormalized()
	return (facingdir:Dot(dir)+1)/2
end

function ENT:EntityFacingUs( theirent )
	local dir = theirent:EyeAngles():Forward()
	local facingdir = (self:GetPos()-(theirent.GetShootPos and theirent:GetShootPos() or theirent:GetPos())):GetNormalized()
	if facingdir:Dot(dir)>-0.25 then return true end
end


function ENT:Explosion()
	self:EmitSound("TFA_CSGO_FLASHGRENADE.BOOM")

	local tr = {}
	tr.start = self:GetPos()
	tr.mask = MASK_SOLID

	for _, v in ipairs(player.GetAll()) do
		tr.endpos = v:GetShootPos()
		tr.filter = { self, v, v:GetActiveWeapon() }
		local traceres = util.TraceLine(tr)

		if !traceres.Hit or traceres.Fraction>=1 or traceres.Fraction<=0 then
			local factor = self:EntityFacingFactor(v)
			local distance = v:GetShootPos():Distance(self:GetPos())
			v:SetNWFloat("TFACSGO_LastFlash", CurTime())
			v:SetNWEntity("TFACSGO_LastFlashBy", self:GetOwner())
			v:SetNWFloat("TFACSGO_FlashDistance", distance)
			v:SetNWFloat("TFACSGO_FlashFactor", factor)

			hook.Run("PlayerFlashed", v, self:GetOwner(), self, distance, factor)

			if v:GetNWFloat("TFACSGO_FlashDistance",distance) < 1500 and v:GetNWFloat("FlashFactor",factor) < tr.endpos:Distance(self:GetPos(v)) then
				if v:GetNWFloat("TFACSGO_FlashDistance",distance) < 1000 then
					v:SetDSP( 37 , false )
				elseif v:GetNWFloat("TFACSGO_FlashDistance",distance) < 800 then
					v:SetDSP( 36 , false )
				elseif v:GetNWFloat("TFACSGO_FlashDistance",distance) < 600 then
					v:SetDSP( 35, false )
				end
			end
		end
	end

	--[[
	for _, v in ipairs(ents.GetAll()) do
		if v:IsNPC() and self:EntityFacingUs(v) then
			tr.endpos = v.GetShootPos and v:GetShootPos() or v:GetPos()
			tr.filter = { self, v, v.GetActiveWeapon and v:GetActiveWeapon() or v}
			local traceres = util.TraceLine(tr)
			if !traceres.Hit or traceres.Fraction>=1 or traceres.Fraction<=0 then
				local flashdistance = tr.endpos:Distance(self:GetPos())
				local flashtime = CurTime()
				local distancefac = ( 1-math.Clamp((flashdistance-csgo_flashdistance+csgo_flashdistancefade)/csgo_flashdistancefade,0,1) )
				local intensity = ( 1-math.Clamp(((CurTime()-flashtime)/distancefac-csgo_flashtime+csgo_flashfade)/csgo_flashfade,0,1) )
				if intensity>0.8 then
					v:SetNWFloat("TFACSGO_LastFlash", CurTime())
					v:SetNWEntity("TFACSGO_LastFlashBy", self:GetOwner())
					v:SetNWFloat("TFACSGO_FlashDistance", v:GetShootPos():Distance(self:GetPos()))
					v:SetNWFloat("TFACSGO_FlashFactor", self:EntityFacingFactor(v))
					if v.ClearSchedule then
						v:ClearSchedule()
					end
					if v.SetEnemy then
						v:SetEnemy(nil)
					end
					if v.AddEntityRelationship and IsValid(self.Owner) then
						local oldrel = v.GetRelationship and v:GetRelationship(self.Owner) or ( ( IsFriendEntityName( v:GetClass() ) and !game.GetMap()=="gm_raid" ) and D_LI or D_HT )
						v:AddEntityRelationship( self.Owner, D_NU, 99)
						timer.Simple(csgo_flashtime/2, function()
							if IsValid(v) and v:IsNPC() and IsValid(self) and IsValid(self.Owner) then
								v:AddEntityRelationship( self.Owner, oldrel, 99)
							end
						end)
					end
					if v.ClearEnemyMemory then
						v:ClearEnemyMemory()
					end
				end
			end
		end
	end
	]]

	self.deactivated = true
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end