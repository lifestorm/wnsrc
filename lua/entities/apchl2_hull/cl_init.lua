--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


include('shared.lua')

function ENT:Initialize()
end
--[[
if( SinglePlayer() ) then

	function ENT:RenderOverride()

		-- if( self:GetVelocity():Length() < 50 ) then self:DrawModel() return end
		
		local phys = self:GetPhysicsObject()
		
		local speed = 1
		
		if( phys:IsValid() ) then
			
			print( "yay got phys" )
			speed = phys:GetAngleVelocity().y
			
		end
		
		local itr, max_iterations = 1, 8
		
		for i=itr, max_iterations  do
			
			-- self:SetLocalAngles( 0,0,0 )
			local a = self:GetAngles()
			a:RotateAroundAxis( self:GetUp(), i * 3)
			
			render.SetBlend( i / max_iterations )
			self:SetupBones()
			self:SetRenderAngles( a )
			self:DrawModel()
			--self:SetRenderAngles( nil )
			

		end
		
	end

end
]]--

function ENT:Draw()
	
	-- self:SetupBones()
	self:DrawModel()

end

function ENT:CustomOnRemove()
end
