--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.Model = {"models/VJ_fassassin_Z.mdl"}
ENT.StartHealth = 50

ENT.MaxJumpLegalDistance = VJ_Set(400, 550) -- The max distance the NPC can jump (Usually from one node to another) | ( UP, DOWN )

ENT.FootStepTimeRun = 0.2
ENT.FootStepTimeWalk = 0.2

ENT.MeleeAttackDamage = 20
ENT.MeleeAttackDistance = 60 -- How close does it have to be until it attacks?
ENT.TimeUntilMeleeAttackDamage = 0.35 -- This counted in seconds | This calculates the time until it hits something
ENT.AnimTbl_MeleeAttack = {"melee","melee2"} -- Melee Attack Animations

ENT.DeathCorpseBodyGroup = VJ_Set(1, 0)

ENT.HasItemDropsOnDeath = true
ENT.ItemDropsOnDeathChance = 1
ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
"item_healthvial",
}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 0, 0), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "ValveBiped.Bip01_Head1", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(5, 0, 5), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = true, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 0, -- Should the camera's angle be affected by the bone's angle? | 0 = No, 1 = Pitch, 2 = Yaw, 3 = Roll
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? | Useful for weird bone angles
}

ENT.Soldier_WeaponSpread = 1

ENT.CanFlinch = 0 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.CanHaveTurret = false
ENT.CanBeMedic = false

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 110

ENT.AnimTbl_WeaponAim = {ACT_IDLE}

ENT.HasWeaponBackAway = false -- Should the SNPC back away if the enemy is close?
ENT.WaitForEnemyToComeOut = false -- Should it wait for the enemy to come out from hiding?
ENT.MoveRandomlyWhenShooting = false -- Should it move randomly when shooting?
ENT.CanCrouchOnWeaponAttack = false -- Can it crouch while shooting?
ENT.AllowWeaponReloading = false -- If false, the SNPC will no longer reload
ENT.AlertedToIdleTime = VJ_Set(0, 0) -- How much time until it calms down after the enemy has been killed/disappeared | Sets self.Alerted to false after the timer expires
ENT.AlertFriendsOnDeath = false -- Should the SNPCs allies get alerted when it dies? | Its allies will also need to have this variable set to true!

ENT.ConstantlyFaceEnemy = false -- Should it face the enemy constantly?
ENT.ConstantlyFaceEnemy_IfVisible = false -- Should it only face the enemy if it's visible?
ENT.ConstantlyFaceEnemy_IfAttacking = true -- Should it face the enemy when attacking?
ENT.ConstantlyFaceEnemyDistance = 3000 -- How close does it have to be until it starts to face the enemy?
ENT.CombatFaceEnemy = false -- If enemy exists and is visible

ENT.DodgeCooldown = {
    min = 2.5,
    max = 5,
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SoldierInit()
    self.SoundTbl_FootStep = {
    "npc/stalker/stalker_footstep_left1.wav",
    "npc/stalker/stalker_footstep_left2.wav",
    "npc/stalker/stalker_footstep_right1.wav",
    "npc/stalker/stalker_footstep_right2.wav",
    }

    local eye = ents.Create( "env_sprite" )
    eye:SetKeyValue( "model","sprites/blueflare1.spr" )
    eye:SetKeyValue( "rendercolor","125 0 0" )
    eye:SetPos( self:GetAttachment(5).Pos )
    eye:SetParent( self, 5 )
    eye:SetKeyValue( "scale","0.18" )
    eye:SetKeyValue( "rendermode","9" )
    eye:Spawn()
    self:DeleteOnRemove(eye)
    util.SpriteTrail(eye, 0, Color(255,0,0), true, 7, 0, 0.35, 0.008, "trails/laser")

    self.NextDodge = CurTime()
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

    ply:ChatPrint("SPACE (jump key): Dodge (you will dodge in the direction you are moving, you cannot dodge forward)")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SoldierThink() 
    if self.IsBeingDroppedByDropship then return end

    if GetConVar("ai_disabled"):GetInt() == 0 then

        if IsValid(self:GetEnemy()) then
        
            if !self.VJ_IsBeingControlled then
                if self:Visible(self:GetEnemy()) && !self:IsBusy() && self.NextDodge < CurTime() then
                    local dodge_dirs = {}

                    for dir, path_clear in pairs(self:VJ_CheckAllFourSides()) do
                        if dir != "Forward" && path_clear then
                            table.insert(dodge_dirs, dir)
                        end
                    end

                    if !table.IsEmpty(dodge_dirs) then
                        local dodge_dir = string.lower(table.Random(dodge_dirs))
                        local anim = nil

                        self:VJ_ACT_PLAYACTIVITY("flip"..dodge_dir,true,0.75,false)
                        self.NextDodge = CurTime()+math.Rand(self.DodgeCooldown.min, self.DodgeCooldown.max)
                    end
                end
            else
                local controller = self.VJ_TheController

                local dodge_dir = nil
                if controller:KeyDown(IN_MOVELEFT) then
                    dodge_dir = "left"
                elseif controller:KeyDown(IN_MOVERIGHT) then
                    dodge_dir = "right"
                elseif controller:KeyDown(IN_BACK) then
                    dodge_dir = "back"
                end

                if dodge_dir && !self:IsBusy() then
                    self:VJ_ACT_PLAYACTIVITY("flip"..dodge_dir,true,0.75,true)
                end
            end
        end

    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)

    self:Give("weapon_vj_9mmpistol")
    for i = 1,2 do
        self:DropWeaponOnDeathCode(dmginfo, hitgroup)
    end
    self.DropWeaponOnDeath = false -- Should it drop its weapon on death?

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------