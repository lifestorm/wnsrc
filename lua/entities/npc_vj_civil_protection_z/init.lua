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


ENT.Model = {"models/Police.mdl"}
ENT.StartHealth = 50

ENT.FootStepTimeRun = 0.3
ENT.FootStepTimeWalk = 0.5

ENT.AnimTbl_GrenadeAttack = {"grenadethrow"} -- Grenade Attack Animations
ENT.TimeUntilGrenadeIsReleased = 0.82 -- Time until the grenade is released

ENT.AnimTbl_Medic_GiveHealth = {"harassfront1"} -- Animations is plays when giving health to an ally
ENT.Medic_TimeUntilHeal = 0.5 -- Time until the ally receives health | Set to false to let the base decide the time

ENT.AnimTbl_MeleeAttack = {"swing"} -- Melee Attack Animations

-- ENT.WeaponInventory_Melee = true -- If true, the NPC will spawn with one of the given weapons (Will only be given the weapon if it already has another!)
-- ENT.WeaponInventory_MeleeList = {"weapon_vj_stunstick_z"} -- It will randomly be given one of these weapons

ENT.CanUseSecondaryOnWeaponAttack = false -- Can the NPC use a secondary fire if it's available?
ENT.CanHaveTurret = false
ENT.ManhackChance = 3

ENT.ItemDropsOnDeath_EntityList = {
"item_battery",
"item_healthvial",
"weapon_frag",
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SoldierInit()

    if math.random(1,self.ManhackChance) == 1 then
        self:SetBodygroup(1, 1)
    end

    if GetConVar("vj_zippycombines_nemez_metrocop_compatibility"):GetInt() > 0 then

        if self.Model[1] == "models/elitepolice.mdl" then
            self:SetModel("models/Police.mdl")
            self:SetBodygroup(2, 1)
            self:SetSkin(5)
        end

        if self.IsMedicSNPC then
            self:SetSkin(1)
        end

    end

    self.SoundTbl_GrenadeAttack = {}

    self.SoundTbl_FootStep = {
    "npc/metropolice/gear1.wav",
    "npc/metropolice/gear2.wav",
    "npc/metropolice/gear3.wav",
    "npc/metropolice/gear4.wav",
    "npc/metropolice/gear5.wav",
    "npc/metropolice/gear6.wav",
    }

    self.SoundTbl_Idle = {
    "npc/metropolice/vo/dispupdatingapb.wav",
    "npc/metropolice/vo/pickingupnoncorplexindy.wav",
    "npc/metropolice/vo/ten97suspectisgoa.wav",
    "npc/metropolice/vo/stillgetting647e.wav",
    "npc/metropolice/vo/404zone.wav",
    "npc/metropolice/vo/standardloyaltycheck.wav",
    "npc/metropolice/vo/anyonepickup647e.wav",
    "npc/metropolice/vo/blockisholdingcohesive.wav",
    "npc/metropolice/vo/checkformiscount.wav",
    "npc/metropolice/vo/catchthatbliponstabilization.wav",
    "npc/metropolice/vo/clearandcode100.wav",
    "npc/metropolice/vo/clearno647no10-107.wav",
    "npc/metropolice/vo/classifyasdbthisblockready.wav",
    "npc/metropolice/vo/control100percent.wav",
    "npc/metropolice/vo/cprequestsallunitsreportin.wav",
    "npc/metropolice/vo/dispreportssuspectincursion.wav",
    "npc/metropolice/vo/wegotadbherecancel10-102.wav",
    "npc/metropolice/vo/localcptreportstatus.wav",
    "npc/metropolice/vo/novisualonupi.wav",
    "npc/metropolice/vo/loyaltycheckfailure.wav",
    }

    self.SoundTbl_IdleDialogue = self.SoundTbl_Idle

    self.SoundTbl_IdleDialogueAnswer = {
    "npc/metropolice/vo/rodgerthat.wav",
    }

    self.SoundTbl_Investigate = {
    "npc/metropolice/vo/requestsecondaryviscerator.wav",
    "npc/metropolice/vo/goingtotakealook.wav",
    "npc/metropolice/vo/movetoarrestpositions.wav",
    "npc/metropolice/vo/investigating10-103.wav",
    "npc/metropolice/vo/readytoamputate.wav",
    "npc/metropolice/vo/readytojudge.wav",
    "npc/metropolice/vo/preparingtojudge10-107.wav",
    "npc/metropolice/vo/prepareforjudgement.wav",
    "npc/metropolice/vo/possible10-103alerttagunits.wav",
    "npc/metropolice/vo/possible404here.wav",
    "npc/metropolice/vo/possiblelevel3civilprivacyviolator.wav",
    "npc/metropolice/vo/possible647erequestairwatch.wav",
    "npc/metropolice/vo/positiontocontain.wav",
    }

    self.SoundTbl_CombatIdle = {
    "npc/metropolice/vo/airwatchsubjectis505.wav",
    "npc/metropolice/vo/assaultpointsecureadvance.wav",
    "npc/metropolice/vo/breakhiscover.wav",
    "npc/metropolice/vo/covermegoingin.wav",
    "npc/metropolice/vo/destroythatcover.wav",
    "npc/metropolice/vo/firingtoexposetarget.wav",
    "npc/metropolice/vo/lockyourposition.wav",
    "npc/metropolice/vo/holdthisposition.wav",
    "npc/metropolice/vo/teaminpositionadvance.wav",
    }

    self.SoundTbl_Alert = {
    "npc/metropolice/vo/allunitscloseonsuspect.wav",
    "npc/metropolice/vo/allunitsmovein.wav",
    "npc/metropolice/vo/contactwith243suspect.wav",
    "npc/metropolice/vo/criminaltrespass63.wav",
    "npc/metropolice/vo/get11-44inboundcleaningup.wav",
    "npc/metropolice/vo/unlawfulentry603.wav",
    "npc/metropolice/vo/malcompliant10107my1020.wav",
    "npc/metropolice/vo/level3civilprivacyviolator.wav",
    "npc/metropolice/vo/ivegot408hereatlocation.wav",
    "npc/metropolice/vo/ihave10-30my10-20responding.wav",
    "npc/metropolice/vo/readytoprosecute.wav",
    "npc/metropolice/vo/priority2anticitizenhere.wav",
    "npc/metropolice/vo/gota10-107sendairwatch.wav",
    }

    self.SoundTbl_WeaponReload = {
    "npc/metropolice/vo/runninglowonverdicts.wav",
    "npc/metropolice/vo/backmeupimout.wav",
    "npc/metropolice/vo/movingtocover.wav",
    "npc/metropolice/vo/finalverdictadministered.wav",
    }

    self.SoundTbl_OnDangerSight = {
    "npc/metropolice/vo/lookout.wav",
    "npc/metropolice/vo/shit.wav",
    "npc/metropolice/vo/takecover.wav",
    "npc/metropolice/vo/getdown.wav",
    }

    self.SoundTbl_OnGrenadeSight = {
    "npc/metropolice/vo/thatsagrenade.wav",
    "npc/metropolice/vo/grenade.wav"
    }

    self.SoundTbl_OnKilledEnemy = {
    "npc/metropolice/vo/chuckle.wav",
    "npc/metropolice/vo/suspectisbleeding.wav",
    "npc/metropolice/vo/sentencedelivered.wav",
    }

    self.SoundTbl_AllyDeath = {
    "npc/metropolice/vo/11-99officerneedsassistance.wav",
    "npc/metropolice/vo/wehavea10-108.wav",
    "npc/metropolice/vo/reinforcementteamscode3.wav",
    "npc/metropolice/vo/officerneedshelp.wav",
    "npc/metropolice/vo/officerunderfiretakingcover.wav",
    "npc/metropolice/vo/officerneedsassistance.wav",
    "npc/metropolice/vo/officerdowniam10-99.wav",
    "npc/metropolice/vo/officerdowncode3tomy10-20.wav",
    "npc/metropolice/vo/cpiscompromised.wav",
    "npc/metropolice/vo/cpisoverrunwehavenocontainment.wav",
    "npc/metropolice/vo/minorhitscontinuing.wav",
    }

    self.SoundTbl_LostEnemy = {
    "npc/metropolice/vo/hidinglastseenatrange.wav",
    "npc/metropolice/vo/hesgone148.wav",
    "npc/metropolice/vo/searchingforsuspect.wav",
    "npc/metropolice/vo/suspectlocationunknown.wav",
    }

    self.SoundTbl_Death = {
    "npc/metropolice/die1.wav",
    "npc/metropolice/die2.wav",
    "npc/metropolice/die3.wav",
    "npc/metropolice/die4.wav",
    }

    self.SoundTbl_Hurt = {"npc/metropolice/vo/help.wav"}
    self.SoundTbl_Pain = {
    "npc/metropolice/pain1.wav",
    "npc/metropolice/pain2.wav",
    "npc/metropolice/pain3.wav",
    "npc/metropolice/pain4.wav",
    "npc/metropolice/vo/help.wav",
    }

    self.SoundTbl_RadioOn = {
    "npc/metropolice/vo/on1.wav",
    "npc/metropolice/vo/on2.wav",
    }

    self.SoundTbl_RadioOff = {
    "npc/metropolice/vo/off1.wav",
    "npc/metropolice/vo/off2.wav",
    "npc/metropolice/vo/off3.wav",
    "npc/metropolice/vo/off4.wav",
    }

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DeployManhack()
    if self.DeployingManhack then return end
    self.DeployingManhack = true

    local manhack_grab_time = 0.33
    local manhack_deploy_time = 1.25

    self:VJ_ACT_PLAYACTIVITY("deploy", true, manhack_deploy_time, false)

    timer.Simple(manhack_grab_time, function() if IsValid(self) then
        self.manhackprop = ents.Create("prop_dynamic")
        self.manhackprop:SetModel("models/manhack.mdl")
        self.manhackprop:SetParent(self, 4)
        self.manhackprop:SetAngles(self:GetAngles())
        self.manhackprop:SetPos(self:GetAttachment(4).Pos)
        self.manhackprop:Spawn()
        self:SetBodygroup(1,0)
    end end)

    timer.Simple(manhack_deploy_time, function() if IsValid(self) then
        self.manhackprop:Remove()
        self.DeployingManhack = false

        local manhack = ents.Create("npc_manhack")
        manhack:SetPos(self:GetPos() + Vector(0,0,90))
        manhack:SetAngles(self:GetAngles())
        manhack:SetKeyValue("spawnflags",tostring(bit.bor(256,65536,262144)))
        manhack:Spawn()
        manhack.VJ_NPC_Class = self.VJ_NPC_Class
    end end)

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_IntMsg(ply, controlEnt)

	ply:ChatPrint("ALT (walk key): Deploy Manhack (if available)")

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
    if self.IsBeingDroppedByDropship then return end

    local enemy = self:GetEnemy()

    if self:GetBodygroup(1) == 1 && IsValid(enemy) then
        if (!self.VJ_IsBeingControlled && self:Visible(enemy) && !self:IsNearDropshipDropPoint()) or (self.VJ_IsBeingControlled && self.VJ_TheController:KeyDown(IN_WALK)) then
            self:DeployManhack()
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------