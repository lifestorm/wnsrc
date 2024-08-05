--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

util.AddNetworkString("ixOpenHandSignalMenu")
util.AddNetworkString("ixGestureAnimation")
util.AddNetworkString("ixAskForGestureAnimation")

local animationLookup = {
	male = {
		"bg_accent_left",
		"bg_accentfwd",
		"bg_accentup",
		"bg_down",
		"bg_left",
		"bg_right",
		"bg_up_l",
		"bg_up_r",
		"g_antman_punctuate",
		"g_armsout",
		"g_chestup",
		"g_fist_l",
		"g_fist_r",
		"g_first_swing_accross",
		"g_lefthandmotion",
		"g_lhandease",
		"g_look",
		"g_look_small",
		"g_medpuct_mid",
		"g_noway_small",
		"g_openarms",
		"g_openarms_right",
		"g_palm_out_high_l",
		"g_palm_out_high_r",
		"g_palm_out_r",
		"g_palm_out_l",
		"g_palm_up_high_l",
		"g_palm_up_l",
		"g_puncuate",
		"g_righthandheavy",
		"g_righthandroll",
		"g_shrug",
		"g_what",
		"hg_chest_twistl",
		"hg_headshake",
		"hg_nod_yes",
		"hg_puncuate_down",
		"hg_turn_l",
		"hg_turn_r",
		"hg_turnl",
		"hg_turnr"
	},
	female = {
		"hg_headshake",
		"hg_nodleft",
		"hg_nodright",
		"hg_puncuate_down",
		"g_display_left",
		"g_left_openhand",
		"g_puncuate",
		"g_right_openhand",
		"b_accent_back",
		"b_accent_fwd",
		"b_head_back",
		"b_head_forward",
		"b_overhere_left",
		"b_overhere_right",
	}
}

local allowedChatTypes = {
	["ic"] = true,
	["w"] = true,
	["wd"] = true,
	["y"] = true,
	["sv"] = true
}
function PLUGIN:PostPlayerSay(client, chatType)
	if (!ix.option.Get(client, "enableGestureAnims", true)) then return end
	if (!allowedChatTypes[chatType] or !client:Alive()) then return end
	if (!client:Alive()) then return end
	--local modelClass = ix.anim.GetModelClass(client:GetModel())
	--if (modelClass != "citizen_male" and modelClass != "citizen_female") then return end

	local activeWeapon = client:GetActiveWeapon()
	if (!IsValid(activeWeapon)) then return end
	if (activeWeapon and activeWeapon:GetClass() != "ix_hands") then return end

	if (math.random(1, 2) == 2) then return end -- Don't want it to always gesture

	client:PlayGestureAnimation(client:LookupSequence(client:IsFemale() and animationLookup.female[math.random(#animationLookup.female)] or animationLookup.male[math.random(#animationLookup.male)]))
end
