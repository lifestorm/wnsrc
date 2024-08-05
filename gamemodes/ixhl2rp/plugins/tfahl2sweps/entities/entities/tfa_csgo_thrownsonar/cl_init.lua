--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

include("shared.lua")

function ENT:Think()
	local CT = CurTime()
	local FT = FrameTime()
	local attach = self:LookupAttachment("Wick")
	local data = self:GetAttachment(attach)
	local attpos,attangs
	attpos = data.Pos
	attangs = data.Ang

	if self:GetNWBool("Fused") then
		ParticleEffect("weapon_sensorgren_beeplight",attpos,attangs,self)
		self.ParticleCreated = true
		self:StopParticles()
		if self.FuseTime then
			if self.FuseTime <= CT then
				if not self.NextBeep then
					self.DetonateTime = CT + 1.5
					self.NextBeep     = 0
				end

				self.NextBeep = self.NextBeep - FT * 6
				self:StopParticles()
				self.ParticleCreated = false

				if self.NextBeep <= 0 and self.ParticleCreated == false then
					self.NextBeep = 1
				end
			end
		else
			self.FuseTime = CT + 0.65
			self:StopParticles()
		end
	end
end

local tr, col = {}, Color(255, 25, 25)
local glow = Material("tfa_csgo/sprites/flare_sprite_02")

function ENT:Draw()
	local ply = LocalPlayer()
	local attach = self:LookupAttachment("Wick")
	local data = self:GetAttachment(attach)
	local attpos,attangs
	attpos = data.Pos
	attangs = data.Ang

	self:DrawModel()

	local CT = CurTime()

	if self.NextBeep then
		if self.NextBeep > 0 then
			tr.start  = self:GetPos()
			tr.endpos = ply:EyePos()
			tr.mask   = MASK_SOLID
			tr.filter = { self, ply, ply:GetActiveWeapon() }

			local trace    = util.TraceLine(tr)
			local fraction = trace.Fraction

			if self.DetonateTime > CT then
				self:StopParticles()
			end
		end
	end
end

local TFA_HaloManager = {}
TFA_HaloManager.EVENT_NAME = "TFA_SONAR"

-- Taken from Sakarias88's Intelligent HUD
local function GetEntityAABB(ent)
	local mins = ent:OBBMins()
	local maxs = ent:OBBMaxs()

	local pos = {
		ent:LocalToWorld(Vector(maxs.x, maxs.y, maxs.z)):ToScreen(),
		ent:LocalToWorld(Vector(maxs.x, mins.y, maxs.z)):ToScreen(),
		ent:LocalToWorld(Vector(maxs.x, maxs.y, mins.z)):ToScreen(),
		ent:LocalToWorld(Vector(maxs.x, mins.y, mins.z)):ToScreen(),
		ent:LocalToWorld(Vector(mins.x, maxs.y, maxs.z)):ToScreen(),
		ent:LocalToWorld(Vector(mins.x, mins.y, maxs.z)):ToScreen(),
		ent:LocalToWorld(Vector(mins.x, maxs.y, mins.z)):ToScreen(),
		ent:LocalToWorld(Vector(mins.x, mins.y, mins.z)):ToScreen()
	}

	local minX = pos[1].x
	local minY = pos[1].y

	local maxX = pos[1].x
	local maxY = pos[1].y

	for k = 2, 8 do
		if pos[k].x > maxX then
			maxX = pos[k].x
		end

		if pos[k].y > maxY then
			maxY = pos[k].y
		end

		if pos[k].x < minX then
			minX = pos[k].x
		end

		if pos[k].y < minY then
			minY = pos[k].y
		end
	end

	return Vector(minX, minY), Vector(maxX, maxY)
end

local function TFA_SONAR_CREATE_HALOS(len, ply)
	local entnum = net.ReadInt(14)

	for i = 1, entnum do
		TFA_HaloManager:Add(net.ReadEntity(), 3)
	end
end
net.Receive("TFA_CSGO_SONAR_EXPLODE", TFA_SONAR_CREATE_HALOS)

function TFA_HaloManager:Add(ent, t)
	if not IsValid(ent) then return end

	table.insert(self, {ent = ent, t = CurTime() + t})
	self:Enable()
end

local _ents = {}
local halo_color = Color(255, 0, 0)

function TFA_HaloManager:Enable()
	local events = hook.GetTable()

	local tab = events["PreDrawHalos"]

	if tab and not tab[self.EVENT_NAME] or not tab then
		hook.Add("PreDrawHalos", self.EVENT_NAME, function()
			self:DrawHalo()
		end)
	end

	local tab = events["PostDrawOpaqueRenderables"]

	if tab and not tab[self.EVENT_NAME] or not tab then
		hook.Add("PostDrawOpaqueRenderables", self.EVENT_NAME, function()
			self:Draw()
		end)
	end
end

function TFA_HaloManager:Disable()
	hook.Remove("PreDrawHalos", self.EVENT_NAME)
	hook.Remove("PostDrawOpaqueRenderables", self.EVENT_NAME)
end

local mat1 = Material("models/debug/debugwhite")
function TFA_HaloManager:Draw()
	for k, v in ipairs(self) do
		if not IsValid(v.ent) then self[k] = nil continue end
		render.ClearStencil()
		render.SetStencilEnable(true)

		render.SetStencilWriteMask(255)
		render.SetStencilTestMask(255)
		render.SetStencilReferenceValue(1)

		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
		render.SetStencilFailOperation(STENCILOPERATION_KEEP)
		render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
		render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)

		v.ent:DrawModel()

		render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

		local mins, maxs = GetEntityAABB(v.ent)

		cam.Start2D()
			local health    = v.ent:Health()
			local maxHealth = v.ent:GetMaxHealth()

			local mul = math.Clamp(health / maxHealth, 0, 1)

			local x = mins.x
			local y = mins.y + (maxs.y - mins.y) * mul

			local w = maxs.x - x
			local h = maxs.y - y

			surface.SetDrawColor(255, 0, 0, 32)
			surface.DrawRect(x, y, w, h)
		cam.End2D()

		render.SetStencilEnable(false)
	end
end

function TFA_HaloManager:DrawHalo()
	local CT = CurTime()

	for i = 1, #_ents do
		_ents[i] = nil
	end

	for k, v in ipairs(self) do
		if (not IsValid(v.ent) or v.ent:Health() <= 0) or v.t <= CT then
			table.remove(self, k)
		else
			table.insert(_ents, v.ent)
		end
	end

	halo.Add(_ents, halo_color, 2, 2, 2, true, true )

	if #self <= 0 then
		self:Disable()
	end
end