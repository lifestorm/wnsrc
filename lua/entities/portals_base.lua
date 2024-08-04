--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Type = "anim"

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.Model = Model("models/effects/intro_vortshield.mdl")

ENT.Mins = Vector(-25, -25, -25)
ENT.Maxs = Vector(25, 25, 25)

function ENT:Initialize()
	self:SetModel(self.Model)

	self:DrawShadow(false)

	if SERVER then
		self:PhysicsInitBox(self.Mins, self.Maxs)
		self:SetMoveType(MOVETYPE_NONE)

		self:SetTrigger(true)
	end

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:GetCustomColor()
	return color_white
end

if CLIENT then
	local lightsEnabled = GetConVar("portals_lights_enabled")
	local lightsRange = GetConVar("portals_lights_range")

	function ENT:ShouldDoLight() -- Convar
		if not lightsEnabled:GetBool() then
			return false
		end

		local range = lightsRange:GetFloat() * lightsRange:GetFloat()

		return not self:IsDormant() and EyePos():DistToSqr(self:GetPos()) < range
	end

	function ENT:Think()
		local color = self:GetCustomColor()

		if self:GetColor() != color then
			self:SetColor(color)
		end

		if self:ShouldDoLight() then
			local light = DynamicLight(self:EntIndex())

			if light then
				light.pos = self:GetPos()
				light.r = color.r
				light.g = color.g
				light.b = color.b
				light.brightness = 2
				light.Decay = 1000
				light.Size = 128
				light.DieTime = CurTime() + 1
			end
		end

		self:RemoveAllDecals()
	end

	local developer = GetConVar("developer")
	local sprite = Material("sprites/light_glow02_add")

	function ENT:DrawTranslucent()
		if developer:GetBool() then
			local mins = self.Mins - Vector(0.1, 0.1, 0.1)
			local maxs = self.Maxs + Vector(0.1, 0.1, 0.1)

			local color = ColorAlpha(self:GetCustomColor(), 50)

			render.SetColorMaterial()
			render.DrawBox(self:GetPos(), self:GetNetworkAngles(), mins, maxs, color, true)
			render.DrawWireframeBox(self:GetPos(), self:GetNetworkAngles(), mins, maxs, color, true)

			render.DrawLine(self:GetPos(), self:GetPos() + self:GetForward() * 50, self:GetCustomColor(), true)
		end

		render.OverrideBlend(true, BLEND_ZERO, BLEND_ONE_MINUS_SRC_COLOR, BLENDFUNC_ADD)
		render.SetMaterial(sprite)
		render.DrawSprite(self:GetPos(), 150, 150)
		render.OverrideBlend(false)

		local ang = (EyePos() - self:GetPos()):Angle()

		self:SetRenderAngles(ang)
		self:SetupBones()
		self:DrawModel()
		self:DrawModel()
	end
else
	local allowSound = GetConVar("portals_allow_custom_sounds")
	local defaultSound = GetConVar("portals_default_sound")
	local extendedWhitelist = GetConVar("portals_extended_whitelist")

	function ENT:TeleportEffect(ent)
		if not ent then
			ent = self
		end

		local snd = defaultSound:GetString()

		if allowSound:GetBool() and self.GetTeleportSound then
			snd = self:GetTeleportSound()
		end

		if snd == "" then
			return
		end

		ent:EmitSound(snd, 75, 100, 0.5)
	end

	function ENT:IsValidEntity(ent)
		if ent:IsPlayer() then
			return ent:GetMoveType() != MOVETYPE_NOCLIP
		end

		if not extendedWhitelist:GetBool() and not ent:IsNPC() then
			return false
		end

		local phys = ent:GetPhysicsObject()

		if IsValid(phys) and not phys:IsMotionEnabled() then
			return false
		end

		local class = ent:GetClass()

		if string.find(class, "prop_dynamic") then return false end
		if string.find(class, "prop_door") then return false end
		if class == "func_physbox" and ent:HasSpawnFlags(SF_PHYSBOX_MOTIONDISABLED) then return false end
		if string.find(class, "prop_") and (ent:HasSpawnFlags(SF_PHYSPROP_MOTIONDISABLED) or ent:HasSpawnFlags(SF_PHYSPROP_PREVENT_PICKUP)) then return false end
		if class != "func_physbox" and string.find(class, "func_") then return false end

		return true
	end
end
