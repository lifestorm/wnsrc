--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

-- explosion related
local function CreateCVarInt(name, default, text)
	local cvar = CreateConVar(name, default, FCVAR_DEMO, text)
	return function() return cvar:GetInt() end
end

local ZAPC_MAGNITUDE = CreateCVarInt('zapc_secondary_magnitude', 128, 'Explosion magnitude of a single rocket.')

local SpawnProtection = 0.1 -- how long we're protected from blowing up the own APC (i.e. nocollided) and the player has no control over us

local MODEL = Model('models/weapons/W_missile_closed.mdl')

for i = 4, 9 do
	util.PrecacheSound('ambient/explosions/explode_' .. math.random(4, 9) .. '.wav')
end

function ENT:Initialize()
	self.SpawnTime = CurTime()
	self:SetModel(MODEL)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	phys:Wake()
	phys:EnableGravity(false) -- we ain't no afraid of no gravity. Oder so.
	
	-- No hack this time.
	self:StartMotionController()
	self.Destination = Vector(0, 0, 0)
	
	self.ShadowParams = {
		secondstoarrive = 0.5,
		maxangular = 0.000001,
		maxangulardamp = 1,
		maxspeed = 500000,
		maxspeeddamp = 500,
		dampfactor = 0.7,
		teleportdistance = 0
	}
	
	self:SetCustomCollisionCheck(true)
	self:EmitSound('Missile.Ignite')
end

-- Poof.
function ENT:OnRemove()
	self:StopSound('Missile.Ignite')

	local expl = ents.Create('env_explosion')
		expl:SetPos(self:GetPos())
		expl:SetOwner(self:GetOwner())
		expl:SetKeyValue('imagnitude', tostring(ZAPC_MAGNITUDE()))
		expl.APC = self.APC
	expl:Spawn()
	expl:Fire('explode')
	
	expl = ents.Create('env_physexplosion')
		expl:SetPos(self:GetPos())
		expl:SetKeyValue('magnitude', tostring(ZAPC_MAGNITUDE()))
		expl:SetKeyValue('spawnflags', '1') -- 19 would be push players + disorient players
	expl:Spawn()
	expl:Fire('explode', '', 0)
	expl:Fire('kill', '', 1)
end

local function LimitPitch(ang)
	return math.Clamp(ang, -45, 45)
end

local function ProcessAngle(ang)
	ang.pitch = LimitPitch(math.NormalizeAngle(ang.pitch))
	ang.yaw = math.NormalizeAngle(ang.yaw)
	ang.roll = math.NormalizeAngle(ang.roll)
	return ang
end


function ENT:Think()
	-- No owner or APC anymore?
	local owner = self:GetOwner()
	if not IsValid(owner) or not IsValid(self.APC) then
		self:Remove()
		return
	end
	
	-- Not a gunner anymore?
	local vehicle = owner:GetVehicle()
	if vehicle ~= self.APC.GunnerSeat then
		self:Remove()
		return
	end
	
	local attach = self.APC.DriverSeat:GetAttachment(self.APC.DriverSeat:LookupAttachment('muzzle'))
	self.Destination = util.TraceLine({ start = attach.Pos - 15 * attach.Ang:Forward() + attach.Ang:Right(), endpos = attach.Pos - 15 * attach.Ang:Forward() + attach.Ang:Right() + attach.Ang:Forward()*16384, filter = { self.APC, self.APC.DriverSeat, self.APC.GunnerSeat, self.APC.Turret }, mask = MASK_SHOT }).HitPos
end

function ENT:OnTakeDamage(damage)
	self:Remove()
end

-- Barely a clue what this does.
function ENT:PhysicsSimulate(phys, dt)
	-- In case our APC got lost, weeell.
	if not IsValid(self.APC) then
		return
	end
	
	phys:Wake()
	
	local spos = self:GetPos()
	local dir = ((self.Destination - spos):GetNormalized() + self:GetAngles():Forward()*10)/11
	local ang = dir:Angle()
	local vec = spos + dir* 512 + self:GetAngles():Forward()*100
	
	if CurTime() < self.SpawnTime + SpawnProtection then
		vec = spos + self:GetForward() * 1024 + dir * 64
		ang = self.APC:GetForward():Angle()
	else
		phys:SetAngles(ang)
	end
	
	self.ShadowParams.pos = vec
	self.ShadowParams.deltatime = dt
	self.ShadowParams.ang = ang
	phys:ComputeShadowControl(self.ShadowParams)
end

function ENT:PhysicsCollide(data, physobj)
	if IsValid(self.APC) and data.HitEntity == self.APC.DriverSeat and CurTime() - self.SpawnTime <= SpawnProtection then
		return
	end
	
	self:Remove()
end


local function ShouldCollide(ent1, ent2)
	if 
		(ent1:GetClass() == 'prop_vehicle_zapc_rocket' and ent2 == ent1.APC.DriverSeat and CurTime() - ent1.SpawnTime <= SpawnProtection)
		or
		(ent2:GetClass() == 'prop_vehicle_zapc_rocket' and ent1 == ent2.APC.DriverSeat and CurTime() - ent2.SpawnTime <= SpawnProtection)
	then
		return true
	end
end
hook.Add('ShouldCollide', '_ZAPCRocketShouldCollide', ShouldCollide)