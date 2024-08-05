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

ENT.StartHealth = 80

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SoldierInit()

    self:SetSkin(1,1)

    self.SoundTbl_NovaProspektIdle = {
    "npc/combine_soldier/vo/prison_soldier_visceratorsa5.wav",
    "npc/combine_soldier/vo/prison_soldier_tohighpoints.wav",
    "npc/combine_soldier/vo/prison_soldier_sundown3dead.wav",
    "npc/combine_soldier/vo/prison_soldier_prosecuted7.wav",
    "npc/combine_soldier/vo/prison_soldier_negativecontainment.wav",
    "npc/combine_soldier/vo/prison_soldier_leader9dead.wav",
    "npc/combine_soldier/vo/prison_soldier_fullbioticoverrun.wav",
    "npc/combine_soldier/vo/prison_soldier_freeman_antlions.wav",
    "npc/combine_soldier/vo/prison_soldier_fallback_b4.wav",
    "npc/combine_soldier/vo/prison_soldier_containd8.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker3.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker2.wav",
    "npc/combine_soldier/vo/prison_soldier_bunker1.wav",
    "npc/combine_soldier/vo/prison_soldier_boomersinbound.wav",
    "npc/combine_soldier/vo/prison_soldier_activatecentral.wav",
    }

    self.SoundTbl_Idle = self.SoundTbl_NovaProspektIdle
    self.SoundTbl_IdleDialogue = self.SoundTbl_NovaProspektIdle

    self.SoundTbl_RadioOn = {
    "npc/combine_soldier/vo/on1.wav",
    "npc/combine_soldier/vo/on2.wav",
    }

    self.SoundTbl_RadioOff = {
    "npc/combine_soldier/vo/off1.wav",
    "npc/combine_soldier/vo/off2.wav",
    "npc/combine_soldier/vo/off2.wav",
    }
    
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------