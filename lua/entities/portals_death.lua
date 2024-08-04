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

ENT.Base = "portals_base"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Death Portal"
ENT.Category = "Portals"

ENT.Spawnable = true
ENT.AdminOnly = true

ENT.Mins = Vector(-40, -40, -50)
ENT.Maxs = Vector(40, 40, 40)

if CLIENT then
	function ENT:OnRemove()
		if self.Sound then
			self.Sound:Stop()
		end
	end

	function ENT:GetCustomColor()
		return Color(255, 80, 80)
	end

	local matrix = Matrix()

	matrix:SetScale(Vector(2, 2, 2))

	function ENT:Think()
		local light = DynamicLight(self:EntIndex())
		local color = self:GetCustomColor()

		if self:GetColor() != color then
			self:SetColor(color)
		end

		if light then
			light.pos = self:GetPos()
			light.r = 255
			light.g = 32
			light.b = 32
			light.brightness = 2
			light.Decay = 1000
			light.Size = 256
			light.DieTime = CurTime() + 1
		end

		if not self.Sound then
			self.Sound = CreateSound(self, "ambient/levels/citadel/citadel_drone_loop2.wav")
			self.Sound:ChangePitch(0.2)
			self.Sound:SetSoundLevel(75)
		end

		if not self.Sound:IsPlaying() then
			self.Sound:Play()
		end

		self:EnableMatrix("RenderMultiply", matrix)
	end

	local developer = GetConVar("developer")

	local sprite = Material("sprites/light_glow02_add")
	local mat = CreateMaterial("portal_death", "UnlitTwoTexture", {
		["$basetexture"] = "models/effects/vortshield_color",
		["$texture2"] = "models/effects/vortshield_base",
		["$model"] = 1,
		["$nocull"] = 1,
		["$additive"] = 1,
		["Proxies"] = {
			["TextureScroll"] = {
				["texturescrollvar"] = "$texture2transform",
				["texturescrollrate"] = -0.1,
				["texturescrollangle"] = 0
			}
		}
	})

	function ENT:DrawTranslucent()
		if developer:GetBool() then
			local mins = self.Mins - Vector(0.1, 0.1, 0.1)
			local maxs = self.Maxs + Vector(0.1, 0.1, 0.1)

			local color = ColorAlpha(self.Color, 50)

			render.SetColorMaterial()
			render.DrawBox(self:GetPos(), self:GetNetworkAngles(), mins, maxs, color, true)
			render.DrawWireframeBox(self:GetPos(), self:GetNetworkAngles(), mins, maxs, color, true)
		end

		local size = 250

		render.OverrideBlend(true, BLEND_ZERO, BLEND_ONE_MINUS_SRC_COLOR, BLENDFUNC_ADD)
		render.SetMaterial(sprite)
		render.DrawSprite(self:GetPos(), size, size)
		render.DrawSprite(self:GetPos(), size, size)
		render.OverrideBlend(false)

		local ang = (EyePos() - self:GetPos()):Angle()

		render.MaterialOverride(mat)

		self:SetRenderAngles(ang)
		self:SetupBones()
		self:DrawModel()

		render.MaterialOverride()
	end
else
	function ENT:StartTouch(ent)
		if not self:IsValidEntity(ent) then
			return
		end

		ent:ForcePlayerDrop()

		if ent:IsPlayer() then
			ent:SetPos(self:WorldSpaceCenter())
			ent:KillSilent()
			ent:ScreenFade(SCREENFADE.IN, Color(255, 0, 0), 2.5, 0)

			self:EmitSound("npc/stalker/go_alert2.wav", 140, 40, 1)
		else
			ent:Remove()
		end

		self:TeleportEffect()
	end
end
