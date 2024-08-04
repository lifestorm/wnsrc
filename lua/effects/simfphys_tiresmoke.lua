--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local Materials = {
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
	local Entity = data:GetEntity()
	local Mul = data:GetMagnitude() 
	local Pos = data:GetOrigin()
	local Dir = data:GetNormal()
	local WheelSize = data:GetRadius()
	local ColorIn = data:GetStart()

	local VecCol = render.GetLightColor( Pos + Dir ) * 0.4 + Vector(0.6,0.6,0.6)

	local Col = Vector( math.min(ColorIn.x * VecCol.x, 255), math.min(ColorIn.y * VecCol.y, 255), math.min(ColorIn.z * VecCol.z, 255) )

	local Ran = Vector( math.Rand( -WheelSize, WheelSize ), math.Rand( -WheelSize, WheelSize ),math.Rand( -WheelSize, WheelSize ) ) * 0.3
	local OffsetPos = Pos + Ran + Vector(0,0,WheelSize * 0.2)
	
	local emitter = ParticleEmitter(Pos, false )
	
	if emitter then
		local OffsetPos2 = OffsetPos + Ran * 0.4 + Vector(0,0,-WheelSize)

		local particle1 = emitter:Add( Materials[math.Round(math.Rand(1, table.Count(Materials) ),0)], OffsetPos )
		local particle2 = emitter:Add( Materials[math.Round(math.Rand(1, table.Count(Materials) ),0)], OffsetPos2 )

		if particle1 then
			particle1:SetVelocity( Vector(0,0,-50) )
			particle1:SetDieTime( 0.5 )
			particle1:SetStartAlpha( 255 * Mul ^ 2 )
			particle1:SetStartSize( 16 * Mul )
			particle1:SetEndSize( 32 * Mul )
			particle1:SetRoll( math.Rand( -1, 1 ) )
			particle1:SetColor( Col.x * 0.9,Col.y * 0.9,Col.z * 0.9 )
			particle1:SetCollide( true )
		end
		
		if particle2 then
			particle2:SetGravity( Vector(0,0,12) + Ran * 0.2 ) 
			particle2:SetVelocity( Dir * 30 * (3 - Mul) + Vector(0,0,15) + Ran * Mul  )
			particle2:SetDieTime( math.Rand( 2, 4 ) * Mul )
			particle2:SetStartAlpha( 100 * Mul )
			particle2:SetStartSize( WheelSize * 0.7 * Mul )
			particle2:SetEndSize( math.Rand( 80, 160 ) * Mul ^ 2 )
			particle2:SetRoll( math.Rand( -1, 1 ) )
			particle2:SetColor( Col.x,Col.y,Col.z )
			particle2:SetCollide( false )
		end

		emitter:Finish()
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
