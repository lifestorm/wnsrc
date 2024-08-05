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

ENT.Type = "anim"
ENT.PrintName = "Sawblade"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

ENT.glitchthreshold = 24 --threshold distance from bone to reset pos
ENT.glitchthresholds = {}
ENT.glitchthresholds["ValveBiped.Bip01_Head1"] = 8
ENT.glitchthresholds["ValveBiped.Bip01_Head"] = 8
ENT.glitchthresholds["ValveBiped.Bip01_R_Hand"] = 1
ENT.glitchthresholds["ValveBiped.Bip01_L_Hand"] = 1
ENT.glitchthresholds["ValveBiped.Bip01_Spine2"] = 40

ENT.Hull = 1.5 --Expand hull to make it easier to grab
ENT.PredictCL = false
ENT.UseMod = false --Experimentally modify the parent's Use func

local cv_al = GetConVar("sv_tfa_arrow_lifetime")
local nzombies

local function GetBoneCenter(ent, bone)
	local bonechildren = ent:GetChildBones(bone)

	if #bonechildren <= 0 then
		return ent:GetBonePosition(bone)
	else
		local bonepos = ent:GetBonePosition(bone)
		local tmppos = bonepos

		if tmppos then
			for i = 1, #bonechildren do
				local childpos = ent:GetBonePosition(bonechildren[i])

				if childpos then
					tmppos = (tmppos + childpos) / 2
				end
			end
		else
			return ent:GetPos()
		end

		return tmppos
	end
end

function ENT:Initialize()

	if nzombies == nil then
		nzombies = nZombies or NZ or NZombies or engine.ActiveGamemode() == "nzombies"
	end

	local mdl = self:GetModel()

	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/weapons/w_tfa_arrow.mdl")
	end

	if SERVER then

		local mins = (self:OBBMins() and self:OBBMins() or Vector(0, 0, 0)) - Vector(1, 1, 1)
		local maxs = (self:OBBMaxs() and self:OBBMaxs() or Vector(0, 0, 0)) + Vector(1, 1, 1)
		self:PhysicsInitBox(mins * self.Hull, maxs * self.Hull)
		--self:PhysicsInit( SOLID_VPHYSICS )
		--self:SetSolid( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		local phys = self:GetPhysicsObject()

		if (phys:IsValid()) then
			phys:Wake()
			phys:SetMass(2)
			phys:EnableGravity(false)
			phys:EnableCollisions(false)
		end

		if self.SetUseType then
			self:SetUseType(SIMPLE_USE)
		end

		if cv_al:GetInt() ~= -1 then
			timer.Simple( cv_al:GetFloat(), function()
				if IsValid(self) then
					self:Remove()
				end
			end)
		end

		self:SetUseType( SIMPLE_USE )
	end

	if SERVER then
		self:TargetEnt( true )
	end

	if CLIENT then
		self:SetPredictable(false)
	end

	if (self:GetModel() and self:GetModel() == "") then
		self:SetModel("models/weapons/w_tfa_arrow.mdl")
	end

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	self:DrawShadow(true)
end

function ENT:TargetEnt( init )
	if self.targent and IsValid(self.targent) then
		if init then
			local ent, bone, bonepos, bonerot
			ent = self.targent
			bone = self.targent:TranslatePhysBoneToBone(self.targphysbone)
			self.targbone = bone

			if not ent:GetBoneCount() or ent:GetBoneCount() <= 1 or string.find(ent:GetModel(), "door") then
				bonepos = ent:GetPos()
				bonerot = ent:GetAngles()
				self.enthasbones = false
			else
				if ent.SetupBones then
					ent:SetupBones()
				end

				bonepos, bonerot = ent:GetBonePosition(bone)
				self.enthasbones = true
			end

			if self.enthasbones == true then
				local gpos = self:GetPos()
				local bonepos2 = GetBoneCenter(ent, bone)
				local tmpgts = self.glitchthresholds[ent:LookupBone(bone)] or self.glitchthreshold

				while gpos:Distance(bonepos2) > tmpgts do
					self:SetPos((gpos + bonepos2) / 2)
					gpos = (gpos + bonepos2) / 2
				end
			end

			if not bonepos then
				bonepos = ent:GetPos()
				bonerot = ent:GetAngles()
			end

			self.posoff, self.angoff = WorldToLocal(self:GetPos(), self:GetAngles(), bonepos, bonerot)
		end
		self:FollowBone( self.targent, self.targbone or -1 )
		self:SetOwner( self.targent )
		self:SetLocalPos( self.posoff )
		self:SetLocalAngles( self.angoff )
		self.HTE = true
		if SERVER and self.PredictCL then
			timer.Simple(0.05,function()
				if IsValid(self) then
					net.Start("tfaArrowFollow")
					net.WriteEntity( self )
					net.WriteEntity( self.targent )
					net.WriteInt( self.targbone, 8 )
					net.WriteVector( self.posoff )
					net.WriteAngle( self.angoff )
					net.Broadcast()
				end
			end)
		end
	end
end

function ENT:Think()
	if CLIENT and not self.PredictCL then return end
	if IsValid(self.targent) and self.targent.Health and self.targent:Health() <= 0 and self.targent.GetRagdollEntity then
		local rag = self.targent:GetRagdollEntity()
		if IsValid(rag) then
			self.targent = rag
			self:TargetEnt( false )
		end
	end
	local par = self:GetParent()
	if IsValid(par) and self.UseMod and not par.HasUseMod then
		par.HasUseMod = true
		par.ArrowUseOld = par.ArrowUseOld or par.Use
		par.Use = function( parent, ... )
			for _,v in pairs( par:GetChildren() ) do
				if v.Use then v:Use(...) end
			end
			parent:Use( ... )
		end
		par:SetUseType( SIMPLE_USE )
	end
	if SERVER and not self.HTE then
		self:TargetEnt( true )
	end
	self:NextThink(CurTime())
	return true
end