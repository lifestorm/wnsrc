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

SWEP.PrintName = "Fire Vulcan Minigu"
SWEP.Category = "Jakub Baku"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/jakubbaku/v_mach_m249mini.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = false

SWEP.Primary.Automatic = true

SWEP._IsFiring = false
SWEP._FireSnd = nil

function SWEP:Initialize()
	self:SetWeaponHoldType("shotgun")
end

function SWEP:OnStartFiring()
	self._FireSnd = CreateSound(self, "poopass/fireloop.wav")
    self._FireSnd:Play()
end

function SWEP:OnStopFiring()
	if(!self._IsFiring) then return end
	self._FireSnd:Stop()
	self:EmitSound("poopass/winddown.wav")
end

function SWEP:OnRemove()
	self:OnStopFiring()
end

function SWEP:Holster()
	self:OnStopFiring()
	self._IsFiring = false
	return true
end

function SWEP:Think()
	local own = self:GetOwner()

	if(!self._IsFiring && own:KeyDown(IN_ATTACK)) then
		self._IsFiring = true
		self:OnStartFiring()
	elseif(self._IsFiring && !own:KeyDown(IN_ATTACK)) then
		self:OnStopFiring()
		self._IsFiring = false
	end
end

function SWEP:PrimaryAttack()
	local own = self:GetOwner()
	local b = {
		Src = own:GetShootPos(),
		Dir = own:GetAimVector(),
		Damage = 8,
		Force = 6,
		Tracer = 1,
		TracerName = "eff_baku_burntcer",
		Attacker = own,
		Inflictor = self,
		Num = 1,
		Spread = Vector(1,1,0) * 0.02,
	}

	if(SERVER) then
		b.Callback = function(_att, _tr, _dmg)
            local ent = _tr.Entity

            if(!ent:IsPlayer()) then
                ent:Ignite(2)
            end

        end
	end

	own:MuzzleFlash()
	own:SetAnimation( PLAYER_ATTACK1 )
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	own:ViewPunch(AngleRand() * 0.002)

	own:FireBullets(b)
	self:SetNextPrimaryFire(CurTime() + 0.05)
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:DoImpactEffect(tr, dmg)
	local ef = EffectData()
    ef:SetOrigin(tr.HitPos + tr.HitNormal * 2)
    ef:SetNormal(tr.HitNormal)
    ef:SetScale(1)

    util.Effect("eff_baku_impactor", ef)
    return true
end

function SWEP:FireAnimationEvent(pos, ang, event)
	if(event == 5001) then
		local eff = EffectData()
		eff:SetEntity(self.Owner:GetViewModel())
		eff:SetAttachment(1)
		eff:SetScale(0.5)

		util.Effect("eff_baku_burnzzle", eff)
		return true
	elseif(event == 6001) then return true
	end
end

if(SERVER)then

else
	function SWEP:CustomAmmoDisplay()
		self.AmmoDisplay = self.AmmoDisplay or {}
		self.AmmoDisplay.Draw = false

		return self.AmmoDisplay
	end
end