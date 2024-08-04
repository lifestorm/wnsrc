--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Stunbaton"
SWEP.Author = "Zippy"

SWEP.MadeForNPCsOnly = true
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.HoldType = "melee"
SWEP.Primary.Damage = 25
SWEP.NPC_NextPrimaryFire = 1 -- Next time it can use primary fire
SWEP.IsMeleeWeapon = true
SWEP.MeleeWeaponSound_Hit = {"Weapon_StunStick.Melee_Hit"}
SWEP.MeleeWeaponSound_Miss = {"Weapon_StunStick.Swing"}

function SWEP:CustomOnPrimaryAttack_MeleeHit(ent)

	ParticleEffectAttach("electrical_arc_01_cp0",PATTACH_POINT_FOLLOW,self,1)
	local expLight = ents.Create("light_dynamic")
	expLight:SetKeyValue("brightness", "3")
	expLight:SetKeyValue("distance", "300")
	expLight:Fire("Color", "0 75 255")
	expLight:SetPos(self:GetAttachment(1).Pos)
	expLight:Spawn()
	expLight:SetParent(self,1)
	expLight:Fire("TurnOn", "", 0)
	timer.Simple(0.1,function() if IsValid(expLight) then expLight:Remove() end end)
	self:DeleteOnRemove(expLight)

end