--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local len = 400
local len2 = 400

local lifetime = 0.6
local inv = 1 / lifetime

local lifetime2 = 0.1
local inv2 = 1 / lifetime2

local imptimer = 0

local PulserPointofimpact_FractalStructure = Material("sprites/baku_impactor_smoke")

function EFFECT:Init(data)
	self:SetPos(data:GetOrigin() or Vector(0, 0, 0))

	self:SetRenderBounds(Vector(0, 0, 0), Vector(0, 0, 0), Vector(1,1,1) * 512)

	self.DieTime = CurTime() + lifetime
	self.DieTime2 = CurTime() + lifetime2

	local norm = data:GetNormal() or Vector(0, 0, 1)

	self.Normal = norm

	local light = render.GetLightColor(self:GetPos() + norm * 5)
	//LocalPlayer():ChatPrint(light:LengthSqr())

	if(light:LengthSqr() < 0.01) then
		local dlight = DynamicLight( LocalPlayer():EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 100
			dlight.b = 0
			dlight.brightness = 0.4
			dlight.Decay = 500
			dlight.Size = 128
			dlight.DieTime = CurTime() + 1
		end
	end

	util.Decal("FadingScorch", self:GetPos(), self:GetPos() - norm * 5)

	local emitter = ParticleEmitter(self:GetPos(), false)
	local dir = (norm + VectorRand() * 0.4):GetNormalized()

	local ___x = math.random(3, 10)

	for i = 1, ___x do
		local vectorrand = VectorRand()
		local part = emitter:Add("sprites/flamelet"..math.random(1,4), self:GetPos() + norm * i * 5)
		local vel = (norm + vectorrand * 0.4):GetNormalized()
		part:SetVelocity(vel * 200)
		part:SetAngleVelocity(AngleRand())
		part:SetStartSize(10)
		part:SetEndSize(0)
		part:SetDieTime(0.2)

		local dietime

		vel = (dir + vectorrand * 0.3):GetNormalized()
		part = emitter:Add( "sprites/light_glow02_add", self:GetPos() + norm * 2 );
		if(___x > 7 && i > 4) then
			dietime = math.random( 4, 6 )
			part:SetNextThink(CurTime())
			part:SetThinkFunction(function(p)
				local _y_ = p:GetLifeTime() / p:GetDieTime()
				local col = LerpVector(_y_ * (0.7 + math.sin(CurTime() * 5) * 0.3), Vector(255, 170, 0), Vector(255, 0, 0))
				p:SetColor(col.x, col.y, col.z)
				p:SetNextThink(CurTime())
			end)
			part:SetStartAlpha( 255 );
			part:SetEndAlpha( 0 );
			part:SetStartSize( math.random(1, 10) );
			part:SetEndSize( 0 );
			part:SetRoll( 0 );
			part:SetGravity( Vector( 0, 0, -1000 ) );
			part:SetVelocity( vel * 300);
		else
			part:SetColor(255, 128, 0)
			dietime = math.Rand(0.5, 0.8)
			part:SetStartAlpha( 255 );
			part:SetEndAlpha( 0 );
			part:SetStartSize( math.random(1, 5) );
			part:SetEndSize( 0 );
			part:SetRoll( 0 );
			part:SetGravity( Vector( 0, 0, -200 ) );
			part:SetVelocity( vel * 500);
		end
		part:SetDieTime( dietime );
		part:SetCollide( true );
		part:SetBounce( 0.3 );
		part:SetAirResistance( 5 );
	end

	local max = 5
	local imax = 1/max
	for i = 1, max do
		local vectorrand = VectorRand()
		local part = emitter:Add("sprites/flamelet1", self:GetPos() + norm * (30 + i * 10) )
		local vel = (norm + vectorrand * 0.4):GetNormalized()
		local _i = (max - i) * imax 
		part:SetVelocity(vel * 200)
		part:SetAngleVelocity(AngleRand())
		part:SetDieTime(_i * 0.3 + 0.2)

		part:SetStartAlpha( 128 );
		part:SetEndAlpha( 0 );
		part:SetStartSize( 48 * _i);
		part:SetEndSize( 13 );
		part:SetCollide( true );

		part:SetRoll(0)
		part:SetRollDelta(3)

		part:SetBounce( 0.1 );
		part:SetAirResistance( 5 );
		part:SetMaterial(PulserPointofimpact_FractalStructure)
		part:SetColor(128,128,128)
	end

	emitter:Finish()

	if(imptimer < CurTime()) then
		local rand = math.random(1,3)
		sound.Play("weapons/debris" .. rand .. ".wav", self:GetPos())
		imptimer = CurTime() + rand * 0.3
	end
end

local MRToFrance_beamSeanTyas = Material("sprites/baku_impactor")

local mat = Material("sprites/light_glow02_add")

function EFFECT:Render()
	local _y = (math.max(0, (self.DieTime - CurTime()) * inv))
	local _y2 = (math.max(0, (self.DieTime2 - CurTime()) * inv2))
	local __x = (math.sin(CurTime() * 20) * 0.5 + 1)
	local size = _y * 128
	local size2 = _y2 * 48

	render.SetMaterial(MRToFrance_beamSeanTyas)
	//render.DrawSprite(self:GetPos(), size * __x, size * __x, Color(255,128,0,size))
	render.DrawBeam(self:GetPos(), self:GetPos() + self.Normal * size2, 16, 0.9, 0, Color(255,255,255,_y2 * 255))
	render.SetMaterial(mat)
	render.DrawQuadEasy(self:GetPos(), self.Normal, _y * 90, _y * 90, Color(255,128,0,_y2 * 255))
end

function EFFECT:Think()
	return self.DieTime > CurTime()
end