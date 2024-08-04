--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

ix.anim.stalker = {
	normal = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_LAND] = {ACT_IDLE, ACT_IDLE},
		attack = ACT_MELEE_ATTACK1
	},
	smg = {
		[ACT_MP_STAND_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCH_IDLE] = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_WALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_CROUCHWALK] = {ACT_WALK, ACT_WALK},
		[ACT_MP_RUN] = {ACT_WALK, ACT_WALK},
		[ACT_LAND] = {ACT_IDLE, ACT_IDLE},
		attack = ACT_MELEE_ATTACK1
	},
}

ix.anim.SetModelClass("models/stalker.mdl", "stalker")