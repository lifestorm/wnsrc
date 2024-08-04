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
ENT.PrintName = "Gauss Gun"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
	function ENT.DupeFunction(ply, data)
		data.__PreFireTimer = 0
	end
	
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.__ChargeSound = nil
		self.__PreFireTimer = 0
		self.ShootDelay = 0.075
		self._Automatic = false

		self._HideGunModel = true
	end

	function ENT:OnStartAttack()
		if(self.__PreFireTimer < CurTime()) then
			self.__ChargeSound = CreateSound(self, "Jeep.GaussCharge")
			self.__ChargeSound:Play()
			self.__PreFireTimer = CurTime() + 0.4

			if(math.random(1, 4) == 2) then
				local ef = EffectData()
				ef:SetOrigin(self:GetBonePosition(4))
				ef:SetMagnitude(2)

				util.Effect("ElectricSpark", ef)
			end

			self._ShootTimer = CurTime() + 0.4
		end
	end

	function ENT:OnStopAttack()
		if(self.__ChargeSound) then
			self.__ChargeSound:Stop()
		end
	end

	function ENT:OnStartShooting()
		if(self.__ChargeSound) then
			self.__ChargeSound:Stop()
		end
	end

	function ENT:DoRemove()
		if(self.__ChargeSound) then
			self.__ChargeSound:Stop()
		end
	end

	function ENT:DoShoot(dest)
        local lastpos = self:GetAttachment(1).Pos
        local lastdir = dest
        local lasthitpos = lastpos
        local lastent = self

        local bounces = math.random(3, 8)

        local __kika02aa = self._User

        local hitentities = {[__kika02aa:EntIndex()] = true}

        for i = 1, bounces do
        	local tr = util.TraceLine({
        		start = lastpos,
        		endpos = lastpos + lastdir * 65535,
        		filter = lastent
        	})

        	local __i = ((bounces - i + 1) / bounces)

        	local ef = EffectData()
        	ef:SetOrigin(tr.HitPos)
        	ef:SetStart(lastpos)
        	ef:SetEntity(NULL)
        	ef:SetScale(__i)
        	ef:SetFlags(0)

    		util.Effect("eff_baku_jeeptracer",ef)

        	lastpos = tr.HitPos
        	lastdir = ((lastdir - 2 * lastdir:Dot(tr.HitNormal) * tr.HitNormal) + VectorRand() * 0.01):GetNormalized()
        	lasthitpos = tr.HitPos

        	if(IsValid(tr.Entity)) then
        		hitentities[tr.Entity:EntIndex()] = true

        		local dmg = DamageInfo()
        		dmg:SetDamage( __i * 40 )
        		dmg:SetDamageType(bit.bor(DMG_SHOCK, DMG_BULLET, DMG_ENERGYBEAM))
        		dmg:SetAttacker(__kika02aa)
        		dmg:SetInflictor(self)
        		dmg:SetDamagePosition(tr.HitPos)

        		tr.Entity:TakeDamageInfo(dmg)

        		if(math.random(1,4) > 1 && tr.Entity:IsNPC()) then
        			lastent = tr.Entity
        			local entsnear = ents.FindInSphere(tr.HitPos, 512)
        			local ent = nil

        			local lasthealth = 65535

        			for k, v in pairs(entsnear) do
        				if(v:IsNPC() && !hitentities[v:EntIndex()] && v:Health() < lasthealth) then
        					ent = v
        					lasthealth = v:Health()
        				end
        			end

        			if(IsValid(ent)) then
	        			hitentities[ent:EntIndex()] = true
	        			lastdir = (ent:GetPos() + ent:OBBCenter() - tr.HitPos):GetNormalized()
	        		end
        		end
        	end

        	if(tr.HitSky) then break end

        	sound.Play("weapons/fx/rics/ric" .. math.random(1, 5) .. ".wav", tr.HitPos, 75, 100 + math.random(-20, 20), 10)
        end

        self:EmitSound("PropJeep.FireCannon")

        local ef = EffectData()
        ef:SetEntity(self)
        ef:SetAttachment(1)
        ef:SetFlags(7)

        util.Effect("MuzzleFlash", ef)

        ef = EffectData()
        ef:SetOrigin(lasthitpos)

        util.Effect("cball_explode", ef)
	end
else
	function ENT:DoInit()
		self:SetupCustomModel("models/weapons/jakubbaku/w_gauss.mdl", 1)

		self._Notification = {"Hold left mouse, let it charge.", "Watch out for ricochetes!"}

		local mat = Matrix()
		mat:Translate(Vector(-3, 0, 0))
		mat:Rotate(Angle(0, 90, 94))
		self._GunModelMatrix = mat
	end

	function ENT:DoThink()
		
	end

	local glow = Material("sprites/bakuglow")

	function ENT:DoDraw()
		if(self._Active) then
			local pos = self:GetAttachment(1).Pos
			render.SetMaterial(glow)
			render.DrawSprite(pos, 40, 32, Color(255, 180, 40))

			local dlight = DynamicLight( self:EntIndex() )
			if ( dlight ) then
				dlight.pos = pos
				dlight.r = 255
				dlight.g = 180
				dlight.b = 40
				dlight.brightness = 1
				dlight.Decay = 100
				dlight.Size = 64
				dlight.DieTime = CurTime() + 0.1
			end
		end
	end
end