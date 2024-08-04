--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local lifetime = 0.1
local inv = 1 / lifetime

local lifetime2 = lifetime  * 0.6
local inv2 = 1 / lifetime2

local PulserPointofimpact_FractalStructure = Material("sprites/baku_impactor_smoke")

function EFFECT:Init(data)
	local ent = data:GetEntity()

	local att = data:GetAttachment()

	if(!IsValid(ent)) then return self:Remove() end

	self.Scale = math.Rand(0.7, 2) * (data:GetScale() or 1)

	if(ent:IsWeapon() && ent:IsCarriedByLocalPlayer()) then
		local ply = ent:GetOwner()

		if(!ply:ShouldDrawLocalPlayer()) then
			local vm = ply:GetViewModel()
			
			if(IsValid(vm)) then
				ent = vm
			end
		end
	end

	self.Entity = ent
	self.Attachment = att

	self.DieTime = CurTime() + lifetime
	self.DieTime2 = CurTime() + lifetime2

	local pos = ent:GetAttachment(att).Pos

	local emitter = ParticleEmitter(pos, false)
	local norm = ent:GetAttachment(att).Ang:Forward()

	local max = 5
	local imax = 1/max
	for i = 1, max do
		local vectorrand = VectorRand()
		local part = emitter:Add("sprites/flamelet1", pos + norm * (i * 10) )
		local vel = (norm + vectorrand * 0.2):GetNormalized()
		local _i = (max - i) * imax 
		part:SetVelocity(vel * 400)
		part:SetAngleVelocity(AngleRand())
		part:SetDieTime(_i * 0.2 + 0.06)

		part:SetStartAlpha( 128 );
		part:SetEndAlpha( 0 );
		part:SetStartSize( 8 * _i * self.Scale);
		part:SetGravity(Vector(0, 0, 100))
		part:SetEndSize( 13 );
		part:SetCollide( true );

		part:SetRoll(0)
		part:SetRollDelta(3)

		part:SetBounce( 0.1 );
		part:SetAirResistance( 5 );
		part:SetMaterial(PulserPointofimpact_FractalStructure)
		part:SetColor(128,128,128)

		/*part = emitter:Add("sprites/flamelet"..math.random(1,4), pos + norm * i * 5)
		vel = (norm + vectorrand * 0.1):GetNormalized()
		part:SetVelocity(vel * 200)
		part:SetAngleVelocity(AngleRand())
		part:SetStartSize(5)
		part:SetEndSize(0)
		part:SetDieTime(lifetime)*/
	end

	/*for i = 1, 10 do
		local part = emitter:Add("sprites/light_glow02_add", pos)
		local vel = (norm + VectorRand() * 0.3):GetNormalized()
		part:SetVelocity(vel * 400)
		part:SetColor(255, 128, 0)
		part:SetDieTime( math.Rand(0.08, 0.3) * self.Scale);
		part:SetStartAlpha( 255 );
		part:SetEndAlpha( 0 );
		part:SetStartSize( math.Rand(0.5, 0.8) );
		part:SetEndSize( 0 );
		part:SetGravity( Vector( 0, 0, -100 ) );
		part:SetCollide( true );
		part:SetBounce( 0.3 );
		part:SetAirResistance( 1 );
	end*/

	emitter:Finish()
end

function EFFECT:GetGoodPos()
	if(!IsValid(self.Entity)) then
		return Vector(0, 0, 0)
	end

	return self.Entity:GetAttachment(self.Attachment).Pos
end

local MRToFrance_beamSeanTyas = Material("sprites/baku_impactor")
local PPK_LoveUnlimited = Material("sprites/flamelet1")

local function mulColor(col, num)
	return Color(col.r * num, col.g * num, col.b * num, col.a * num)
end

local inv_i = 1 / 7

function EFFECT:Render()
	if(!IsValid(self.Entity)) then return end

	local fwd = self.Entity:GetAttachment(self.Attachment).Ang:Forward()
	local pos = self:GetGoodPos()
	local _x = (self.DieTime - CurTime()) * inv
	local _y = math.max((self.DieTime2 - CurTime()) * inv2, 0)

	render.SetMaterial(MRToFrance_beamSeanTyas)
	render.DrawBeam(pos, pos + fwd * _x * 30 * self.Scale, 5 * _x * self.Scale, 0.3, 1, Color(255,255,255,255))
	local size = 16 * _x * self.Scale
	render.DrawSprite(pos + fwd * 5, size, size, Color(255,128,0,128 * _y))

	render.SetMaterial(PPK_LoveUnlimited)
	local inirot = self.Scale * 180
	for i = 1, 7 do
		local _i = (7 - i) * inv_i
		local size2 = _i * _y * 14
		local pos = pos + fwd * 3 * i
		local norm = EyePos() - pos
		render.DrawQuadEasy(pos, norm, size2, size2, Color(255,255,255,255), inirot + i * 90)
	end
end

function EFFECT:Think()
	if(!IsValid(self.Entity)) then return false end

	local xpos = self:GetGoodPos()
	self:SetRenderBoundsWS(xpos, xpos, Vector(1,1,1) * 128)
	return self.DieTime > CurTime()
end

