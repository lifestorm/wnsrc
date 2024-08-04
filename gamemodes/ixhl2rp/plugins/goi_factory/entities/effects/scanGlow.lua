--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- some cool glowing code is taken from open-source LVS base originally used
-- for shield impacting

function EFFECT:Init( data )
	self.ent = data:GetEntity()

	self.lt = data:GetScale()
	self.dt = CurTime() + self.lt

	if IsValid( self.ent ) then
		self.model = ClientsideModel( self.ent:GetModel(), RENDERMODE_TRANSCOLOR )
		self.model:SetMaterial("models/alyx/emptool_glow")
		self.model:SetColor( Color(255, 223, 136) )
		self.model:SetParent( self.ent, 0 )
		self.model:SetMoveType( MOVETYPE_NONE )
		self.model:SetLocalPos( Vector( 0, 0, 0 ) )
		self.model:SetLocalAngles( Angle( 0, 0, 0 ) )
		self.model:AddEffects( EF_BONEMERGE )
	end
end

function EFFECT:Think()
	if not IsValid( self.ent ) and IsValid(self.model) then
		self.model:Remove()
	end

	if self.dt < CurTime() then
		if IsValid( self.model ) then
			self.model:Remove()
		end

		return false
	end

	return true
end

function EFFECT:Render()
end