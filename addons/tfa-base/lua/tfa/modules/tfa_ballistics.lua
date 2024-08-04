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

-- Degrees to accuracy vector, Valve's formula from SDK 2013
TFA.DegreesToAccuracy = math.sin((math.pi / 180) / 2) -- approx. 0.00873

--default cvar integration
local cv_gravity = GetConVar("sv_gravity")

--[[local function TimeScale(v)
	return v * game.GetTimeScale() / TFA.Ballistics.SubSteps
end]]

--init code
TFA.Ballistics = TFA.Ballistics or {}
TFA.Ballistics.Enabled = false
TFA.Ballistics.Gravity = Vector(0, 0, -cv_gravity:GetFloat())
TFA.Ballistics.Bullets = TFA.Ballistics.Bullets or {}
TFA.Ballistics.Bullets.bullet_registry = TFA.Ballistics.Bullets.bullet_registry or {}
TFA.Ballistics.BulletLife = 10
TFA.Ballistics.UnitScale = TFA.UnitScale or 39.3701 --meters to inches
TFA.Ballistics.AirResistance = 1
TFA.Ballistics.WaterResistance = 3
TFA.Ballistics.WaterEntranceResistance = 6

TFA.Ballistics.DamageVelocityLUT = {
	[13] = 350, --shotgun
	[25] = 425, --mp5k etc.
	[35] = 900, --ak-12
	[65] = 830, --SVD
	[120] = 1100 --sniper cap
}

TFA.Ballistics.VelocityMultiplier = 1
TFA.Ballistics.SubSteps = 1
TFA.Ballistics.BulletCreationNetString = "TFABallisticsBullet"

TFA.Ballistics.TracerStyles = {
	[0] = "",
	[1] = "tfa_bullet_smoke_tracer",
	[2] = "tfa_bullet_fire_tracer"
}

setmetatable(TFA.Ballistics.TracerStyles, {
	["__index"] = function(t, k) return t[math.Round(tonumber(k) or 1)] or t[1] end
})

if SERVER then
	util.AddNetworkString(TFA.Ballistics.BulletCreationNetString)
end

--bullet class
local function IncludeClass(fn)
	include("tfa/ballistics/" .. fn .. ".lua")
	AddCSLuaFile("tfa/ballistics/" .. fn .. ".lua")
end

IncludeClass("bullet")
--cvar code
local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end -- replicated only on clients, archive/notify on server

local cv_enabled = CreateReplConVar("sv_tfa_ballistics_enabled", "0", "Enable TFA Ballistics?")
local cv_bulletlife = CreateReplConVar("sv_tfa_ballistics_bullet_life", 10, "Time to process bullets before removing.")
local cv_res_air = CreateReplConVar("sv_tfa_ballistics_bullet_damping_air", 1, "Air resistance, which makes bullets arc faster.")
local cv_res_water = CreateReplConVar("sv_tfa_ballistics_bullet_damping_water", 3, "Water resistance, which makes bullets arc faster in water.")
local cv_vel = CreateReplConVar("sv_tfa_ballistics_bullet_velocity", 1, "Global velocity multiplier for TFA ballistics bullets.")
local cv_substep = CreateReplConVar("sv_tfa_ballistics_substeps", 1, "Substeps for ballistics; more is more precise, at the cost of performance.")
local sv_tfa_ballistics_custom_gravity = CreateReplConVar("sv_tfa_ballistics_custom_gravity", 0, "Enable sv_gravity override for ballistics")
local sv_tfa_ballistics_custom_gravity_value = CreateReplConVar("sv_tfa_ballistics_custom_gravity_value", 0, "Z velocity down of custom gravity")
CreateReplConVar("sv_tfa_ballistics_mindist", -1, "Minimum distance to activate; -1 for always.")

local function updateCVars()
	TFA.Ballistics.BulletLife = cv_bulletlife:GetFloat()
	TFA.Ballistics.AirResistance = cv_res_air:GetFloat()
	TFA.Ballistics.WaterResistance = cv_res_water:GetFloat()
	TFA.Ballistics.WaterEntranceResistance = TFA.Ballistics.WaterResistance * 2
	TFA.Ballistics.VelocityMultiplier = cv_vel:GetFloat()

	if sv_tfa_ballistics_custom_gravity:GetBool() then
		TFA.Ballistics.Gravity.z = -sv_tfa_ballistics_custom_gravity_value:GetFloat()
	else
		TFA.Ballistics.Gravity.z = -cv_gravity:GetFloat()
	end

	TFA.Ballistics.Enabled = cv_enabled:GetBool()
	TFA.Ballistics.SubSteps = cv_substep:GetInt()
end

cvars.AddChangeCallback("sv_tfa_ballistics_enabled", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_bullet_life", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_bullet_damping_air", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_bullet_damping_water", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_bullet_velocity", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_substeps", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_mindist", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_custom_gravity", updateCVars, "TFA")
cvars.AddChangeCallback("sv_tfa_ballistics_custom_gravity_value", updateCVars, "TFA")
cvars.AddChangeCallback("sv_gravity", updateCVars, "TFA Ballistics")
updateCVars()

--client cvar code
local cv_receive, cv_tracers_style, cv_tracers_mp

if CLIENT then
	cv_receive = CreateClientConVar("cl_tfa_ballistics_mp", "1", true, false, "Receive bullet data from other players?")
	CreateClientConVar("cl_tfa_ballistics_fx_bullet", "1", true, false, "Display bullet models for each TFA ballistics bullet?")
	cv_tracers_style = CreateClientConVar("cl_tfa_ballistics_fx_tracers_style", "1", true, false, "Style of tracers for TFA ballistics? 0=disable,1=smoke")
	cv_tracers_mp = CreateClientConVar("cl_tfa_ballistics_fx_tracers_mp", "1", true, false, "Enable tracers for other TFA ballistics users?")
	CreateClientConVar("cl_tfa_ballistics_fx_tracers_adv", "1", true, false, "Enable advanced tracer calculations for other users? This corrects smoke trail to their barrel")
end

--utility func
local function Remap(inp, u, v, x, y)
	return (inp - u) / (v - u) * (y - x) + x
end

--Accessors
local CopyTable = table.Copy

function TFA.Ballistics.Bullets:Add(bulletStruct, originalBulletData)
	local bullet = TFA.Ballistics:Bullet(bulletStruct)
	bullet.bul = CopyTable(originalBulletData or bullet.bul)
	bullet.last_update = CurTime() - TFA.FrameTime()

	table.insert(self.bullet_registry, bullet)

	bullet:_setup()

	if SERVER and game.GetTimeScale() > 0.99 then
		-- always update bullet since they are being added from predicted hook
		bullet:Update(CurTime())
	end
end

function TFA.Ballistics.Bullets:Update(ply)
	--local delta = TimeScale(SysTime() - (self.lastUpdate or (SysTime() - FrameTime())))
	local delta = CurTime()

	--self.lastUpdate = SysTime()
	local toremove
	local lply = CLIENT and LocalPlayer()

	for i, bullet in ipairs(self.bullet_registry) do
		if bullet.delete then
			if not toremove then
				toremove = {}
			end

			table.insert(toremove, i)
		elseif not ply and not bullet.playerOwned or CLIENT and bullet.owner ~= lply or ply == bullet.owner then
			for _ = 1, TFA.Ballistics.SubSteps do
				bullet:Update(delta)
			end
		end
	end

	if toremove then
		for i = #toremove, 1, -1 do
			table.remove(self.bullet_registry, toremove[i])
		end
	end
end

function TFA.Ballistics:AutoDetectVelocity(damage)
	local lutMin, lutMax, LUT, DMGs
	LUT = self.DamageVelocityLUT
	DMGs = table.GetKeys(LUT)
	table.sort(DMGs)

	for _, v in ipairs(DMGs) do
		if v < damage then
			lutMin = v
		elseif lutMin then
			lutMax = v
			break
		end
	end

	if not lutMax then
		lutMax = DMGs[#DMGs]
		lutMin = DMGs[#DMGs - 1]
	elseif not lutMin then
		lutMin = DMGs[1]
		lutMax = DMGs[2]
	end

	return Remap(damage, lutMin, lutMax, LUT[lutMin], LUT[lutMax])
end

function TFA.Ballistics:ShouldUse(wep)
	if not IsValid(wep) or not wep.IsTFAWeapon then
		return false
	end

	local shouldUse = wep:GetStatL("UseBallistics")

	if shouldUse == nil then
		if wep:GetStatL("TracerPCF") then
			return false
		end

		return self.Enabled
	else
		return shouldUse
	end
end

local sv_tfa_recoil_legacy = GetConVar("sv_tfa_recoil_legacy")

function TFA.Ballistics:FireBullets(wep, bulletStruct, angIn, bulletOverride)
	if not IsValid(wep) then return end
	if not IsValid(wep:GetOwner()) then return end

	local vel

	if bulletStruct.Velocity then
		vel = bulletStruct.Velocity
	elseif wep.GetStat and wep:GetStatL("Primary.Velocity") then
		vel = wep:GetStatL("Primary.Velocity") * TFA.Ballistics.UnitScale
	elseif wep.Primary and wep.Primary.Velocity then
		vel = wep.Primary.Velocity * TFA.Ballistics.UnitScale
	elseif wep.Velocity then
		vel = wep.Velocity * TFA.Ballistics.UnitScale
	else
		local dmg

		if wep.GetStat and wep:GetStatL("Primary.Damage") then
			dmg = wep:GetStatL("Primary.Damage")
		else
			dmg = wep.Primary.Damage or wep.Damage or 30
		end

		vel = TFA.Ballistics:AutoDetectVelocity(dmg) * TFA.Ballistics.UnitScale
	end

	vel = vel * (TFA.Ballistics.VelocityMultiplier or 1)

	local oldNum = bulletStruct.Num
	bulletStruct.Num = 1
	bulletStruct.IsBallistics = true

	local owner = wep:GetOwner()
	local isnpc = owner:IsNPC()
	local ac = bulletStruct.Spread
	local sharedRandomSeed = "Ballistics" .. CurTime()

	for i = 1, oldNum do
		local ang

		if angIn then
			ang = angIn
		else
			ang = owner:GetAimVector():Angle()

			if sv_tfa_recoil_legacy:GetBool() and not isnpc then
				ang:Add(owner:GetViewPunchAngles())
			else
				ang.p = ang.p + wep:GetViewPunchP()
				ang.y = ang.y + wep:GetViewPunchY()
			end
		end

		if not angIn then
			ang:RotateAroundAxis(ang:Up(), util.SharedRandom(sharedRandomSeed, -ac.x * 45, ac.x * 45, 0 + i))
			ang:RotateAroundAxis(ang:Right(), util.SharedRandom(sharedRandomSeed, -ac.y * 45, ac.y * 45, 1 + i))
		end

		local struct = {
			owner = owner, --used for dmginfo SetAttacker
			inflictor = wep, --used for dmginfo SetInflictor
			damage = bulletStruct.Damage, --floating point number representing inflicted damage
			force = bulletStruct.Force,
			pos = bulletOverride and bulletStruct.Src or owner:GetShootPos(), --b.Src, --vector representing current position
			velocity = (bulletOverride and bulletStruct.Dir or ang:Forward()) * vel, --b.Dir * vel, --vector representing movement velocity
			model = wep.BulletModel or bulletStruct.Model, --optional variable representing the given model
			smokeparticle = bulletStruct.SmokeParticle,
			customPosition = bulletStruct.CustomPosition or bulletOverride,
			IgnoreEntity = bulletStruct.IgnoreEntity
		}

		if CLIENT then
			if not struct.smokeparticle then
				struct.smokeparticle = TFA.Ballistics.TracerStyles[cv_tracers_style:GetInt()]
			end
		end

		self.Bullets:Add(struct, bulletStruct)

		if SERVER then
			net.Start(TFA.Ballistics.BulletCreationNetString)

			net.WriteEntity(struct.owner)
			net.WriteEntity(struct.inflictor)
			net.WriteFloat(struct.damage)
			net.WriteFloat(struct.force)
			net.WriteVector(struct.pos)

			net.WriteDouble(struct.velocity.x)
			net.WriteDouble(struct.velocity.y)
			net.WriteDouble(struct.velocity.z)

			net.WriteString(struct.model or '')
			net.WriteString(struct.smokeparticle or '')
			net.WriteBool(struct.customPosition == true)
			net.WriteEntity(struct.IgnoreEntity or NULL)

			net.WriteVector(bulletStruct.Src)
			net.WriteNormal(bulletStruct.Dir)
			net.WriteEntity(bulletStruct.Attacker)
			net.WriteVector(bulletStruct.Spread)
			net.WriteFloat(vel)

			if game.SinglePlayer() or isnpc then
				net.SendPVS(struct.pos)
			else
				net.SendOmit(owner)
			end
		end
	end
end

function TFA.Ballistics.Bullets:Render()
	for i = 1, #self.bullet_registry do
		self.bullet_registry[i]:Render()
	end
end

local sp = game.SinglePlayer()

--Netcode and Hooks
if CLIENT then
	net.Receive(TFA.Ballistics.BulletCreationNetString, function()
		if not sp and not cv_receive:GetBool() then return end

		local owner =           net.ReadEntity()
		local inflictor =       net.ReadEntity()
		local damage =          net.ReadFloat()
		local force =           net.ReadFloat()
		local pos =             net.ReadVector()
		local velocity =        Vector(net.ReadDouble(), net.ReadDouble(), net.ReadDouble())
		local model =           net.ReadString()
		local smokeparticle =   net.ReadString()
		local customPosition =  net.ReadBool()
		local IgnoreEntity =    net.ReadEntity()


		local Src =             net.ReadVector()
		local Dir =             net.ReadNormal()
		local Attacker =        net.ReadEntity()
		local Spread =          net.ReadVector()
		local Velocity =        net.ReadFloat()

		if not IsValid(owner) or not IsValid(inflictor) then return end

		if not cv_tracers_mp:GetBool() and owner ~= LocalPlayer() then
			smokeparticle = ""
		elseif smokeparticle == "" then
			smokeparticle = TFA.Ballistics.TracerStyles[cv_tracers_style:GetInt()]
		end

		local struct = {
			owner = owner,
			inflictor = inflictor,
			damage = damage,
			force = force,
			pos = pos,
			velocity = velocity,
			model = model ~= "" and model or nil,
			smokeparticle = smokeparticle,
			customPosition = customPosition,
			IgnoreEntity = IgnoreEntity,
		}

		local bulletStruct = {
			Damage = damage,
			Force = force,
			Num = 1,
			Src = Src,
			Dir = Dir,
			Attacker = Attacker,
			Spread = Spread,
			SmokeParticle = smokeparticle,
			CustomPosition = customPosition,
			Model = model ~= "" and model or nil,
			Velocity = Velocity,
			IsBallistics = true,
		}

		TFA.Ballistics.Bullets:Add(struct, bulletStruct)
	end)
end

if CLIENT then
	hook.Add("FinishMove", "TFABallisticsTick", function(self)
		if IsFirstTimePredicted() then
			TFA.Ballistics.Bullets:Update(self)
		end
	end)
else
	hook.Add("PlayerPostThink", "TFABallisticsTick", function(self)
		TFA.Ballistics.Bullets:Update(self)
	end)
end

hook.Add("Tick", "TFABallisticsTick", function()
	TFA.Ballistics.Bullets:Update()

	if CLIENT and sp then
		TFA.Ballistics.Bullets:Update(LocalPlayer())
	end
end)

--Rendering
hook.Add("PostDrawOpaqueRenderables", "TFABallisticsRender", function()
	TFA.Ballistics.Bullets:Render()
end)
