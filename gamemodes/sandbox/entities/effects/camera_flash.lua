--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


function EFFECT:Init( data )

	local vOffset = data:GetOrigin()
	local ent = data:GetEntity()

	local dlight = DynamicLight( ent:EntIndex() )

	if ( dlight ) then

		dlight.Pos = vOffset
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 10
		dlight.Size = 512
		dlight.DieTime = CurTime() + 0.02
		dlight.Decay = 512

	end

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
