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
	self.pos = data:GetOrigin()
	local emitter = ParticleEmitter( self.pos, false )

	for i = 1, 40 do
		local Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 2)
		local particle = emitter:Add( smoke[math.random(1, #smoke)], self.pos + Pos * 2 )
		if ( particle ) then
			particle:SetVelocity( Pos * 1.35 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 3 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )

			particle:SetColor(255, 223, 136)
			particle:SetRoll( math.Rand( -1, 1 ) )

			local Size = math.random( 8, 10 )
			particle:SetStartSize( Size )
			particle:SetEndSize( Size )

			particle:SetAirResistance( 50 )
			particle:SetGravity( Vector( math.Rand( -1, 1 ) * 4, math.Rand( -1, 1 ) * 4, 0.5 ) )

		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end