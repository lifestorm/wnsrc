--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local ringMats = {
	"particle/particle_ring_blur",
	"particle/particle_ring_wave_additive",
	"particle/particle_ring_wave_addnofog",
	"particle/particle_ring_sharp_additive",
	"particle/particle_ring_sharp",
	"particle/particle_ring_refract_01",
	"particle/particle_ring_blur",
	"particle/particle_noisesphere"
}
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

	local NumParticles = 32

	local emitter = ParticleEmitter( vOffset, false )
	local ringSize = math.random( 80, 90 )

	for i = 1, #ringMats do
		local ring = emitter:Add(ringMats[i], vOffset + Vector(0, 0, 20))
		if (ring) then
			ring:SetStartSize( ringSize )
			ring:SetEndSize( 0 )
			ring:SetLifeTime( 0 )
			ring:SetDieTime( 0.5 )
			ring:SetStartAlpha( 150 )
			ring:SetEndAlpha( 0 )
			ring:SetAirResistance( 100 )
			ring:SetGravity( Vector( 0, 0, 10 ) )
			ring:SetRoll( 90 )
			ring:SetColor(32, 185, 50)
		end
	end

	for i = 0, 40 do
		local exp = emitter:Add( "particle/particle_glow_03", vOffset + Vector(0, 0, 20) )

		if exp then
			exp:SetVelocity( Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0) * 30 )
			exp:SetDieTime( 0.5 )
			exp:SetStartAlpha( 255 )
			exp:SetStartSize( 75 )
			exp:SetEndSize( 120 )
			exp:SetEndAlpha( 0 )
			exp:SetRoll( math.Rand( -1, 1 ) )
			exp:SetColor(32, 185, 50)
		end
	end

	for i = 1, 40 do
		local Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0)
		local particle = emitter:Add( smoke[math.random(1, #smoke)], vOffset + Pos * 4 )
		if ( particle ) then
			particle:SetVelocity( Pos * 30 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 5 )

			particle:SetStartAlpha( 8 )
			particle:SetEndAlpha( 0 )

			particle:SetColor(32, 185, 50)
			particle:SetRoll( math.Rand( -1, 1 ) )

			local Size = math.random( 100, 150 )
			particle:SetStartSize( Size )
			particle:SetEndSize( Size )

			particle:SetAirResistance( 50 )
			particle:SetGravity( Vector( math.Rand( -1, 1 ) * 15, math.Rand( -1, 1 ) * 15, 18 ) )

		end
	end

	for i = 0, NumParticles do

		local Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local particle = emitter:Add( "particle/particle_ring_wave_8", vOffset + Pos * 4 )
		if ( particle ) then

			particle:SetVelocity( Pos * 340 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 3 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )

			particle:SetColor(32, 185, 50)


			local Size = math.random( 5, 15 )
			particle:SetStartSize( Size )
			particle:SetEndSize( 0 )

			particle:SetRoll( math.Rand( 0, 360 ) )
			particle:SetRollDelta( math.Rand( -25, 25 ) )

			particle:SetAirResistance( 150 )
			particle:SetGravity( Vector( math.Rand( -1, 1 ) * 15, math.Rand( -1, 1 ) * 15, 30 ) )

		end

	end

	emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end