--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local smoke = {
	"particle/smokesprites_0001",
	"particle/smokesprites_0002",
	"particle/smokesprites_0003",
	"particle/smokesprites_0004",
	"particle/smokesprites_0005",
	"particle/smokesprites_0006",
	"particle/smokesprites_0007",
	"particle/smokesprites_0008",
	"particle/smokesprites_0009",
	"particle/smokesprites_0010",
	"particle/smokesprites_0011",
	"particle/smokesprites_0012",
	"particle/smokesprites_0013",
	"particle/smokesprites_0014",
	"particle/smokesprites_0015",
	"particle/smokesprites_0016"
}

function EFFECT:Init( data )
	local vOffset = data:GetOrigin()

	local emitter = ParticleEmitter( vOffset, false )

	for i = 0, 15 do
		local exp = emitter:Add( "particles/flamelet"..math.random(1,5), vOffset)

		if exp then
			exp:SetVelocity( VectorRand() * 250 )
			exp:SetDieTime( 0.2 )
			exp:SetStartAlpha( 255 )
			exp:SetStartSize( 20 )
			exp:SetEndSize( 150 )
			exp:SetEndAlpha( 50 )
			exp:SetRoll( math.Rand( -1, 1 ) )
			exp:SetColor(60, 193, 255)
			exp:SetGravity( Vector( 50, 50, 10 ) )
		end
	end

	for i = 1, 40 do
		local Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0)
		local particle = emitter:Add( smoke[math.random(1, #smoke)], vOffset + Pos * 4 )
		if ( particle ) then
			particle:SetVelocity( Pos * 120 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 2 )

			particle:SetStartAlpha( 8 )
			particle:SetEndAlpha( 0 )

			particle:SetColor(60, 193, 255)
			particle:SetRoll( math.Rand( -1, 1 ) )

			local Size = math.random( 100, 150 )
			particle:SetStartSize( Size )
			particle:SetEndSize( Size )

			particle:SetAirResistance( 50 )
			particle:SetGravity( Vector( math.Rand( -1, 1 ) * 50, math.Rand( -1, 1 ) * 50, 10 ) )

		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end