--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

ENT.Sound				= {}
ENT.Sound.Blip			= "TFA_HL2R_Grenade.Beep"
ENT.Sound.Explode		= "BaseGrenade.Explode"

ENT.Trail				= {}
ENT.Trail.Color			= Color( 255, 0, 0, 255 )
ENT.Trail.Material		= "sprites/bluelaser1.vmt"
ENT.Trail.StartWidth	= 8.0
ENT.Trail.EndWidth		= 1.0
ENT.Trail.LifeTime		= 0.5

// Nice helper function, this does all the work.

/*---------------------------------------------------------
   Name: DoExplodeEffect
---------------------------------------------------------*/
function ENT:DoExplodeEffect()

	local info = EffectData();
	info:SetEntity( self.Entity );
	info:SetOrigin( self.Entity:GetPos() );

	if self:WaterLevel() >= 3 then
		util.Effect("WaterSurfaceExplosion", info)
	end
	
	--util.Effect( "Explosion", info );
	self:EmitSound("BaseExplosionEffect.Sound")
	util.Effect("tfa_hl2r_fx_explosion_dlight", info)

end

/*---------------------------------------------------------
   Name: OnExplode
   Desc: The grenade has just exploded.
---------------------------------------------------------*/
function ENT:OnExplode( pTrace )

	local Pos1 = pTrace.HitPos + pTrace.HitNormal
	local Pos2 = pTrace.HitPos - pTrace.HitNormal

 	util.Decal( "Scorch", Pos1, Pos2 );

end

/*---------------------------------------------------------
   Name: OnInitialize
---------------------------------------------------------*/
function ENT:OnInitialize()
end

/*---------------------------------------------------------
   Name: StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end

/*---------------------------------------------------------
   Name: EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end

/*---------------------------------------------------------
   Name: Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end

/*---------------------------------------------------------
   Name: OnThink
---------------------------------------------------------*/
function ENT:OnThink()
end