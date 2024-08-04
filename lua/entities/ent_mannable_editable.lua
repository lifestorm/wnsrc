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

ENT.Base = "ent_mannable_bakubase"
ENT.PrintName = "Editable Gun"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Editable = true

local __muzzles = {
	{effect = "GunshipMuzzleFlash"},
	{effect = "ChopperMuzzleFlash"},
	{effect = "AirboatMuzzleFlash"},
	{effect = "MuzzleFlash", flags = 7},
	{effect = "CS_MuzzleFlash"},
	{effect = "CS_MuzzleFlash_X"},
	{effect = "StriderMuzzleFlash"},
	{effect = "MuzzleFlash", flags = 5}
}

local __tracers = {
	"AR2Tracer",
	"HelicopterTracer",
	"AirboatGunTracer",
	"Tracer",
	"ToolTracer",
	"eff_baku_combinecannon_tracer",
	"eff_baku_jeeptracer",
}

local __impacts = {
	"StunstickImpact",
	"BoltImpact",
	"ManhackSparks",
	"HelicopterMegaBomb",
	"AR2Impact",
}

local __shells = {
	"ShellEject",
	"RifleShellEject",
	"ShotgunShellEject"
}

function ENT:DoSetupDataTables()
	self:NetworkVar("Int", 0, "ProjectileType", {KeyName = "projtype", Edit = { title = "Projectile type", category = "Projectile", type = "Combo", order = 10, values = {
		["Bullet"] = 1,
		["Flechette"] = 2,
		["SMG Grenade"] = 3,
		["Rocket"] = 4,
	}}})

	self:NetworkVar("Float", 0, "PhysProjVel", {KeyName = "physvel", Edit = {title = "Phys projectile velocity", category = "Projectile", type = "Float", order = 20,
	min = 0, max = 8000}})

	self:NetworkVar("Float", 3, "Spread", {KeyName = "spread", Edit = {title = "Spread", category = "Projectile", type = "Float", order = 26,
	min = 0, max = 10}})

	self:NetworkVar("Float", 1, "FireDelay", {KeyName = "firedelay", Edit = {title = "Fire delay", category = "Projectile", type = "Float", order = 25,
	min = 0.05, max = 10}})

	self:NetworkVar("Int", 1, "ProjDamage", {KeyName = "damage", Edit = {title = "Damage", category = "Projectile", type = "Int", order = 30,
	min = 0, max = 100}})

	self:NetworkVar("Int", 2, "NumProjectiles", {KeyName = "numprojectiles", Edit = {title = "Bullets per shot", category = "Projectile", type = "Int", order = 40,
	min = 0, max = 20}})

	self:NetworkVar("String", 0, "ShootSound", {KeyName = "shootsound", Edit = {title = "Shoot sound", category = "Sound", type = "Generic", order = 50}})
	self:NetworkVar("Bool", 0, "__LoopSound", {KeyName = "loopsound", Edit = {title = "Loop fire sound", category = "Sound", type = "Boolean", order = 55}})
	self:NetworkVar("String", 1, "ChargeSound", {KeyName = "chargesound", Edit = {title = "Charge sound", category = "Sound", type = "Generic", order = 60}})
	self:NetworkVar("Float", 2, "ChargeTime", {KeyName = "chargetime", Edit = {title = "Charge time", category = "Sound", type = "Float", order = 70, min = 0, max = 10}})
	self:NetworkVar("String", 3, "EndFireSound", {KeyName = "endfiresound", Edit = {title = "Last fire Sound", category = "Sound", type = "Generic", order = 75}})

	self:NetworkVar("Int", 3, "MuzzleEffect", {KeyName = "muzzleeffect", Edit = { title = "Muzzle flash", category = "Effects", type = "Combo", order = 80, values = {
		["Airboat Gun"] = 3,
		["Chopper"] = 2,
		["Gunship"] = 1,
		["Counter Strike X"] = 6,
		["HL2 Default"] =  4,
		["Counter Strike"] =  5,
		["Strider"] =  7,
		["Combine"] = 8
	}}})

	self:NetworkVar("Int", 4, "TracerEffect", {KeyName = "tracereffect", Edit = { title = "Tracer", category = "Effects", type = "Combo", order = 90, values = {
		["AR2"] = 1,
		["Chopper"] = 2,
		["Airboat Gun"] = 3,
		["HL2 Default"] = 4,
		["Toolgun"] = 5,
		["Combine cannon"] = 6,
		["Gauss gun"] = 7,
	}}})

	self:NetworkVar("Int", 5, "ShellEject", {KeyName = "shelleject", Edit = { title = "Shells", category = "Effects", type = "Combo", order = 100, values = {
		["None"] = 0,
		["Default"] = 1,
		["Rifle"] = 2,
		["Buckshot"] = 3,
	}}})

	if(SERVER) then
		self:NetworkVarNotify("ChargeSound", self.HandleVarChange)
		self:NetworkVarNotify("ChargeTime", self.HandleVarChange)
		self:NetworkVarNotify("FireDelay", self.HandleVarChange)
		self:NetworkVarNotify("__LoopSound", self.HandleVarChange)
		self:NetworkVarNotify("ShootSound", self.HandleVarChange)
		self:NetworkVarNotify("TracerEffect", self.HandleVarChange)
		self:NetworkVarNotify("MuzzleEffect", self.HandleVarChange)
	end

	self:SetShootSound("Weapon_AR2.NPC_Single")
	self:SetChargeSound("Jeep.GaussCharge")
	self:Set__LoopSound(false)
	self:SetProjectileType(1)
	self:SetFireDelay(0.075)
	self:SetProjDamage(13)
	self:SetNumProjectiles(1)
	self:SetPhysProjVel(1000)
	self:SetSpread(3)
	self:SetMuzzleEffect(8)
	self:SetTracerEffect(1)
	self:SetShellEject(0)
end

if(SERVER) then
	function ENT.DupeFunction(ply, data)
		data.__PreFireTimer = 0
	end

	ENT.ShootDelay = 0.075
	ENT.__PreFireTimer = 0
	ENT.__IsLoopSound = false
	ENT.__ShootSound = false
	ENT.__TracerEffect = "Tracer"
	ENT.__MuzzleEffect = {effect = "MuzzleFlash", flags = 5}
	ENT._PitchOffset = 10

	ENT.__ChargeSound = nil
	ENT.__DoCharge = false

	ENT._HideGunModel = false

	local _varhandlers = {
		["ChargeSound"] = function(self, old, new)
			local cleared = string.Trim(new)

			if(cleared != "") then
				self.__ChargeSoundName = cleared
			else
				self.__ChargeSoundName = nil
			end
		end,

		["ChargeTime"] = function(self, old, new)
			self.__DoCharge = new > 0.001
		end,

		["FireDelay"] = function(self, old, new)
			self.ShootDelay = new
		end,

		["__LoopSound"] = function(self, old, new)
			self.__IsLoopSound = new
		end,

		["ShootSound"] = function(self, old, new)
			local cleared = string.Trim(new)

			if(cleared != "") then
				self.__ShootSoundName = cleared
			else
				self.__ShootSoundName = nil
			end
		end,
		["TracerEffect"] = function(self, old, new)
			if(__tracers[new]) then
				self.__TracerEffect = __tracers[new]
			end
		end,
		["MuzzleEffect"] = function(self, old, new)
			if(__muzzles[new]) then
				self.__MuzzleEffect = __muzzles[new]
			end
		end
	}

	function ENT:HandleVarChange(name, old, new)
		if(isfunction(_varhandlers[name])) then
			if(old != new) then
				_varhandlers[name](self, old, new)
			end
		end
	end

	function ENT:DoInit()
		self:BakuRegisterMannable()

		self.ShootDelay = 0.075
		self.__ShootSoundName = self.__ShootSoundName or "Airboat.FireGunLoop"
		self.__ChargeSound = self.__ChargeSound or "Airboat.FireGunLoop"
		self.__PreFireTimer = 0
		self.__IsLoopSound = self.__IsLoopSound or false
		self.__ShootSound = self.__ShootSound or false
		self.__TracerEffect = self.__TracerEffect or "Tracer"
		self.__MuzzleEffect = self.__MuzzleEffect or {effect = "MuzzleFlash", flags = 5}
		self._PitchOffset = 10

		self.__ChargeSound = nil
		self.__DoCharge = false

		self._HideGunModel = false
	end

	function ENT:OnStartAttack()
		if(self.__PreFireTimer < CurTime() && self.__DoCharge) then
			local delay = CurTime() + self:GetChargeTime()
			self.__PreFireTimer = delay
			self._ShootTimer = delay

			if(self.__DoCharge) then
				self.__ChargeSound = CreateSound(self, self.__ChargeSoundName)
				self.__ChargeSound:Play()
			end
		end
	end

	function ENT:OnStartShooting()
		if(self.__DoCharge && self.__ChargeSound) then
			self.__ChargeSound:Stop()
		end

		if(self.__IsLoopSound) then
			self.__ShootSound = CreateSound(self, self.__ShootSoundName)
			self.__ShootSound:Play()
		end
	end

	function ENT:OnStopAttack()
		if(self.__ShootSound) then
			self.__ShootSound:Stop()
		end

		if(self.__ChargeSound) then
			self.__ChargeSound:Stop()
		end

		self:EmitSound(self:GetEndFireSound())
	end

	function ENT:DoRemove()
		if(self.__ChargeSound) then
			self.__ChargeSound:Stop()
		end

		if(self.__ShootSound) then
			self.__ShootSound:Stop()
		end
	end

	local function createphysprojectile(self, dest, class, damagefunc)
		local num = self:GetNumProjectiles()

		for i = 1, num do
			local proj = ents.Create(class)
			proj:SetPos(self:GetAttachment(1).Pos + dest * 10)
			proj:SetAngles(dest:Angle())

			if(isfunction(damagefunc)) then
				damagefunc(self:GetProjDamage(), proj)
			end

			proj:SetOwner(self._User)
			proj:Spawn()
			
			local phys = proj:GetPhysicsObject()

			if(IsValid(phys)) then
				phys:SetVelocity((dest + VectorRand() * self:GetSpread() * 0.01):GetNormalized() * self:GetPhysProjVel())
			else
				proj:SetVelocity((dest + VectorRand() * self:GetSpread() * 0.01):GetNormalized() * self:GetPhysProjVel())
			end

			/*local tbl = proj:GetSaveTable(true)

			print("-------------------------")
			for k, v in pairs(tbl) do
				if(!istable(v) && ( string.find(string.lower(k), "vel") )) then
					print(k, v)
				end
			end*/
		end
	end

	local function setrocketdamage(dmg, proj)
		proj:SetSaveValue("m_flDamage", math.max(dmg, 40))
	end

	local function setboltdamage(dmg, proj)
		//-N-O---W-O-R-K---S-H-I-T- 
	end

	local projectiles = {
		[1] = function(self, dest)
			//bullet
			local bullet = {
	            TracerName = self.__TracerEffect,
	            Damage = self:GetProjDamage(),
	            Force = 5,
	            Spread = Vector(1, 1, 0) * self:GetSpread() * 0.01,
	            Src = self:GetAttachment(1).Pos,
	            Dir = dest,
	            Num = self:GetNumProjectiles(),
	            Attacker = self._User,
	            Inflictor = self,
	        }

	        self:FireBullets(bullet)
		end,

		[2] = function(self, dest)
			createphysprojectile(self, dest, "hunter_flechette")
		end,

		[3] = function(self, dest)
			createphysprojectile(self, dest, "grenade_ar2")
		end,

		[4] = function(self, dest)
			createphysprojectile(self, dest, "rpg_missile", setrocketdamage)
		end,

		[5] = function(self, dest)
			//createphysprojectile(self, dest, "rpg_missile", setrocketdamage)
		end,

		[6] = function(self, dest)
			createphysprojectile(self, dest, "crossbow_bolt", setboltdamage)
		end,
	}

	function ENT:DoShoot(dest)
		local func = projectiles[self:GetProjectileType()]

		if(isfunction(func)) then
			func(self, dest)
		else
			projectiles[1](self, dest)
		end

        if(!self.__IsLoopSound) then
        	self:EmitSound(self:GetShootSound())
        end

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)
        ef:SetFlags(self.__MuzzleEffect.flags or 0)

        util.Effect(self.__MuzzleEffect.effect, ef)

        if(self:GetShellEject() > 0) then
	        ef = EffectData()
	        ef:SetOrigin(self:GetBonePosition(4))
	        ef:SetAngles(self:GetRight():Angle())

	        util.Effect(__shells[self:GetShellEject()], ef)
	    end
	end
else
	function ENT:DoInit()
		/*self:SetupCustomModel("models/weapons/w_hmg1.mdl")

		local mat = Matrix()
		mat:Translate(Vector(5, 0, -1))
		mat:Rotate(Angle(0, 90, 3))
		self._GunModelMatrix = mat*/
	end

	function ENT:DoThink()

	end
end