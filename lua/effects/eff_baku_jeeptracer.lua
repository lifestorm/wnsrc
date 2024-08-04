--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local lifetime = 0.2
local inverse = 1 / lifetime

function EFFECT:Init(data)
	self.DieTime = CurTime() + lifetime

	self.Entity = data:GetEntity()
	self.Attachment = data:GetAttachment()
	self.StartPos = data:GetStart() or Vector(0, 0, 0)
	self.Scale = 1

	if(IsValid(self.Entity)) then
		self.StartPos = self.Entity:GetAttachment(self.Attachment).Pos
	end

	self.EndPos = data:GetOrigin()

	self:SetRenderBoundsWS(self.StartPos, self.EndPos)

	local flags = data:GetFlags()

	local dontdrawbeam = bit.band(flags, 4) > 0

	self.Beam = {}

	if(!dontdrawbeam) then
		for i = 1, math.random(1, 3) do
			local beam = {}
			beam[1] = self.StartPos

			local breaks = math.max(self.EndPos:Distance(self.StartPos) / (300), 3)

			for i = 2, breaks do
				local x_ = LerpVector( (i - 1) / breaks, self.StartPos, self.EndPos)
				beam[i] = x_
			end

			beam[#beam + 1] = self.EndPos

			self.Beam[i] = beam
		end
	end
end

local beam = CreateMaterial("baku_jeep_tracer", "UnlitGeneric", { ["$basetexture"] = "sprites/laserbeam", ["$vertexcolor"] = 1,
		["$vertexalpha"] = 1,
		["$additive"] = 1, })

function EFFECT:Render()
	local size = Lerp( (self.DieTime - CurTime()) * inverse, 0, 16 * self.Scale )

	render.SetMaterial(beam)
	render.DrawBeam(self.StartPos, self.EndPos, size, 0, 1, Color(255, 185, 40))

	for k, v in pairs(self.Beam) do
		render.StartBeam(#v)
			render.AddBeam(v[1], size * 0.2, 0, Color(255, 255, 255))
			for i = 2, #v - 2 do
				render.AddBeam(v[i] + VectorRand() * 5, size * 0.2, 0, Color(255, 255, 255))
			end
			render.AddBeam(v[#v], size * 0.2, 0, Color(255, 255, 255))
		render.EndBeam()
	end
end

function EFFECT:Think()
	return self.DieTime > CurTime()
end