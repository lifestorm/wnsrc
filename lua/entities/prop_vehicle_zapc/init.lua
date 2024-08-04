--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

-- ZAPC
-- Copyright (c) 2012 Zaubermuffin
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-- Resources first.
AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

include('shared.lua')

-- Spawn Icon
resource.AddFile('materials/vgui/entities/prop_vehicle_zapc.vmt')

-- HUD
resource.AddFile('materials/zapc_hud/seat.png')
resource.AddFile('materials/zapc_hud/seat_driver.png')
resource.AddFile('materials/zapc_hud/seat_gunner.png')
resource.AddFile('materials/zapc_hud/crosshair.png')
resource.AddFile('materials/zapc_hud/rocket.png')

-- Feel free to change those.
local function CreateCVar(name, default, text)
	local cvar = CreateConVar(name, default, FCVAR_DEMO, text)
	return function() return cvar:GetFloat() end
end

local function CreateCVarInt(name, default, text)
	local cvar = CreateConVar(name, default, FCVAR_DEMO, text)
	return function() return cvar:GetInt() end
end
	
local ZAPC_PRIMARY_DAMAGE = CreateCVar('zapc_primary_damage', 40, 'The damage inflicted by the turret')
local ZAPC_PRIMARY_DELAY = CreateCVar('zapc_primary_delay', 0.1, 'The delay between two turret shots')
local ZAPC_PRIMARY_FORCE = CreateCVar('zapc_primary_force', 2, 'The force applies to objects hit by the turret')
local ZAPC_PRIMARY_SPREAD = CreateCVar('zapc_primary_spread', 0.01, 'The spread of the turret.')
local ZAPC_EXPLOSION_MAGNITUDE = CreateCVarInt('zapc_explosion_magnitude', 600, 'Damage done by the explosion upon destroying an APC. Must be an integer.')
local ZAPC_EXPLOSION_RADIUS = CreateCVarInt('zapc_explosion_radius', 230, 'Explosion radius upon destroying an APC. Must be an integer.')
local ZAPC_REPAIR_FORCE =  CreateCVarInt('zapc_repair_force', 15, 'How much health can be repaired each tick using the easteregg. Must be an integer.')
local ZAPC_REMOTE_LOCK_DISTANCE = CreateCVarInt('zapc_remote_lock_distance', 300, 'The maximum distance a player can be away to lock the hatch.')
local ZAPC_REPAIR_SOUND = 'suitrecharge.chargingloop' -- why this sound? WHY NOT?
local ZAPC_ALARM_INTERVAL = SoundDuration('ambient/alarms/apc_alarm_loop1.wav') * 0.5 -- time between two alarm waves - tightly tied to the sound, don't change it!

-- Do not feel free to modify anything below.

-- Make sure it doesn't conflict.
local ZAPC_VIEW_UNRELATED, ZAPC_VIEW_DRIVER, ZAPC_VIEW_GUNNER, ZAPC_VIEW_PASSENGER = ZAPC_VIEW_UNRELATED, ZAPC_VIEW_DRIVER, ZAPC_VIEW_GUNNER, ZAPC_VIEW_PASSENGER
local ZAPC_MAX_HEALTH = ZAPC_MAX_HEALTH
local ZAPC_PRIMARY_RELOAD_TIME, ZAPC_SECONDARY_RELOAD_TIME = ZAPC_PRIMARY_RELOAD_TIME, ZAPC_SECONDARY_RELOAD_TIME
local ZAPC_MAX_PASSENGERS = ZAPC_MAX_PASSENGERS

-- Get rid of them.
for k, v in pairs(_G) do
	if type(k) == 'string' and k:find('^ZAPC_') then
		_G[k] = nil
	end
end

-- Resources.
local MODEL = Model('models/combine_apc.mdl')
local INVISIBLE_MODEL = Model('models/Items/combine_rifle_ammo01.mdl')

-- Checks if a player has access to a certain thing.
-- Possible actions:
-- "personal": Is able to enter and use gunner/driver functions. This will be checked upon any action and if it isn't fulfilled anymore, the player will be thrown out from the APC.
-- "destruct": Is able to use zapc_sd self-destruct any APC by looking at it from any distance (while not being inside any APC). Passed as parameter is the APC in question.
-- "alarm": Is able to use zapc_sa alarming "easter egg" any APC by looking at it. Passed as parameter is the APC in question.
-- "repair": Is able to use +zapc_repair repairing "easter egg" (that can transform APCs into so called 'golden APCs'. Passed as parameter is the APC in question. This might be called although the repair itself won't start (due to other limitations).
-- "tool": Is able to use any tool (except duplicator, which will stay explicitly forbidden) on an APC. Needs to have proper called SENT:CanTool on the SENT in order to work (i.e. by the sandbox gamemode). Passed as parameters are the trace and the toolmode.
local function CheckAccess(ply, action, apc, ...)
	return hook.Call('ZAPC_CheckAccess', nil, ply, action, apc, ...) ~= false
end

-- Replies to a player.
local function ReplyTo(ply, text, ...)
	if IsValid(ply) then
		ply:PrintMessage(HUD_PRINTCONSOLE, '[APC] ' .. string.format(text, ...))
	else
		print('[APC] ' .. string.format(text, ...))
	end
end

-- Beep.
local function Beep(apc, snd)
	if not IsValid(apc) then
		return
	end
	
	apc:EmitSound(snd)
end

-- Pouff
local function BlowUp(apc)
	if IsValid(apc) then
		apc:Explode()
	end
end

local function Unsatisfiable()
	return false
end

function ENT:Initialize()
	-- Move us upwards.
	self:SetPos(self:GetPos() + Vector(0, 0, 60))
	
	-- ghastly ghost! boooooo!
	self:SetModel(INVISIBLE_MODEL)
	self:SetRenderMode(RENDERMODE_NONE)
	self:SetNoDraw(true)
	
	-- Cheat
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetNotSolid(true)

	-- Create the driver seat.
	self.DriverSeat = ents.Create('prop_vehicle_jeep')
		self.DriverSeat:SetSolid(SOLID_VPHYSICS)
		self.DriverSeat:SetPos(self:GetPos() - self:GetUp()*50)
		self.DriverSeat:SetAngles(self:GetAngles())
		self.DriverSeat:SetModel(MODEL)
		self.DriverSeat:SetKeyValue('vehiclescript', 'scripts/vehicles/zapc_script.txt', 0)
		self.DriverSeat:SetKeyValue('limitview', 0, 0)
		self.DriverSeat.CanTool = function(_, ...) return self:CanTool(...) end
		self.DriverSeat.PhysgunPickup = function(_, ...) return self:PhysgunPickup(...) end
		self.DriverSeat.PhysgunDisabled = true -- redundant, but eh.
	self.DriverSeat:Spawn()
	
	-- The gunner "seat".
	self.GunnerSeat = ents.Create('prop_vehicle_prisoner_pod')
		self.GunnerSeat:SetModel(INVISIBLE_MODEL)
		self.GunnerSeat:SetSolid(SOLID_NONE)
		self.GunnerSeat:SetNotSolid(true)
		self.GunnerSeat:SetPos(self:GetPos() - self:GetUp()*10 + self:GetRight()*10)
		local ang = self:GetAngles()
		ang:RotateAroundAxis(self:GetUp(), 180)
		self.GunnerSeat:SetAngles(ang)
		self.GunnerSeat:SetKeyValue('limitview', 0, 0)
		self.GunnerSeat:SetRenderMode(RENDERMODE_NONE)
		self.GunnerSeat.CanTool = Unsatisfiable
		self.GunnerSeat.PhysgunPickup = Unsatisfiable
		self.GunnerSeat.PhysgunDisabled = true -- redundant, but eh.
	self.GunnerSeat:Spawn()
	self.GunnerSeat:GetPhysicsObject():EnableCollisions(false)
	self.GunnerSeat:SetMoveType(MOVETYPE_NONE)
	
	-- Turret.
	-- Could be a custom SENT, but we're just abusing the gmod turret here.
	self.Turret = ents.Create('base_gmodentity')
		self.Turret:SetModel(INVISIBLE_MODEL)
		self.Turret:SetPos(self.DriverSeat:GetAttachment(self.DriverSeat:LookupAttachment('muzzle')).Pos)
		self.Turret:Spawn()
		self.Turret:SetParent(self.DriverSeat)
		self.Turret.NextShot = 0
		self.Turret:SetNotSolid(true)
		self.Turret:SetMoveType(MOVETYPE_NONE)
		self.Turret:SetRenderMode(RENDERMODE_NONE)
		self.Turret.CanTool = Unsatisfiable
		self.Turret.PhysgunPickup = Unsatisfiable
		self.Turret.PhysgunDisabled = true -- redundant, but eh.
	self.Turret.APC = self
	
	-- The driver and the gunner are nil per default.
	-- Not necessary, but to declare the variables.
	self.Driver, self.Gunner = nil, nil
	
	-- Weld everything to the real driving thing.
	-- But set us slightly differently first.
	self:SetParent(self.DriverSeat)
	self.GunnerSeat:SetParent(self.DriverSeat)
	
	-- pew pew stuff.
	self.Bullets = 50
	
	self.NextPrimary, self.NextSecondary = 0, 0
	
	-- Health!
	self:SetMaxHealth(ZAPC_MAX_HEALTH())
	self:SetHealth(ZAPC_MAX_HEALTH())
	
	-- informational wiring. Necessary for certain things.
	self.DriverSeat.APC = self
	self.GunnerSeat.APC = self
	
	-- We are APC. A callback would be unhandier.
	self.IsAPC = true
	
	-- Passengers!
	self.Passengers = {}
	self.HatchOpened = false
	
	-- Lock us!
	self.DriverSeat:Fire('TurnOff', '')
	self.TurnedOn = false
	self.SlowDrive = false
end

-- Introduced in the March '15 update, I don't think we need to know
-- what class we are.
function ENT:SetVehicleClass(name)
	assert(name == 'prop_vehicle_zapc', 'invalid class name')
end

-- Informs the user about his gunner view status.
local function SendViewMode(ply, status)
	if not IsValid(ply) then
		return
	end
	
	umsg.Start('ZAPC_VU', ply)
		umsg.Char(status)
	umsg.End()
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
	self:UpdateGun()
	self:NextThink(CurTime() + 1/200)
	if self.NextAlarm and self.NextAlarm <= CurTime() then
		self.DriverSeat:GetPhysicsObject():AddVelocity(Vector(0, 0, 150))
		self.NextAlarm = self.NextAlarm + ZAPC_ALARM_INTERVAL * (self.Special and 0.5 or 1)
	end
	
	if IsValid(self.Gunner) then
		if self.NextPrimary < CurTime() and self.Gunner:KeyDown(IN_ATTACK) then
			self:FireTurret()
		end
		
		if self.NextSecondary < CurTime() and self.Gunner:KeyDown(IN_ATTACK2) then
			self:FireRocket()
		end
	end
	
	return true
end

-- Updates the gun according to the gunner's view.
function ENT:UpdateGun()
	if not IsValid(self.Gunner) then
		return
	end
	
	local gunnerAngles, apcAngles = ProcessAngle(self.Gunner:EyeAngles()), self.DriverSeat:GetAngles()
	
	self.DriverSeat:SetPoseParameter('vehicle_weapon_yaw', math.NormalizeAngle(gunnerAngles.yaw - apcAngles.yaw - 90))
	self.DriverSeat:SetPoseParameter('vehicle_weapon_pitch', LimitPitch(math.NormalizeAngle(gunnerAngles.pitch - apcAngles.pitch)))
	
	if self.Special and self.SirenSound then
		self.SirenSound:ChangePitch(self.DriverSeat:GetPoseParameter('vehicle_weapon_pitch') + 95, 0)
	end
end

-- Returns everybody that should know about updates.
-- Because, if we put nil or [NULL] into a umsg, it's sent to everybody.
function ENT:GetReceipees()
	local t = RecipientFilter()
	
	if IsValid(self.Driver) then
		t:AddPlayer(self.Driver)
	end
	
	if IsValid(self.Gunner) then
		t:AddPlayer(self.Gunner)
	end
	
	return t
end

-- Send the new passengers to whoever cares
function ENT:PassengersUpdate(ply)
	if IsValid(self.Driver) or IsValid(self.Gunner) then
		umsg.Start('ZAPC_PU', ply or self:GetReceipees())
			umsg.Entity(self.Driver or NULL)
			umsg.Entity(self.Gunner or NULL)
			for i = 1, ZAPC_MAX_PASSENGERS() do
				local pass = self.Passengers[i]
				umsg.Entity(IsValid(pass) and pass:GetPassenger(0) or NULL)
			end
		umsg.End()
	end
end

-- Sends a bullet update.
function ENT:BulletUpdate(ply)
	umsg.Start('ZAPC_BU', ply or self:GetReceipees())
		umsg.Char(math.max(self.Bullets, 0))
	umsg.End()
end

-- Health update
function ENT:HealthUpdate(ply)
	umsg.Start('ZAPC_HU', ply or self:GetReceipees())
		umsg.Short(self:Health())
	umsg.End()
end

function ENT:HatchUpdate(ply)
	local recv = ply
	if not recv then
		recv = self:GetReceipees()
		for k, v in pairs(self.Passengers) do
			recv:AddPlayer(v:GetPassenger(0))
		end
	end
	
	SendUserMessage('ZAPC_HOU', recv, self.HatchOpened)
end

function ENT:ToggleHatch()
	if self.Destructing then
		return
	end
	self.HatchOpened = not self.HatchOpened
	self:HatchUpdate()
end

local function KeyPress(ply, key)
	local vehicle = ply:GetVehicle()
	local apc = vehicle.APC
	if IsValid(apc) then
		if (not CheckAccess(ply, 'personal', apc)) and (vehicle == apc.DriverSeat or vehicle == apc.GunnerSeat) then
			ply:ExitVehicle()
			ReplyTo(ply, '[ZAPC] You are no longer authorized to use this specialized vehicle. If you think this is a mistake, please contact the nearest police station.')
			return
		end
		
		-- Driver?
		if ply == apc.Driver then
			if key == IN_ATTACK then
				apc:ToggleEngine()
			elseif key == IN_ATTACK2 then
				apc:ToggleSpeed()
			elseif key == IN_SPEED then
				if not IsValid(apc.Gunner) then
					apc:DriverToGunner(ply)
				end
			elseif key == IN_RELOAD then
				apc:ToggleSiren()				
			elseif key == IN_WALK then
				apc:ToggleHatch()
			end
		-- Gunner!
		elseif ply == apc.Gunner then
			-- Reloading?
			if key == IN_RELOAD then
				apc:ReloadGun()
				return true
			elseif key == IN_SPEED then
				if not IsValid(apc.Driver) then
					apc:GunnerToDriver(ply)
					return true
				end
			end
		end
	end
end
hook.Add('KeyPress', '_ZAPC.KeyPress', KeyPress)

local function ColdBoot(apc)
	if IsValid(apc) and apc.TurnedOn and not apc.Destructing then
		apc.DriverSeat:Fire('TurnOn', '')
		apc.DriverSeat:Fire('HandbrakeOff', '')
	end
end

function ENT:StartEngine()
	timer.Simple(1, function() ColdBoot(self) end)
	self:EmitSound('apc_engine_start')
end

function ENT:StopEngine()
	self.DriverSeat:Fire('TurnOff', '')
	self:StopSound('apc_engine_start')
	self:EmitSound('apc_engine_stop')
	
	if self.MovingSound then
		self:StopSound(self.MovingSound)
		self.MovingSound = nil
	end
	
	self.Direction = nil
end

function ENT:AddDriver(driver)
	self.Driver = driver
	-- Health before APC, so the APC overwrites the thing.
	self:HealthUpdate(driver)
	self:EnterPlayer(driver)
	-- And the bullets.
	self:BulletUpdate(driver)
	SendViewMode(driver, ZAPC_VIEW_DRIVER)
	self:PassengersUpdate()
end

function ENT:AddGunner(gunner)
	self.Gunner = gunner
	-- Health before APC, so the APC overwrites the thing.
	self:HealthUpdate(gunner)
	self:EnterPlayer(gunner)
	-- And the bullets.
	self:BulletUpdate(gunner)
	SendViewMode(gunner, ZAPC_VIEW_GUNNER)
	self:PassengersUpdate()
end

-- Adds a new passenger in the back-door-hatch
-- unlucky name is unlucky
function ENT:AddPassenger(ply)
	local seat = ents.Create('prop_vehicle_prisoner_pod')
		seat:SetModel(INVISIBLE_MODEL)
		seat:SetSolid(SOLID_NONE)
		seat:SetNotSolid(true)
		seat:SetNoDraw(true)
		seat:SetColor(Color(255, 255, 255, 0))
		seat:SetPos(self:GetPos())
		seat:SetAngles(self.DriverSeat:GetAngles())
		seat:SetParent(self.DriverSeat)
		seat:SetKeyValue('limitview', 0, 0)	
		seat.CanTool = Unsatisfiable
		seat.PhysgunPickup = Unsatisfiable
		seat.PhysgunDisabled = true -- redundant, but eh.
		seat.APC = self
	seat:Spawn()
	seat:SetMoveType(MOVETYPE_NONE)
	local phys = seat:GetPhysicsObject()
	phys:EnableCollisions(false)
	table.insert(self.Passengers, seat)
	self:EnterPlayer(ply)
	ply:EnterVehicle(seat)
	SendViewMode(ply, ZAPC_VIEW_PASSENGER)
	self:PassengersUpdate()
end

-- Hook callback when a new passenger (gunner, driver, passenger) is detected.
function ENT:NewPassenger(ply, seat)
	if self.DriverSeat == seat then
		self:AddDriver(ply)
	elseif self.GunnerSeat == seat then
		self:AddGunner(ply)
	else
		-- I suppose it's a passenger. Those were added manually anyway - but let's check
		for k, v in pairs(self.Passengers) do
			if v == seat then
				return
			end
		end
		
		error('Attempt to add ' .. tostring(ply) .. ' to ' .. tostring(self) .. ' - but player is not inside the APC.')
	end
end

local function ResetLastPassenger(apc, ply)
	if not IsValid(apc) or not IsValid(ply) or apc.LastPassenger ~= ply then
		return
	end
	
	apc.LastPassenger = nil
end

-- This function may be called multiple times, depending on how GMod feels right now.
-- Therefore, the if-checks SHOULD NOT BE COMBINED (no if seat == and ply ==). No.
-- Note: Due to historical reasons, this is here to remove ANY KIND OF PASSENGER - not just "passengers".
function ENT:RemovePassenger(ply, seat)
	if seat == self.DriverSeat then
		if ply == self.Driver then
			self.Driver = nil
			self:ExitPlayer(ply, true)
			ply:SetPos(self:GetPos() + self:GetForward()*60)
		end
	elseif seat == self.GunnerSeat then
		if ply == self.Gunner then
			self.Gunner = nil
			self.LastPassenger = ply
			timer.Simple(0.5, function() ResetLastPassenger(self, ply) end)
			self:ExitPlayer(ply, true)
			self.DriverSeat:SetPoseParameter('vehicle_weapon_yaw', 0)
			self.DriverSeat:SetPoseParameter('vehicle_weapon_pitch', 0)
			ply:SetPos(self:GetPos() - self:GetForward()*60)
		end
	else
		-- Passenger?
		for k, v in pairs(self.Passengers) do
			if v == seat then
				-- Make sure he doesn't get in IMMEDIATELY AGAIN.
				self.LastPassenger = ply
				timer.Simple(0.5, function() ResetLastPassenger(self, ply) end)
				-- ok bye
				self:ExitPlayer(ply, true)
				ply:SetPos(self:GetPos() + self:GetRight() * 150)
				seat:Remove()
				table.remove(self.Passengers, k)
				self:PassengersUpdate()
				return
			end
		end
		
		error('Unable to find ' .. tostring(ply) .. ' as passenger in ' .. tostring(seat))
	end
	
	self:PassengersUpdate()
end

function ENT:DriverToGunner(driver)
	if self.Destructing then
		return
	end
	
	driver:ExitVehicle()
	driver:EnterVehicle(self.GunnerSeat)
end

function ENT:GunnerToDriver(gunner)
	if self.Destructing then
		return
	end
	
	gunner:ExitVehicle()
	gunner:EnterVehicle(self.DriverSeat)
end

local function ReloadComplete(apc)
	if not IsValid(apc) or apc.Bullets ~= -1 or apc.Destructing then
		return
	end
	
	apc:EmitSound('Weapon_AR2.Reload_Push')
	apc.Bullets = 50
	apc:BulletUpdate()
end

function ENT:ReloadGun()
	-- eeh.
	if self.Bullets == -1 or self.Bullets == 50 or self.Destructing then
		return
	end
	
	self.Bullets = 0
	self:BulletUpdate()
	self.NextPrimary = CurTime() + ZAPC_PRIMARY_RELOAD_TIME()
	
	self:PrimaryUpdate()
	self.Bullets = -1
	timer.Simple(ZAPC_PRIMARY_RELOAD_TIME(), function() ReloadComplete(self) end)
end

local function CanPlayerEnterVehicle(ply, vehicle, role)
	local apc = vehicle.APC
	
	if IsValid(apc) then
		local access = CheckAccess(ply, 'personal', apc)
		
		-- +walk moves us into the passenger bay.
		if access and vehicle == apc.DriverSeat and ply:KeyDown(IN_WALK) then
			return false
		end
		
		-- If we are exploding or trying to access and invalid seat, nope
		if apc.Destructing or (not access and (vehicle == apc.DriverSeat or vehicle == apc.GunnerSeat)) then
			apc:EmitSound('buttons.snd47')
			return false
		else
			return true
		end
	end
end
hook.Add('CanPlayerEnterVehicle', '_ZAPC.CanPlayerEnterVehicle', CanPlayerEnterVehicle)

local function PlayerEnteredVehicle(ply, veh, role)
	if IsValid(veh.APC) then
		veh.APC:NewPassenger(ply, veh)
	end
end
hook.Add('PlayerEnteredVehicle', '_ZAPC.PlayerEnteredVehicle', PlayerEnteredVehicle)

local function PlayerUse(ply, ent)
	if IsValid(ent.APC) and not IsValid(ply:GetVehicle()) then
		local apc = ent.APC
		
		-- The APC is NOT blowing up and this isn't the last passenger?
		if not apc.Destructing and apc.LastPassenger ~= ply then
			-- If we don't have a driver OR he isn't authorized
			local driverE = IsValid(apc.Driver)

			if (driverE or not CheckAccess(ply, 'personal', apc) or ply:KeyDown(IN_WALK)) and apc.HatchOpened and #apc.Passengers < ZAPC_MAX_PASSENGERS() then
				apc:AddPassenger(ply)
				return true
			-- Driver?
			elseif not driverE and CheckAccess(ply, 'personal', apc) then
				-- It's okay. Just return.
				return
			-- Authorized to be gunner?
			elseif CheckAccess(ply, 'personal', apc) and not IsValid(apc.Gunner) then
				ply:EnterVehicle(apc.GunnerSeat)
				return true
			end
		end
	end
end
hook.Add('PlayerUse', '_ZAPC.PlayerUse', PlayerUse)

local function CanExitVehicle(vehicle, ply)
	local apc = vehicle.APC
	if IsValid(apc) then
		if apc.Destructing or (ply ~= apc.Driver and ply ~= apc.Gunner and not apc.HatchOpened) then
			return false
		end
	end
end
hook.Add('CanExitVehicle', '_ZAPC.CanExitVehicle', CanExitVehicle)

function ENT:FireTurret()
	-- more gun? No gun.
	if not IsValid(self.Gunner) or self.Destructing then
		return
	end
	
	self.NextPrimary = CurTime() + ZAPC_PRIMARY_DELAY()
	
	-- click click click
	if self.Bullets <= 0 then
		self:EmitSound('Weapon_Shotgun.Empty', 200, 100)
		return
	end
	
	local turret = self.Turret
	
	-- Prepare.
	self.Bullets = self.Bullets - 1
	self:BulletUpdate()
	
	-- If we call this RIGHT NOW (i.e. inside KeyPress), weird stuff happens.
	-- Don't do that.
	-- In Think, it's okay. So, just delay it.
	local muzzleTach = self.DriverSeat:LookupAttachment('muzzle')
	local attach = self.DriverSeat:GetAttachment(muzzleTach)
	attach.Pos = attach.Pos - 5 * attach.Ang:Forward()  - attach.Ang:Up()*6
	turret:SetPos(attach.Pos)
	turret:SetAngles(attach.Ang)

	-- And now, pewpew.
	turret:EmitSound('Weapon_AR2.Single')

	local bullet = {}
		bullet.Num = 1
		bullet.Src = attach.Pos
		bullet.Dir = attach.Ang:Forward()
		bullet.Spread = Vector(ZAPC_PRIMARY_SPREAD(), ZAPC_PRIMARY_SPREAD(), 0)
		bullet.Tracer = 1
		bullet.TracerName = 'AR2Tracer'
		bullet.Force = ZAPC_PRIMARY_FORCE()
		bullet.Damage = ZAPC_PRIMARY_DAMAGE() * (self.Special and 100 or 1)
		bullet.Attacker = self.Gunner
	turret:FireBullets(bullet)

	local effd = EffectData()
		effd:SetEntity(self.DriverSeat)
		effd:SetAngles(attach.Ang)
		effd:SetOrigin(attach.Pos)
		effd:SetScale(1.8)
		effd:SetAttachment(muzzleTach)
	util.Effect('AirboatMuzzleFlash', effd)
		
	if self.Bullets == 0 then
		self:ReloadGun()
	end
end

-- Sends updates for primary
function ENT:PrimaryUpdate(ply)
	SendUserMessage('ZAPC_LPU', ply or self:GetReceipees())
end

function ENT:SecondaryUpdate(ply)
	SendUserMessage('ZAPC_LSU', ply or self:GetReceipees())
end

-- cleans the dishes, duh.
function ENT:FireRocket()
	if self.NextSecondary > CurTime() or self.Destructing then
		return
	end
	
	self.NextSecondary = CurTime() + ZAPC_SECONDARY_RELOAD_TIME()
	
	self:SecondaryUpdate()
	
	self:EmitSound('PropAPC.FireRocket')
	local attachLookup = self.DriverSeat:LookupAttachment('cannon_muzzle')
	local attach = self.DriverSeat:GetAttachment(attachLookup)
	local ent = ents.Create('prop_vehicle_zapc_rocket')
		ent:SetOwner(self.Gunner)
		ent:SetPos(attach.Pos + self:GetForward()*2)
		ent:SetAngles(attach.Ang)
		ent.APC = self
	ent:Spawn()
	
	if self.Special then
		ent:SetModel('models/props_junk/watermelon01.mdl')
		ent:SetMaterial('models/shiny')
		ent:SetColor(Color(0, 242, 255, 255))
	end
	
	-- MUZZLEDUZZLE
	local ed = EffectData()
		ed:SetEntity(self.DriverSeat)
		ed:SetScale(2)
		ed:SetAttachment(attachLookup)
	util.Effect('AirboatMuzzleFlash', ed)
	
	timer.Simple(ZAPC_SECONDARY_RELOAD_TIME(), function() Beep(self, 'buttons.snd6') end)
end

-- Helper function called to un-solid a player. Calls itself recursively.
local ZAPC_GHOST_LIST = {}
local function UnsolidifyPlayer(ply)
	if not IsValid(ply) or not ply:Alive() or IsValid(ply:GetVehicle()) then
		ZAPC_GHOST_LIST[ply] = nil
		return
	end
	
	-- Check for collisions
	local tr = util.TraceEntity({ start = ply:GetPos(), endpos = ply:GetPos(), filter = ply}, ply)
	if tr.Hit then
		timer.Simple(0.5, function() UnsolidifyPlayer(ply) end)
		return
	end
	
	ply:SetCustomCollisionCheck(ZAPC_GHOST_LIST[ply])
	ZAPC_GHOST_LIST[ply] = nil
end

-- Assure that ghosted players don't collide.
local function ShouldCollide(ent1, ent2)
	if not IsValid(ent1) or not IsValid(ent2) then
		return
	end
	
	if (ent2:IsPlayer() and ZAPC_GHOST_LIST[ent1] ~= nil) or (ent1:IsPlayer() and ZAPC_GHOST_LIST[ent2] ~= nil) then
		return false
	end
end
hook.Add('ShouldCollide', '_ZAPC.ShouldCollide', ShouldCollide)

-- Gets rid of a player... in a nice way.
function ENT:ExitPlayer(ply, nopos)
	SendViewMode(ply, ZAPC_VIEW_UNRELATED)
	ply:GodDisable()
	ply:SetColor(Color(255, 255, 255, 255))
	ply:SetNoDraw(false)
	ZAPC_GHOST_LIST[ply] = ply:GetCustomCollisionCheck()
	timer.Simple(0.5, function() UnsolidifyPlayer(ply) end)
	if not nopos then
		ply:SetPos(self:GetPos() + self:GetForward()*60)
	end
end

-- Hello Fräulein!
function ENT:EnterPlayer(ply)
	ply:GodEnable()
	ply:SetNoDraw(true)
	ply:SetColor(Color(255, 255, 255, 0))
	-- Send the DriverSeat as APC.
	SendUserMessage('ZAPC_AU', ply, self.DriverSeat)
	-- And hatches!
	self:HatchUpdate(ply)
end

-- Ouch.
local function EntityTakeDamage(ent, dmg)
	if IsValid(ent) and ent:GetClass() == 'prop_vehicle_jeep' and IsValid(ent.APC) and dmg:GetDamage() > 1 then
		ent.APC:Pewpew(dmg:GetDamage())
	end
end
hook.Add('EntityTakeDamage', '_ZAPC.EntityTakeDamage', EntityTakeDamage)

local function PlayerSpawn(ply)
	-- Under NO circumstances can you re-spawn inside the APC. This prevents KillSilent/Spawn combos to switch characters while inside.
	if IsValid(ply) and IsValid(ply:GetVehicle()) and IsValid(ply:GetVehicle().APC) then
		ply:ExitVehicle()
	end
end
hook.Add('PlayerSpawn', '_ZAPC.PlayerSpawn', PlayerSpawn)

function ENT:Pewpew(amount)
	if self.Special then
		amount = amount * 0.001
	end
	
	self:SetHealth(math.max(self:Health() - amount, 0))
	if self:Health() <= 0 then
		-- We are not allowed to do this in this frame.
		timer.Simple(0, function() BlowUp(self) end)
		return
	end
	self:HealthUpdate()
end


local function CleanupGibs(ent, gibs)
	for k, v in pairs(gibs) do
		if IsValid(v) then
			v:Remove()
		end
	end
end

-- POUFF.
function ENT:Explode()
	-- Do not explode multiple times.
	if self.Died then
		return
	end
	
	local apc = self.DriverSeat
	local driver, gunner = self.Driver, self.Gunner
	
	if IsValid(driver) then
		self:ExitPlayer(driver, true)
		driver:ExitVehicle()
		driver:SetPos(apc:GetPos() + apc:GetForward()*150 - apc:GetRight()*50 + apc:GetUp()*150)
		driver:SetVelocity(apc:GetForward()*500 + apc:GetUp()*600 - apc:GetRight() * math.random(50, 200))
		self.Driver = nil
		driver:Kill()
	end
	
	if IsValid(gunner) then
		self:ExitPlayer(gunner, true)
		gunner:ExitVehicle()
		gunner:SetPos(apc:GetPos() + apc:GetForward()*150 + apc:GetRight()*50 + apc:GetUp()*150)
		gunner:SetVelocity(apc:GetForward()*500 + apc:GetUp()*600 + apc:GetRight() * math.random(50, 200))
		self.Gunner = nil
		gunner:Kill()
	end
	
	for k, v in pairs(self.Passengers) do
		local pass = v:GetPassenger(0)
		self:ExitPlayer(pass)
		pass:ExitVehicle()
		pass:Kill()
	end
	
	-- Now, when we explode, we explode. Of course.
	local expl = ents.Create('env_explosion')
		expl:SetPos(apc:GetPos() + apc:GetForward()*80 + apc:GetUp()*10)
		expl:SetKeyValue('imagnitude', tostring(ZAPC_EXPLOSION_MAGNITUDE()))
		expl:SetKeyValue('iradiusoverride', tostring(ZAPC_EXPLOSION_RADIUS()))
	expl:Spawn()
	expl:Fire('explode', '', 0)

		
	-- Create some gibs.
	local gibs = {}
	
	for i = 1,5 do
		local ent = ents.Create('prop_physics')
		ent:SetModel('models/combine_apc_destroyed_gib0' .. i .. '.mdl')
		ent:SetPos(apc:GetPos())
		ent:SetAngles(apc:GetAngles())
		ent:Spawn()
		table.insert(gibs, ent)
	end
	
	-- Fix the undo/cleanup history.
	undo.ReplaceEntity(self, gibs[1])
	cleanup.ReplaceEntity(self, gibs[1])
	
	gibs[1]:CallOnRemove('ZAPCCleanUp', CleanupGibs, gibs)
	
	-- Special for the wheel!
	local ent = ents.Create('prop_physics')
		ent:SetModel('models/combine_apc_destroyed_gib06.mdl')
		ent:SetPos(self:GetPos() - self:GetRight()*110 - self:GetUp()*30)
		ent:SetAngles(self:GetForward():Angle())
	ent:Spawn()
	table.insert(gibs, ent)
	
	-- The softy	
	expl = ents.Create('env_physexplosion')
		expl:SetPos(apc:GetPos() + apc:GetForward()*80)
		expl:SetKeyValue('magnitude', tostring(ZAPC_EXPLOSION_MAGNITUDE()))
		expl:SetKeyValue('spawnflags', '1') -- 19 would be push players + disorient players
	expl:Spawn()
	expl:Fire('explode', '', 0)
	expl:Fire('kill', '', 1)
	
	-- And dead.
	self:Remove()
	self.Died = true	
end

-- dam dam daaaam
function ENT:OnRemove()
	-- Eject people
	local driver = self.Driver
	if IsValid(driver) then
		self:ExitPlayer(driver, true)
	end
	
	local gunner = self.Gunner
	if IsValid(gunner) then
		self:ExitPlayer(gunner)
	end

	-- Passengers are a bit special; because the table is modified (i.e. the passenger is removed)
	for k, v in pairs(self.Passengers) do
		local pass = v:GetPassenger(0)
		self:ExitPlayer(pass)
	end
	
	-- Get rid of the APC
	if IsValid(self.DriverSeat) then
		self.DriverSeat:Remove()
	end
	
	if IsValid(self.GunnerSeat) then
		self.GunnerSeat:Remove()
	end
	
	for k, v in pairs(self.Passengers) do
		v:Remove()
	end
	
	if self.SirenSound then
		self.SirenSound:Stop()
	end
	
	self:StopSound(ZAPC_REPAIR_SOUND)
	self:StopSound('apc_engine_start')
end

local function PlayerLeaveVehicle(ply, vehicle)
	if IsValid(vehicle.APC) and not vehicle.APC.Destructing then
		-- Is it the player?
		if vehicle.APC.Driver == ply then
			timer.Simple(0, function() ColdBoot(vehicle.APC) end)
		end
		
		vehicle.APC:RemovePassenger(ply, vehicle)
	end
end
hook.Add('PlayerLeaveVehicle', '_ZAPC.PlayerLeaveVehicle', PlayerLeaveVehicle)

-- If passengers disconnect while being inside, everything fucks up majorly.
local function PlayerDisconnected(ply)
	local vehicle = ply:GetVehicle()
	if IsValid(vehicle) and IsValid(vehicle.APC) then
		vehicle.APC:RemovePassenger(ply, vehicle)
	end
end
hook.Add('PlayerDisconnected', '_ZAPC.PlayerDisconnected', PlayerDisconnected)

concommand.Add('zapc_sd', function(ply, cmd, args)
	if not IsValid(ply) then
		return
	end
	
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent.APC) or ent.APC.Destructing or not CheckAccess(ply, 'destruct', ent.APC) or ply:GetVehicle() == ent.APC.DriverSeat or ply:GetVehicle() == ent.APC.GunnerSeat then
		return
	end
	
	ent.APC:SelfDestruct()
end, nil, "Blows up the APC you are looking at - if you have the required authorization.")

concommand.Add('zapc_sa', function(ply, cmd, args)
	if not IsValid(ply) then
		return
	end
	
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent.APC) or ent.APC.Destructing or not CheckAccess(ply, 'alarm', ent.APC) or ply:GetVehicle() == ent.APC.DriverSeat or ply:GetVehicle() == ent.APC.GunnerSeat then
		return
	end
	
	ent.APC:StartAlarm()
end, nil, "Starts an alarm on the APC you are looking at - if you have the required authorization.")

function ENT:SelfDestruct()
	self.Destructing = true
	
	-- Make the beeps!
	-- Normal beeps
	-- [1, 3] @ 1
	for i = 0, 3 do
		timer.Simple(i, function() Beep(self, 'buttons.snd16') end)
	end
	
	-- Faster beeps
	-- [3, 5] @ 5
	for i = 1, 4 do
		timer.Simple(3 + i/2, function() Beep(self, 'buttons.snd16') end)
	end
	
	-- BEEEEP
	-- [5.25, 6.5] @ 0.25
	for i = 1, 9 do
		timer.Simple(5 + i/8, function() Beep(self, 'buttons.snd16') end)
	end
	
	timer.Simple(6.25, function() BlowUp(self) end)
	
	self.DriverSeat:Fire('TurnOff', '')
	self.DriverSeat:Fire('Lock', '')
	
	if IsValid(self.Driver) or IsValid(self.Gunner) then
		SendUserMessage('ZAPC_SD', self:GetReceipees())
	end
end

function ENT:StartRepairing(ply)
	self.RepairingPlayer = ply
	local effectdata = EffectData()
	effectdata:SetScale(500)
	effectdata:SetRadius(100000)
	
	self.RepairEffectData = effectdata
	
	-- And start the effect! Yaaay!
	timer.Create('ZAPCRepair' .. self:EntIndex(), 0.1, 0, function() if IsValid(self) then self:RepairEffect() end end)
	self:EmitSound(ZAPC_REPAIR_SOUND)
end

function ENT:RepairEffect()
	-- Is the player still valid?
	local tr = self.RepairingPlayer:GetEyeTrace()
	-- Too close?
	if not IsValid(self.RepairingPlayer) or tr.Entity ~= self.DriverSeat or tr.HitPos:Distance(self.RepairingPlayer:GetPos()) < 270 then
		self:EndRepairing()
		return
	end
	
	-- Do the effect!
	local ed = self.RepairEffectData
	ed:SetStart(self.RepairingPlayer:EyePos())
	ed:SetOrigin(tr.HitPos)
	ed:SetNormal(tr.HitNormal)
	util.Effect("GaussTracer", ed)
	
	-- Now repair us!
	self:SetHealth(self:Health() + ZAPC_REPAIR_FORCE())
	self:HealthUpdate()
	-- Are we full again?
	if self:Health() > ZAPC_MAX_HEALTH()*1.5 and not self.Special then
		self:MakeSpecial()
		-- End the healing. :(
		self:EndRepairing()
	end
end

function ENT:MakeSpecial()
	-- BUT MAKE US SHINY
	self.Special = true	
	self:EmitSound('bounce.concrete')
	
	local effectdata = EffectData()
	effectdata:SetOrigin(self.DriverSeat:GetPos())
	effectdata:SetScale(1000)
	effectdata:SetRadius(100)
	effectdata:SetColor(255, 0, 255, 255)

	for i = 1, 10 do
		timer.Simple(i/20, function()
			util.Effect('ThumperDust', effectdata)
		end)
	end
	
	timer.Simple(0.6, function()
		self.DriverSeat:SetMaterial('models/shiny')
		self.DriverSeat:SetColor(Color(255, 215, 0, 255))
	end)
	
	if self.SirenSound then
		self.SirenSound:Stop()
		self.SirenSound = nil
		self.Siren = false
	end
end

function ENT:EndRepairing()
	timer.Destroy('ZAPCRepair' .. self:EntIndex())
	self.RepairingPlayer = nil
	self:StopSound(ZAPC_REPAIR_SOUND)
end

concommand.Add('+zapc_repair', function(ply, cmd, args)
	-- Check the trace
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent) or not IsValid(ent.APC) then
		return
	end

	-- Is it even allowed?
	if ZAPC_REPAIR_FORCE() == 0 then
		return
	end
	
	-- It's an APC! Amazing!
	local zapc = ent.APC
	
	-- If we aren't allowed to do anything, the APC is already being healed OR it is at full health, do nothing
	if not CheckAccess(ply, 'repair', zapc) or IsValid(zapc.HealingPlayer) or zapc:Health() >= ZAPC_MAX_HEALTH()*1.5 or zapc.Destructing then
		return
	end
	zapc:StartRepairing(ply)
end, nil, "What could this function possibly do? Better don't touch it.")

concommand.Add('-zapc_repair', function(ply, cmd, args)
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent) or not IsValid(ent.APC) then
		return
	end

	if ent.APC.RepairingPlayer == ply then
		ent.APC:EndRepairing()
	end
end, nil, "What could this function possibly do? Better don't touch it.")

function ENT:ToggleEngine()
	if self.Destructing then
		return
	end
	
	self.TurnedOn = not self.TurnedOn
	self[(self.TurnedOn and 'Start' or 'Stop') .. 'Engine'](self)
end

local function StopSirenSound(apc)
	if not IsValid(apc) then
		return
	end
	
	apc.SirenSound = nil
end

function ENT:ToggleSiren()
	if self.Destructing then
		return
	end
	
	-- Don't enable before we died.
	if not self.Siren and self.SirenSound then
		return
	end
	
	self.Siren = not self.Siren
	
	if self.SirenSound then
		self.SirenSound:FadeOut(1.5)
		timer.Simple(1.6, function() StopSirenSound(self) end)
		self.NextAlarm = nil
	else
		self.SirenSound = CreateSound(self.DriverSeat, self.Special and 'd1_trainstation.ChaseMusic' or 'd1_canals_08.siren01')
		self.SirenSound:SetSoundLevel(self.Special and 110 or 150)
		self.SirenSound:PlayEx(1.0, 100)
	end
end

function ENT:StartAlarm()
	if self.Destructing then
		return
	end
	
	-- If the siren isn't running, enable it
	if not self.Siren then
		self:ToggleSiren()
	end
	
	self.SirenSound:ChangePitch(200, 0)
	self.NextAlarm = CurTime() + ZAPC_ALARM_INTERVAL
end

function ENT:ToggleSpeed()
--~ 	self.SlowDrive = not self.SlowDrive
--~ 	self.DriverSeat:SetKeyValue('vehiclescript', 'scripts/vehicles/zapc_script' .. (self.SlowDrive and '_slow' or '') .. '.txt')
--~ 	RunConsoleCommand('vehicle_flushscript')
end

-- Fixes the view
local function SetupPlayerVisibility(ply, ent)
	if IsValid(ply:GetVehicle().APC) then
		-- Add above him too
		AddOriginToPVS(ply:GetVehicle():GetPos() + Vector(0, 0, 10))
	end
end
hook.Add('SetupPlayerVisibility', '_ZAPC.SetupPlayerVisibility', SetupPlayerVisibility)

-- Non-admins and non-authorized personal cannot do ANYTHING to us.
-- ANYTHING!
function ENT:CanTool(ply, tr, mode)
	return CheckAccess(ply, 'tool', self, tr, mode) and mode ~= 'duplicator'
end

function ENT:PhysgunPickup(ply)
	return false
end

concommand.Add('zapc_togglehatch', function(ply, cmd, args)
	local apc = ply:GetEyeTrace().Entity.APC
	
	-- Check if it's an APC
	if not IsValid(apc) then
		ReplyTo(ply, 'You are not looking at an APC.')
		return
	end
	
	-- Check what way we want it locked
	local opened = not apc.HatchOpened
	
	-- Do we have a parameter-sided override?
	if #args > 0 and #args[1] > 0 then
		opened = tobool(args[1])
	end
	
	-- For HUI reasons.
	local openedString
	-- `locked' describes the state we want to put it in.
	if opened then
		openedString = 'unlock'
	else
		openedString = 'lock'
	end
	
	-- openedString describes what the player wishes to do
	
	-- Check distance
	if apc.DriverSeat:GetPos():Distance(ply:GetPos()) > ZAPC_REMOTE_LOCK_DISTANCE() then
		ReplyTo(ply, "You are too far away to %s this APC's hatch.", openedString)
		return
	end
	
	-- Check authorization
	if (not CheckAccess(ply, 'remotelock', apc, locked)) then
		ReplyTo(ply, "You are not authorized to %s this APC's hatch.", openedString)
		return
	end
	
	-- Check if we are even changing something
	if opened == apc.HatchOpened then
		ReplyTo(ply, "The APC's hatch is already %sed", openedString) -- I love English
		return
	end
	
	-- Do it then, I guess
	apc:ToggleHatch()
	
	ReplyTo(ply, 'Success. Hatch is now %sed.', openedString)
end)

concommand.Add('zapc_enterhatch', function(ply, cmd, args)
	local apc = ply:GetEyeTrace().Entity.APC
	
	-- Check if it's an APC
	if not IsValid(apc) then
		ReplyTo(ply, 'You are not looking at an APC.')
		return
	end
	
	-- Check distance. In tests, 100 seemed OK. No need to have a configuration for this.
	if ply:GetEyeTrace().HitPos:Distance(ply:EyePos()) > 100 then
		ReplyTo(ply, "You are too far away to enter this APC.")
		return
	end
	
	if not apc.HatchOpened then
		ReplyTo(ply, "This APC's hatch is closed.")
		return
	end
	
	if #apc.Passengers >= ZAPC_MAX_PASSENGERS() then
		ReplyTo(ply, "This APC is full.")
		return
	end
	
	-- Add him.
	apc:AddPassenger(ply)
end)

--[[ 
Because some people fail to realize that hooks should only return a value if they wish this action to be final,
there are some addons that break the APC. Currently, there are none that I know of. However, there have
been in the past and this is the reason this function exists.

What this function does is basically "wrapping" the old functions. If such a "rogue" function has been found,
it will be wrapped and re-placed. Currently, the wrapper does nothing, and I believe simply re-inserting it into
the hook table is enough to execute said function *after* ours.

There would be an extremely easy way to fix the issue - but we needed lua 5.2 for the __pairs metamethod.
]]

local function WrapFunction(event, name)
	local func = hook.GetTable()[event][name]
	if not func then
		return
	end
	
	hook.Remove(event, name)
	hook.Add(event, name, function(...) func(...) end)
end

local function Initialize()
	--[[
	The official HALL OF SHAME.
	(NOW HIRING)
	]]--
end
hook.Add('Initialize', '_ZAPC.Initialize', Initialize)

-- In case this happens again, here's a few debuggers.
local function DumpHooks(ply, cmd, args)
	if IsValid(ply) and (game.IsDedicated() or not ply:IsListenServerHost()) then
		ply:PrintMessage(HUD_PRINTCONSOLE, "[ZAPC] This is a server command. Execute it on the server, not the client.")
		return
	end
	
	local hooks = { 'PlayerEnteredVehicle', 'PlayerUse', 'CanPlayerEnterVehicle', 'KeyPress', 'CanExitVehicle', 'ShouldCollide', 'EntityTakeDamage', 'PlayerLeaveVehicle' }
	
	print("\n[ZAPC] Dumping possible hook collisions...")
	for _, h in pairs(hooks) do
		print("[ZAPC]   " .. h)
		for k, v in pairs(hook.GetTable()[h]) do
			print('[ZAPC]     "' .. tostring(k) .. '"')
		end
		print()
	end
	
	print("[ZAPC] Hooks dumped.")
end
concommand.Add('zapc_dumphooks', DumpHooks, nil, "Dumps all hooks that could possibly cause havok.")