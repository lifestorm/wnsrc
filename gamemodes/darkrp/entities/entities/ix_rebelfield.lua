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

ENT.Type = "anim"
ENT.PrintName = "Hacked Forcefield"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.PhysgunDisabled = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Mode")
	self:NetworkVar("Entity", 0, "Dummy")
	self:NetworkVar("Bool", 0, "Malfunctioning")
end

local MODE_OFFLINE = 1
local MODE_ALLOW_ALL = 2
local MODE_ALLOW_COMBINE = 3
local MODE_ALLOW_COMBINE_INF = 4

if (SERVER) then
	function ENT:SpawnFunction(client, trace)
		local angles = (client:GetPos() - trace.HitPos):Angle()
		angles.p = 0
		angles.r = 0
		angles:RotateAroundAxis(angles:Up(), 270)

		local entity = ents.Create("ix_rebelfield")
		entity:SetPos(trace.HitPos + Vector(0, 0, 40))
		entity:SetAngles(angles:SnapTo("y", 90))
		entity:Spawn()
		entity:Activate()

		Schema:SaveRebelForceFields()
		return entity
	end

	function ENT:Initialize()
		self:SetModel("models/willardnetworks/props/forcefield_left.mdl")
		self:SetSkin(3)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysicsInit(SOLID_VPHYSICS)

		local data = {}
		data.start = self:GetPos() + self:GetRight() * -16
		data.endpos = self:GetPos() + self:GetRight() * -480
		data.filter = self
		local trace = util.TraceLine(data)
		
		local angles = self:GetAngles()
		angles:RotateAroundAxis(angles:Up(), 90)
		
		self.dummy = ents.Create("prop_physics")
		self.dummy:SetModel("models/willardnetworks/props/forcefield_right.mdl")
		self.dummy:SetSkin(3)
		self.dummy:SetPos(trace.HitPos)
		self.dummy:SetAngles(self:GetAngles())
		self.dummy:Spawn()
		self.dummy.PhysgunDisabled = true
		self.dummy:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:DeleteOnRemove(self.dummy)

		local verts = {
			{pos = Vector(0, 0, -25)},
			{pos = Vector(0, 0, 150)},
			{pos = self:WorldToLocal(self.dummy:GetPos()) + Vector(0, 0, 150)},
			{pos = self:WorldToLocal(self.dummy:GetPos()) + Vector(0, 0, 150)},
			{pos = self:WorldToLocal(self.dummy:GetPos()) - Vector(0, 0, 25)},
			{pos = Vector(0, 0, -25)}
		}

		self:PhysicsFromMesh(verts)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self:AddSolidFlags(FSOLID_CUSTOMBOXTEST)
		self:SetCustomCollisionCheck(true)
		self:SetDummy(self.dummy)

		physObj = self.dummy:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

		self:SetMoveType(MOVETYPE_NOCLIP)
		self:SetMoveType(MOVETYPE_PUSH)
		self:MakePhysicsObjectAShadow()
		self:SetMode(MODE_OFFLINE)
	end

	function ENT:StartTouch(entity)
		if (!self.buzzer) then
			self.buzzer = CreateSound(entity, "ambient/machines/combine_shield_touch_loop1.wav")
			self.buzzer:Play()
			self.buzzer:ChangeVolume(0.8, 0)
			self.buzzer:SetSoundLevel(60)
		else
			self.buzzer:ChangeVolume(0.8, 0.5)
			self.buzzer:Play()
		end

		self.entities = (self.entities or 0) + 1
	end

	function ENT:EndTouch(entity)
		self.entities = math.max((self.entities or 0) - 1, 0)

		if (self.buzzer and self.entities == 0) then
			self.buzzer:FadeOut(0.5)
		end
	end

	function ENT:OnRemove()
		if (self.buzzer) then
			self.buzzer:Stop()
			self.buzzer = nil
		end

		if (!ix.shuttingDown and !self.ixIsSafe) then
			Schema:SaveRebelForceFields()
		end
	end

	ENT.MODES = {
		{
			function(entity)
				return false
			end,
			"field disengaged.",
			"disengaged",
			3
		},
		{
			function(entity)
				if (!entity:IsPlayer()) then return true end

				local character = entity:GetCharacter()
				if (!character or !character:GetInventory()) then
					return true
				end

				if (!character:GetInventory():HasItem("id_card", {active = true})) then
					if character:IsVortigaunt() and
					character:GetCollarItemID() and
					ix.item.instances[character:GetCollarItemID()] and
					-ix.config.Get("blacklistSCAmount", 40) <= ix.item.instances[character:GetCollarItemID()]:GetData("sterilizedCredits", 0) then
						return false
					end
					return false
				else
					return false
				end
			end,
			"allow all individuals",
			"engaged",
			0
		},
		{
			function(entity)
				return true
			end,
			"disallow combine forces.",
			"restricted",
			1
		},
		{
			function(entity)
				return true
			end,
			"disallow non-functionary units (Unused Variant... ignore and change!!!)",
			"restricted",
			2
		}
	}

	function ENT:Use(activator)
		if ((self.nextUse or 0) < CurTime()) then
			self.nextUse = CurTime() + 1.5
		else
			return
		end

		local bForced = CAMI.PlayerHasAccess(activator, "Helix - Basic Admin Commands", nil) and activator:GetMoveType() == MOVETYPE_NOCLIP

		if (activator:GetCharacter():HasFlags("F") or bForced) then
			self:SetMode(self:GetMode() + 1)
			local action = "modified"

			if (self:GetMode() > #self.MODES) then
				self:SetMode(MODE_OFFLINE)
				self:CollisionRulesChanged()

				self:SetSkin(self.MODES[1][4])
				self.dummy:SetSkin(self.MODES[1][4])
				self:EmitSound("npc/turret_floor/die.wav")
			else
				self:CollisionRulesChanged()

				self:SetSkin(self.MODES[self:GetMode()][4])
				self.dummy:SetSkin(self.MODES[self:GetMode()][4])
			end

			self:EmitSound("buttons/combine_button5.wav", 140, 100 + (self:GetMode() - 1) * 15)
			activator:ChatPrint("Changed barrier mode to: " .. self.MODES[self:GetMode()][2])
			
			Schema:SaveRebelForceFields()
			if (bForced) then return end
			
		end
	end

	function ENT:Malfunction()
		local bMalfunctioning = self:GetMalfunctioning()
		if (!bMalfunctioning) then return end

		timer.Simple(math.random(0.2, 1), function()
			if (!self:IsValid()) then return end

			self:SetMode(MODE_OFFLINE)
			self:CollisionRulesChanged()

			self:SetSkin(self.MODES[1][4])
			self.dummy:SetSkin(self.MODES[1][4])
			self:EmitSound("buttons/combine_button5.wav", 65, 100 + (self:GetMode() - 1) * 15)
			self:EmitSound("npc/turret_floor/die.wav", 55)
			
			local target = math.random(2) == 1 and self or self:GetDummy()
			local vPoint = target:GetPos() + Vector(0, 0, math.random(-10, 100)) + target:GetRight() * (target == self and -10 or 10)
			local effectdata = EffectData()
			effectdata:SetOrigin(vPoint)
			util.Effect("ManhackSparks", effectdata)
			
			if (math.random(2) == 1) then
				target = math.random(2) == 1 and self or self:GetDummy()
				vPoint = target:GetPos() + Vector(0, 0, math.random(-10, 100)) + target:GetRight() * (target == self and -10 or 10)
				effectdata = EffectData()
				effectdata:SetOrigin(vPoint)
				util.Effect("ManhackSparks", effectdata)
			end

			self:EmitSound("ambient/energy/zap" .. math.random(1, 9) .. ".wav", 65)

			timer.Simple(math.random(1, 5), function()
				if (!self:IsValid()) then return end

				self:SetMode(math.random(2, 4))
				self:CollisionRulesChanged()

				self:SetSkin(self.MODES[self:GetMode()][4])
				self.dummy:SetSkin(self.MODES[self:GetMode()][4])

				self:EmitSound("buttons/combine_button5.wav", 65, 100 + (self:GetMode() - 1) * 15)

				self:Malfunction()
			end)
		end)
	end

	hook.Add("ShouldCollide", "ix_rebelfields", function(a, b)
		local entity
		local forcefield

		if (a:GetClass() == "ix_rebelfield") then
			entity = b
			forcefield = a
		elseif (b:GetClass() == "ix_rebelfield") then
			entity = a
			forcefield = b
		end

		if (IsValid(forcefield)) then
			if (IsValid(entity)) then
				if (entity:IsPlayer() and ix.faction.Get(entity:Team()).allowRebelForcefieldPassage) then
					return false
				end

				local mode = forcefield:GetMode() or MODE_OFFLINE

				return istable(forcefield.MODES[mode]) and forcefield.MODES[mode][1](entity)
			else 
				return forcefield:GetMode() != 5
			end
		end
	end)
else
	SHIELD_MATERIALS = {
		nil,
		ix.util.GetMaterial("models/effects/shield_blue"),
		ix.util.GetMaterial("models/effects/shield_red"),
		ix.util.GetMaterial("models/effects/shield_yellow")
	}

	function ENT:Initialize()
		local data = {}
			data.start = self:GetPos() + self:GetRight()*-16
			data.endpos = self:GetPos() + self:GetRight()*-480
			data.filter = self
		local trace = util.TraceLine(data)

		self:SetCustomCollisionCheck(true)
		self:PhysicsInitConvex({
			vector_origin,
			Vector(0, 0, 150),
			trace.HitPos + Vector(0, 0, 150),
			trace.HitPos
		})

		self.distance = self:GetPos():Distance(trace.HitPos)
	end

	function ENT:Draw()
		self:DrawModel()

		if (self:GetMode() == MODE_OFFLINE) then
			return
		end

		local pos = self:GetPos()
		local angles = self:GetAngles()
		local matrix = Matrix()
		matrix:Translate(pos + self:GetUp() * -40)
		matrix:Rotate(angles)

		render.SetMaterial(SHIELD_MATERIALS[self:GetMode()])

		local dummy = self:GetDummy()

		if (IsValid(dummy)) then
			local dummyPos = dummy:GetPos()
			local vertex = self:WorldToLocal(dummyPos)
			self:SetRenderBounds(vector_origin, vertex + self:GetUp() * 150)

			cam.PushModelMatrix(matrix)
				self:DrawShield(vertex)
			cam.PopModelMatrix()

			matrix:Translate(vertex)
			matrix:Rotate(Angle(0, 180, 0))

			cam.PushModelMatrix(matrix)
				self:DrawShield(vertex)
			cam.PopModelMatrix()
		end
	end

	function ENT:DrawShield(vertex)
		mesh.Begin(MATERIAL_QUADS, 1)
			mesh.Position(vector_origin)
			mesh.TexCoord(0, 0, 0)
			mesh.AdvanceVertex()

			mesh.Position(self:GetUp() * 190)
			mesh.TexCoord(0, 0, 3)
			mesh.AdvanceVertex()

			mesh.Position(vertex + self:GetUp() * 190)
			mesh.TexCoord(0, 3, 3)
			mesh.AdvanceVertex()

			mesh.Position(vertex)
			mesh.TexCoord(0, 3, 0)
			mesh.AdvanceVertex()
		mesh.End()
	end
end

properties.Add("ixRebelfieldStartMalfunction", {
	MenuLabel = "Start Malfunctioning",
	Order = 500,
	MenuIcon = "icon16/lightning_add.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_rebelfield" and !entity:GetMalfunctioning() and CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands", nil)) then return true end
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		
		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		entity:SetMalfunctioning(true)
		entity:Malfunction()
	end
})

properties.Add("ixRebelfieldStopMalfunction", {
	MenuLabel = "Stop Malfunctioning",
	Order = 500,
	MenuIcon = "icon16/lightning_delete.png",

	Filter = function(self, entity, client)
		if (entity:GetClass() == "ix_rebelfield" and entity:GetMalfunctioning() and CAMI.PlayerHasAccess(client, "Helix - Basic Admin Commands", nil)) then return true end
	end,

	Action = function(self, entity)
		self:MsgStart()
			net.WriteEntity(entity)
		self:MsgEnd()
	end,

	Receive = function(self, length, client)
		local entity = net.ReadEntity()
		
		if (!IsValid(entity)) then return end
		if (!self:Filter(entity, client)) then return end

		entity:SetMalfunctioning(false)
	end
})
