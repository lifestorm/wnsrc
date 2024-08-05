--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local vector_origin = Vector()

TFA.Particles = TFA.Particles or {}
TFA.Particles.FlareParts = {}
TFA.Particles.VMAttachments = {}

local VMAttachments = TFA.Particles.VMAttachments
local FlareParts = TFA.Particles.FlareParts

local ply, vm, wep

local IsValid_ = FindMetaTable("Entity").IsValid
local GetModel = FindMetaTable("Entity").GetModel
local lastVMModel, lastVMAtts

local lastRequired = 0
local RealTime = RealTime
local FrameTime = FrameTime
local LocalPlayer = LocalPlayer
local ipairs = ipairs
local istable = istable
local isfunction = isfunction
local WorldToLocal = WorldToLocal
local table = table

local thinkAttachments = {}
local slowThinkers = 0

hook.Add("PreDrawEffects", "TFAMuzzleUpdate", function()
	if lastRequired < RealTime() then return end

	if not ply then
		ply = LocalPlayer()
	end

	if not IsValid_(vm) then
		vm = ply:GetViewModel()
		if not IsValid_(vm) then return end
	end

	local vmmodel = GetModel(vm)

	if vmmodel ~= lastVMModel then
		lastVMModel = vmmodel
		lastVMAtts = vm:GetAttachments()
	end

	if not lastVMAtts then return end

	if slowThinkers == 0 then
		for i in pairs(thinkAttachments) do
			VMAttachments[i] = vm:GetAttachment(i)
		end
	else
		for i = 1, #lastVMAtts do
			VMAttachments[i] = vm:GetAttachment(i)
		end
	end

	for _, v in ipairs(FlareParts) do
		if v and v.ThinkFunc then
			v:ThinkFunc()
		end
	end
end)

function TFA.Particles.RegisterParticleThink(particle, partfunc)
	if not particle or not isfunction(partfunc) then return end

	if not ply then
		ply = LocalPlayer()
	end

	if not IsValid_(vm) then
		vm = ply:GetViewModel()
		if not IsValid_(vm) then return end
	end

	particle.ThinkFunc = partfunc

	if IsValid(particle.FollowEnt) and particle.Att then
		local angpos = particle.FollowEnt:GetAttachment(particle.Att)

		if angpos then
			particle.OffPos = WorldToLocal(particle:GetPos(), particle:GetAngles(), angpos.Pos, angpos.Ang)
		end
	end

	local att = particle.Att

	local isFast = partfunc == TFA.Particles.FollowMuzzle and att ~= nil
	local isVM = particle.FollowEnt == vm

	if isFast then
		if isVM then
			thinkAttachments[att] = (thinkAttachments[att] or 0) + 1
		end
	else
		slowThinkers = slowThinkers + 1
	end

	table.insert(FlareParts, particle)

	timer.Simple(particle:GetDieTime(), function()
		if particle then
			table.RemoveByValue(FlareParts, particle)
		end

		if not isFast then
			slowThinkers = slowThinkers - 1
		elseif isVM and att then
			thinkAttachments[att] = thinkAttachments[att] - 1
			if thinkAttachments[att] <= 0 then thinkAttachments[att] = nil end
		end
	end)

	lastRequired = RealTime() + 0.5
end

function TFA.Particles.FollowMuzzle(self, first)
	if lastRequired < RealTime() then
		lastRequired = RealTime() + 0.5
		return
	end

	lastRequired = RealTime() + 0.5

	if self.isfirst == nil then
		self.isfirst = false
		first = true
	end

	if not IsValid_(ply) or not IsValid_(vm) then return end
	wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep.IsCurrentlyScoped and wep:IsCurrentlyScoped() then return end

	if not IsValid(self.FollowEnt) then return end
	local owent = self.FollowEnt:GetOwner() or self.FollowEnt
	if not IsValid(owent) then return end

	local firvel

	if first then
		firvel = owent:GetVelocity() * FrameTime() * 1.1
	else
		firvel = vector_origin
	end

	if not self.Att or not self.OffPos then return end

	if self.FollowEnt == vm then
		local angpos = VMAttachments[self.Att]

		if angpos then
			local tmppos = LocalToWorld(self.OffPos, self:GetAngles(), angpos.Pos, angpos.Ang)
			local npos = tmppos + self:GetVelocity() * FrameTime()
			self.OffPos = WorldToLocal(npos + firvel, self:GetAngles(), angpos.Pos, angpos.Ang)
			self:SetPos(npos + firvel)
		end

		return
	end

	local angpos = self.FollowEnt:GetAttachment(self.Att)

	if angpos then
		local tmppos = LocalToWorld(self.OffPos, self:GetAngles(), angpos.Pos, angpos.Ang)
		local npos = tmppos + self:GetVelocity() * FrameTime()
		self.OffPos = WorldToLocal(npos + firvel * 0.5, self:GetAngles(), angpos.Pos, angpos.Ang)
		self:SetPos(npos + firvel)
	end
end
