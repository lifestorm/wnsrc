--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


local PLUGIN = PLUGIN

PLUGIN.name = "Legs"
PLUGIN.author = "Valkyrie & blackops7799 & M!NT"
PLUGIN.description = "Renders the characters legs to the local player."
PLUGIN.license = [[
This is free and unencumbered software released into the public domain.
Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this software dedicate any and all copyright interest in the software to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
For more information, please refer to <http://unlicense.org/>
]]

ix.lang.AddTable("english", {
	legs = "Legs",

	optLegsEnabled = "Enable legs",
	optdLegsEnabled = "Whether you should see your character's legs when you look down.",
	optLegsInVehicle = "Enable legs in vehicles",
	optdLegsInVehicle = "Whether you should see your character's legs when you are in a vehicle."
})

ix.lang.AddTable("spanish", {
	legs = "Piernas",
	optLegsInVehicle = "Activar piernas en vehículos",
	optLegsEnabled = "Habilita las piernas"
})

if (CLIENT) then
	ix.option.Add("legsEnabled", ix.type.bool, true, {
		category = "legs"
	})

	local Legs = {}
	Legs.LegEnt = nil

	function Legs:Setup(model)
		local ply = LocalPlayer()
		model = model or ply:GetModel()

		-- remake this every time due to conflicts
		self.LegEnt = ClientsideModel(model, RENDER_GROUP_OPAQUE_ENTITY)

		self.LegEnt:SetNoDraw(true)

		for _, v in pairs(ply:GetBodyGroups()) do
			local current = ply:GetBodygroup(v.id)
			self.LegEnt:SetBodygroup(v.id,  current)
		end

		for k, _ in ipairs(ply:GetMaterials()) do
			self.LegEnt:SetSubMaterial(k - 1, ply:GetSubMaterial(k - 1))
		end

		self.IsFemale = ply:IsFemale()
		self.LegEnt:SetSkin(ply:GetSkin())
		self.LegEnt:SetMaterial(ply:GetMaterial())
		self.LegEnt:SetColor(ply:GetColor())
		self.LegEnt.GetPlayerColor = function()
			return ply:GetPlayerColor()
		end
		self.LegEnt.Anim = nil
		self.PlaybackRate = 1
		self.Sequence = nil
		self.Velocity = 0
		self.BonesToRemove = {}
		self.LegEnt.LastTick = 0
		self.HeadBone = ply:LookupBone("ValveBiped.Bip01_Head1")
		self:Update(0)
		self.Arms =
		{
			"ValveBiped.Bip01_L_Upperarm",
			"ValveBiped.Bip01_L_Forearm",
			"ValveBiped.Bip01_R_Upperarm",
			"ValveBiped.Bip01_R_Forearm"
		}

		local colorProxies = ply:GetCharacter():GetProxyColors() or {}
		for proxy, vector in pairs(colorProxies) do
			local color = vector
			if !isvector(color) and istable(color) and color.r then
				color = Vector(color.r / 255, color.g / 255, color.b / 255)
			end

			self.LegEnt:SetNWVector(proxy, color)
		end
	end

	Legs.PlaybackRate = 1
	Legs.Sequence = nil
	Legs.Velocity = 0
	Legs.BonesToRemove = {}
	Legs.BreathScale = 0.5
	Legs.NextBreath = 0

	function Legs:Think(maxSeqGroundSpeed)
		if (!LocalPlayer():Alive()) then
			Legs:Setup()
			return
		end
		self:Update(maxSeqGroundSpeed)
	end

	function Legs:UpdateAniSequence(idle_seq, walk_seq, run_seq, jump_seq)
		local player = LocalPlayer()
		self.Sequence = idle_seq
		if (player:KeyDown(IN_FORWARD)
		or player:KeyDown(IN_MOVELEFT)
		or player:KeyDown(IN_MOVERIGHT)
		or player:KeyDown(IN_BACK)
		) then
			self.Sequence = walk_seq
		end
		if (player:KeyDown(IN_SPEED) and self.Velocity > 130) then
			self.Sequence = run_seq
		end
		if (player:GetGroundEntity() == NULL) then
			self.Sequence = jump_seq
		end
	end

	local validTypes = {
		["citizen_male"] = true,
		["citizen_female"] = true,
		["metrocop"] = true,
		["metrocop_female"] = true
	}

	function Legs:Update(maxSeqGroundSpeed)
		if (!IsValid(self.LegEnt)) then
			return
		end

		--[[
			Silly setsequence hacks to get the animations to work.
		]]
		if (!validTypes[self.AnimationType]) then
			self.InvalidModel = true
			return
		end

		-- get the animation table set in the faction code
		local _tbl = ix.anim[self.AnimationType]
		if (!_tbl or !istable(_tbl)) then
			self.InvalidModel = true
			return
		end

		local seqs = {
			[1] = _tbl.normal[ACT_MP_STAND_IDLE][1],
			[2] = _tbl.normal[ACT_MP_WALK][1],
			[3] = _tbl.normal[ACT_MP_RUN][1],
			[4] = _tbl.normal[ACT_LAND][1],
		}

		for k, v in ipairs(seqs) do
			if (v == nil) then
				self.InvalidModel = true
				return
			end

			-- sometimes these are strings, because helix is a mess.
			-- or they're nil or something like that, but either way, we don't want that.
			-- the overwatch models have this condition for some reason. I don't know why. I don't know why. I don't know why.
			if (!isnumber(v)) then
				self.InvalidModel = true
				return
			end
		end

		self:UpdateAniSequence(
			self.LegEnt:SelectWeightedSequence(seqs[1]),
			self.LegEnt:SelectWeightedSequence(seqs[2]),
			self.LegEnt:SelectWeightedSequence(seqs[3]),
			self.LegEnt:SelectWeightedSequence(seqs[4])
		)


		if (self.LegEnt.Anim != self.Sequence) then
			self.LegEnt.Anim = self.Sequence
			self.LegEnt:ResetSequence(self.Sequence)
		end

		--[[
			Finally done fucking with touchy model anim sequences. Yay!
		]]

		local client = LocalPlayer()
		self.Velocity = client:GetVelocity():Length2D()
		self.PlaybackRate = 1

		if (self.Velocity > 0.5) then
			if (maxSeqGroundSpeed < 0.001) then
				self.PlaybackRate = 0.01
			else
				self.PlaybackRate = self.Velocity / maxSeqGroundSpeed
				self.PlaybackRate = math.Clamp(self.PlaybackRate, 0.01, 10)
			end
		end

		self.LegEnt:SetPlaybackRate(self.PlaybackRate)
		self.LegEnt:FrameAdvance(CurTime() - self.LegEnt.LastTick)
		self.LegEnt.LastTick = CurTime()
		Legs.BreathScale = 0.5

		if (Legs.NextBreath <= CurTime()) then
			Legs.NextBreath = CurTime() + 1.95 / Legs.BreathScale
			self.LegEnt:SetPoseParameter("breathing", Legs.BreathScale)
		end

		self.LegEnt:SetPoseParameter(
			"move_x",
			(client:GetPoseParameter("move_x") * 2) - 1
		) -- Translate the walk x direction
		self.LegEnt:SetPoseParameter(
			"move_y",
			(client:GetPoseParameter("move_y") * 2) - 1
		) -- Translate the walk y direction
		self.LegEnt:SetPoseParameter(
			"move_yaw",
			(client:GetPoseParameter("move_yaw") * 360) - 180
		) -- Translate the walk direction
		self.LegEnt:SetPoseParameter(
			"body_yaw",
			(client:GetPoseParameter("body_yaw") * 180) - 90
		) -- Translate the body yaw
		self.LegEnt:SetPoseParameter(
			"spine_yaw",
			(client:GetPoseParameter("spine_yaw") * 180) - 90
		) -- Translate the spine yaw
	end

	Legs.RenderAngle = nil
	Legs.BiaisAngle = nil
	Legs.RadAngle = nil
	Legs.RenderPos = nil
	Legs.RenderColor = {}
	Legs.ClipVector = vector_up * -1
	Legs.ForwardOffset = -24
	Legs.eyeposOffsetLerp = 0.01
	Legs.eyeposOffset = Vector(0,0,5)
	Legs.desiredEyeposOffset = Vector(0,0,0)
	Legs.decreaseLerp = false

	function Legs:ShouldDrawLegs()
		if (hook.Run("ShouldDisableLegs") == true) then
			return false
		end

		if (ix.option.Get("legsEnabled", true)) then
			local client = LocalPlayer()
			return  IsValid(Legs.LegEnt) and
					(client:Alive() or (client.IsGhosted and client:IsGhosted())) and
					!client:ShouldDrawLocalPlayer() and !IsValid(client:GetObserverTarget()) and
					!client:GetNoDraw() and !client.ShouldDisableLegs
		end
	end


	function Legs:DoOffsets()
		local player = LocalPlayer()
		if (!self.InvalidModel and self.offsetRun) then
			-- offset the camera to prevent model clipping
			self.eyeposOffsetLerp = 0
			if (player:KeyDown(IN_DUCK)) then
				self.desiredEyeposOffset = Vector(0,0,0) + self.offsetCrouch
				self.desiredEyeposOffset:Rotate(EyeAngles())
				if (!self.increaseLerp) then self.eyeposOffsetLerp = 0 end
				self.increaseLerp = true
			elseif (player:KeyDown(IN_SPEED) and !player:GetAbsVelocity():IsZero()) then
				self.desiredEyeposOffset = Vector(0,0,0) + self.offsetRun
				self.desiredEyeposOffset:Rotate(EyeAngles())
				if (!self.increaseLerp) then self.eyeposOffsetLerp = 0 end
				self.increaseLerp = true
			else
				self.desiredEyeposOffset = Vector(0,0,0) + self.offsetIdle
				self.desiredEyeposOffset:Rotate(EyeAngles())
				if (!self.increaseLerp) then self.eyeposOffsetLerp = 0 end
				self.increaseLerp = true
			end
			if (player:IsWepRaised()) then
				self.desiredEyeposOffset = Vector(0,0,0) + self.offsetWep
				self.desiredEyeposOffset:Rotate(EyeAngles())
			end
			if (self.increaseLerp and self.eyeposOffsetLerp < 1) then
				self.eyeposOffsetLerp = self.eyeposOffsetLerp + 0.025
			elseif !(self.increaseLerp and self.eyeposOffsetLerp > 0) then
				self.eyeposOffsetLerp = self.eyeposOffsetLerp - 0.025
			end
			self.eyeposOffset = LerpVector(
				self.eyeposOffsetLerp,
				self.eyeposOffset,
				self.desiredEyeposOffset
			)
		end
	end

	function Legs:DoFinalRender()
		local ply = LocalPlayer()
		if (self:ShouldDrawLegs()) then
			self:DoOffsets()
			cam.Start3D(EyePos()-self.eyeposOffset, EyeAngles())
				if (ply:IsWepRaised()) then
					self:RemoveArms()
				else
					self:ResetArms()
				end
				self.RenderPos = ply:GetPos()
				self.BiaisAngles = ply:EyeAngles()
				self.RenderAngle = Angle(0, self.BiaisAngles.y, 0)
				self.RadAngle = math.rad(self.BiaisAngles.y)
				self.ForwardOffset = -13
				self.RenderPos.x = self.RenderPos.x + math.cos(self.RadAngle) * self.ForwardOffset
				self.RenderPos.y = self.RenderPos.y + math.sin(self.RadAngle) * self.ForwardOffset
				if (!self.HeadBone or !isnumber(self.HeadBone)) then
					print("The head bone for the FP legs entity has become invalidated!")
					self.InvalidModel = true
					return
				end
				self.LegEnt:ManipulateBonePosition(self.HeadBone, Vector(-10,0,0))
				if (ply:GetGroundEntity() == NULL) then
					self.RenderPos.z = self.RenderPos.z + 9

					if (ply:KeyDown(IN_DUCK)) then
						self.RenderPos.z = self.RenderPos.z - 28
					end
				end

				self.RenderColor = ply:GetColor()

				local bEnabled = render.EnableClipping(true)
					render.PushCustomClipPlane(self.ClipVector, self.ClipVector:Dot(EyePos()))
						render.SetColorModulation(
							self.RenderColor.r / 255,
							self.RenderColor.g / 255,
							self.RenderColor.b / 255
						)
							render.SetBlend(self.RenderColor.a / 255)
									self.LegEnt:SetRenderOrigin(self.RenderPos)
									self.LegEnt:SetRenderAngles(self.RenderAngle)
									self.LegEnt:SetupBones()
									self.LegEnt:DrawModel()
									self.LegEnt:SetRenderOrigin()
									self.LegEnt:SetRenderAngles()
							render.SetBlend(1)
						render.SetColorModulation(1, 1, 1)
					render.PopCustomClipPlane()
				render.EnableClipping(bEnabled)
			cam.End3D()
		end
	end

	function Legs:RemoveArms()
		for k, v in pairs(self.Arms) do
			local bone = self.LegEnt:LookupBone(v)
			if (bone) then
				self.LegEnt:ManipulateBonePosition(bone, Vector(-6,15,0))
				self.LegEnt:ManipulateBoneAngles(bone, Angle(0,0,6))
			end
		end
	end

	function Legs:ResetArms()
		for k, v in pairs(self.Arms) do
			local bone = self.LegEnt:LookupBone(v)
			if (bone) then
				self.LegEnt:ManipulateBonePosition(bone, Vector(0,0,0))
				self.LegEnt:ManipulateBoneAngles(bone, Angle(0,0,0))
			end
		end
	end

	function PLUGIN:UpdateAnimation(client, velocity, maxSeqGroundSpeed)
		if (client == LocalPlayer()) then
			if (!Legs.offsetIdle) then
				return
			elseif (IsValid(Legs.LegEnt)) then
				Legs:Think(maxSeqGroundSpeed)
			else
				Legs:Setup()
			end
		end
	end

	function PLUGIN:PlayerModelChanged(client, model)
		if (client == LocalPlayer()) then
			Legs.AnimationType = ix.anim.GetModelClass(model) or "citizen_female"
			if (Legs.AnimationType == "citizen_female") then
				Legs.InvalidModel  = false
				Legs.offsetCrouch  = Vector(0,0,-14)
				Legs.offsetRun     = Vector(-10,0,1)
				Legs.offsetIdle    = Vector(-4,0,3)
				Legs.offsetWep     = Vector(-10,0,-15)
			elseif (Legs.AnimationType == "citizen_male") then
				Legs.InvalidModel  = false
				Legs.offsetCrouch  = Vector(0,0,-14)
				Legs.offsetRun     = Vector(-5,0,0)
				Legs.offsetIdle    = Vector(-4,0,3)
				Legs.offsetWep     = Vector(-10,0,-15)
			elseif (Legs.AnimationType == "metrocop") then
				Legs.InvalidModel  = false
				Legs.offsetCrouch  = Vector(0,0,-64)
				Legs.offsetRun     = Vector(-10,0,-12)
				Legs.offsetIdle    = Vector(-4,0,3)
				Legs.offsetWep     = Vector(-10,0,-15)
			elseif (Legs.AnimationType == "metrocop_female") then
				Legs.InvalidModel  = false
				Legs.offsetCrouch  = Vector(0,0,-64)
				Legs.offsetRun     = Vector(-10,0,-12)
				Legs.offsetIdle    = Vector(-4,0,3)
				Legs.offsetWep     = Vector(-10,0,-15)
			elseif (Legs.AnimationType == "overwatch") then
				Legs.InvalidModel  = false
				Legs.offsetCrouch  = Vector(0,0,-64)
				Legs.offsetRun     = Vector(-10,0,-12)
				Legs.offsetIdle    = Vector(-4,0,3)
				Legs.offsetWep     = Vector(-10,0,-15)
			else Legs.InvalidModel = true
			end
			Legs:Setup(model)
		end
	end

	function PLUGIN:PostDrawTranslucentRenderables()
		 if (LocalPlayer() and !LocalPlayer():InVehicle() and Legs.offsetIdle and !Legs.InvalidModel) then
			Legs:DoFinalRender()
		end
	end

	net.Receive("ixUpdateLegs", function()
		timer.Simple(0.1, function() -- Timer to allow the bodygroup information to network before updating.
			Legs:Setup()
		end)
	end)
else
	util.AddNetworkString("ixUpdateLegs")

	local playerMeta = FindMetaTable("Player")

	function playerMeta:UpdateLegs()
		net.Start("ixUpdateLegs")
		net.Send(self)
	end
end