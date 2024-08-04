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

ix.anim.headcrab = {
	["normal"] = {
		[ACT_MP_STAND_IDLE] = {1, 1},
		[ACT_MP_CROUCH_IDLE] = {1, 1},
		[ACT_MP_WALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
	},
	["pistol"] = {
		[ACT_MP_STAND_IDLE] = {1, 1},
		[ACT_MP_CROUCH_IDLE] = {1, 1},
		[ACT_MP_WALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
	},
	["smg"] = {
		[ACT_MP_STAND_IDLE] = {1, 1},
		[ACT_MP_CROUCH_IDLE] = {1, 1},
		[ACT_MP_WALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
	},
	["shotgun"] = {
		[ACT_MP_STAND_IDLE] = {1, 1},
		[ACT_MP_CROUCH_IDLE] = {1, 1},
		[ACT_MP_WALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
	},
	["grenade"] = {
		[ACT_MP_STAND_IDLE] = {1, 1},
		[ACT_MP_CROUCH_IDLE] = {1, 1},
		[ACT_MP_WALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
	},
	["melee"] = {
		[ACT_MP_STAND_IDLE] = {1, 1},
		[ACT_MP_CROUCH_IDLE] = {1, 1},
		[ACT_MP_WALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_CROUCHWALK] = {ACT_RUN, ACT_RUN},
		[ACT_MP_RUN] = {ACT_RUN, ACT_RUN},
	}
}

ix.anim.SetModelClass("models/headcrabclassic.mdl", "headcrab")
ix.anim.SetModelClass("models/headcrabblack.mdl", "headcrab")
ix.anim.SetModelClass("models/headcrab.mdl", "headcrab")