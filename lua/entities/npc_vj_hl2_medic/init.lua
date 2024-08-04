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
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/

ENT.Model = {} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 85
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_CITIZEN","CLASS_AMERICA_FRIENDLY","CIVILAN"} 
ENT.PlayerFriendly = true
ENT.MoveOutOfFriendlyPlayersWay = false -- Should the SNPC move out of the way when a friendly player comes close to it?

ENT.WeaponSpread = 1
ENT.BloodColor = "Red" 
ENT.SightDistance = 5000 -- How far it can see
ENT.BecomeEnemyToPlayer = true
ENT.BecomeEnemyToPlayerLevel = 2 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasMeleeAttack = true
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
	ENT.FootStepSoundLevel = 60
ENT.ShootDistance = 2000
ENT.MeleeAttackDamage = 35
ENT.SquadName = "resistance" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 600 -- -- How far away the SNPC's call for help goes | Counted in World Units
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation
ENT.AnimTbl_CallForHelp = {ACT_SIGNAL_ADVANCE,ACT_SIGNAL_FORWARD,ACT_SIGNAL_GROUP} -- Call For Help Animations
ENT.NextCallForHelpTime = 10 -- Time until it calls for help again
ENT.WaitForEnemyToComeOutTime1 = 2 -- How much time should it wait until it starts chasing the enemy? | First number in math.random
ENT.WaitForEnemyToComeOutTime2 = 3 -- How much time should it wait until it starts chasing the enemy? | Second number in math.random
ENT.AnimTbl_Flinch = {ACT_FLINCH_PHYSICS} -- If it uses normal based animation, use this


ENT.IsMedicSNPC = true
ENT.AnimTbl_Medic_GiveHealth = {"reload_low"} -- Animations is plays when giving health to an ally
ENT.Medic_CheckDistance = 1600 -- How far does it check for allies that are hurt? | World units
ENT.Medic_HealDistance = 100 -- How close does it have to be until it stops moving and heals its ally?
ENT.Medic_HealthAmount = 35 -- How health does it give?
ENT.Medic_NextHealTime1 = 5 -- How much time until it can give health to an ally again | First number in the math.random
ENT.Medic_NextHealTime2 = 10 -- How much time until it can give health to an ally again | Second number in the math.random
ENT.Medic_SpawnPropOnHeal = true -- Should it spawn a prop, such as small health vial at a attachment when healing an ally?

ENT.Medic_SpawnPropOnHealAttachment = "anim_attachment_LH" -- The attachment it spawns on



ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.GrenadeAttackEntity = "npc_grenade_frag" -- The entity that the SNPC throws | Half Life 2 Grenade: "npc_grenade_frag"
ENT.GrenadeAttackModel = "models/weapons/w_grenade.mdl" -- The model for the grenade entity
	-- ====== Animation Variables ====== --
ENT.AnimTbl_GrenadeAttack = {"grenThrow"} -- Grenade Attack Animations
ENT.GrenadeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.GrenadeAttackAnimationFaceEnemy = true -- Should it face the enemy while playing the grenade attack animation?
	-- ====== Distance & Chance Variables ====== --
ENT.NextThrowGrenadeTime1 = math.random(15,26) -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = math.random(11,20) -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 1 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackThrowDistance = 1000 -- How far it can throw grenades
ENT.GrenadeAttackThrowDistanceClose = 500 -- How close until it stops throwing grenades
	-- ====== Sound File Paths ====== --
ENT.SoundTbl_FootStep = {"npc/footsteps/hardboot_generic1.wav","npc/footsteps/hardboot_generic2.wav","npc/footsteps/hardboot_generic3.wav","npc/footsteps/hardboot_generic4.wav","npc/footsteps/hardboot_generic5.wav","npc/footsteps/hardboot_generic6.wav",}


ENT.DefaultSoundTbl_MeleeAttack = {"physics/body/body_medium_impact_hard1.wav","physics/body/body_medium_impact_hard2.wav","physics/body/body_medium_impact_hard3.wav","physics/body/body_medium_impact_hard4.wav","physics/body/body_medium_impact_hard5.wav","physics/body/body_medium_impact_hard6.wav"}
ENT.DefaultSoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav","npc/zombie/claw_miss2.wav"}
ENT.DefaultSoundTbl_Impact = {"physics/flesh/flesh_impact_bullet1.wav","physics/flesh/flesh_impact_bullet2.wav","physics/flesh/flesh_impact_bullet3.wav","physics/flesh/flesh_impact_bullet4.wav","physics/flesh/flesh_impact_bullet5.wav"}
ENT.DefaultSoundTbl_MedicAfterHeal = {"items/smallmedkit1.wav"}


ENT.HasOnPlayerSight = true
function ENT:CustomOnPreInitialize()
	local rand = math.random(1,2)
	if rand == 1 then
self.Model = {"models/humans/group03m/male_01.mdl","models/humans/group03m/male_02.mdl","models/humans/group03m/male_03.mdl","models/humans/group03m/male_04.mdl","models/humans/group03m/male_05.mdl","models/humans/group03m/male_06.mdl","models/humans/group03m/male_07.mdl","models/humans/group03m/male_08.mdl","models/humans/group03m/male_09.mdl"}
self.SoundTbl_Idle = {
"vo/npc/male01/answer01.wav",
"vo/npc/male01/answer02.wav",
"vo/npc/male01/answer03.wav",
"vo/npc/male01/answer04.wav",
"vo/npc/male01/answer05.wav",
"vo/npc/male01/answer07.wav",
"vo/npc/male01/answer08.wav",
"vo/npc/male01/answer09.wav",
"vo/npc/male01/answer10.wav",
"vo/npc/male01/answer11.wav",
"vo/npc/male01/answer12.wav",
"vo/npc/male01/answer13.wav",
"vo/npc/male01/answer14.wav",
"vo/npc/male01/answer15.wav",
"vo/npc/male01/answer16.wav",
"vo/npc/male01/answer17.wav",
"vo/npc/male01/answer18.wav",
"vo/npc/male01/answer19.wav",
"vo/npc/male01/answer20.wav",
"vo/npc/male01/answer21.wav",
"vo/npc/male01/answer22.wav",
"vo/npc/male01/answer23.wav",
"vo/npc/male01/answer24.wav",
"vo/npc/male01/answer25.wav",
"vo/npc/male01/answer26.wav",
"vo/npc/male01/answer27.wav",
"vo/npc/male01/answer28.wav",
"vo/npc/male01/answer29.wav",
"vo/npc/male01/answer30.wav",
"vo/npc/male01/answer31.wav",
"vo/npc/male01/answer32.wav",
"vo/npc/male01/answer33.wav",
"vo/npc/male01/answer34.wav",
"vo/npc/male01/answer35.wav",
"vo/npc/male01/answer36.wav",
"vo/npc/male01/answer37.wav",
"vo/npc/male01/answer38.wav",
"vo/npc/male01/answer39.wav",
"vo/npc/male01/answer40.wav",
"vo/npc/male01/question01.wav",
"vo/npc/male01/question02.wav",
"vo/npc/male01/question03.wav",
"vo/npc/male01/question04.wav",
"vo/npc/male01/question05.wav",
"vo/npc/male01/question06.wav",
"vo/npc/male01/question07.wav",
"vo/npc/male01/question08.wav",
"vo/npc/male01/question09.wav",
"vo/npc/male01/question10.wav",
"vo/npc/male01/question11.wav",
"vo/npc/male01/question12.wav",
"vo/npc/male01/question13.wav",
"vo/npc/male01/question14.wav",
"vo/npc/male01/question15.wav",
"vo/npc/male01/question16.wav",
"vo/npc/male01/question17.wav",
"vo/npc/male01/question18.wav",
"vo/npc/male01/question19.wav",
"vo/npc/male01/question20.wav",
"vo/npc/male01/question21.wav",
"vo/npc/male01/question22.wav",
"vo/npc/male01/question23.wav",
"vo/npc/male01/question25.wav",
"vo/npc/male01/question26.wav",
"vo/npc/male01/question27.wav",
"vo/npc/male01/question28.wav",
"vo/npc/male01/question29.wav",
"vo/npc/male01/question30.wav",
"vo/npc/male01/question31.wav",
"vo/npc/male01/upthere01.wav",
"vo/npc/male01/upthere02.wav",
"vo/npc/male01/vanswer01.wav",
"vo/npc/male01/vanswer02.wav",
"vo/npc/male01/vanswer03.wav",
"vo/npc/male01/vanswer04.wav",
"vo/npc/male01/vanswer05.wav",
"vo/npc/male01/vanswer06.wav",
"vo/npc/male01/vanswer07.wav",
"vo/npc/male01/vanswer08.wav",
"vo/npc/male01/vanswer09.wav",
"vo/npc/male01/vanswer10.wav",
"vo/npc/male01/vanswer11.wav",
"vo/npc/male01/vanswer12.wav",
"vo/npc/male01/vanswer13.wav",
"vo/npc/male01/vanswer14.wav",
"vo/npc/male01/vquestion01.wav",
"vo/npc/male01/vquestion02.wav",
"vo/npc/male01/vquestion03.wav",
"vo/npc/male01/vquestion04.wav",
"vo/npc/male01/vquestion05.wav",
"vo/npc/male01/vquestion06.wav",
"vo/npc/male01/vquestion07.wav",
}
self.SoundTbl_Alert = {
"vo/npc/male01/behindyou01.wav",
"vo/npc/male01/behindyou02.wav",
"vo/npc/male01/busy02.wav",
"vo/npc/male01/heretheycome01.wav",
"vo/npc/male01/incoming02.wav",
}
self.SoundTbl_CombatIdle = {
"vo/npc/male01/runforyourlife01.wav",
"vo/npc/male01/runforyourlife02.wav",
"vo/npc/male01/runforyourlife03.wav",
"vo/npc/male01/getdown02.wav",
"vo/npc/male01/getgoingsoon.wav",
"vo/npc/male01/gethellout.wav",
"vo/npc/male01/moan01.wav",
"vo/npc/male01/moan02.wav",
"vo/npc/male01/moan03.wav",
"vo/npc/male01/moan04.wav",
"vo/npc/male01/moan05.wav",
"vo/npc/male01/upthere01.wav",
"vo/npc/male01/upthere02.wav",
"vo/npc/male01/help01.wav",

}
self.SoundTbl_OnGrenadeSight = {
"vo/npc/male01/cps01.wav",
"vo/npc/male01/cps02.wav",
"vo/npc/male01/hacks01.wav",
"vo/npc/male01/hacks02.wav",
}
self.SoundTbl_Pain = {
"vo/npc/male01/pain01.wav",
"vo/npc/male01/pain02.wav",
"vo/npc/male01/pain03.wav",
"vo/npc/male01/pain04.wav",
"vo/npc/male01/pain05.wav",
"vo/npc/male01/pain06.wav",
"vo/npc/male01/pain07.wav",
"vo/npc/male01/pain08.wav",
"vo/npc/male01/pain09.wav",
"vo/npc/male01/myarm01.wav",
"vo/npc/male01/myarm02.wav",
"vo/npc/male01/mygut02.wav",
"vo/npc/male01/myleg01.wav",
"vo/npc/male01/myleg02.wav",
"vo/npc/male01/imhurt01.wav",
"vo/npc/male01/imhurt02.wav",
"vo/npc/male01/no01.wav",
"vo/npc/male01/no02.wav",
}
self.SoundTbl_Death = {
"vo/npc/male01/ohno.wav",
"vo/npc/male01/ow01.wav",
"vo/npc/male01/ow02.wav",
"vo/npc/male01/pain08.wav",
"vo/npc/male01/pain09.wav",
}
self.SoundTbl_FollowPlayer = {
"vo/npc/male01/letsgo01.wav",
"vo/npc/male01/letsgo02.wav",
"vo/npc/male01/leadon01.wav",
"vo/npc/male01/leadon02.wav",
"vo/npc/male01/squad_reinforce_single01.wav",
"vo/npc/male01/squad_reinforce_single02.wav",
"vo/npc/male01/squad_reinforce_single03.wav",
"vo/npc/male01/squad_reinforce_single04.wav",
"vo/npc/male01/squad_follow01.wav",
"vo/npc/male01/squad_follow02.wav",
"vo/npc/male01/squad_follow03.wav",
"vo/npc/male01/squad_follow04.wav",
}
self.SoundTbl_UnFollowPlayer = {
"vo/npc/male01/readywhenyouare01.wav",
"vo/npc/male01/readywhenyouare02.wav",
"vo/npc/male01/outofyourway02.wav",
"vo/npc/male01/yeah02.wav",
"vo/npc/male01/watchout.wav",
"vo/npc/male01/waitingsomebody.wav",
"vo/npc/male01/ok01.wav",
"vo/npc/male01/ok02.wav",
"vo/npc/male01/okimready01.wav",
"vo/npc/male01/okimready02.wav",
"vo/npc/male01/okimready03.wav",
}
self.SoundTbl_OnPlayerSight = {
"vo/npc/male01/nice.wav",
"vo/npc/male01/heydoc01.wav",
"vo/npc/male01/heydoc02.wav",
"vo/npc/male01/freeman.wav",
"vo/npc/male01/ahgordon01.wav",
"vo/npc/male01/ahgordon02.wav",
"vo/npc/male01/goodgod.wav",
"vo/npc/male01/doingsomething.wav",
"vo/npc/male01/docfreeman01.wav",
"vo/npc/male01/docfreeman02.wav",
"vo/npc/male01/hi01.wav",
"vo/npc/male01/hi02.wav",
}
self.SoundTbl_DamageByPlayer = {
"vo/npc/male01/watchout.wav",
"vo/npc/male01/watchwhat.wav",
"vo/npc/male01/wetrustedyou01.wav",
"vo/npc/male01/wetrustedyou02.wav",
"vo/npc/male01/notthemanithought01.wav",
"vo/npc/male01/notthemanithought02.wav",
"vo/npc/male01/stopitfm.wav",
}
	elseif rand == 2 then
self.Model = {"models/humans/group03m/female_01.mdl","models/humans/group03m/female_02.mdl","models/humans/group03m/female_03.mdl","models/humans/group03m/female_04.mdl","models/humans/group03m/female_06.mdl","models/humans/group03m/female_07.mdl"}
self.SoundTbl_Idle = {
"vo/npc/female01/answer01.wav",
"vo/npc/female01/answer02.wav",
"vo/npc/female01/answer03.wav",
"vo/npc/female01/answer04.wav",
"vo/npc/female01/answer05.wav",
"vo/npc/female01/answer07.wav",
"vo/npc/female01/answer08.wav",
"vo/npc/female01/answer09.wav",
"vo/npc/female01/answer10.wav",
"vo/npc/female01/answer11.wav",
"vo/npc/female01/answer12.wav",
"vo/npc/female01/answer13.wav",
"vo/npc/female01/answer14.wav",
"vo/npc/female01/answer15.wav",
"vo/npc/female01/answer16.wav",
"vo/npc/female01/answer17.wav",
"vo/npc/female01/answer18.wav",
"vo/npc/female01/answer19.wav",
"vo/npc/female01/answer20.wav",
"vo/npc/female01/answer21.wav",
"vo/npc/female01/answer22.wav",
"vo/npc/female01/answer23.wav",
"vo/npc/female01/answer24.wav",
"vo/npc/female01/answer25.wav",
"vo/npc/female01/answer26.wav",
"vo/npc/female01/answer27.wav",
"vo/npc/female01/answer28.wav",
"vo/npc/female01/answer29.wav",
"vo/npc/female01/answer30.wav",
"vo/npc/female01/answer31.wav",
"vo/npc/female01/answer32.wav",
"vo/npc/female01/answer33.wav",
"vo/npc/female01/answer34.wav",
"vo/npc/female01/answer35.wav",
"vo/npc/female01/answer36.wav",
"vo/npc/female01/answer37.wav",
"vo/npc/female01/answer38.wav",
"vo/npc/female01/answer39.wav",
"vo/npc/female01/answer40.wav",
"vo/npc/female01/question01.wav",
"vo/npc/female01/question02.wav",
"vo/npc/female01/question03.wav",
"vo/npc/female01/question04.wav",
"vo/npc/female01/question05.wav",
"vo/npc/female01/question06.wav",
"vo/npc/female01/question07.wav",
"vo/npc/female01/question08.wav",
"vo/npc/female01/question09.wav",
"vo/npc/female01/question10.wav",
"vo/npc/female01/question11.wav",
"vo/npc/female01/question12.wav",
"vo/npc/female01/question13.wav",
"vo/npc/female01/question14.wav",
"vo/npc/female01/question15.wav",
"vo/npc/female01/question16.wav",
"vo/npc/female01/question17.wav",
"vo/npc/female01/question18.wav",
"vo/npc/female01/question19.wav",
"vo/npc/female01/question20.wav",
"vo/npc/female01/question21.wav",
"vo/npc/female01/question22.wav",
"vo/npc/female01/question23.wav",
"vo/npc/female01/question25.wav",
"vo/npc/female01/question26.wav",
"vo/npc/female01/question27.wav",
"vo/npc/female01/question28.wav",
"vo/npc/female01/question29.wav",
"vo/npc/female01/question30.wav",
"vo/npc/female01/question31.wav",
"vo/npc/female01/upthere01.wav",
"vo/npc/female01/upthere02.wav",
"vo/npc/female01/vanswer01.wav",
"vo/npc/female01/vanswer02.wav",
"vo/npc/female01/vanswer03.wav",
"vo/npc/female01/vanswer04.wav",
"vo/npc/female01/vanswer05.wav",
"vo/npc/female01/vanswer06.wav",
"vo/npc/female01/vanswer07.wav",
"vo/npc/female01/vanswer08.wav",
"vo/npc/female01/vanswer09.wav",
"vo/npc/female01/vanswer10.wav",
"vo/npc/female01/vanswer11.wav",
"vo/npc/female01/vanswer12.wav",
"vo/npc/female01/vanswer13.wav",
"vo/npc/female01/vanswer14.wav",
"vo/npc/female01/vquestion01.wav",
"vo/npc/female01/vquestion02.wav",
"vo/npc/female01/vquestion03.wav",
"vo/npc/female01/vquestion04.wav",
"vo/npc/female01/vquestion05.wav",
"vo/npc/female01/vquestion06.wav",
"vo/npc/female01/vquestion07.wav",
}
self.SoundTbl_Alert = {
"vo/npc/female01/behindyou01.wav",
"vo/npc/female01/behindyou02.wav",
"vo/npc/female01/busy02.wav",
"vo/npc/female01/heretheycome01.wav",
"vo/npc/female01/incoming02.wav",
}
self.SoundTbl_CombatIdle = {
"vo/npc/female01/runforyourlife01.wav",
"vo/npc/female01/runforyourlife02.wav",
"vo/npc/female01/getdown02.wav",
"vo/npc/female01/getgoingsoon.wav",
"vo/npc/female01/gethellout.wav",
"vo/npc/female01/moan01.wav",
"vo/npc/female01/moan02.wav",
"vo/npc/female01/moan03.wav",
"vo/npc/female01/moan04.wav",
"vo/npc/female01/moan05.wav",
"vo/npc/female01/upthere01.wav",
"vo/npc/female01/upthere02.wav",
"vo/npc/female01/help01.wav",

}
self.SoundTbl_OnGrenadeSight = {
"vo/npc/female01/cps01.wav",
"vo/npc/female01/cps02.wav",
"vo/npc/female01/hacks01.wav",
"vo/npc/female01/hacks02.wav",
}
self.SoundTbl_Pain = {
"vo/npc/female01/pain01.wav",
"vo/npc/female01/pain02.wav",
"vo/npc/female01/pain03.wav",
"vo/npc/female01/pain04.wav",
"vo/npc/female01/pain05.wav",
"vo/npc/female01/pain06.wav",
"vo/npc/female01/pain07.wav",
"vo/npc/female01/pain08.wav",
"vo/npc/female01/pain09.wav",
"vo/npc/female01/myarm01.wav",
"vo/npc/female01/myarm02.wav",
"vo/npc/female01/mygut02.wav",
"vo/npc/female01/myleg01.wav",
"vo/npc/female01/myleg02.wav",
"vo/npc/female01/imhurt01.wav",
"vo/npc/female01/imhurt02.wav",
"vo/npc/female01/no01.wav",
"vo/npc/female01/no02.wav",
}
self.SoundTbl_Death = {
"vo/npc/female01/ow01.wav",
"vo/npc/female01/ow02.wav",
"vo/npc/female01/pain08.wav",
"vo/npc/female01/pain09.wav",
"vo/npc/female01/uhoh.wav",
}
self.SoundTbl_FollowPlayer = {
"vo/npc/female01/letsgo01.wav",
"vo/npc/female01/letsgo02.wav",
"vo/npc/female01/leadon01.wav",
"vo/npc/female01/leadon02.wav",
"vo/npc/female01/squad_reinforce_single01.wav",
"vo/npc/female01/squad_reinforce_single02.wav",
"vo/npc/female01/squad_reinforce_single03.wav",
"vo/npc/female01/squad_reinforce_single04.wav",
"vo/npc/female01/squad_follow01.wav",
"vo/npc/female01/squad_follow02.wav",
"vo/npc/female01/squad_follow03.wav",
"vo/npc/female01/squad_follow04.wav",
}
self.SoundTbl_UnFollowPlayer = {
"vo/npc/female01/readywhenyouare01.wav",
"vo/npc/female01/readywhenyouare02.wav",
"vo/npc/female01/outofyourway02.wav",
"vo/npc/female01/yeah02.wav",
"vo/npc/female01/watchout.wav",
"vo/npc/female01/waitingsomebody.wav",
"vo/npc/female01/ok01.wav",
"vo/npc/female01/ok02.wav",
"vo/npc/female01/okimready01.wav",
"vo/npc/female01/okimready02.wav",
"vo/npc/female01/okimready03.wav",
}
self.SoundTbl_OnPlayerSight = {
"vo/npc/female01/nice.wav",
"vo/npc/female01/heydoc01.wav",
"vo/npc/female01/heydoc02.wav",
"vo/npc/female01/freeman.wav",
"vo/npc/female01/ahgordon01.wav",
"vo/npc/female01/ahgordon02.wav",
"vo/npc/female01/goodgod.wav",
"vo/npc/female01/doingsomething.wav",
"vo/npc/female01/docfreeman01.wav",
"vo/npc/female01/docfreeman02.wav",
"vo/npc/female01/hi01.wav",
"vo/npc/female01/hi02.wav",
}
self.SoundTbl_DamageByPlayer = {
"vo/npc/female01/watchout.wav",
"vo/npc/female01/watchwhat.wav",
"vo/npc/female01/wetrustedyou01.wav",
"vo/npc/female01/wetrustedyou02.wav",
"vo/npc/female01/notthemanithought01.wav",
"vo/npc/female01/notthemanithought02.wav",
"vo/npc/female01/stopitfm.wav",
}
	end


end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 30000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine" then
		self.PlayerFriendly = false
	
		
end
end
end
end
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
self.Weapon_FiringDistanceFar = self.ShootDistance
	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 30000 ) ) do
		if v:IsValid() && ((v:IsPlayer() && v:Alive() && GetConVarNumber("ai_ignoreplayers") == 0) || (v:IsNPC() && v != self && v:Disposition(self) != D_LI)) && v:Visible(self) then
			if v:IsPlayer() and v.SquadName == "vj_combine"then
		self.PlayerFriendly = false
	
		
end
end
end
end


ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = 100
ENT.IdleSoundPitch2 = 100
ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.OnReceiveOrderSoundPitch1 = 100
ENT.OnReceiveOrderSoundPitch2 = 100
ENT.MoveOutOfPlayersWaySoundPitch1 = 100
ENT.MoveOutOfPlayersWaySoundPitch2 = 100
ENT.BeforeHealSoundPitch1 = 100
ENT.BeforeHealSoundPitch2 = 100
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.MedicReceiveHealSoundPitch1 = 100
ENT.MedicReceiveHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = 100
ENT.OnPlayerSightSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.CallForHelpSoundPitch1 = 100
ENT.CallForHelpSoundPitch2 = 100
ENT.BecomeEnemyToPlayerPitch1 = 100
ENT.BecomeEnemyToPlayerPitch2 = 100
ENT.SuppressingPitch1 = 100
ENT.SuppressingPitch2 = 100
ENT.WeaponReloadSoundPitch1 = 100
ENT.WeaponReloadSoundPitch2 = 100
ENT.GrenadeAttackSoundPitch1 = 100
ENT.GrenadeAttackSoundPitch2 = 100
ENT.OnGrenadeSightSoundPitch1 = 100
ENT.OnGrenadeSightSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = 100
ENT.DamageByPlayerPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100
/*-----------------------------------------------
	*** Copyright (c) 2012-2017 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/