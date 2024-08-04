--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end

function SWEP:SetupWeaponHoldTypeForAI(htype)
    local idlesaw = ACT_IDLE
	local runsaw = ACT_RUN
	local run = ACT_RUN
	local idle = ACT_IDLE
	local walk = ACT_WALK
	local walksaw = ACT_WALK
	local melee = ACT_MELEE_ATTACK_SWING
	local meleesaw = ACT_MELEE_ATTACK_SWING
	if self.NPC_AnimationSet == "Rebel" then
		run = ACT_RUN
		walk = ACT_DOD_PRONE_AIM_MP44
		melee = ACT_MELEE_ATTACK_SWING
		idle = ACT_IDLE
	 idlesaw = ACT_IDLE_SHOTGUN_AGITATED
	 runsaw = ACT_RUN_RIFLE
	 walksaw = ACT_WALK_RIFLE
	 meleesaw = ACT_RANGE_ATTACK_SHOTGUN
	end
	if self.NPC_AnimationSet == "Combine" then
		run = ACT_RUN_RIFLE
		walk = VJ_SequenceToActivity(self.Owner,"walkunarmed_all")
		melee = ACT_MELEE_ATTACK1
		idle = VJ_SequenceToActivity(self.Owner,"idle_unarmed")
		idlesaw = ACT_IDLE_SHOTGUN
		runsaw = ACT_RUN_AIM_SHOTGUN
		walksaw = ACT_WALK_UNARMED
		meleesaw = ACT_MELEE_ATTACK1
	end	

	self.ActivityTranslateAI = {}
	-- revolver2 or pistol2
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= melee
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= melee
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= melee
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= melee
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= idle
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= idle
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= idle
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= idle*/
		self.ActivityTranslateAI[ACT_WALK] 							= walk
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= walk
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= walk
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= walk
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= walk
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= walk*/
		self.ActivityTranslateAI[ACT_RUN] 							= run
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= run
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= run
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= run
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= run
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= run
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= run
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= run*/
		
if htype == "ar2" or htype == "smg" then 
		if htype == "ar2" or rifleOverride == true then --melee
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= melee
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= melee
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= melee
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= melee
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= idle
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= idle
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= idle
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= idle
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= idle*/
		self.ActivityTranslateAI[ACT_WALK] 							= walk
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= walk
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= walk
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= walk
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= walk
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= walk*/
		self.ActivityTranslateAI[ACT_RUN] 							= run
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= run
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= run
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= run
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= run
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= run
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= run
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= run*/
		elseif htype == "smg" then   -- melee2
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= ACT_HL2MP_IDLE_MELEE2
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= ACT_HL2MP_IDLE_MELEE2
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= ACT_HL2MP_IDLE_MELEE2
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= ACT_HL2MP_IDLE_MELEE2
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= ACT_HL2MP_IDLE_MELEE2
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= ACT_HL2MP_IDLE_MELEE2
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= ACT_HL2MP_IDLE_MELEE2
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= ACT_HL2MP_IDLE_MELEE2*/
		self.ActivityTranslateAI[ACT_WALK] 							= walk
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= walk
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= walk
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= walk
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= walk
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= walk*/
		self.ActivityTranslateAI[ACT_RUN] 							= run
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= run
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= run
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= run
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= run
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= run
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= run
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= run*/
		end

	elseif htype == "crossbow" or htype == "shotgun" then -- fists 
	if htype == "crossbow" or rifleOverride == true then --saw
			self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= meleesaw
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= meleesaw
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= meleesaw
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= meleesaw
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= idlesaw
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= idlesaw
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= idlesaw
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= idlesaw
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= idlesaw
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= idlesaw
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= idlesaw
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= idlesaw*/
		self.ActivityTranslateAI[ACT_WALK] 							= walksaw
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= walksaw
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= walksaw
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= walksaw
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= walksaw
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= walksaw
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= walksaw
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= walksaw
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= walksaw
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= walksaw*/
		self.ActivityTranslateAI[ACT_RUN] 							= runsaw
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= runsaw
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= runsaw
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= runsaw
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= runsaw
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= runsaw
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= runsaw
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= runsaw
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= runsaw
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= runsaw*/
	elseif htype == "shotgun" then   -- fist
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= ACT_HL2MP_IDLE_FIST
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= ACT_HL2MP_IDLE_FIST
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= ACT_HL2MP_IDLE_FIST
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= ACT_HL2MP_IDLE_FIST
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= ACT_HL2MP_IDLE_FIST
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= ACT_HL2MP_IDLE_FIST
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= ACT_HL2MP_IDLE_FIST
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= ACT_HL2MP_IDLE_FIST*/
		self.ActivityTranslateAI[ACT_WALK] 							= walk
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= walk
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= walk
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= walk
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= walk
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= walk*/
		self.ActivityTranslateAI[ACT_RUN] 							= run
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= run
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= run
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= run
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= run
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= run
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= run
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= run
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= run*/
		end
	elseif htype == "rpg" then -- knife
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= ACT_HL2MP_GESTURE_RANGE_ATTACK_KNIFE
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= ACT_HL2MP_IDLE_KNIFE
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= ACT_HL2MP_IDLE_KNIFE
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= ACT_HL2MP_IDLE_KNIFE*/
		self.ActivityTranslateAI[ACT_WALK] 							= walk
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= walk
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= walk
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= walk
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= walk
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= walk
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= walk*/
		self.ActivityTranslateAI[ACT_RUN] 							= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= ACT_RUN_CROUCH_RIFLE
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= ACT_RUN_CROUCH_RIFLE
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= ACT_RUN_CROUCH_RIFLE*/
		elseif htype == "melee" then -- saw 2
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1] 				= ACT_MELEE_ATTACK1
		self.ActivityTranslateAI[ACT_GESTURE_RANGE_ATTACK1] 		= ACT_MELEE_ATTACK1
		self.ActivityTranslateAI[ACT_RANGE_AIM_LOW] 				= ACT_MELEE_ATTACK1
		self.ActivityTranslateAI[ACT_RANGE_ATTACK1_LOW] 			= ACT_MELEE_ATTACK1
		self.ActivityTranslateAI[ACT_COVER_LOW] 					= ACT_COVER_PISTOL_LOW
		self.ActivityTranslateAI[ACT_RELOAD] 						= ACT_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_RELOAD_LOW] 					= ACT_RELOAD_PISTOL_LOW
		self.ActivityTranslateAI[ACT_GESTURE_RELOAD] 				= ACT_GESTURE_RELOAD_PISTOL
		self.ActivityTranslateAI[ACT_IDLE] 							= ACT_IDLE_SHOTGUN
		self.ActivityTranslateAI[ACT_IDLE_ANGRY] 					= ACT_IDLE_SHOTGUN
		/*self.ActivityTranslateAI[ACT_IDLE_RELAXED] 				= ACT_IDLE_SHOTGUN
		self.ActivityTranslateAI[ACT_IDLE_STIMULATED] 				= ACT_IDLE_SHOTGUN
		self.ActivityTranslateAI[ACT_IDLE_AGITATED] 				= ACT_IDLE_SHOTGUN
		self.ActivityTranslateAI[ACT_IDLE_AIM_RELAXED] 				= ACT_IDLE_SHOTGUN
		self.ActivityTranslateAI[ACT_IDLE_AIM_STIMULATED] 			= ACT_IDLE_SHOTGUN
		self.ActivityTranslateAI[ACT_IDLE_AIM_AGITATED] 			= ACT_IDLE_SHOTGUN*/
		self.ActivityTranslateAI[ACT_WALK] 							= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_AIM] 						= ACT_WALK_UNARMED
		/*self.ActivityTranslateAI[ACT_WALK_CROUCH] 					= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_CROUCH_AIM] 				= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_RELAXED] 					= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_STIMULATED] 				= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_AGITATED] 				= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_AIM_RELAXED] 				= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_AIM_STIMULATED] 			= ACT_WALK_UNARMED
		self.ActivityTranslateAI[ACT_WALK_AIM_AGITATED] 			= ACT_WALK_UNARMED*/
		self.ActivityTranslateAI[ACT_RUN] 							= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_AIM] 						= ACT_RUN_AIM_SHOTGUN
		/*self.ActivityTranslateAI[ACT_RUN_CROUCH] 					= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_CROUCH_AIM] 				= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_RELAXED] 					= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_STIMULATED] 				= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_AGITATED] 					= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_AIM_RELAXED] 				= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_AIM_STIMULATED] 			= ACT_RUN_AIM_SHOTGUN
		self.ActivityTranslateAI[ACT_RUN_AIM_AGITATED] 				= ACT_RUN_AIM_SHOTGUN*/
	end
	

	return
end