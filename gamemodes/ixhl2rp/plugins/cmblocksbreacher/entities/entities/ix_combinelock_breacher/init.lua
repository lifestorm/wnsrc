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
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

resource.AddFile("models/transmissions_element120/charger_attachment.mdl")
resource.AddFile("models/transmissions_element120/charger_attachment_m.mdl")
resource.AddFile("models/transmissions_element120/rotato_small.mdl")

function ENT:Initialize()
	local model = "models/transmissions_element120/charger_attachment.mdl"
	self:SetModel(model)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetUseType(CONTINUOUS_USE)

	self:SetBreached(false)

	self.Velocity = 0
	self.BuzzerStopped = false
end

function ENT:OnRemove()
	if IsValid(self.ixLock) then
		self.ixLock:SetDisabled(false)
	end
	self.ixLock.ixBreacher = nil

	if self.buzzer then
		self.buzzer:Stop()
	end
end

function ENT:SetLock(entity)
	if not IsValid(entity) then return end

	entity.ixBreacher = entity
	self.ixLock = entity

	entity:SetDisabled(true)
	-- entity:SetLocked(true)

	self:SetAngles(entity:GetAngles())
	self:SetParent(entity)
	local pos = Vector(-3, -8.7, 9)
	self:SetLocalPos(pos)
end

function ENT:Use(activator)
	if self:GetBreached() then return end
	self.LastUse = CurTime()
	self.lastUser = activator

	self.Velocity = math.min(self.Velocity + 0.1, 2)
end

function ENT:Think()
	if !self.LastUse then return end

	if self.LastUse < CurTime() - 0.2 then
		self.Velocity = math.max(self.Velocity - (self:GetBreached() and 0.7 or 0.5), self:GetBreached() and -6 or -4)
	end

	local progress = self:GetProgress() or 0
	progress = math.Clamp(progress + (self.Velocity / 5), 0, 255)
	self:SetProgress(progress)

	if not self.buzzer then
		self.buzzer = CreateSound(self, "weapons/physcannon/superphys_hold_loop.wav")
		self.buzzer:Stop()
	end
	if (!self.BuzzerStopped and self:GetProgress() <= 0) then
		self.buzzer:FadeOut(1)
		self.BuzzerStopped = true
	elseif (self:GetProgress() > 0) then
		if (self.BuzzerStopped) then
			self.BuzzerStopped = false
			self.buzzer:Play()
			self.buzzer:ChangeVolume(1, 0)
			self.buzzer:SetDSP(11)
			self.buzzer:SetSoundLevel(65)
		end
		self.buzzer:ChangePitch(self:GetProgress() / 2 + (255 / 2), 0)
	end

	if self:GetProgress() == 255 and !self:GetBreached() then
		self:Breach()
	end

	self:NextThink(CurTime())
	return true
end

local function OpenDoor(entity, origin)
	if (!entity:IsDoor()) then return end

	entity:Fire("Unlock", "")
	local delay = 0.025

	if (origin and string.lower(entity:GetClass()) == "prop_door_rotating") then
		local target = ents.Create("info_target")
		target:SetName(tostring(target))
		target:SetPos(origin)
		target:Spawn()
		entity:Fire("OpenAwayFrom", tostring(target), delay)

		timer.Simple(delay + 1, function()
			if (IsValid(target)) then
				target:Remove()
			end
		end)
	else
		entity:Fire("Open", "", delay)
	end
end

function ENT:Breach()
	if !IsValid(self.ixLock) then return end

	self:SetBreached(true)

	ix.combineNotify:AddNotification("LOG:// Bio-Restrictor unlocked by %USER-ERROR%", nil, "unknown location")

	-- Get effect positions and produce them
	local lockPos = self.ixLock:GetPos() + self.ixLock:GetUp() * -8.7 + self.ixLock:GetForward() * -3.85 + self.ixLock:GetRight() * -6
	local lockPosEnd = self.ixLock:GetPos() + self.ixLock:GetUp() * -8.7 + self.ixLock:GetForward() * -3.85 + self.ixLock:GetRight() * -7
	local lockPos2 = self.ixLock:GetPos() + self.ixLock:GetUp() * 8 + self.ixLock:GetForward() * -5 + self.ixLock:GetRight() * -2
	local lockPosEnd2 = self.ixLock:GetPos() + self.ixLock:GetUp() * 8 + self.ixLock:GetForward() * -5 + self.ixLock:GetRight() * -3

	local chargerPos = self:GetPos() + self:GetUp() * 8 + self:GetForward() * 4.5 + self:GetRight() * -13.4
	local chargerPosEnd = self:GetPos() + self:GetUp() * 9 + self:GetForward() * 4.5 + self:GetRight() * -13.4

	local positionsForEffect = {
		{lockPos, lockPosEnd, self.ixLock},
		{lockPos2, lockPosEnd2, self.ixLock},
		{chargerPos, chargerPosEnd, self}
	}

	for _, v in pairs(positionsForEffect) do
		local effectData = EffectData()

		effectData:SetStart(v[1])
		effectData:SetOrigin(v[1])
		effectData:SetNormal(v[2])

		effectData:SetMagnitude(2)
		effectData:SetScale(1)
		effectData:SetRadius(2)

		effectData:SetEntity(v[3])

		util.Effect("Sparks", effectData, true, true)
	end

	self.ixLock:SetLocked(false) -- unlock the lock
	local doors = self.ixLock.doors or {self.ixLock.door}
	if (self.ixLock.doorPartner and !table.HasValue(doors, self.ixLock.doorPartner)) then
		table.insert(doors, self.ixLock.doorPartner)
	end
	for _, v in pairs(doors) do
		v.lastSpeed = v:GetSaveTable().speed -- store the last door speed to restore it
		v:Fire("setspeed", tostring(v.lastSpeed * 4))
		OpenDoor(v, self.ixLock:GetPos())
		timer.Simple(0.5, function()
			if IsValid(v) then
				v:Fire("setspeed", tostring(v.lastSpeed))
				v.lastSpeed = nil -- Delete the temp var
			end
		end)
	end

	self:EmitSound("ambient/energy/zap9.wav", 75, 100, 0.8)
end
