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
ENT.PrintName = "Combine Lock (Conscript)"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.PhysgunDisable = true
ENT.bNoPersist = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Locked")
	self:NetworkVar("Bool", 1, "DisplayError")
	self:NetworkVar("Bool", 2, "Disabled")

	if (SERVER) then
		self:NetworkVarNotify("Locked", self.OnLockChanged)
	end
end

if (SERVER) then
	function ENT:GetLockPosition(door, normal)
		local index = door:LookupBone("handle")
		local position = door:GetPos()
		normal = normal or door:GetForward():Angle()

		if (index and index >= 1) then
			position = door:GetBonePosition(index)
		end

		position = position + normal:Forward() * 7.2 + normal:Up() * 10 + normal:Right() * 2

		normal:RotateAroundAxis(normal:Up(), 90)
		normal:RotateAroundAxis(normal:Forward(), 180)
		normal:RotateAroundAxis(normal:Right(), 180)

		return position, normal
	end

	function ENT:SetDoor(door, position, angles)
		if (!IsValid(door) or !door:IsDoor()) then
			return
		end

		local doorPartner = door:GetDoorPartner()

		self.door = door
		self.door:DeleteOnRemove(self)
		door.ixLock = self

		if (IsValid(doorPartner)) then
			self.doorPartner = doorPartner
			self.doorPartner:DeleteOnRemove(self)
			doorPartner.ixLock = self
		end

		self:SetPos(position)
		self:SetAngles(angles)
		self:SetParent(door)
	end

	function ENT:SpawnFunction(client, trace)
		local door = trace.Entity

		if (!IsValid(door) or !door:IsDoor() or IsValid(door.ixLock)) then
			return client:NotifyLocalized("dNotValid")
		end

		local normal = client:GetEyeTrace().HitNormal:Angle()
		local position, angles = self:GetLockPosition(door, normal)

		local entity = ents.Create("ix_combinelock_con")
		entity:SetPos(trace.HitPos)
		entity:Spawn()
		entity:Activate()
		entity:SetDoor(door, position, angles)

		ix.saveEnts:SaveEntity(entity)
		Schema:SaveCombineLocks()
		return entity
	end

	function ENT:Initialize()
		self:SetModel("models/willardnetworks/props_combine/wn_combine_lock.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:SetHealth(300)

		self.accessLevel = 1
		self.nextUseTime = 0
	end

	function ENT:OnRemove()
		if (IsValid(self)) then
			self:SetParent(nil)
		end

		if (IsValid(self.door)) then
			self.door:Fire("unlock")
			self.door.ixLock = nil
		end

		if (IsValid(self.doorPartner)) then
			self.doorPartner:Fire("unlock")
			self.doorPartner.ixLock = nil
		end

		if (!ix.shuttingDown) then
			Schema:SaveCombineLocks()
		end
	end

	function ENT:OnLockChanged(name, bWasLocked, bLocked)
		if (!IsValid(self.door) or self:GetDisabled()) then
			return
		end

		ix.saveEnts:SaveEntity(self)
		if (bLocked) then
			self:EmitSound("buttons/combine_button2.wav")
			self.door:Fire("lock")
			self.door:Fire("close")

			if (IsValid(self.doorPartner)) then
				self.doorPartner:Fire("lock")
				self.doorPartner:Fire("close")
			end
		else
			self:EmitSound("buttons/combine_button7.wav")
			self.door:Fire("unlock")

			if (IsValid(self.doorPartner)) then
				self.doorPartner:Fire("unlock")
			end
		end
	end

	function ENT:DisplayError()
		self:EmitSound("buttons/combine_button_locked.wav")
		self:SetDisplayError(true)

		timer.Simple(1.2, function()
			if (IsValid(self)) then
				self:SetDisplayError(false)
			end
		end)
	end

	function ENT:DisplayDamage()
		self:SetDisplayError(true)

		timer.Simple(1.2, function()
			if (IsValid(self)) then
				self:SetDisplayError(false)
			end
		end)
	end

	function ENT:Toggle(client)
		if (self:GetDisabled()) then return end
		
		if (self.nextUseTime > CurTime()) then
			return
		end

		local character = client:GetCharacter()
		local items = character:GetInventory():GetItems()
		local conCards = {}

		for _, item in pairs(items) do
			if (item.uniqueID == "con_card" and item:GetData("cardID")) then
				conCards[#conCards + 1] = item
			end
		end

		local canOpen = false
		for _, card in pairs(conCards) do
			-- access level 5 should open all doors. access level 3 should open only 3, 2, and 1 doors, etc
			if (items[card:GetData("cardID")] and (card:GetData("accessLevel", 1) >= self.accessLevel)) then
				canOpen = true
			end
		end

		if (!Schema:CanPlayerOpenCombineLock(client, self) and !canOpen) then
			self:DisplayError()
			self.nextUseTime = CurTime() + 2

			return
		end

		self:SetLocked(!self:GetLocked())

		self.nextUseTime = CurTime() + 2
	end

	function ENT:Use(client)
		if (client:KeyDown(IN_SPEED) and (client:Team() == FACTION_ADMIN or client:Team() == FACTION_SERVERADMIN or client:IsCombine() or client:GetCharacter():HasFlags("M"))) then
			net.Start("changeLockAccessCon")
				net.WriteEntity(self)
			net.Send(client)
		else
			self:Toggle(client)
		end
	end

	function ENT:OnOptionSelected(client, option, data)
		if (option == "Set Level 1 Access") then
			self.accessLevel = 1

			client:Notify("You have set Level 1 Access to this lock.")
		elseif (option == "Set Level 2 Access") then
			self.accessLevel = 2

			client:Notify("You have set Level 2 Access to this lock.")
		elseif (option == "Set Level 3 Access") then
			self.accessLevel = 3

			client:Notify("You have set Level 3 Access to this lock.")
		elseif (option == "Set Level 4 Access") then
			self.accessLevel = 4

			client:Notify("You have set Level 4 Access to this lock.")
		elseif (option == "Set Level 5 Access") then
			self.accessLevel = 5

			client:Notify("You have set Level 5 Access to this lock.")
		end
	end

	function ENT:OnTakeDamage(dmgInfo)
		self:SetHealth(self:Health() - dmgInfo:GetDamage())
		self:EmitSound("physics/metal/metal_sheet_impact_hard"..math.random(6, 8)..".wav")
		self:DisplayDamage()

		if (self:Health() <= 0) then
			local pos = self:GetPos()
			local curTime = CurTime()

			if (!self.nextSpark or self.nextSpark <= curTime) then
				local effect = EffectData()
					effect:SetStart(pos)
					effect:SetOrigin(pos)
					effect:SetScale(2)
				util.Effect("cball_explode", effect)

				self.nextSpark = curTime + 0.1
			end

			local attacker = dmgInfo:GetAttacker()

			self:EmitSound("npc/manhack/gib.wav")
			ix.combineNotify:AddImportantNotification("WRN:// Bio-Restrictor failure", nil, attacker:IsPlayer() and attacker, self:GetPos())
			ix.item.Spawn("trash_biolock", Vector(self:GetPos().x, self:GetPos().y, self:GetPos().z))

			self:Remove()
		end
	end
else
	local glowMaterial = ix.util.GetMaterial("sprites/glow04_noz")
	local color_green = Color(0, 255, 0, 255)
	local color_orange = Color(255, 180, 0, 255)
	local color_red = Color(255, 50, 50, 255)

	function ENT:Draw()
		self:DrawModel()

		if (self:GetDisabled()) then return end

		local color = color_green

		if (self:GetDisplayError()) then
			color = color_red
		elseif (self:GetLocked()) then
			color = color_orange
		end

		local position = self:GetPos() + self:GetUp() * -8.7 + self:GetForward() * -3.85 + self:GetRight() * -6

		render.SetMaterial(glowMaterial)
		render.DrawSprite(position, 10, 10, color)
	end
end
