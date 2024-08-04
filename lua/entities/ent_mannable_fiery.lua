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
ENT.PrintName = "Incendiary gun (geneva no like)"
ENT.Category = "Jakub Baku Emplacements"
ENT.Spawnable = true
ENT.AdminOnly = false

if(SERVER) then
    ENT.ShootDelay = 0.075

    ENT._DoNetworking = true
    ENT._HideGunModel = false
    ENT._PitchOffset = 10
    
	function ENT:DoInit()
		self:BakuRegisterMannable()
		self.ShootDelay = 0.05

        self._DoNetworking = true
		self._HideGunModel = false
        self._PitchOffset = 10
        self.__ShootSound = nil
	end

	function ENT:DoImpactEffect(tr, _dmg)
        local ef = EffectData()
        ef:SetOrigin(tr.HitPos + tr.HitNormal * 2)
        ef:SetNormal(tr.HitNormal)
        ef:SetScale(1)

        util.Effect("eff_baku_impactor", ef)
        return true
    end

    function ENT:OnStartShooting()
        self.__ShootSound = CreateSound(self, "poopass/fireloop.wav")
        self.__ShootSound:Play()
    end

    function ENT:OnStopShooting()
        if(self.__ShootSound) then
            self.__ShootSound:Stop()
        end
        self:EmitSound("poopass/winddown.wav")
    end

    function ENT:DoRemove()
        if(self.__ShootSound) then
            self.__ShootSound:Stop()
        end
    end

	function ENT:DoShoot(dest)
		local bullet = {
            TracerName = "eff_baku_burntcer",
            Damage = 10,
            Force = 5,
            Spread = Vector(1, 1, 0) * 0.02,
            Src = self:GetAttachment(1).Pos,
            Dir = dest,
            Attacker = self._User,
            Inflictor = self,
            Callback = function(_att, _tr, _dmg)
                local ent = _tr.Entity

                if(!ent:IsPlayer()) then
                    ent:Ignite(2)
                end
            end
        }

        self:FireBullets(bullet)
        //self:EmitSound("Weapon_AR2.NPC_Single")

        local eff = EffectData()
        eff:SetEntity(self)
        eff:SetAttachment(1)
        eff:SetScale(2)

        util.Effect("eff_baku_burnzzle", eff)
	end
else
    function ENT:OnActivateGun()

    end

    function ENT:OnDeactivateGun()

    end

    local glow = Material("sprites/combine_cannon_glow")

    function ENT:DoDraw()
        /*if(self._Active) then
            render.SetMaterial(glow)
            render.DrawSprite(self:GetAttachment(1).Pos, 40, 32)
        end*/
    end
end